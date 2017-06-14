/**
 * Created by QuyTruong on 6/8/17.
 */

$(document).ready(function(){

    //Change role user
    $('.user-role-select').change(function() {
        var userId = $(this).data('id');
        var role = $(this).val();
        $.ajax({
            url: '/profile/user/'+userId+'/role?role='+role,
            type: 'POST',
            dataType: 'json',
            data: { authenticity_token: window._token },
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {

            },
            error: function (data) {

            }
        });
    });

    //search button
    $('#list-user-search-button').click(function() {
        var keyword = $('#list-user-search-input').val();
        window.location.href = window.location.href.replace( /[\?#].*|$/, "?search="+keyword );
    });

    $('#list-project-search-input').click(function() {
        var keyword = $('#list-project-search-input').val();
        window.location.href = window.location.href.replace( /[\?#].*|$/, "?search="+keyword );
    });

    $('#list-house-search-input').click(function() {
        var keyword = $('#list-house-search-input').val();
        window.location.href = window.location.href.replace( /[\?#].*|$/, "?search="+keyword );
    });

    //change status house
    $('.house-status-select').change(function() {
        var houseId = $(this).data('id');
        var status = $(this).val();
        $.ajax({
            url: '/profile/post/'+houseId+'/status?status='+status,
            type: 'POST',
            dataType: 'json',
            data: { authenticity_token: window._token },
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {

            },
            error: function (data) {

            }
        });
    });

    //set house at home
    $('.house-home-select').change(function() {
        var houseId = $(this).data('id');
        var status = $(this).is(":checked");
        $.ajax({
            url: '/profile/post/'+houseId+'/is_home?status='+status,
            type: 'POST',
            dataType: 'json',
            data: { authenticity_token: window._token },
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {

            },
            error: function (data) {

            }
        });
    });

    //set user at home
    $('.user-home-select').change(function() {
        var userId = $(this).data('id');
        var status = $(this).is(":checked");
        $.ajax({
            url: '/profile/user/'+userId+'/is_home?status='+status,
            type: 'POST',
            dataType: 'json',
            data: { authenticity_token: window._token },
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {

            },
            error: function (data) {

            }
        });
    });

    //set project at home
    $('.project-home-select').change(function() {
        var projectId = $(this).data('id');
        var status = $(this).is(":checked");
        $.ajax({
            url: '/profile/project/'+projectId+'/is_home?status='+status,
            type: 'POST',
            dataType: 'json',
            data: { authenticity_token: window._token },
            contentType: 'application/x-www-form-urlencoded',
            success: function (data) {

            },
            error: function (data) {

            }
        });
    });

    // Project delete
    //Modal for delete action
    var projectId = 0;
    $('.project-button-delete').click(function() {
        $('#modal-delete-project').css('display','block');
        projectId = $(this).data('id');
    });

    $('.model-button-close').click(function() {
        $('#modal-delete-project').css('display','none');
    });

    $('.model-button-done-project').click(function() {
        $('#modal-delete-project').css('display','none');
        //ajax

        removeProject(projectId)
    });

    // Api Delete Project
    function removeProject(projectId) {
        $.ajax({
            url: '/profile/project/' + projectId,
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
});