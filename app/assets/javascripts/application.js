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


// JQuery Popup, 20110330, Hasang Cheon
$(document).ready(function() {
	//When you click on a link with class of poplight and the href starts with a #
	$('a.poplight[href^=#]').live("click", function() {

		var popID = $(this).attr('rel'); //Get Popup Name
		var popURL = $(this).attr('href'); //Get Popup href to define size

		//Pull Query & Variables from href URL
		var query= popURL.split('?');
		var dim= query[1].split('&');
		var popWidth = dim[0].split('=')[1]; //Gets the first query string value

		//Fade in the Popup and add close button
		$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="/assets/popup_selector.png" title="Close Window" alt="Close" /></a>');

		//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
		var popMargTop = ($('#' + popID).height() + 80) / 2;
		var popMargLeft = ($('#' + popID).width() + 80) / 2;
		
		//Apply Margin to Popup
		$('#' + popID).css({
			'margin-top' : -popMargTop,
			'margin-left' : -popMargLeft
		});
		
		$(".popup-prev, .popup-next").each(function(){
			$(this).css("top", ($('#' + popID).height()-$(this).height())/ 2 + "px");
		});
		

		//Fade in Background
		$('body').append('<div id="fade"></div>'); //Add the fade layer to bottom of the body tag.
		$('#fade').css({'filter' : 'alpha(opacity=80)'}).fadeIn(); //Fade in the fade layer - .css({'filter' : 'alpha(opacity=80)'}) is used to fix the IE Bug on fading transparencies 

		return false;
	});
	
	$('a.poplight_next[href^=#]').live("click", function() {

		$('.popup_block').hide();		

		var popID = $(this).attr('rel'); //Get Popup Name
		var popURL = $(this).attr('href'); //Get Popup href to define size

		//Pull Query & Variables from href URL
		var query= popURL.split('?');
		var dim= query[1].split('&');
		var popWidth = dim[0].split('=')[1]; //Gets the first query string value

		//Fade in the Popup and add close button
		$('#' + popID).fadeIn().css({ 'width': Number( popWidth ) }).prepend('<a href="#" class="close"><img src="/assets/popup_selector.png" class="btn_close" title="Close Window" alt="Close" /></a>');

		//Define margin for center alignment (vertical   horizontal) - we add 80px to the height/width to accomodate for the padding  and border width defined in the css
		var popMargTop = ($('#' + popID).height() + 80) / 2;
		var popMargLeft = ($('#' + popID).width() + 80) / 2;

		//Apply Margin to Popup
		$('#' + popID).css({
			'margin-top' : -popMargTop,
			'margin-left' : -popMargLeft
		});
		
		$(".popup-prev, .popup-next").each(function(){
			$(this).css("top", ($('#' + popID).height()-$(this).height())/ 2 + "px");
		});

		return false;
	});
	

	//Close Popups and Fade Layer
	$('a.close, #fade').live('click', function() { //When clicking on the close or fade layer...
		$('#fade , .popup_block').fadeOut(function() {
			$('#fade, a.close').remove();  //fade them both out
		});
		return false;
	});
	$(".popup_block").hover(function(){
		$(".popup-prev, .popup-next").fadeIn();
	}, function(){
		$(".popup-prev, .popup-next").fadeOut();		
	});
});

// Kit Ajax if no photo is attached
$(document).ready(function() {
	$("form#new_kit").submit(function() {
		if ($("input#kit_photos_attributes__image").val() == "")
		{
			var i = $(this).find("input[type=submit]");
			if ($("textarea#kit-form-text").val() == "")
				return false;
			var t =  i.attr("data-disable-with");
			if (t != null && t != "")
				i.val(t);
			i.attr("disabled", "disabled");
			$.post(this.action, $(this).serialize(), null, "script")
			.complete(function(){
				i.removeAttr("disabled");
				i.val("Kit");
			})
			.error(function(){
				i.val("Kit");
			});
			return false;
		}
		return true;
	});
});

