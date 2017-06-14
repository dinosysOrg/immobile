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
    });

$(document).ready(function(){

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
        //ajax

        removeHouse(houseId)
    });

    //Remove thumb Click
    $('.thumb-trash').click(function() {
        var photoId = $(this).data('id');
        removePhoto(photoId)
    });

    // Api Delete house
    function removeHouse(houseId) {
        $.ajax({
            url: '/profile/post/' + houseId,
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

});
