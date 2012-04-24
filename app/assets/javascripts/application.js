// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.purr
//= require best_in_place
//= require dataTables/jquery.dataTables
//= require twitter/bootstrap
//= require_tree .


// ground-show status
// $("div.status-control").not(".li-freeze").mouseenter(function(){
// 	$(this).addClass("li-active");
// 	$(this).children(".seed-digit").css("color", "#777");
// 	$(this).children().children().children("input:last").addClass("button-hover");
// });
// $("div.status-control").not(".li-freeze").mouseleave(function(){
// 	$(this).removeClass("li-active");
// 	$(this).children(".seed-digit").css("color", "#ccc");
// 	$(this).children().children().children("input:last").removeClass("button-hover");		
// });

//dropdown
$('.dropdown-toggle').dropdown()

$('a[data-toggle="tab"]').on('shown', function (e) {
  e.target // activated tab
  e.relatedTarget // previous tab
})