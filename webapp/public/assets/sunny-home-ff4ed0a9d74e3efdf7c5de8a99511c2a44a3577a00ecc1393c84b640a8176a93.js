/* Application Controller
 ------------------------------------------------ */

$(document).ready(function () {
    menuTypeSelect();
});

/* Menu change color
 ------------------------------------------------ */
var menuTypeSelect = function () {
    $('.menu-card-type').click(function () {
        var estateId = $(this).data('id');
        var estateName = $(this).data('name');
        $('#menu-card-title').html(estateName);
        $('#menu-card-title').css('color', '#8F8E8E');
    });
};

/* Search autocomplete
 ------------------------------------------------ */
var autocomplete;
var componentForm = {
    street_number: 'short_name',
    route: 'long_name',
    locality: 'long_name',
    administrative_area_level_1: 'short_name',
    country: 'long_name',
    postal_code: 'short_name'
};

function initAutocomplete() {
    autocomplete = new google.maps.places.Autocomplete((document.getElementById('input-search-place')),
        {types: ['geocode']});

    // When the user selects an address from the dropdown, populate the address
    // fields in the form.
    autocomplete.addListener('place_changed', fillInAddress);
}

function fillInAddress() {
    var place = autocomplete.getPlace();
    var placeSearch = place.address_components;

    var name = getAreaName(placeSearch);
    var city = getAreaData(placeSearch, 'locality');
    var province = getAreaData(placeSearch, 'administrative_area_level_1');
    var country = getAreaData(placeSearch, 'country');
    var lat = place.geometry.location.lat();
    var lng = place.geometry.location.lng();

    window.location.replace("/search");
}

function getAreaData(placeSearch, type) {
    if (placeSearch != null && placeSearch.length > 0 && componentForm[type]) {
        for (var i = 0; i < placeSearch.length; i++) {
            var addressType = placeSearch[i].types[0];
            if (addressType == type) {
                return placeSearch[i][componentForm[type]];
            }
        }
    }
}

function getAreaName(placeSearch) {
    if (placeSearch != null && placeSearch.length > 0) {
        return placeSearch[0]["long_name"];
    }
}

function geoLocate() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var geolocation = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            var circle = new google.maps.Circle({
                center: geolocation,
                radius: position.coords.accuracy
            });
            autocomplete.setBounds(circle.getBounds());
        });
    }
}

;
