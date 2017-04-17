/**
 * Created by QuyTruong on 4/14/17.
 */

function initMap() {
    var center = {lat: 10.783741, lng: 106.691255};
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 14,
        center: center
    });

    new google.maps.Marker({
        position: {lat: 10.788994, lng: 106.689901},
        label: '4500$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });
    new google.maps.Marker({
        position: {lat: 10.777423, lng: 106.683944},
        label: '3400$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });
    new google.maps.Marker({
        position: {lat: 10.780083, lng: 106.6963994},
        label: '3800$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });
    new google.maps.Marker({
        position: {lat: 10.775894, lng: 106.694436},
        label: '2500$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });
    new google.maps.Marker({
        position: {lat: 10.786467, lng: 106.693624},
        label: '4800$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });
    new google.maps.Marker({
        position: {lat: 10.782610, lng: 106.698024},
        label: '5900$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });
    new google.maps.Marker({
        position: {lat: 10.787132, lng: 106.684621},
        label: '3900$',
        icon: '/assets/ic_marker_filter.png',
        map: map
    });


    // Define the LatLng coordinates for the polygon's path.
    var triangleCoords = [
        {lat: 10.787132, lng: 106.684621},
        {lat: 10.777423, lng: 106.683944},
        {lat: 10.775894, lng: 106.694436},
        {lat: 10.780083, lng: 106.6963994},
        {lat: 10.782610, lng: 106.698024},
        {lat: 10.786467, lng: 106.693624},
        {lat: 10.788994, lng: 106.689901}
    ];

    // Construct the polygon.
    var bermudaTriangle = new google.maps.Polygon({
        paths: triangleCoords,
        strokeColor: '#FF0000',
        strokeOpacity: 0.5,
        strokeWeight: 1,
        fillColor: '#FF0000',
        fillOpacity: 0.35
    });
    bermudaTriangle.setMap(map);
}


$(document).ready(function () {
    butotnListner();
});

function butotnListner(){
    $("#bathroom-click").click(function() {
        if ($("#bathroom-box").hasClass("box-hidden") == true){
            //close all
            $(".search-filter-box").addClass("box-hidden");
            $(".search-filter-item i").removeClass("fa-chevron-up");
            $(".search-filter-item i").addClass("fa-chevron-down");
            $(".search-filter-item").css("background", "#fff");

            //open
            $(".search-filter-box").addClass("box-hidden");
            $("#bathroom-box").removeClass("box-hidden");
            $("#bathroom-button i").removeClass("fa-chevron-down");
            $("#bathroom-button i").addClass("fa-chevron-up");
            $("#bathroom-button").css("background", "#f4f5f9");
        }else{
            //close
            $("#bathroom-box").addClass("box-hidden");
            $("#bathroom-button i").removeClass("fa-chevron-up");
            $("#bathroom-button i").addClass("fa-chevron-down");
            $("#bathroom-button").css("background", "#fff");
        }
    });

    $("#bedroom-click").click(function() {
        if ($("#bedroom-box").hasClass("box-hidden") == true){
            //close all
            $(".search-filter-box").addClass("box-hidden");
            $(".search-filter-item i").removeClass("fa-chevron-up");
            $(".search-filter-item i").addClass("fa-chevron-down");
            $(".search-filter-item").css("background", "#fff");

            //open
            $("#bedroom-box").removeClass("box-hidden");
            $("#bedroom-button i").removeClass("fa-chevron-down");
            $("#bedroom-button i").addClass("fa-chevron-up");
            $("#bedroom-button").css("background", "#f4f5f9");
        }else{
            //close
            $("#bedroom-box").addClass("box-hidden");
            $("#bedroom-button i").removeClass("fa-chevron-up");
            $("#bedroom-button i").addClass("fa-chevron-down");
            $("#bedroom-button").css("background", "#fff");
        }
    });

    $("#size-click").click(function() {
        if ($("#size-box").hasClass("box-hidden") == true){
            //close all
            $(".search-filter-box").addClass("box-hidden");
            $(".search-filter-item i").removeClass("fa-chevron-up");
            $(".search-filter-item i").addClass("fa-chevron-down");
            $(".search-filter-item").css("background", "#fff");

            //open
            $("#size-box").removeClass("box-hidden");
            $("#size-button i").removeClass("fa-chevron-down");
            $("#size-button i").addClass("fa-chevron-up");
            $("#size-button").css("background", "#f4f5f9");
        }else{
            //close
            $("#size-box").addClass("box-hidden");
            $("#size-button i").removeClass("fa-chevron-up");
            $("#size-button i").addClass("fa-chevron-down");
            $("#size-button").css("background", "#fff");
        }
    });

    $("#price-click").click(function() {
        if ($("#price-box").hasClass("box-hidden") == true){
            //close all
            $(".search-filter-box").addClass("box-hidden");
            $(".search-filter-item i").removeClass("fa-chevron-up");
            $(".search-filter-item i").addClass("fa-chevron-down");
            $(".search-filter-item").css("background", "#fff");

            //open
            $("#price-box").removeClass("box-hidden");
            $("#price-button i").removeClass("fa-chevron-down");
            $("#price-button i").addClass("fa-chevron-up");
            $("#price-button").css("background", "#f4f5f9");
        }else{
            //close
            $("#price-box").addClass("box-hidden");
            $("#price-button i").removeClass("fa-chevron-up");
            $("#price-button i").addClass("fa-chevron-down");
            $("#price-button").css("background", "#fff");
        }
    });
}