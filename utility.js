/* ============================== */
/*          Validation            */
/* ============================== */

function stripSpecial(phoneNum){
    var clean = phoneNum
    var special = [' ','`','~','!','@','#','$','%','^','&','*','(',')','-','_','=','+',';',':','.','<','>','\\','|','[',']','{','}','\'','\"',',','/','?'];
    for (var i = special.length - 1; i >= 0; i--) {
        clean = clean.split(special[i]).join('');
    };
    return clean;
}

function isEmailValid(email){
    var regex = /[^ @]*@[^ @]*\.[^ @]/g;
    if (!email.match(regex)) return false;
    return true;
}

function isPhoneValid(phone){
    var regex = /^[1-9][0-9]{9,}/g;
    cleanPhone = stripSpecial(phone);
    if (cleanPhone.match(regex) && cleanPhone.length <= 11){
        if (cleanPhone.length == 11 && cleanPhone.substring(0,1) !== "1"){
            return false;
        } else {
            return true;
        }
    }
    return false;
}

function trimPhone(phone){
    cleanPhone = stripSpecial(phone);
    if (cleanPhone.length >= 11){
        return cleanPhone.substring(1,11);
    } else {
        return cleanPhone;
    }
}
