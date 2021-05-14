EXPORT Validate_Contact_Name(

   string   pFirst_Name
  ,string   pLast_Name
  ,string   pBusiness_Name
  ,boolean  pIsTesting      = false
) :=
function

  first_name := trim(pFirst_Name,left,right);
  last_name  := trim(pLast_Name ,left,right);
  full_name  := trim(pFirst_Name,left,right) + ' ' + trim(pLast_Name,left,right);


  // -- contact name is not valid if any of the following conditions are met
  is_not_valid := 
    
                regexfind('[[:digit:]]'     ,full_name  ,nocase)        // contains digits
      or      (         regexfind('[^[:alpha:] ]'    ,full_name  ,nocase)  // contains special character
                and not regexfind('[-\'][:alpha:]'  ,full_name  ,nocase)  // and doesn't have character after - or '
              )
     
      or trim(pFirst_Name,left,right) = trim(pBusiness_Name,left,right)
      or trim(pLast_Name ,left,right) = trim(pBusiness_Name,left,right)
      or trim(full_name  ,left,right) = trim(pBusiness_Name,left,right)
     
      or regexfind(Marketing_List._Config().business_terms_regex     ,full_name  ,nocase) // contains business terms
 
      or (length(first_name) = 1 and length(last_name) = 1)
      or (first_name = '' and last_name = '')                             // other fields such as lexid, empid, titles, contact address, etc won't be populated if there is no name
      or (first_name != '' and last_name  = 'NULL' or last_name  = '')
      or (last_name  != '' and first_name = 'NULL' or first_name = '')
  ;

  // -- Not the above condition.  So this is true if valid
  is_valid := ~(is_not_valid);

  ds_debug_condition := dataset([
    {'regexfind(\'[[:digit:]]\'       ,full_name  ,nocase)'                                 ,regexfind('[[:digit:]]'     ,full_name  ,nocase)                                 }
   ,{'or (regexfind(\'[^[:alpha:]]\'      ,full_name  ,nocase'                              ,regexfind('[^[:alpha:] ]'    ,full_name  ,nocase)                                 }
   ,{'and not regexfind(\'[-\\\'][:alpha:]\'  ,full_name  ,nocase)'                         ,regexfind('[-\'][:alpha:]'  ,full_name  ,nocase)                                 }
   ,{'or trim(pFirst_Name,left,right) = trim(pBusiness_Name,left,right)'                    ,trim(pFirst_Name,left,right) = trim(pBusiness_Name,left,right)                   }
   ,{'or trim(pLast_Name ,left,right) = trim(pBusiness_Name,left,right)'                    ,trim(pLast_Name ,left,right) = trim(pBusiness_Name,left,right)                   }
   ,{'or trim(full_name  ,left,right) = trim(pBusiness_Name,left,right)'                    ,trim(full_name  ,left,right) = trim(pBusiness_Name,left,right)                   }
   ,{'or regexfind(Marketing_List._Config().business_terms_regex     ,full_name  ,nocase)'  ,regexfind(Marketing_List._Config().business_terms_regex     ,full_name  ,nocase) }
   ,{'or (length(first_name) = 1 and length(last_name) = 1)'                                ,(length(first_name) = 1 and length(last_name) = 1)                               }
   ,{'or (first_name = \'\' and last_name = \'\')                         '                 ,(first_name = '' and last_name = '')                                             }
   ,{'or (first_name != \'\' and last_name  = \'NULL\' or last_name  = \'\')'               ,(first_name != '' and last_name  = 'NULL' or last_name  = '')                    }
   ,{'or (last_name  != \'\' and first_name = \'NULL\' or first_name = \'\')'               ,(last_name  != '' and first_name = 'NULL' or first_name = '')                    }
  
  ] ,{string statname ,boolean statvalue});

  
  return when(is_valid  ,if(pIsTesting = true ,output(ds_debug_condition  ,named('ds_debug_condition'))));
   
end;