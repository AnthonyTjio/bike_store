function getEvent(e){
	if(e.keyCode == 13){
		findCustomerData();
		alert('test');
	}
}

function findCustomerData(){
	var customerID = $('#orderCustomerID').val();
	$.ajax({
		url: localhost+"/customers/"+customerID+".json",
		type: "GET",
		success: function(returnData){
			$("#orderCustomerName").val(returnData.customer_name);
			$("#orderCustomerAddress").val(returnData.customer_address);
			$("#orderCustomerPhone").val(returnData.customer_phone);
			
			$("#orderCustomerName").attr("disabled", true);
			$("#orderCustomerAddress").attr("disabled", true);
			$("#orderCustomerPhone").attr("disabled", true);
			
		},
		error: function(statusText, jqXHR, returnText){
			$("#orderCustomerName").val("");
			$("#orderCustomerAddress").val("");
			$("#orderCustomerPhone").val("");
			
			$("#orderCustomerName").attr("disabled", false);
			$("#orderCustomerAddress").attr("disabled", false);
			$("#orderCustomerPhone").attr("disabled", false);
		}
	});
}

function checkCustomerData(){
	var customerID = $('#orderCustomerID').val();
	var answer = null;
	$.ajax({
		url: localhost+"/customers/"+customerID+".json",
		type: "GET",
		async: false, 
		success: function(returnData){
			answer =  true;
		},
		error: function(statusText, jqXHR, returnText){
			answer =  false;
		}
	});
	return answer;
}

function orderSetCustomerData(){
	var customerID = $('#orderCustomerID').val();
	var customerName = $('#orderCustomerName').val();
	var customerAddress = $('#orderCustomerAddress').val();  
	var customerPhone = $('#orderCustomerPhone').val();
	
	var existence = false;
	
	if(customerID) existence = checkCustomerData();
	var ok = false;
	if(existence){ // kalo udah ada kita langsung proses
		ok = true;
	}
	else{ // kalo belum ada, kita masukin DB dulu
		$.ajax({
			url: localhost+"/customers.json", //ke PHP nya
			type: 'POST',
			async: false, 
			data: {
				mode: 'POST',//ini mode buat di php nya ton buat else if nya tapi gak gw buatin phpnya yak
				//authenticity_token : authenticity_token,
				"customer[customer_name]" : customerName,
				"customer[customer_address]" : customerAddress,
				"customer[customer_phone]" : customerPhone
			},
			success: function (returnData) {
				ok = true;
				customerID = returnData.customer.id;
				$('#orderCustomerID').append("<option value='"+customerID+"'>"+customerID+" - "+customerName+"</option>")
				$('#orderCustomerID').val(customerID);

			},error: function (statusText, jqXHR, returnText) {
				var errorMessage = JSON.parse(statusText.responseText).errors;
				
				$.each(errorMessage, function(key, value) {
					$('#order_' + key + '_header').attr("hidden", false);
					$('#order_' + key + '_alert').html(value);
				    console.log(key, value);
				});
				
				ok = false;
				console.log(errorMessage);
			}
		});
	}
	
	if(ok){
		$.ajax({
			url: localhost+"/orders.json",
			type: 'POST',
			data: {
				mode: 'POST',
				"customer[id]": customerID,
				"customer[customer_name]" : customerName,
				"customer[customer_address]" : customerAddress,
				"customer[customer_phone]" : customerPhone
			},
			success: function(returnData){
				//alert("Order Created!");
				console.log(returnData);
			},
			error: function(status,jqXHR,returnText){
				console.log(status);
				// var errorMessage = JSON.parse(returnText.responseText).errors;
				// console.log(errorMessage);
			}
		})
	}
	
	
	
	
}

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