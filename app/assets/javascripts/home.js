
var delId = "";
function changeDeleteId(userRow){
	delId = $(userRow).parent().parent().find(".UserID").html();
}

function deleteUser(){
	console.log(delId);
	var userID = delId;
	$.ajax({
		url: localhost+"/home/delete/"+userID+".json", //ke PHP nya
		header: {
			"Access-Control-Allow-Origin": localhost
		},
			type: 'POST',
			data: {
				_method: 'DELETE'
			},

			success: function (returnData) {
				alert("data berhasil di delete!");
				window.location.reload(true);

			},error: function (statusText, jqXHR, returnText) {
				console.log(statusText);
				console.log(jqXHR);
				console.log(returnText);
			}, complete: function (data) {

			}
	});
}

$(document).ready(function() {
	$("#submitNewUser").on('click',function(){
		//var authenticityToken = $('#authenticity_token').val();
		var userUsername = $('#userUsername').val();
		var userPassword = $('#userPassword').val();  
		var userConfirmPassword = $('#userConfirmPassword').val();
		var userType = $('#userType').val();
		alert(userUsername+" "+userPassword+" "+userConfirmPassword+" "+userType);
		$.ajax({
			url: localhost+"/home/create.json", //ke PHP nya
			type: 'POST',
			data: {
				_method : "POST",
				//authenticity_token : authenticityToken,
				"user[username]" : userUsername,
				"user[password]" : userPassword,
				"user[password_confirmation]" : userConfirmPassword,
				"user[user_type]" : userType
			},
			success: function (returnData) {
				alert("data berhasil di input!");
				window.location.reload(true);

			},error: function (statusText, jqXHR, returnText) {
			alert(statusText+" "+jqXHR+" "+returnText);
				console.log(statusText);
				console.log(jqXHR);
				console.log(returnText);
			}, complete: function (data) {
			}
		});
	});
});
