/**
 * https://github.com/handaoliang/html5ImageUploader
 * Licensed under GNU GPL 2 or later and GNU LGPL 2 or later.
 */

var moduleNameSpace = "comnovo.html5ImageCopper.UploaderModel";
var nameSpace = comnovo.util.initNameSpace(moduleNameSpace);

(function(ns) {
    ns.html5ImageCopperObj = null;
    ns.init = function() {
        ns.html5ImageCopperObj = new ImageCropper(300, 300, 180, 180);
        ns.html5ImageCopperObj.setCanvas("cropper_img_area");
        ns.html5ImageCopperObj.addPreview("preview_100_px");

        if (!ns.html5ImageCopperObj.isAvaliable()) {
            var warnningInfo = "Sorry, your browser doesn't support FileReader," +
                "please use Firefox3.6+ or Chrome10+ to run it.";
            alert(warnningInfo);
        }
    }

    ns.fileInputImageSelect = function(evt) {
        var files = evt.target.files;
        ns.html5ImageCopperObj.loadImage(files[0]);
        jQuery("#drag_drop_area").hide();
        jQuery("#dragdrop_info").hide();
        jQuery("#select_img_button").hide();
    };

    ns.reloadCropperImage = function() {
        window.location.reload();
    };

    ns.dragImageSelect = function(evt) {
        evt.stopPropagation();
        evt.preventDefault();
        var files = evt.dataTransfer.files;
        ns.html5ImageCopperObj.loadImage(files[0]);
        jQuery("#drag_drop_area").hide();
        jQuery("#dragdrop_info").hide();
        jQuery("#select_img_button").hide();
    };

    ns.handleDragOver = function(evt) {
        jQuery("#drag_drop_area").css({ "border": "3px dashed #999999" });
        evt.stopPropagation();
        evt.preventDefault();
    };

    ns.handleDragLeave = function(evt) {
        jQuery("#drag_drop_area").hide();
    };

    ns.rotateImage = function() {
        ns.html5ImageCopperObj.rotate(90);
    }

    /*   ns.saveImage = function() {
           var bigImgData = ns.html5ImageCopperObj.getCroppedImageData(180, 180);
           // var smallImgData = ns.html5ImageCopperObj.getCroppedImageData(50, 50);

           jQuery.ajax({
               url: 'uploader.php',
               type: "POST",
               dataType: "json",
               data: {
                   jrand: Math.round(Math.random() * 10000000000),
                   iName: "images",
                   iSize: 240,
                   iBigFile: bigImgData,
                   //imidFile: midImgData,
                   //    iSmallFile: smallImgData,
               },
               success: function(JSONData) {
                   ns.callbackActions(JSONData);
               }
           });
       };*/

    ns.callbackActions = function(JSONData) {
        jQuery("#upload_success_preview_big")[0].src = JSONData.big_file_name;
        jQuery("#upload_success_preview_small")[0].src = JSONData.small_file_name
            //do some thing..
    };


    ns.trace = function() {
        if (typeof(console) != "undefined") {
            console.log(Array.prototype.slice.apply(arguments).join(" "));
        }
    };
})(nameSpace);

$(document).ready(function() {

    $("#save_img_button").click(function() {

        var filesSelected = document.getElementById("image_file").files;

        if (filesSelected.length > 0) {
            var fileToLoad = filesSelected[0];
            var fileReader = new FileReader();
            fileReader.onload = function(fileLoadedEvent) {
                var srcData = fileLoadedEvent.target.result; // <--- data: base64

                var obj = document.getElementById("preview_100_px");

                var jpegUrl = obj.toDataURL("image/png", 1.2);

                $.ajax({
                    url: '../crop.php',
                    data: { thumbbasecode: jpegUrl, basecode: srcData },
                    type: 'post',
                    success: function(res) {

                        $("#tab_1_2").removeClass("active");
                        $("#tab_1_1").addClass("active");
                        $("#tab1_2").parent().removeClass("active");
                        $("#tab1_1").parent().addClass("active");
                        $("#photo").attr("src", res);
                        $("#photo").css("height", "150px");
                    },
                    complete: function(res) {

                    }
                });

            }

            fileReader.readAsDataURL(fileToLoad);
        }


    });
    $("#change_img_button").click(function() {
        $("#dragdrop_info").show();
        $("#drag_drop_area").show();
        $("#select_img_button").show();
    });

    comnovo.html5ImageCopper.UploaderModel.init();
    comnovo.util.getElement('image_file').addEventListener('change', comnovo.html5ImageCopper.UploaderModel.fileInputImageSelect);
    comnovo.util.getElement('drag_drop_area').addEventListener('dragover', comnovo.html5ImageCopper.UploaderModel.handleDragOver, false);
    comnovo.util.getElement('drag_drop_area').addEventListener('drop', comnovo.html5ImageCopper.UploaderModel.dragImageSelect, false);
    comnovo.util.getElement('rotate_btn').addEventListener('click', comnovo.html5ImageCopper.UploaderModel.rotateImage, false);
    comnovo.util.getElement('change_img_button').addEventListener('click', comnovo.html5ImageCopper.UploaderModel.init, false);
    //comnovo.util.getElement('back_btn').addEventListener('click', comnovo.html5ImageCopper.UploaderModel.reloadCropperImage, false);
    //comnovo.util.getElement('save_img_button').addEventListener('click', comnovo.html5ImageCopper.UploaderModel.saveImage, false)
});