// -- return whether to suppress the field value('Suppress' = true, '' = false)
EXPORT mac_Suppress_Field(/*recordof(ds_table)*/ pRow  ,/*string*/ pfieldname  ,/*string*/ pfieldvalue  ,/*string*/ pOperation) := 
functionmacro
  // -- filter suppression file to see if the field's values exist in it
  fieldvalue_matches  := lSuppressionFile  
                         (      //fieldvalue is not a regex, do straight comparison
                                ( trim(pfieldvalue) in set(suppressed_field_values(trim(fieldname)[length(trim(fieldname))] != '*'  ,fieldname = pfieldname)  ,trim(fieldvalue)  )  ) 
                                //fieldvalue is regex(last char in fieldname is *), do regex
                            or  (exists(suppressed_field_values(trim(fieldname)[length(trim(fieldname))] = '*'  ,trim(fieldname)[1..length(trim(fieldname))-1] = trim(pfieldname)  ,regexfind(trim(fieldvalue) ,pfieldvalue,nocase)  ))  )
                         );
  
  // -- if they do exist, check to see if all of the context matches, if context exists for these field values
  context_matches     := fieldvalue_matches(
                                       ~exists(context) 
                                    // fieldvalue is not a regex, do straight comparison                        context field value          field value for that fieldname in data
                                    or (count (context) = count(context(trim(fieldvalue)    = trim(get_field_value(fieldname,pRow))))) 
                                    // regex in context fieldname field, fieldvalue is regex(last char in fieldname is *), do regex
                                    or (count (context) = count(context(
                                                                             (trim(fieldname)[length(trim(fieldname))] != '*' and           trim(fieldvalue) = trim(get_field_value(     fieldname                                ,pRow))         )
                                                                          or (trim(fieldname)[length(trim(fieldname))]  = '*' and regexfind(trim(fieldvalue)  ,trim(get_field_value(trim(fieldname)[1..length(trim(fieldname))-1] ,pRow)),nocase) )  
                                                                       )
                                                               )
                                       ) 
                                    
                         );
  // -------------------------------------------------------------------------
  // -- debug suppressions
  // lay_debug_field := {dataset(LinkingTools.layouts.Suppression_field) calcs,LinkingTools.layouts.Suppression_field};
  
  ds_debug := project(lSuppressionFile  ,transform(lay_debug,
     context_exists := exists(left.context);
     count_context  := count(left.context) ;
     self.suppress_debug  := project(left.suppressed_field_values ,transform(lay_debug_field  ,self.calcs := dataset([
                                                                                                {'pfieldvalue'                                      ,pfieldvalue                                        }
                                                                                               ,{'trim(fieldname)[length(trim(fieldname))] != \'*\'',trim(left.fieldname)[length(trim(left.fieldname))] }
                                                                                               ,{'pfieldname'                                       ,pfieldname                                         } 
                                                                                               ,{'fieldvalue'                                       ,left.fieldvalue                                    } 
                                                                                               ,{'trim(fieldname)[length(trim(fieldname))]'         ,trim(left.fieldname)[length(trim(left.fieldname))] } 
                                                                                               ,{'trim(fieldname)[1..length(trim(fieldname))-1]'    ,trim(left.fieldname)[1..length(trim(left.fieldname))-1]      } 
                                                                                              ],LinkingTools.layouts.Suppression_field)
                                                                                              ,self := left
                                                                                              )
                                                                                              );
     self.context_debug  := project(left.context ,transform(lay_debug_field  ,self.calcs := dataset([
                                                                                                {'~exists(context)'                                                             ,~context_exists                                        }
                                                                                               ,{'count (context)'                                                              ,count_context }
                                                                                               ,{'trim(left.fieldvalue)'                                                        ,trim(left.fieldvalue) }
                                                                                               ,{'trim(get_field_value(left.fieldname,pRow))'                                   ,trim(get_field_value(left.fieldname,pRow)) }
                                                                                               ,{'trim(get_field_value(trim(left.fieldname)[1..length(trim(left.fieldname))-1] ,pRow))'                                   ,trim(get_field_value(trim(left.fieldname)[1..length(trim(left.fieldname))-1] ,pRow)) }
                                                                                               ,{'count(context(trim(fieldvalue)    = trim(get_field_value(fieldname,pRow))))'  ,count(dataset(left)(trim(left.fieldvalue)    = trim(get_field_value(left.fieldname,pRow)) ))                                         } 
                                                                                               ,{'trim(fieldname)[length(trim(fieldname))]'         ,trim(left.fieldname)[length(trim(left.fieldname))]                                         } 
                                                                                               ,{'trim(fieldname)[1..length(trim(fieldname))-1]'    ,trim(left.fieldname)[1..length(trim(left.fieldname))-1]      } 
                                                                                               ,{'regexfind(trim(fieldvalue)  ,trim(get_field_value(trim(fieldname)[1..length(trim(fieldname))-1] ,pRow)),nocase)'  ,if(regexfind(trim(left.fieldvalue)  ,trim(get_field_value(trim(left.fieldname)[1..length(trim(left.fieldname))-1] ,pRow)),nocase) = true,'true','false')                                         } 
                                                                                               ,{'count(context(trim(fieldvalue)    = trim(get_field_value(fieldname,pRow))))'  ,count(dataset(left)(trim(left.fieldvalue)    = trim(get_field_value(left.fieldname,pRow))))                                         } 
                                                                                               ,{'count(context(trim(fieldvalue)    = trim(get_field_value(fieldname,pRow)))) ****'  ,count(dataset(left)(
                                                                                                       (trim(left.fieldname)[length(trim(left.fieldname))] != '*' and           trim(left.fieldvalue) = trim(get_field_value(     left.fieldname                                ,pRow))         )
                                                                                                    or (trim(left.fieldname)[length(trim(left.fieldname))]  = '*' and regexfind(trim(left.fieldvalue)  ,trim(get_field_value(trim(left.fieldname)[1..length(trim(left.fieldname))-1] ,pRow)),nocase) )  
                                                                                                 )
                                                                                         )                                         } 
                                                                                            ],LinkingTools.layouts.Suppression_field)
                                                                                              ,self := left
                             ));
     self                 := left;
  ));


  // -------------------------------------------------------------------------

  
  ds_result := project(context_matches  ,transform({recordof(left) - wuid - userid - comment}
    // ,self.suppressed_field_values := left.suppressed_field_values(fieldname = pfieldname,fieldvalue = pfieldvalue)
    ,self.suppressed_field_values := left.suppressed_field_values(
                                          (trim(fieldname)[length(trim(fieldname))] != '*' and trim(fieldname)                               = trim(pfieldname)  and           trim(fieldvalue) = pfieldvalue           )
                                       or (trim(fieldname)[length(trim(fieldname))]  = '*' and trim(fieldname)[1..length(trim(fieldname))-1] = trim(pfieldname)  and regexfind(trim(fieldvalue) , pfieldvalue,nocase)   ) 
                                      )
    ,self := left
  ));

  returnresult := 
  #IF(trim(pOperation) = 'Suppress')
    if(exists(context_matches)  
      ,'Suppress' 
      ,''
    );
  #ELSEIF(trim(pOperation) = 'FieldValues'    )
    ds_result;
  #ELSEIF(trim(pOperation) = 'SuppressionIDs' )
    if(exists(context_matches)  //return suppression id
      ,set(context_matches  ,suppressionid)
      ,[]
    );
  #ELSEIF(trim(pOperation) = 'Debug'    )
    ds_debug;
  #END

  return returnresult;

endmacro;
