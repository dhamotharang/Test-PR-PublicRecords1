/*
  example wuid:
 W20171101-170232 

output(WorkMan.get_Result('W20170501-145638','MatchesPerformed'             )  ,named('MatchesPerformed'      ));
output(WorkMan.get_Result('W20170501-145638','BasicMatchesPerformed'        )  ,named('BasicMatchesPerformed' ));
output(WorkMan.get_Result('W20170501-145638','SlicesPerformed'              )  ,named('SlicesPerformed'       ));
output(WorkMan.get_Result('W20170501-145638','PreClusterCount.Proxid_Cnt'   )  ,named('PreClusterCount'       ));
output(WorkMan.get_Result('W20170501-145638','PostClusterCount.Proxid_Cnt'  )  ,named('PostClusterCount'      ));
output(WorkMan.get_Result('W20170501-145638','ProxidsCreatedByCleave'       )  ,named('ProxidsCreatedByCleave'));  
*/
import std;
EXPORT get_Result(
   string   pWuid
  ,string   pResult                                   // can be a regex
  ,string   pesp           = WorkMan._Config.LocalEsp
  ,unsigned pCount         = 50
  ,boolean  pOutputDebug   = false
) :=
function

  // -- parse out result wanted
  parsed_result           := WorkMan.parsefieldname(pResult);
  parsed_index            := std.str.extract(parsed_result,3);
  parsed_fieldname        := std.str.extract(parsed_result,4);
  parsed_resultname_prep  := std.str.extract(parsed_result,2);
  parsed_resultname       := if(trim(parsed_index + parsed_fieldname + parsed_resultname_prep) = '' ,std.str.extract(parsed_result,1) ,parsed_resultname_prep);

  // -- get all results from the wuid
  ds_results := WorkMan.get_All_Results(pWuid,pesp,pCount);

  // -- try to find which result they want
  // -- go from most specific to the least
  ds_result_field_match       := ds_results(regexfind(parsed_resultname ,result_name  ,nocase),regexfind(parsed_fieldname  ,field_name   ,nocase),parsed_index = '' or record_number = (unsigned)parsed_index);
  ds_result_fieldvalue_match  := ds_results(regexfind(parsed_resultname ,result_name  ,nocase),regexfind(parsed_fieldname  ,field_value  ,nocase));

  ds_result_match             := ds_results(regexfind(parsed_resultname ,result_name  ,nocase));
  ds_fieldname_match          := ds_results(regexfind(parsed_resultname ,field_name   ,nocase));
  ds_fieldvalue_match         := ds_results(regexfind(parsed_resultname ,field_value  ,nocase));

  ds_result_name              := ds_results(regexfind(parsed_resultname ,result_name  ,nocase));
  count_fields                := count(table(ds_result_name,{field_name},field_name));

  ds_result_name_fieldvalue_match  := ds_results(regexfind(ds_fieldvalue_match[1].result_name ,result_name  ,nocase));
  count_fields_fieldvalue_match    := count(table(ds_result_name_fieldvalue_match,{field_name},field_name));

