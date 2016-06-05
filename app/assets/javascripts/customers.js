function showCustomerData(element){
	$("#reviseData").css("display","block");
	$("#reviseCustomerID").val($(element).parent().parent().find(".CustomerID").html());
	$("#reviseCustomerName").val($(element).parent().parent().find(".CustomerName").html());
	$("#reviseCustomerAddress").val($(element).parent().parent().find(".CustomerAddress").html());
	$("#reviseCustomerPhone").val($(element).parent().parent().find(".CustomerPhone").html());
}

var delId = "";
function changeDeleteId(customerRow){
	delId = $(customerRow).parent().parent().find(".CustomerID").html();
}

function editCustomer(){
	var customerID = $('#reviseCustomerID').val();
	var customerAddress = $('#reviseCustomerAddress').val();
	var customerPhone = $('#reviseCustomerPhone').val();
	$.ajax({
		url: localhost+"/customers/"+customerID+".json",
		type: "POST",
		data: {
			_method: "PUT",
			"customer[customer_address]" : customerAddress,
			"customer[customer_phone]" : customerPhone
		},
		success: function(returnData){
			alert(returnData.message);
			window.location.reload(true);
		},
		error: function(statusText, jqXHR, returnText){
			var errorMessage = JSON.parse(statusText.responseText).errors;
			$.each(errorMessage, function(key, value) {
				$('#revise_' + key + '_header').attr("hidden", false);
				$('#revise_' + key + '_alert').html(value);
			    console.log(key, value);
			});
			console.log(errorMessage);
		}

	});
}

$(document).ready(function() {
	$("#submitNewCustomer").on('click',function(){
		//var authenticityToken = $('#authenticity_token').val();
		var customerName = $('#customerName').val();
		var customerAddress = $('#customerAddress').val();  
		var customerPhone = $('#customerPhone').val();
		$.ajax({
			url: localhost+"/customers.json", //ke PHP nya
			type: 'POST',
			data: {
				mode: 'POST',//ini mode buat di php nya ton buat else if nya tapi gak gw buatin phpnya yak
				//authenticity_token : authenticity_token,
				"customer[customer_name]" : customerName,
				"customer[customer_address]" : customerAddress,
				"customer[customer_phone]" : customerPhone
			},
			success: function (returnData) {
				alert(returnData.message);
				window.location.reload(true);

			},error: function (statusText, jqXHR, returnText) {
				var errorMessage = JSON.parse(statusText.responseText).errors;
				
				$.each(errorMessage, function(key, value) {
					$('#add_' + key + '_header').attr("hidden", false);
					$('#add_' + key + '_alert').html(value);
				    console.log(key, value);
				});
				
				console.log(errorMessage);
			}
		});
	});
});