function viewProductDetail(element){
	var productID = $(element).parent().parent().find(".ProductID").html();
	window.location = localhost+"/inventory/check/"+productID;
	/*
	$.ajax({
		url: localhost+"/inventory/check/"+productID,
		type: 'GET',
		success: function (returnData){
			document.write(returnData);
		}
	})
	*/
}

// -----------FOR ADDING AN ITEM--------------
var currentQty = '';
var currentQtyInt = '';
var additionalQty = '';
var additionalQtyInt = '';
var totalQty = ''
// -------------------------------------------

// ------------FOR REVISE AN ITEM-------------
var lossStock = '';
var currStock = '';
var newStock = '';
// -------------------------------------------
function calculateTotalQty(){
	currentQtyInt = parseInt(currentQty);
	additionalQty = $("#addQtyAdditionalStock").val();
	additionalQtyInt = parseInt(additionalQty);
	totalQty = additionalQtyInt + currentQtyInt;
	console.log(totalQty);
	$("#addQtyTotalStock").val(totalQty);
}

function calculateNewStock() {
	currStock = parseInt($("#reviseQtyCurrentStock").val());
	lossStock = parseInt($("#reviseQtyAdditionalStock").val());
	newStock = currStock - lossStock;
	$("#reviseQtyTotalStock").val(newStock);
}

function editProductData(element){
	$('#addQtyData').css("display","none");
	$('#reviseQtyData').css("display","none");
	$("#reviseProductData").css("display","block");
	$("#reviseProductID").val($(element).parent().parent().find(".ProductID").html());
	$("#reviseProductName").val($(element).parent().parent().find(".ProductName").html());
	$("#reviseProductModel").val($(element).parent().parent().find(".ProductModel").html());
	$("#reviseProductSize").val($(element).parent().parent().find(".ProductSize").html());
	$("#reviseProductPrice").val($(element).parent().parent().find(".ProductPrice").html());
}

function addQtyData(element){
	$("#reviseProductData").css("display","none");
	$('#reviseQtyData').css("display","none");
	$('#addQtyData').css("display","block");
	$("#addQtyProductID").val($(element).parent().parent().find(".ProductID").html());
	$("#addQtyProductName").val($(element).parent().parent().find(".ProductName").html());
	$("#addQtyCurrentStock").val($(element).parent().parent().find(".ProductQty").html());
	currentQty = $(element).parent().parent().find(".ProductQty").html();
	// $("#addQtyTotalStock").val($(element).parent().parent().find(".ProductQty").html());
}

function reviseQtyData(element){
	$("#reviseProductData").css("display","none");
	$('#addQtyData').css("display","none");
	$('#reviseQtyData').css("display","block");
	$("#reviseQtyProductID").val($(element).parent().parent().find(".ProductID").html());
	$("#reviseQtyProductName").val($(element).parent().parent().find(".ProductName").html());
	$("#reviseQtyCurrentStock").val($(element).parent().parent().find(".ProductQty").html());
	//$("#reviseQtyTotalStock").val($(element).parent().parent().find(".ProductQty").html());
}

function createProduct(){
	var productName = $('#newProductName').val();
	var productModel = $('#newProductModel').val();
	var productSize = $('#newProductSize').val();
	var productPrice = $('#newProductPrice').val();
	var productStock = $('#newProductInitialStock').val();
	
	$.ajax({
		url: localhost+"/products.json",
		type: 'POST',
		data: {
			"product[bike_name]": productName,
			"product[bike_model_id]": productModel,
			"product[bike_size]": productSize,
			"product[price]": productPrice,
			"stock[qty]": productStock
		},
		success: function(returnData){
			alert("Product successfully created!");
			window.location.reload(true);
		},
		error: function(statusText, jqXHR, returnText){
			//alert(statusText+" "+jqXHR+" "+returnText);
			var errorMessage = JSON.parse(statusText.responseText).errors;
			
			$.each(errorMessage, function(key, value) {
				$('#new_product_' + key + '_header').attr("hidden", false);
				$('#new_product_' + key + '_alert').html(value);
			    console.log(key, value);
			});
			
			console.log(errorMessage);
			//console.log(stockErrorMessage);
		}
	});
}

