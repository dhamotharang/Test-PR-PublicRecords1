EXPORT Validate_Email(

  string pEmail_Address

) :=
function

  is_valid := 
    ~(     trim     (              pEmail_Address       )  = ''
      or  ~regexfind('[@]'        ,pEmail_Address,nocase)
      or   regexfind('^[@].*$'    ,pEmail_Address,nocase)   
      or   regexfind('^.*?[@]$'   ,pEmail_Address,nocase)   
      or  ~regexfind('[.]'        ,pEmail_Address,nocase)
    )
   ;
   
   return if(is_valid = true ,pEmail_Address ,'');
   
end;