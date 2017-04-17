/**
 * Created by QuyTruong on 4/14/17.
 */

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

