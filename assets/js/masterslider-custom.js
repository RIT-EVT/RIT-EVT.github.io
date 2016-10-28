/* 
 * RIT Electric Vehicle Team v2.0
 * Design_mylife
 */
(function ($) {
    "use strict";
    var slider = new MasterSlider();

    // adds Arrows navigation control to the slider.
    slider.control('arrows');
    slider.control('timebar', {insertTo: '#masterslider'});
    slider.control('bullets');

    slider.setup('masterslider', {
        width: 1400, // slider standard width
        height: 600, // slider standard height
        space: 0,
        layout: 'fullwidth',
        loop: true,
        preload: 0,
        instantStartLayers: true,
        autoplay: true
    });
})(jQuery);

//team carousel
var slider = new MasterSlider();
slider.setup('teamslider', {
    loop: true,
    width: 240,
    height: 240,
    speed: 20,
    view: 'fadeBasic',
    preload: 0,
    space: 0,
    wheel: false
});
slider.control('arrows');
slider.control('slideinfo', {insertTo: '#staff-info'});

