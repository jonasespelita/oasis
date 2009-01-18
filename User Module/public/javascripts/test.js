jQuery().ready(function(){
    // simple accordion
    jQuery('.woof').accordion({
        alwaysOpen: false,
        active: false,
        header:"a.t_tab"
    });

// $('.pane-unselected ol li a').click(function(){$('.scrollit').scrollTo(0, 0)});

});
jQuery(function( $ ){
/*
$(".pane-unselected ol li a").click(function(){
    $('.scrollit').scrollLeft = 0;
});*/

    $('.scrollit').localScroll({// Only the links inside that jquery object will be affected
        lazy: true, // This is the KEY setting here, makes the links work even after an Ajax load.
        target: '.scrollit', // The element that gets scrolled
        axis:'x', // Horizontal scrolling
        duration:500,
        onBefore:function( e, subsec, $cont ){//'this' is the clicked link
            if( this.blur )
                this.blur(); // Remove the awful outline
        }
    });

  


});



function reset_menu(){

 var panelist = $('t_menu_2').getElementsByTagName('li');
    var nodes = $A(panelist);
  
    nodes.each(function(node){
        node.className='pane-unselected';
    });
}