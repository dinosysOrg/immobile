/**
 * Created by QuyTruong on 4/14/17.
 */

/* Init Map
 ------------------------------------------------ */

function initMap() {
    var center = {lat: 10.788994, lng: 106.689901};
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 14,
        center: center
    });

    new google.maps.Marker({
        position: {lat: 10.788994, lng: 106.689901},
        map: map
    });

}

/* Application Controller
 ------------------------------------------------ */
$(document).ready(function(){
    detailDropdown();
});

/* Dropdown detail
 ------------------------------------------------ */
var detailDropdown = function() {
    $('#convenience-in-dropdown').click(function() {
        var icon = $('#convenience-in-dropdown i');
        if(icon.hasClass('fa-angle-down')) {
            icon.removeClass('fa-angle-down');
            icon.addClass('fa-angle-up');
        }else{
            icon.removeClass('fa-angle-up');
            icon.addClass('fa-angle-down');
        }
        $('#convenience-in-content').slideToggle('slow');
    });

    $('#convenience-out-dropdown').click(function() {
        var icon = $('#convenience-out-dropdown i');
        if(icon.hasClass('fa-angle-down')) {
            icon.removeClass('fa-angle-down');
            icon.addClass('fa-angle-up');
        }else{
            icon.removeClass('fa-angle-up');
            icon.addClass('fa-angle-down');
        }
        $('#convenience-out-content').slideToggle('slow');
    });

    $('#furniture-dropdown').click(function() {
        var icon = $('#furniture-dropdown i');
        if(icon.hasClass('fa-angle-down')) {
            icon.removeClass('fa-angle-down');
            icon.addClass('fa-angle-up');
        }else{
            icon.removeClass('fa-angle-up');
            icon.addClass('fa-angle-down');
        }
        $('#furniture-content').slideToggle('slow');
    });
}

;
