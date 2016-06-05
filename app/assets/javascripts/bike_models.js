function editModelDetail(element){
	$("#reviseData").css("display","block");
	$("#reviseModelID").val($(element).parent().parent().find(".BikeModelID").html());
	$("#reviseModelName").val($(element).parent().parent().find(".BikeModelName").html());
}

function editBikeModel(){
	console.log(delId);
	var modelID = $('#reviseModelID').val();
	var modelName = $('#reviseModelName').val();
	$.ajax({
		url: localhost+"/bike_models/"+modelID+".json",
		type: 'POST',
		data: {
			_method: "PUT",
			"bike_model[bike_model_name]": modelName
		},
		success: function(returnData){
			alert("Model successfully updated!");
			window.location.reload(true);
		},
		error: function(statusText, jqXHR, returnText){
			var modelNameErrorMessage = JSON.parse(statusText.responseText).errors;
			$('#reviseModelNameAlert').html(modelNameErrorMessage);			
			console.log(modelNameErrorMessage);

		}
	});
}

$(document).ready(function() {
	$("#submitNewModel").on('click',function(){
		//var authenticityToken = $('#authenticity_token').val();
		var modelName = $('#newModelName').val();
		$.ajax({
			url: localhost+"/bike_models.json", //ke PHP nya
			type: 'POST',
			data: {
				mode: 'POST',
				"bike_model[bike_model_name]" : modelName
			},
			success: function (returnData) {
				alert("data berhasil di input!");
				window.location.reload(true);

			},error: function (statusText, jqXHR, returnText) {
				var errorMessage = JSON.parse(statusText.responseText)[0].message;
				alert(errorMessage)
			}
		});
	});
});