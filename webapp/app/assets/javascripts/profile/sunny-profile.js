/**
 * Created by QuyTruong on 5/31/17.
 */

//Validate form
$(document)
    .on('click', 'form button[type=submit]', function(e) {
        if($('#name').val() == '') {
            $('#name').addClass('parsley-error');
            e.preventDefault(); //prevent the default action
        }else{
            $('#name').removeClass('parsley-error');
        }

        if($('#address').val() == '') {
            $('#address').addClass('parsley-error');
            e.preventDefault(); //prevent the default action
        }else{
            $('#address').removeClass('parsley-error');
        }

        if($('#size').val() == '') {
            $('#size').addClass('parsley-error');
            e.preventDefault(); //prevent the default action
        }else{
            $('#size').removeClass('parsley-error');
        }

        if($('#price').val() == '') {
            $('#price').addClass('parsley-error');
            e.preventDefault(); //prevent the default action
        }else{
            $('#price').removeClass('parsley-error');
        }

        if($('#phone').val() == '') {
            $('#phone').addClass('parsley-error');
            e.preventDefault(); //prevent the default action
        }else{
            $('#phone').removeClass('parsley-error');
        }

        if($('#datepicker').val() == '') {
            $('#datepicker').addClass('parsley-error');
            e.preventDefault(); //prevent the default action
        }else{
            $('#datepicker').removeClass('parsley-error');
        }

        if(parseInt($('.edit-house-total input').data('total')) > parseInt($('#user-budget').val()) ){
            $('#modal-alert-budget').modal('show');
            e.preventDefault(); //prevent the default action
        }else{

        }

    });

// Modal Remove Item
/* ------------------------------------------------ */
var handleModalRemove = function() {
    //Modal for delete action
    var houseId = 0;
    $('.house-button-delete').click(function() {
        $('#modal-delete-house').css('display','block');
        houseId = $(this).data('id');
    });

    $('.model-button-close').click(function() {
        $('#modal-delete-house').css('display','none');
    });

    $('.model-button-done-house').click(function() {
        $('#modal-delete-house').css('display','none');
        removeHouse(houseId)
    });
};

var handleModalBudget = function () {
    $('#model-button-add-budget').click(function () {
        window.open('/profile/budget', '_blank');
    })
};

// Remove Photo in House
/* ------------------------------------------------ */
var handlePhotoRemove = function(){
    $('.thumb-trash').click(function() {
        var photoId = $(this).data('id');
        removePhoto(photoId)
    });
};

// Remove Bookmark
/* ------------------------------------------------ */
var handleBookmarkRemove = function(){
    var bookmarkId = 0;
    $('.bookmark-button-delete').click(function() {
        $('#modal-delete-bookmark').css('display','block');
        bookmarkId = $(this).data('id');
    });

    $('.model-button-close').click(function() {
        $('#modal-delete-bookmark').css('display','none');
    });

    $('.model-button-done-bookmark').click(function() {
        $('#modal-delete-bookmark').css('display','none');
        removeBookmark(bookmarkId)
    });
};

// Check house total change
/* ------------------------------------------------ */
var handleHouseTotal = function(){
    // Sum total in house
    $('#datepicker, .editor-services').change(function() {
        checkHouseTotal();
    });
}

function checkHouseTotal(){
    if ($('#datepicker').val() == '') return;
    var pickDate = new Date($('#datepicker').val());
    var currentDate = new Date();
    currentDate.setHours(0,0,0,0);
    var dateDiff = parseInt((pickDate-currentDate)/(24*3600*1000)) + 1;

    var total = 0;
    $('.editor-services').each(function(){
        if ($(this).is(":checked"))
            total += parseInt($(this).data('price'));
    });

    $('.edit-house-total span').html(total + ' vnd x '+dateDiff+' ngày = '+(total*dateDiff)+' vnd');
    $('.edit-house-total input').attr('data-total', (total*dateDiff));
}

// Check house total change
/* ------------------------------------------------ */
var handleSwitchPayment = function(){
    $('input[type=radio][name=payment_type]').change(function() {
        var url = $('#form_payment').attr("action");

        if (this.value == 'internal') {
            $('.input-payment-internal').prop('disabled', false);
            $('.input-payment-external').prop('disabled', true);
            $('#form_payment').attr("action", url.replace("do_ex.php", "do.php"));
        }else if (this.value == 'external') {
            $('.input-payment-internal').prop('disabled', true);
            $('.input-payment-external').prop('disabled', false);
            $('#form_payment').attr("action", url.replace("do.php", "do_ex.php"));
        }
    });
}

// Api Delete house
/* ------------------------------------------------ */
function removeHouse(houseId) {
    $.ajax({
        url: '/profile/house/' + houseId,
        type: 'DELETE',
        dataType: 'json',
        data: { authenticity_token: window._token },
        contentType: 'application/x-www-form-urlencoded',
        success: function (data) {
            location.reload();
        },
        error: function (data) {

        }
    });
}

// Api Delete photo
/* ------------------------------------------------ */
function removePhoto(photoId) {
    $.ajax({
        url: '/photo/' + photoId,
        type: 'DELETE',
        dataType: 'json',
        data: { authenticity_token: window._token },
        contentType: 'application/x-www-form-urlencoded',
        success: function (data) {
            $('#thumb-'+photoId).remove();
        },
        error: function (data) {

        }
    });
}


// Api Bookmark
/* ------------------------------------------------ */
function removeBookmark(bookmarkId) {
    $.ajax({
        url: '/profile/bookmark/' + bookmarkId,
        type: 'DELETE',
        dataType: 'json',
        data: { authenticity_token: window._token },
        contentType: 'application/x-www-form-urlencoded',
        success: function (data) {
            location.reload();
        },
        error: function (data) {

        }
    });
}

/* Application Controller
 ------------------------------------------------ */
$(document).ready(function(){
    handleModalRemove();
    handlePhotoRemove();
    handleBookmarkRemove();
    handleHouseTotal();
    handleSwitchPayment();
    handleModalBudget();
});
