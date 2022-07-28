/**
 * 회원가입시 각 항목에 대한 입력 유효성 판단 
 */
	/* 이름 유효성 검사 */
	function checkNAME(){
		let name = document.getElementById("NAME").value;
		let warning = document.getElementById("NameWarning");
		var regExpNAME = /^[가-힣]*$/
		
		if(!regExpNAME.test(name)){
			warning.innerHTML = '<p id="warning"> 한글만 입력 가능합니다. </p>';
		}
		if(name.length < 2){
			warning.innerHTML = '<p id="warning"> 이름은 2글자 이상 입력해주세요 </p>';
		} 
		if(name.length > 9){
			warning.innerHTML = '<p id="warning"> 입력하신 이름 정보를 확인해주세요 </p>';
		} 
	}

	function typingNAME(){
		let warning = document.getElementById("NameWarning");
		warning.innerHTML = "";
	}
	
	/* 아이디 유효성검사  */
	function checkID(){
		let id = document.getElementById("userID").value;
		let warning = document.getElementById("IDWarning");
		var regExpID = /^[0-9a-zA-Z]*$/
		
		if(!regExpID.test(id)){
			warning.innerHTML = '<p id="warning"> 영어 대소문자와 숫자만 입력 가능합니다. </p>';
		}
		if(id.length < 3){
			warning.innerHTML = '<p id="warning"> 아이디를 3글자 이상으로 입력해주세요 </p>';
		} 
		if(id.length > 13){
			warning.innerHTML = '<p id="warning"> 아이디를 12글자 이하로 입력해주세요 </p>';
		} 
	}

	function typingID(){
		let warning = document.getElementById("IDWarning");
		warning.innerHTML = "";
	}
	
	/* 이메일 유효성 검사 */
	function checkEM(){
		let email = document.getElementById("email").value;
		let warning = document.getElementById("EMWarning");
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/
		
		if(!regExpEmail.test(email)){
			warning.innerHTML = '<p id="warning"> 이메일 입력 정보를 확인해 주세요. </p>';
		}
	}

	function typingEM(){
		let warning = document.getElementById("EMWarning");
		warning.innerHTML = "";
	}
	
	/* 폰번호 유효성 검사 */
	function checkPH(){
		let phone = document.getElementById("phone").value;
		let warning = document.getElementById("PHWarning");
		var regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/ 
		
		if(!regExpPhone.test(phone)){
			warning.innerHTML = '<p id="warning"> 연락처는 - 를 포함한 형식으로 입력해주세요. </p>';
		}
	}

	function typingPH(){
		let warning = document.getElementById("PHWarning");
		warning.innerHTML = "";
	}
	/* 비밀번호 유효성 검사 */
	function checkPW(){
		let pw = document.getElementById("userPW").value;
		let warning = document.getElementById("PWWarning");
		var regExpPW = /^[0-9a-zA-Z]*$/
		
		if(!regExpPW.test(pw)){
			warning.innerHTML = '<p id="warning"> 영어 대소문자와 숫자만 입력 가능합니다. </p>';
		}
		if(pw.length < 3){
			warning.innerHTML = '<p id="warning"> 비밀번호를 3자 이상 입력해주세요 </p>';
		} 
		if(pw.length > 16){
			warning.innerHTML = '<p id="warning"> 15자 이하로 입력해주세요 </p>';
		} 
	}

	function typingPW(){
		let warning = document.getElementById("PWWarning");
		warning.innerHTML = "";
	}
	
	/* 비밀번호 일치 검사 */
	function checkCFPW()	{
		let pw = document.getElementById("userPW").value;
		let cfpw = document.getElementById("cfPW").value;
		let warning = document.getElementById("CFWarning");
		
		if (pw != cfpw ) {
			warning.innerHTML = '<p id="warning"> 비밀번호가 일치하지 않습니다 </p>';
		}
		if (pw == cfpw ) {
			warning.innerHTML = '<p id="warning"> 비밀번호가 일치합니다 </p>';
		}
	}
	function typingCFPW(){
		let warning = document.getElementById("CFWarning");
		warning.innerHTML = "";
	}
	
	/* 필수 입력  */
	function check(){
		let name = document.getElementById("NAME").value;
		let id = document.getElementById("userID").value;
		let idc = document.getElementById("idcheck").value;
		let pw = document.getElementById("userPW").value;
		let cfpw = document.getElementById("cfPW").value;
		let email = document.getElementById("email").value;
		let phone = document.getElementById("phone").value;
		let birth = document.getElementById("birth").value;

		if(name == ""){
			let warning = document.getElementById("NameWarning");
			warning.innerHTML = '<p id="warning"> 이름을 입력해주세요 </p>';
			return document.signin.userName.focus();
		}
		else if(id == ""){
			let warning = document.getElementById("IDWarning");
			warning.innerHTML = '<p id="warning"> 아이디를 입력해주세요 </p>';
			return document.signin.userID.focus();
		}
		else if( idc == "uncheck"){
			let warning = document.getElementById("IDWarning");
			warning.innerHTML = '<p id="warning"> 아이디 중복확인을 해주세요 </p>';
			return document.signin.userID.focus();
		}
		else if(email == ""){
			let warning = document.getElementById("EMWarning");
			warning.innerHTML = '<p id="warning"> 이메일을 입력해주세요 </p>';
			return document.signin.userEmail.focus();
		}
		else if(phone == ""){
			let warning = document.getElementById("PHWarning");
			warning.innerHTML = '<p id="warning"> 전화번호를 입력해주세요 </p>';
			return document.signin.userPhone.focus();
		}
		else if(pw == ""){
			let warning = document.getElementById("PWWarning");
			warning.innerHTML = '<p id="warning"> 비밀번호를 입력해주세요 </p>';
			return document.signin.userPW.focus();
		}
		else if(cfpw == ""){
			let warning = document.getElementById("CFWarning");
			warning.innerHTML = '<p id="warning"> 비밀번호 확인을 입력해주세요 </p>';
			return document.signin.confirmPW.focus();
		}
		else if(birth == ""){
			let warning = document.getElementById("BDWarning");
			warning.innerHTML = '<p id="warning"> 출생일을 입력해주세요 </p>';
			return document.signin.userBirth.focus();
		}
		else{
		 document.signin.submit();			
		}
	}
	
	function doubleC(){
		let id = document.getElementById("userID").value;
 		window.open('duplicateIDV?userID='+id ,'popup','width=600,height=300'); 
	}
	
	function noblank(obj) { // 공백사용못하게
	    var str_space = /\s/;  // 공백체크
	    if(str_space.exec(obj.value)) { //공백 체크
	        /* alert("해당 항목에는 공백을 사용할수 없습니다.\n\n공백은 자동적으로 제거 됩니다."); */
	        obj.focus();
	        obj.value = obj.value.replace(' ',''); // 공백제거
	        return false;
	    }
	 // onkeyup="noblank(this);" onchange="noSpaceForm(this);"
	}