// PreClusterCount
// Proxid_Cnt

  // ds_result_name  := ds_results(regexfind(parsed_resultname ,result_name  ,nocase));
  // ds_field_name   := ds_results(regexfind(parsed_fieldname  ,field_name   ,nocase));
  // ds_field_value  := ds_results(regexfind('(' + trim(parsed_resultname) + '|' + trim(parsed_fieldname) + ')'           ,field_value  ,nocase));

  // ds_field_value_result_name        := ds_field_value[1].result_name  ;
  // ds_field_value_record_number      := ds_field_value[1].record_number;
  // ds_field_value_result_names       := ds_results(trim(result_name) = trim(ds_field_value_result_name));
  // ds_field_value_result_num_fields  := count(table(ds_field_value_result_names,{field_name},field_name));

  /*
    pass in result name and field name  -- need to look for the result name and then within that, the field name and possibly the field value
    pass in result name --> could refer to a field name or a scalar result name or a field value
  */

  toupper(string pstring) := STD.Str.ToUpperCase(pstring);
  ds_result := map(
     parsed_resultname != '' and parsed_fieldname != '' and exists(ds_result_field_match      )                                       =>if(pOutputDebug = true  ,'1-' ,'') + ds_result_field_match [1].field_value
    ,parsed_resultname != '' and parsed_fieldname != '' and exists(ds_result_fieldvalue_match ) and count_fields                  = 2 =>if(pOutputDebug = true  ,'2-' ,'') + ds_result_name                  (record_number = ds_result_fieldvalue_match[1].record_number  ,~regexfind(parsed_fieldname ,field_value,nocase) )[1].field_value
    ,parsed_resultname != ''                            and exists(ds_fieldvalue_match        ) and count_fields_fieldvalue_match = 2 =>if(pOutputDebug = true  ,'3-' ,'') + ds_result_name_fieldvalue_match (record_number = ds_fieldvalue_match       [1].record_number  ,~regexfind(parsed_resultname,field_value,nocase) )[1].field_value
    ,parsed_resultname != ''                            and exists(ds_fieldname_match         )                                       =>if(pOutputDebug = true  ,'4-' ,'') + ds_fieldname_match    [1].field_value
    ,parsed_resultname != ''                            and exists(ds_result_match            )                                       =>if(pOutputDebug = true  ,'5-' ,'') + ds_result_match       [1].field_value
    ,''
  );
    // ,parsed_resultname != ''                            and exists(ds_fieldvalue_match        ) and count_fields_fieldvalue_match = 2 => /*'3-' + */ds_result_name_fieldvalue_match (record_number = ds_fieldvalue_match       [1].record_number  ,trim(toupper(field_value)) != trim(toupper(parsed_resultname)) )[1].field_value
    // ,parsed_resultname != '' and parsed_fieldname != '' and exists(ds_result_fieldvalue_match ) and count_fields                  = 2 => /*'2-' + */ds_result_name                  (record_number = ds_result_fieldvalue_match[1].record_number  ,trim(toupper(field_value)) != trim(toupper(parsed_fieldname )) )[1].field_value

  // ds_result := map(
     // exists(ds_field_value) and ds_field_value_result_num_fields = 2  => ds_field_value_result_names(record_number = ds_field_value_record_number,trim(field_value) != trim(pResult))[1].field_value
    // ,exists(ds_field_name )                                           => ds_field_name[1].field_value
    // ,exists(ds_result_name)                                           => ds_result_name[1].field_value
    // ,''
  // );
  // ds_result := map(
     // exists(ds_field_value) and ds_field_value_result_num_fields = 2  => ds_field_value_result_names(record_number = ds_field_value_record_number,trim(field_value) != trim(pResult))[1].field_value
    // ,exists(ds_field_name )                                           => ds_field_name[1].field_value
    // ,exists(ds_result_name)                                           => ds_result_name[1].field_value
    // ,''
  // );


  outputdebug := parallel(
     output(pResult                           ,named('pResult'                          ))
    ,output(parsed_result                     ,named('parsed_result'                    ))
    ,output(parsed_resultname                 ,named('parsed_resultname'                ))
    ,output(parsed_index                      ,named('parsed_index'                     ))
    ,output(parsed_fieldname                  ,named('parsed_fieldname'                 ))
    ,output(ds_results                        ,named('ds_results'                       ))
    ,output(ds_result_field_match             ,named('ds_result_field_match'            ))
    ,output(ds_result_fieldvalue_match        ,named('ds_result_fieldvalue_match'       ))
    ,output(ds_result_match                   ,named('ds_result_match'                  ))
    ,output(ds_fieldname_match                ,named('ds_fieldname_match'               ))
    ,output(ds_fieldvalue_match               ,named('ds_fieldvalue_match'              ))
    ,output(ds_result_name                    ,named('ds_result_name'                   ))
    ,output(count_fields                      ,named('count_fields'                     ))
    ,output(ds_result_name_fieldvalue_match   ,named('ds_result_name_fieldvalue_match'  ))
    ,output(count_fields_fieldvalue_match     ,named('count_fields_fieldvalue_match'    ))
    ,output(ds_result                         ,named('ds_result'                        ))
  );


/*

                          PreClusterCount.Proxid_Cnt
WorkMan.parsefieldname = ',PreClusterCount,,Proxid_Cnt'
WorkMan.get_Result     = rcid_Cnt  


result_name     field_name  field_value       record_number
MatchStatistics	label	      MatchesPerformed	1
MatchStatistics	value	      135082	          1

*/
  return when(ds_result ,if(pOutputDebug = true  ,outputdebug));

end;