jQuery().ready(function(){
		// simple accordion
		jQuery('.woof').accordion({
		alwaysOpen: false,
		active: false,
		header:"a.t_tab"
});
		
		
		
		
		var wizard = $("#wizard").accordion({
			header: '.title',
			event: false
		});
		
		var wizardButtons = $([]);
		$("div.title", wizard).each(function(index) {
			wizardButtons = wizardButtons.add($(this)
			.next()
			.children(":button")
			.filter(".next, .previous")
			.click(function() {
				wizard.accordion("activate", index + ($(this).is(".next") ? 1 : -1))
			}));
		});
		
		// bind to change event of select to control first and seconds accordion
		// similar to tab's plugin triggerTab(), without an extra method
		var accordions = jQuery('.woof,  #wizard');
		
		jQuery('#switch select').change(function() {
			accordions.accordion("activate", this.selectedIndex-1 );
		});
		jQuery('#close').click(function() {
			accordions.accordion("activate", -1);
		});
		jQuery('#switch2').change(function() {
			accordions.accordion("activate", this.value);
		});
		jQuery('#enable').click(function() {
			accordions.accordion("enable");
		});
		jQuery('#disable').click(function() {
			accordions.accordion("disable");
		});
		jQuery('#remove').click(function() {
			accordions.accordion("destroy");
			wizardButtons.unbind("click");
		});
	});
	

jQuery(function( $ ){
	/**
	 * Most jQuery.localScroll's settings, actually belong to jQuery.ScrollTo, check it's demo for an example of each option.
	 * @see http://flesler.demos.com/jquery/scrollTo/
	 * You can use EVERY single setting of jQuery.ScrollTo, in the settings hash you send to jQuery.LocalScroll.
	 */
	
	/**
	 * Restart the scroll position to ( 0, 0 ) (Firefox doesn't reset it)
	 * could use $(target).scrollTo( 0, {axis:'xy'));
	 * but this needs to be quick(synchronous), to reset before $.localScroll.hash() begins
	 */
	$('.scrollit').attr({scrollTop:0,scrollLeft:0});
	
	// Scroll initially if there's a hash (#something) in the url 
	$.localScroll.hash({
		target: '.scrollit', //could be a selector or a jQuery object too.
		axis:'xy',//the default is 'y'
		queue:true,
		duration:1500
	});
	
	var $last = $([]);//save the last link
	
	/**
	 * NOTE: I use $.localScroll instead of $('#navigation').localScroll() so I
	 * also affect the >> and << links. I want every link in the page to scroll.
	 */
	$('.g_menu').localScroll({
		target: '.scrollit', //could be a selector or a jQuery object too.
		axis:'xy', //the default is 'y'
		queue:true,
		duration:1500,
		
		
	});
	

	
});

