'======================================'
'        General Utility Functions     '
'======================================'

Function in_array(element, arr)
    For i=0 To Ubound(arr) 
        If Trim(arr(i)) = Trim(element) Then 
            in_array = True
            Exit Function
        Else 
            in_array = False
        End If 
    Next 
End Function

Function regExTest(strPattern, strTest)
  dim regEx: set regEx = New RegExp
  regEx.Pattern = strPattern
  regEx.Global = true
  regExTest = regEx.test(strTest)
  set regEx = nothing
End Function

Function Push(ByRef arrayIn, varElement)
   ReDim preserve arrayIn(UBound(arrayIn) + 1)
   arrayIn(UBound(arrayIn)) = varElement
   Push = UBound(arrayIn)
End Function

function cleanSQL(val)
  temp = replace(val,";","")
  temp = replace(temp,"--","")
  temp = replace(temp,"'","")
  temp = replace(temp,"=","")
  temp = replace(temp,"#","")
  temp = replace(temp,"$","")
  temp = replace(temp,"%","")
  temp = replace(temp,"^","")
  temp = replace(temp,"&","")
  temp = replace(temp,"*","")
  temp = replace(temp,"|","")
  temp = replace(temp,"<","&lt;")
  temp = replace(temp,">","&gt;")
  temp = replace(temp,"""","")
  temp = replace(temp,"(","")
  temp = replace(temp,")","")
  temp = replace(temp,"/*","")
  temp = replace(temp,"@@","")
  temp = replace(temp,"cursor","")
  temp = replace(temp,"exec","")
  temp = replace(temp,"execute","")
  temp = replace(temp,"nchar","")
  temp = replace(temp,"varchar","")
  temp = replace(temp,"nvarchar","")
  temp = replace(temp,"iframe","")
  temp = replace(temp,"!","")
  cleanSQL = temp
end function

Function getNumSuffix(num)
  lastDigit = Right(num&"",1)
  if cint(num) = 11 then
    out = "th"
  elseif cint(num) = 12 then
    out = "th"
  elseif cint(num) = 13 then
    out = "th"
  else
    Select case lastDigit
      case 1
        out = "st"
      case 2
        out = "nd"
      case 3
        out = "rd"
      case else
        out = "th"
    End Select  
  end if
  getNumSuffix = out
end function

function stripSpecial(phoneNum)
    clean = phoneNum
    special = array(" ","`","~","!","@","#","$","%","^","&","*","(",")","-","_","=","+",";",":",".","<",">","\","|","[","]","{","}","'","""",",","/","?")
    for i = 0 to ubound(special)
        clean = join(split(clean, special(i)),"")
    next
    stripSpecial = clean
end function

'======================================'
'          Validation Functions        '
'======================================'

function isPhoneValid(phone)
    regex = "^[1-9][0-9]{9,}"
    cleanPhone = stripSpecial(phone)
    regIsValid = regExTest(regex, cleanPhone)
    isPhoneValid = false
    if (regIsValid and len(cleanPhone) <= 11) then
        if not (len(cleanPhone) = 11 and left(cleanPhone,1) <> "1") then
            isPhoneValid = true
        end if
    end if
end function

function isEmailValid(email)
    regex = "[^ @]*@[^ @]*\.[^ @]"
    if regExTest(regex, email) then
      isEmailValid = true
    else
      isEmailValid = false
    end if
end function

function trimPhone(phone)
    cleanPhone = stripSpecial(phone)
    if len(cleanPhone) >= 11 then
        trimPhone = right(cleanPhone, 10)
    else 
        trimPhone = cleanPhone
    end if
end function
