$(document).ready(function(){
  $(".sub-menu .nav-item .nav-link").on('click', function () {
    $(".sub-menu .nav-item .nav-link").parent().removeClass("active");
    $(".sub-menu .nav-item .nav-link").parent().removeClass("open");
    var index = $(".sub-menu .nav-item .nav-link").index(this);
    var $obj = $(".sub-menu .nav-item .nav-link:eq("+index+")").parent();
    $obj.addClass("active");
    $obj.addClass("open");
  });
});

$('.header-nav a').on('click', function () {
    var index = $('.header-nav a').index(this);
    $('.header-nav li').removeClass('current-menu-item');
    $('.header-nav li:eq('+index+')').addClass('current-menu-item');
});

var onloadf = 0;

function table_row_click(e) {
  alert($(e).html());
}

function note_click() {
  $(".schedule").css("display", "block");
}

function note_disclick() {
  $(".schedule").css("display", "none");
}

function accept_disclick() {
  $(".transaction-accept").css("display", "none");
  menu_height_adjust();
}

function accept_click() {
  $(".transaction-accept").css("display", "block");
  menu_height_adjust();
}

$(document).ready(function() {
  if($(".page-content").height() < $(window).height()) {
      $(".page-content").height($(window).height());
  }

  if($(".page-content").height() >= $(window).height()) {
      $(".page-content").height($(".dashboardpage_height").height() + 500);
  }
});

$(window).resize(function() {
  menu_height_adjust();
});

function menu_height_adjust() {
  if($(".page-content").height() < $(".dashboardpage_height").height() + 100) {
    $(".page-content").height($(".dashboardpage_height").height() + 100);
  }
}