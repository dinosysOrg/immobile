/**
 * Created by QuyTruong on 6/8/17.
 */

/* Search/filter button
 ------------------------------------------------ */
var handleSearchButton = function(){
    $('#list-user-search-button').click(function() {
        var keyword = $('#list-user-search-input').val();
        window.location.href = window.location.href.replace( /[\?#].*|$/, "?search="+keyword );
    });

    $('#list-project-search-button').click(function() {
        var keyword = $('#list-project-search-input').val();
        window.location.href = window.location.href.replace( /[\?#].*|$/, "?search="+keyword );
    });

    $('#list-house-search-button').click(function() {
        var keyword = $('#list-house-search-input').val();
        window.location.href = window.location.href.replace( /[\?#].*|$/, "?search="+keyword );
    });
};

/* Change Role user
 ------------------------------------------------ */
var handleRoleUser = function(){
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

};

/* change house status
 ------------------------------------------------ */
var handleHouseStatus = function(){
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
};

/* Set house at home
 ------------------------------------------------ */
var handleHouseHome = function(){
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
};

/* Set user at home
 ------------------------------------------------ */
var handleUserHome = function () {
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
};

/* Set project at home
 ------------------------------------------------ */
var handleProjectHome = function () {
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
};

/* project modal remove
 ------------------------------------------------ */
var handleProjectRemove = function () {
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
        removeProject(projectId)
    });
}


/* Api Delete Project
 ------------------------------------------------ */
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

/* Application Controller
 ------------------------------------------------ */
$(document).ready(function(){

    handleSearchButton();
    handleRoleUser();
    handleHouseStatus();
    handleHouseHome();
    handleUserHome();
    handleProjectHome();
    handleProjectRemove();

});