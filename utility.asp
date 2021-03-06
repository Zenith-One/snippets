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

function stripTags(str)
    dim openPos, closePos, tmp, before, after
    tmp = str
    'get first <'
    openPos  = instr(tmp,"<")
    if openPos = 0 then
        stripTags = tmp
        exit function
    else 
        closePos = instr(openPos,tmp,">")
    end if
    if closePos = 0 then
        stripTags = tmp
        exit function
    end if
    'echo openPos & " " & closePos
    if openPos > 1 then
        before =  left(tmp, openPos  - 1)
    else
        before = ""
    end if
    if closePos < len(tmp) then
        after  = right(tmp, (len(tmp) - closePos))
    else
        after = ""
    end if
    stripTags = trim(stripTags(before & " " & after))
    'stripTags = trim(before & " " & after)
end function

function camelToProper(str)
    dim a, b, i, tmp, added
    a = str
    b = lcase(a)
    tmp = a

    added = 0
    for i = 1 to len(a)
        if mid(a,i,1) <> mid(b,i,1) and i > 1 then
            tmp = left(tmp,i - 1 + added)  & " " & right(tmp,len(tmp) - i + 1 - added)
            added = added + 1
        end if
    next
    tmp = ucfirst(tmp)
    camelToProper = tmp
end function

function ucfirst(str)
    ucfirst = ucase(left(str,1)) & right(str,len(str) - 1)
end function

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


'======================================'
'             Misc Functions           '
'======================================'

' populates state select box
function getStatesOption()
    statesShort = array("","AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY")
	statesLong = array("--Please Select--","Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming")
	for stateCount = 0 to uBound(statesShort)
		temp = temp & "<option value=""" & statesShort(stateCount) & """>" & statesLong(stateCount) & "</option>"
	next
	getStatesOption = temp
end function

function GetSubstringCount(strToSearch, strToLookFor, caseCheck)
  if caseCheck then
    GetSubstringCount = UBound(split(strToSearch, strToLookFor))
  else
    GetSubstringCount = UBound(split(UCase(strToSearch), UCase(strToLookFor)))
  end if
end function

