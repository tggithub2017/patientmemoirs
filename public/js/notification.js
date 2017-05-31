var socket = io.connect('http://localhost:8880', {reconnect: true});

// Add a connect listener
$('.send_msg').on('click', function(event){
    socket.emit('myClick', {usertype: $("#user_type").html().replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, ''), id: $("#my_profile_id").html().replace(/(\r\n|\n|\r)/gm,"").replace(/\s/g, ''), send_to: $("#message_request_id").val(), content: $("#message_request_content").val(), receive_img: $(".dropdown-user img").attr('src')});
});

var tmpimg, tmpcontent, tmpcount = 0;

socket.on('myClick', function (data) {
    var current = new Date();
    if(data.content != '') {
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
        if(tmpcontent != '') {
            $(".chats").append('<li class="out">' + 
                                    '<img class="avatar" alt="" src="' + tmpimg + '">' + 
                                    '<div class="message">' + 
                                        '<span class="arrow"> </span>' +
                                        '<label> You </label>' +
                                        '<span class="datetime"> at ' + current + ' </span>' +
                                        '<span class="body"> ' + tmpcontent +' </span>' +
                                    '</div>' +
                                '</li>');
        }
        $(".scroller").stop().animate({
            scrollTop: 10000
        }, 1000);
    });
});

$(".account_sel").on('click', function() {
    var index = $(".account_sel").index(this);
    $("#message_request_id").val($(".account_sel:eq("+index+")").val());
    $(".patient_profile_id").val($(".account_sel:eq("+index+")").val());
    $(".account_sel").css("box-shadow", "0px 0px 0px transparent");
    $(".account_sel:eq("+index+")").css("box-shadow", "1px 0px 10px rgb(78, 86, 78)");
});

if(window.location.href.includes("servicenotification")) {
    $(".notification").css("display", "none");
    $(".notification").html(0);
    $("#pending_msg").html('');
    tmpcount = 0;
}

function msgsearch(e) {
    var str = '';
    var count = 1;
    $(".chats .in .body").each(function(index){
        if($(this).html().includes($("#searchval").val())) {
            str += count + ". From : " + $(".chats .in a:eq("+index+")").html() + " / Message : " + $(this).html() + '\n\n';
            count ++;
        }
    });

    alert(str);
}

$("#simplecall").on('click', function() {
    $.ajax({
        method: "POST",

        url: "http://localhost:3000/application/simplecall",

        data: {
            playerinfo : '{"nhs":"6878768767","date":"5/29/2017","time":"11:53pm","location":"thisLocation","o2level":"97,89,98,78","heartrate":"45,83,12,78,98","headposition":"x0y0z0,x1y1z1,x1y2z2","headrotation":"x0y2z0,x1y5z1,x6y2z2"}'
        },

        success: function(data){
            // var obj = JSON.parse(data);
            console.log(data);
        } ,

        error: function(result){
            console.log("failed");
        }
    });

    // "{'NHS:123123123','Date:5/29/2017', 'Time: 11:53pm', 'Location: thisLocation', 'O2Level: 97,89,98,78', 'HeartRate: 45,83,12,78,98', 'HeadPosition: x0y0z0,x1y1z1,x1y2z2','HeadRotation: x0y2z0,x1y5z1,x6y2z2'}"
});