function editProduct(){
	var productID = $('#reviseProductID').val();
	var productPrice = $('#reviseProductPrice').val();
	
	$.ajax({
		url: localhost+"/products/"+productID+".json",
		type: 'POST',
		data: {
			_method: "PUT",
			"product[price]": productPrice
		},
		success: function(returnData){
			alert("Product successfully updated!");
			window.location.reload(true);
		},
		error: function(statusText, jqXHR, returnText){
			//alert(statusText+" "+jqXHR+" "+returnText);
			var errorMessage = JSON.parse(statusText.responseText).errors;
			
			$.each(errorMessage, function(key, value) {
				$('#revise_product_' + key + '_header').attr("hidden", false);
				$('#revise_product_' + key + '_alert').html(value);
			    console.log(key, value);
			});
			
			console.log(errorMessage);
			//console.log(stockErrorMessage);
		}
	});
}

function addQty(){
	var product = $('#addQtyProductID').val();
	var alteration = $('#addQtyAdditionalStock').val();
	var description = $('#addQtyDescription').val();
	var type = true;

	
	$.ajax({
		url: localhost+"/stock_histories.json",
		type: 'POST',
		data: {
			"stock_history[product]": product,
			"stock_history[alteration]": alteration,
			"stock_history[description]": description,
			"stock_history[type]": type
		},
		success: function(returnData){
			alert("Product stock successfully added!");
			window.location.reload(true);
		},
		error: function(statusText, jqXHR, returnText){
			//alert(statusText+" "+jqXHR+" "+returnText);
			var errorMessage = JSON.parse(statusText.responseText).errors;		

			$.each(errorMessage, function(key, value) {
				$('#add_qty_' + key + '_header').attr("hidden", false);
				$('#add_qty_' + key + '_alert').html(value);
			    console.log(key, value);
			});
			
			console.log(errorMessage);
			//console.log(stockErrorMessage);
		}
	});
}

function reviseQty(){
	var product = $('#reviseQtyProductID').val();
	var alteration = $('#reviseQtyAdditionalStock').val();
	var description = $('#reviseQtyDescription').val();
	var type = false;

	
	$.ajax({
		url: localhost+"/stock_histories.json",
		type: 'POST',
		data: {
			"stock_history[product]": product,
			"stock_history[alteration]": alteration,
			"stock_history[description]": description,
			"stock_history[type]": type
		},
		success: function(returnData){
			alert("Product stock successfully updated!");
			window.location.reload(true);
		},
		error: function(statusText, jqXHR, returnText){
			//alert(statusText+" "+jqXHR+" "+returnText);
			var errorMessage = JSON.parse(statusText.responseText).errors;		

			$.each(errorMessage, function(key, value) {
				$('#revise_qty_' + key + '_header').attr("hidden", false);
				$('#revise_qty_' + key + '_alert').html(value);
			    console.log(key, value);
			});
			
			console.log(errorMessage);
			//console.log(stockErrorMessage);
		}
	});
}

function getProductHistory(){
	var product = $('#reviseProductID').val();
	var startDate = $('#productHistoryStartingDate').val();
	var endDate = $('#productHistoryEndingDate').val();
	
	$("#product_history_track").empty();

	$.ajax({	
		url: localhost+"/inventory/product_history.json",
		type: 'POST',
		data: {
			"product": product,
			"start_date": startDate,
			"end_date": endDate
		},
		success: function(returnData){
			var report = returnData.product_track;
			var starting_stock = returnData.starting_stock;
			var ending_stock = returnData.ending_stock;

			
			var table_data = "";
			table_data += "Starting Stock: "+starting_stock+"<br />";
			table_data += "Ending Stock: "+ending_stock+"<br />";

			$.each(report, function (d, data){
				var date = new Date(data.created_at);

				table_data +="<ul><li>Updated On: "+dateFormat(date, "mm/dd/yyyy")+"</td>";
				if(data.alteration>0){
					table_data +="<li>Status: In</li>";
					table_data +="<li>Changes: "+data.alteration+"</li>";
				}
				else{
					table_data +="<li>Status: Out</li>";
					table_data +="<li>Changes: "+(data.alteration*-1)+"</li>";
				}
				table_data +="<li>Description: "+data.description+"</li></ul>";
			});

			$('#product_history_track').append(table_data);


		}
	});
}
