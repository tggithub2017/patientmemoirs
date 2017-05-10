// var app = angular.module('myApp', ['ngRoute']);

// app.config(function($routeProvider) {
//   $routeProvider

//   .when('/', {
//     templateUrl : 'pages/profilepatient.html',
//     controller  : 'HomeController'
//   })

//   .when('/profile', {
//     templateUrl : 'pages/profile.html',
//     controller  : 'ProfileController'
//   })

//   .when('/profilemanagement', {
//     templateUrl : 'pages/profilemanagement.html',
//     controller  : 'PatientManagementController'
//   })

//   .when('/profilesetting', {
//     templateUrl : 'pages/profilesetting.html',
//     controller  : 'ProfileSettingController'
//   })

//   .when('/profilehelp', {
//     templateUrl : 'pages/profilehelp.html',
//     controller  : 'ProfileHelpController'
//   })

//   .when('/service', {
//     templateUrl : 'pages/service.html',
//     controller  : 'ServiceController'
//   })

//   .when('/servicerequest', {
//     templateUrl : 'pages/servicerequest.html',
//     controller  : 'ServiceRequestController'
//   })

//   .when('/servicenotification', {
//     templateUrl : 'pages/servicenotification.html',
//     controller  : 'ServiceNotificationController'
//   })

//   .when('/transaction', {
//     templateUrl : 'pages/transaction.html',
//     controller  : 'TransactionController'
//   })

//   .when('/transactionrequest', {
//     templateUrl : 'pages/transactionrequest.html',
//     controller  : 'TransactionRequestController'
//   })

//   .when('/transactionsetting', {
//     templateUrl : 'pages/transactionsetting.html',
//     controller  : 'TransactionSettingController'
//   })

//   .when('/post', {
//     templateUrl : 'pages/post.html',
//     controller  : 'PostController'
//   })

//   .when('/list', {
//     templateUrl : 'pages/History.html',
//     controller  : 'ListController'
//   })

//   .otherwise({redirectTo: '/'});
// });

// app.controller('HomeController', function($scope) {
//   $scope.message = 1;
//   $("#page-title").html("<h4>Patient Profile</h4>");
// });

// app.controller('ProfileController', function($scope) {
//   $scope.message = 'Hello from ProfileController';
//   $("#page-title").html("<h4>Staff Profile</h4>");
// });

// app.controller('PatientManagementController', function($scope) {
//   $scope.message = 'Hello from PatientManagementController';
//   $("#page-title").html("<h4>Patient Management</h4>");
// });

// app.controller('ProfileSettingController', function($scope) {
//   $scope.message = 'Hello from ProfileController';
//   $("#page-title").html("<h4>User Setting</h4>");
// });

// app.controller('ProfileHelpController', function($scope) {
//   $scope.message = 'Hello from ProfileController';
//   $("#page-title").html("<h4>User Help</h4>");
// });

// app.controller('ServiceController', function($scope) {
//   $scope.message = 'Hello from ServiceController';
//   $("#page-title").html("<h4>Service</h4>");
// });

// app.controller('ServiceRequestController', function($scope) {
//   $scope.message = 'Hello from ServiceController';
//   $("#page-title").html("<h4>Service Request</h4>");
// });

// app.controller('ServiceNotificationController', function($scope) {
//   $scope.message = 'Hello from ServiceController';
//   $("#page-title").html("<h4>Service Notification</h4>");
// });

// app.controller('TransactionController', function($scope) {
//   $scope.message = 'Hello from TransactionController';
//   $("#page-title").html("<h4>Transaction</h4>");
// });

// app.controller('TransactionRequestController', function($scope) {
//   $scope.message = 'Hello from TransactionRequestController';
//   $("#page-title").html("<h4>Transaction Request</h4>");
// });

// app.controller('TransactionSettingController', function($scope) {
//   $scope.message = 'Hello from TransactionSettingController';
//   $("#page-title").html("<h4>Transaction Setting</h4>");
// });

// app.controller('PostController', function($scope) {
//   $scope.message = 'Hello from PostController';
//   $("#page-title").html("<h4>Post</h4>");
// });

// app.controller('ListController', function($scope) {
//   $scope.message = 'Hello from ListController';
//   $("#page-title").html("<h4>History</h4>");
// });

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
});

$(window).resize(function() {
  menu_height_adjust();
});

function menu_height_adjust() {
  if($(".page-content").height() < $(".dashboardpage_height").height() + 100) {
    $(".page-content").height($(".dashboardpage_height").height() + 100);
  }
}