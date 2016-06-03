var delId = "";
function changeDeleteId(bikeRow){
	delId = $(bikeRow).parent().parent().find(".CustomerID").html() 	;
}

function deleteListOrder(){
	console.log(delId);
	var bikeID = delId;
	$.ajax({
		url: "", //ke PHP nya
			type: 'GET',
			data: {
				mode: '',//ini mode buat di php nya ton
				bikeID : bikeID
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
function showCustomer(element){
	$("#reviseData").css("display","block");
	$("#reviseCustomerID").val($(element).parent().parent().find(".customerID").html());
	$("#reviseCustomerName").val($(element).parent().parent().find(".customerName").html());
	$("#reviseOrderDate").val($(element).parent().parent().find(".orderDate").html());
	$("#reviseOrderTime").val($(element).parent().parent().find(".orderTime").html());
	$('reviseStatus').val($(element).parent().parent().find("input:checked").html()); //MASIH BLOM BENER TON
	$("#reviseData").append('<H2>NTAR DI EDIT LAGI TON</H2>');
	
}

$(document).ready(function() {
	$("#buttonReviseOrder").on('click',function(){
		var customerID = $('#reviseCustomerID').val();
		var customerName = $('#reviseCustomerName').val();
		var orderDate = $('#reviseOrderDate').val();    
		var orderTime = $('#reviseOrderTime').val();
		var status = $('').val(); //MASIH BELOM BENER TON
		$.ajax({
			url: "", //ke PHP nya
			type: 'GET',
			data: {
				mode: '',//ini mode buat di php nya ton buat else if nya tapi gak gw buatin phpnya yak
				customerID : customerID,
				customerName : customerName,
				orderDate : orderDate,
				orderTime : orderTime,
				status : status
			},
			success: function (returnData) {
				alert("data berhasil di input!");
				window.location.reload(true);

			},error: function (statusText, jqXHR, returnText) {
				console.log(statusText);
				console.log(jqXHR);
				console.log(returnText);
			}, complete: function (data) {

			}
		});
	});

});