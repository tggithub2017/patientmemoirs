var socket = io.connect('http://localhost:8880', {reconnect: true});

// Add a connect listener
$('.send_msg').on('click', function(event){
    socket.emit('myClick', {usertype: $("#user_type").html().replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, ''), id: $("#my_profile_id").html().replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, ''), send_to: $("#message_request_id").val(), content: $("#message_request_content").val(), receive_img: $(".dropdown-user img").attr('src')});
});

var tmpimg, tmpcontent, tmpcount = 0;

socket.on('myClick', function (data) {
    var current = new Date();
    if($("#user_type").html().replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, '') == "Patient") {
        if(data.usertype == "Staff" && parseInt(data.send_to) == parseInt($("#my_profile_id").html())) {
            $(".chats").append('<li class="in">' + 
                                    '<img class="avatar" alt="" src="' + data.receive_img + '">' + 
                                    '<div class="message">' + 
                                        '<span class="arrow"> </span>' +
                                        '<label> Patient </label>' +
                                        '<span class="datetime"> at ' + current + ' </span>' +
                                        '<span class="body"> ' + data.content +' </span>' +
                                    '</div>' +
                                '</li>'); 
            $(".scroller").stop().animate({
                scrollTop: 10000
            }, 1000);

            tmpcount++;
            var date = new Date();
            var str = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " +  date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
            if(!window.location.href.includes("servicenotification")) {
                $(".notification").css("display", "block");
                $(".notification").html(tmpcount);
                $("#pending_msg").append('<li><a href="javascript:;">' +
                                                    '<span class="time" style="margin-top: -10px;">' + str + '</span>' +
                                                    '<span class="details">' +
                                                        '<span class="label label-sm label-icon label-info">' +
                                                            '<i class="fa fa-bullhorn"></i>' +
                                                        '</span>Message from Staff</span></a></li>');
            }
        }
    }
    else {
        if(data.usertype == "Patient") {
            $(".chats").append('<li class="in">' + 
                                    '<img class="avatar" alt="" src="' + data.receive_img + '">' + 
                                    '<div class="message">' + 
                                        '<span class="arrow"> </span>' +
                                        '<label> Support </label>' +
                                        '<span class="datetime"> at ' + current + ' </span>' +
                                        '<span class="body"> ' + data.content +' </span>' +
                                    '</div>' +
                                '</li>');
            $(".scroller").stop().animate({
                scrollTop: 10000
            }, 1000);

            tmpcount++;
            var date = new Date();
            var str = date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " +  date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
            if(!window.location.href.includes("servicenotification")) {
                $(".notification").css("display", "block");
                $(".notification").html(tmpcount);
                $("#pending_msg").append('<li><a href="javascript:;">' +
                                                    '<span class="time" style="margin-top: -10px;">' + str + '</span>' +
                                                    '<span class="details">' +
                                                        '<span class="label label-sm label-icon label-info">' +
                                                            '<i class="fa fa-bullhorn"></i>' +
                                                        '</span>Message from Patient</span></a></li>');
            }
        }
    }
});

$('.form-submit-btn').on('click', function(event) {
    socket.emit('myRequest', {usertype: 'not'});
    $(".form-submit-btn").submit();
});

$('.patient_profile_request').on('click', function(event) {
    socket.emit('myRequest', {usertype: 'not'});
});

socket.on('myRequest', function (data) {
    $(".newrequest_num").html(parseInt($(".newrequest_num").html()) + 1);
    $(".newrequest_btn").css("display", "-webkit-inline-box");
});

$(document).ready(function() {
    $(".send_msg").on('click', function() {
        var current = new Date();
        tmpimg = $(".dropdown-user img").attr('src');
        tmpcontent = $("#message_request_content").val();
        $(".chats").append('<li class="out">' + 
                                '<img class="avatar" alt="" src="' + tmpimg + '">' + 
                                '<div class="message">' + 
                                    '<span class="arrow"> </span>' +
                                    '<label> You </label>' +
                                    '<span class="datetime"> at ' + current + ' </span>' +
                                    '<span class="body"> ' + tmpcontent +' </span>' +
                                '</div>' +
                            '</li>');
        $(".scroller").stop().animate({
            scrollTop: 10000
        }, 1000);
    });
});

$(".account_sel").on('click', function() {
    var index = $(".account_sel").index(this);
    $("#message_request_id").val($(".account_sel:eq("+index+")").val());
    $(".account_sel").css({"border-color": "green;", "border-width": "0px", "border-style": "dashed"});
    $(".account_sel:eq("+index+")").css({"border-color": "green;", "border-width": "4px", "border-style": "dashed"});
});

if(window.location.href.includes("servicenotification")) {
    $(".notification").css("display", "none");
    $(".notification").html(0);
    $("#pending_msg").html('');
    tmpcount = 0;
}

// $("#simplecall").on('click', function() {
//     $.ajax({
//         method: "GET",

//         url: "http://34.223.252.95:3003/application/simplecall",

//         success: function(data){
//             // var obj = JSON.parse(data);
//             console.log(data);
//         } ,

//         error: function(result){
//             console.log("failed");
//         }
//     });
// });