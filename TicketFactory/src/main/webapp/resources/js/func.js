// Trim
String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
};


// showPrice(공연티켓가격)에서 숫자만 불러오기
function splitPrice(showPrice) {
	
	var priceTest = showPrice.split(" ");
	
	var price1 = priceTest[0]; // ex) 전석
	var price2 = priceTest[1]; // ex) 20,000원
	
	var price = "";
	
	for (var i=0; i<price2.length; i++) {
		
		if(price2.charAt(i) != "," && price2.charAt(i) != "원") {
			price += price2.charAt(i);
		}
	}
	return price;
}

function chkNumber(data) {
	
	var format = /^[0-9]+$/;
	
	if(data.search(format) != -1)
		return true;
	
	return false;
}