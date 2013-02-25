/* ============================== */
/*       Clonable Fields          */
/* ============================== */

function getAttrNum(str, pos){
    var arr = str.split('-');
    return arr[pos];
}

function getNewAttr(str, newNum){
    arr = str.split('-');
    arr[1] = newNum;
    var out = arr.join('-');
    return out;
}

function childRecursive(element, func){
    func(element);
    var children = element.children();
    if (children.length > 0) {
        children.each(function (){
            childRecursive($(this), func);
        });
    }
}

function clearCloneValues(element){
    if (element.attr('value') !== undefined){
        element.val('');
    }
}

function setCloneAttr(element, value){
    if (element.attr('id') !== undefined){
        element.attr('id',getNewAttr(element.attr('id'),value));
    } else {}
    if(element.attr('name') !== undefined){
        element.attr('name',getNewAttr(element.attr('name'),value));
    } else {}
    if (element.attr('for') !== undefined){
        element.attr('for',getNewAttr(element.attr('for'),value));
    } else {}
}

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
