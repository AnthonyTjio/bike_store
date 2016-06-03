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

function deleteCustomer(){
	console.log(delId);
	var customerID = delId;
	$.ajax({
		url: localhost+"/customers/"+customerID+".json", //ke PHP nya
			type: 'POST',
			data: {
				_method: "delete"
			},

			success: function (returnData) {
				alert("data berhasil di delete!");
				window.location.reload(true);

			},error: function (statusText, jqXHR, returnText) {
				alert("error: "+statusText+" "+jqXHR);
				console.log(statusText);
				console.log(jqXHR);
				console.log(returnText);
			}, complete: function (data) {
				console.log(data);
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