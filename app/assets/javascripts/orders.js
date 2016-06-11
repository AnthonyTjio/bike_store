function upToCustomerSection(){
	$('html,body').animate({
        scrollTop: $(".customer-section").offset().top},
        'slow');
}

function upToItemSection(){
	$('html,body').animate({
        scrollTop: $(".customer-section").offset().top},
        'slow');
}

function changeDeleteId(orderItemRow){
	delId = $(orderItemRow).parent().parent().find(".OrderItemID").html();
}

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

function getCustomerDataByOrderID(){
	var orderID = $('#orderItemOrderID').val();
	
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
	var orderID = $('#orderItemOrderID').val();
	
	var existence = false;
	
	if(customerID) existence = checkCustomerData();
	var ok = false;
	
	if(orderID != 0){ // kalo udah ada order ID ga perlu dijalanin
		alert(orderID)
		ok = false;
	}
	else if(existence){ // kalo udah ada kita langsung proses
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
				console.log(returnData);
				 $('#orderItemOrderID').val(returnData.id);
					
					$(".item-section").css("display","block");				
					// --------ANIMATION------------
					$('html,body').animate({
			        scrollTop: $(".item-section").offset().top},
			        'slow');
			        // -------------------------------
				 
			    $('#orderCustomerID').attr("disabled", true);
				$('#orderCustomerName').attr("disabled", true);
				$('#orderCustomerAddress').attr("disabled", true);
				$('#orderCustomerPhone').attr("disabled", true);

				$('#submitCustomerOrder').remove();

				 window.history.pushState('edit/'+returnData.id,'Title','../'+returnData.id+'/edit');
				 //alert("TEST");
			},
			error: function(status,jqXHR,returnText){
				console.log(status);
				// var errorMessage = JSON.parse(returnText.responseText).errors;
				// console.log(errorMessage);
			}
		})
	}

}

function getProductData(){
	var productID = $("#orderItemProductID").val();
	$.ajax({
		url: localhost+"/products/"+productID+".json",
		type: 'GET',
		success: function(returnData){
			var price = returnData.price;
			
			$("#orderItemPrice").val(price);
			$("#orderItemQty").val("");
			$("#orderItemTotalPrice").val("0");
		},
		error: function(status, jqXHR, returnText){
			alert(productID);
			console.log(status);
		}
	});
}

function addToCart(){
	var orderID = $("#orderItemOrderID").val();
	var productID = $("#orderItemProductID").val();
	var qty = $("#orderItemQty").val();
	
	$.ajax({
		url:localhost+"/order_items.json",
		type: 'POST',
		data: {
			_method: "POST",
			"order_item[order_id]": orderID,
			"order_item[product_id]": productID,
<<<<<<< HEAD
			"order_item[qty]": qty
			
=======
			"order_item[qty]": qty,
			"order_item[price]": price
>>>>>>> d51b701324195a510afad3b7cdb2923fd78963b6
		},
		success: function(returnData){
			// update order items table
			console.log(returnData);
		},
		error: function(statusText, jqXHR, returnText){
			alert(returnText);
			var errorMessage = JSON.parse(statusText.responseText).errors;
				
			$.each(errorMessage, function(key, value) {
				$('#order_item_' + key + '_header').attr("hidden", false);
				$('#order_item_' + key + '_alert').html(value);
			    console.log(key, value);
			});
		}
	})
	
}

function deleteOrderItem(){
	var orderItemID = delId;
	$.ajax({
		url: localhost+"/order_items/"+orderItemID+".json",
		type: "POST",
		data: {
			_method: "DELETE",
		},
		success: function(returnData){
			// reload order items table
		},
		error: function(status, jqXHR, returnText){
			console.log(status);
		}
		
	});
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