EXPORT Validate_Address(

  string pAddress_Line1
 ,string pCity
 ,string pState
 ,string pZip
  
) :=
function

  is_valid := 
    ~(
                                    length(trim(pAddress_Line1,left,right)) < 5       // -- length less than 5 characters
      or      regexfind('^[[:digit:]]*$'  ,trim(pAddress_Line1,left,right)  ,nocase)  // -- or address line 1 is all numbers
      or  not regexfind('[[:digit:]]'     ,trim(pAddress_Line1,left,right)  ,nocase)  // -- or no numbers in address line 1
     
      or                            trim(pCity,left,right) = ''                       // -- or city is blank
      or  regexfind('[^[:alpha:] ]',trim(pCity,left,right)  ,nocase)                  // -- or city contains non-alpha characters(space is ok though)
     
      or         trim(pZip,left,right)       = ''                                     // -- or zip is blank
      or  length(trim(pZip,left,right))     != 5                                      // -- or zip isn't 5 characters
      or         trim(pZip,left,right)[1..3] = '000'                                  // -- or zip starts with 3 zeros.
    );


  return is_valid;

end;