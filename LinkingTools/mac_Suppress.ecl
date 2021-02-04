/*
  1. should be able to pass in the regex that makes only certain fields available for suppression.  probably don't want all fields available for suppression.  such as rid, lexid, etc.
  2. need a way to know whether a particular suppression has been run before.  maybe when it is run, instead of just moving it to another superfile, the dataset will be written out again with suppressed = true
     this way, it will know to not explode the clusters again.
  3. also, need stats.
      count records with fields suppressed total
      count records with specific field suppressed(do all of them)
      count clusters exploded.
      count clusters 
      count records with fields suppressed total only new
      count records with specific field suppressed(do all of them) only new
  4.  get samples of records suppressed(each one).  samples of each count
  5.  samples of clusters exploded(each one)
  6. 

// after perform field suppression.
// want to know:
// 1. which fields suppressed(probably build a comma separated string of the field(s) suppressed per record)
// 2. suppression IDs used to suppress the record(can tie back to specific suppression records)
// 3. stats on total number of records where suppression was performed.
// 4. field suppressed(string from #1) stats.  count of records per suppression string.  
// 5. count of records per suppression id.  
// 6. examples of each suppression to double check them.
// 7. count of clusters containing suppressions.  only if cluster is known
// 8. 

1. cut down input file into just fields that we care about.+ unique id.  no dedup
2. randomly distribute the file
3. project the file, suppressing the fields and exploding any clusters they reside in, keeping both the old and new ids.
4. sort, group, and iterate on each of those ids to patch the new id values onto the rest of the clusters.  If multiple ids, do it in ascending order or hierarchy.  ex.  proxid, lgid3.
    this is so that if a suppressed record is in a proxid that consists of 5 dotids, and that proxid is a member of an lgid3 that contains 10 proxids, only that proxid will be exploded.
    the rest of the proxids will not.  and the lgid3 will be exploded to the proxids, but since only 1 proxid was exploded to the dotid, the whole lgid3 will not be reset to the dotid, only that proxid's records.
5. need to sort, group, and iterate on the old proxid, dotid, and the first record in the sort should be one(s) that were reset.so if the proxid != new proxid, that rec should be first.  then do lgid3
6. after this, join back to the full file on rid, and patch the new ids and suppressions on to the full file
7. do stats
*/

EXPORT mac_Suppress( 

   pDataset                                 //dataset to suppression & explode
  ,pSuppressionFile                         //suppression file.  use pull on this dataset to put it into memory.  this will speed it up immensely.
  ,pOutputGeneratedEcl          = 'false'   //output generated ecl as a string, or execute that ecl?
  ,pSuppressionFieldFilter      = '\'\''    //use regex to filter for the fields you want to possibly suppress(include context fields if used) and id fields.  ex. '^(company_fein|duns_number|source|proxid|lgid3)$'
  ,pContextFieldFilter          = '\'\''    //use regex to filter for only the fields that are used in context with the suppression fields. ex. '^(source)$'
  ,pSetIDsFieldFilter           = '\'\''    //use set to filter for only the ID fields you want to possibly explode if a suppression is performed on that cluster.  I
                                            //  Include fields that will be used as reset fields, and sort ascendingly by level in hierarchy.  ex. ['dotid','proxid','lgid3']
  ,pRidField                    = ''        //rid field
  ,pShouldExplode               = 'true'    //if true, it will explode the clusters where suppression was applied.  false = turn off explosions
  ,pDebug                       = 'false'   //if true, it will add a debug output so you can see the calculations
  ,pTurnOffExtraOutputs         = 'false'   //if true, it will not output anything else except for returning the suppressed dataset, false it will do the outputs
  ,pShouldIncrementFile         = 'true'    //if true, it will explode the clusters where suppression was applied.  false = turn off explosions
  ,pReturnDebugFields           = 'false'    //if true, it will keep the extra fields.  false = return same layout as supplied
) :=
functionmacro
  
  // export Suppression_out := 
    // {
       // unsigned6                  suppressionid  
      // ,dataset(Suppression_field) context  
      // ,dataset(Suppression_field) suppressed_field_values  
      // ,string                     date_added 
      // ,string                     userid  
      // ,string                     comment
    // };

  // #UNIQUENAME(ECL_CODE                 )


  import tools,BIPV2_Strata,Workman;
  lSuppressionFile := pSuppressionFile;

  // --------------------------------------------------------------------------------------------------------------------------
  // -- create ID regex from pSetIDsFieldFilter
  // --------------------------------------------------------------------------------------------------------------------------
  #UNIQUENAME(MYCOUNTER                 )
  #UNIQUENAME(EXPLODECOUNTER            )
  #UNIQUENAME(LIDFIELDFILTER            )
  #UNIQUENAME(EXPLODEIDS                )
  #UNIQUENAME(CURRENTID                 )
  #UNIQUENAME(CURRENTID_ORIG            )
  #UNIQUENAME(PREVIOUSID                )
  #UNIQUENAME(PATCHIDS                  )
  #UNIQUENAME(PATCHED_REST              )
  #UNIQUENAME(ID_STATS                  )
  #UNIQUENAME(EXAMPLE_OUTPUTS           )
  #UNIQUENAME(DIDEXPLODE                )
  #UNIQUENAME(DIDEXPLODE_ALL            )
  
  #SET(MYCOUNTER        ,1  )
  #SET(EXPLODECOUNTER   ,1  )
  #SET(LIDFIELDFILTER   ,'' )
  #SET(EXPLODEIDS       ,'' )
  #SET(CURRENTID_ORIG   ,'' )
  #SET(CURRENTID        ,'' )
  #SET(PREVIOUSID       ,#TEXT(pRidField) )
  #SET(PATCHIDS         ,'' )
  #SET(PATCHED_REST     ,'' )
  #SET(ID_STATS         ,'  ds_overall_stats := dataset([\n' )
  #SET(EXAMPLE_OUTPUTS  ,'' )
  #SET(DIDEXPLODE       ,'' )
  #SET(DIDEXPLODE_ALL   ,'')

  
  #LOOP
  
    #IF(%MYCOUNTER% > count(pSetIDsFieldFilter))
      #BREAK
    #END

    #IF(%MYCOUNTER% > 1)
      #APPEND(LIDFIELDFILTER  ,'|')
    #END

    #APPEND(LIDFIELDFILTER  ,pSetIDsFieldFilter[%MYCOUNTER%])

    #SET(CURRENTID  ,pSetIDsFieldFilter[%MYCOUNTER%])

    #IF(trim(STD.Str.ToUpperCase(%'CURRENTID'%)) != trim(STD.Str.ToUpperCase(#TEXT(pRidField))) )
      #APPEND(EXPLODEIDS  ,'get_ids_prep_' + %'CURRENTID'% + '        := self.fields_and_values_suppressed(exists(IDs_To_Explode(trim(fieldname) = \'' + %'CURRENTID'% + '\')));\n')
      
      #APPEND(EXPLODEIDS  ,'get_ids_prep2_'       + %'CURRENTID'% + ' := get_ids_prep_' + %'CURRENTID'% + '[1].IDs_To_Explode[1].fieldvalue;\n')
      #APPEND(EXPLODEIDS  ,'suppression_counter_' + %'CURRENTID'% + ' := get_ids_prep_' + %'CURRENTID'% + '[1].suppression_counter;\n')

      #APPEND(EXPLODEIDS  ,'self.' + %'CURRENTID'% + ' := map(\n')
      #APPEND(EXPLODEIDS  ,'left.' + %'CURRENTID'% + ' = 0 or trim(self.fields_suppressed) = \'\' or suppression_counter_' + %'CURRENTID'% + ' > 0 or ~exists(get_ids_prep_' + %'CURRENTID'% + ') => left.' + %'CURRENTID'% + '  \n')

      #APPEND(EXPLODEIDS  ,',exists(get_ids_prep_' + %'CURRENTID'% + ')              and suppression_counter_' + %'CURRENTID'% + ' < 1 => (typeof(left.' + %'CURRENTID'% + '))trim(get_field_value(get_ids_prep2_' + %'CURRENTID'% + ',left))\n')
       
      #APPEND(EXPLODEIDS  ,',                                                                 left.' + %'CURRENTID'% + ' \n')
      #APPEND(EXPLODEIDS  ,');\n')


      // ---------------------------------------------------------------------------------------------------------------------------------
      #APPEND(EXPLODEIDS  ,'self.didexplode_' + %'CURRENTID'% + ' := map(\n')
      #APPEND(EXPLODEIDS  ,'left.' + %'CURRENTID'% + ' = 0 or trim(self.fields_suppressed) = \'\' or suppression_counter_' + %'CURRENTID'% + ' > 0 or ~exists(get_ids_prep_' + %'CURRENTID'% + ') => false \n')

      #APPEND(EXPLODEIDS  ,',exists(get_ids_prep_' + %'CURRENTID'% + ')              and suppression_counter_' + %'CURRENTID'% + ' < 1 => true \n')
       
      #APPEND(EXPLODEIDS  ,',                                                                 false\n')
      #APPEND(EXPLODEIDS  ,');\n')

      #APPEND(DIDEXPLODE ,'boolean didexplode_' + %'CURRENTID'% + ',')
      #APPEND(DIDEXPLODE_ALL ,' or self.didexplode_' + %'CURRENTID'%)




      #SET(CURRENTID_ORIG ,pSetIDsFieldFilter[%MYCOUNTER%] + '_orig')




      
      #IF(%EXPLODECOUNTER% = 1)
        #APPEND(PATCHIDS  ,'ds_proj_dist_'  + %'CURRENTID'% + '     := distribute(ds_proj(orig.'  + %'CURRENTID'% + ' != 0) ,orig.'  + %'CURRENTID'% + ');\n')
      #ELSE
        #APPEND(PATCHIDS  ,'ds_proj_dist_'  + %'CURRENTID'% + '     := distribute(group(ds_proj_iterate_'  + %'PREVIOUSID'% + '_(orig.'  + %'CURRENTID'% + ' != 0)) ,orig.'  + %'CURRENTID'% + ');\n')
      #END
      
      #APPEND(PATCHIDS  ,'ds_proj_sort_'  + %'CURRENTID'% + '     := sort(ds_proj_dist_'  + %'CURRENTID'% + '  ,orig.'  + %'CURRENTID'% + ',if(didexplode_'  + %'CURRENTID'% + ' = true ,0,1),'  + %'PREVIOUSID'% + '  ,local);\n')
      #APPEND(PATCHIDS  ,'ds_proj_group_'  + %'CURRENTID'% + '    := group(ds_proj_sort_'  + %'CURRENTID'% + ' ,orig.'  + %'CURRENTID'% + ',local);\n')

      #APPEND(PATCHIDS  ,'ds_proj_iterate_'  + %'CURRENTID'% + '  := iterate(ds_proj_group_'  + %'CURRENTID'% + ' ,transform(recordof(left),\n')
      #APPEND(PATCHIDS  ,'\n')
      #APPEND(PATCHIDS  ,'   get_ids_prep_'  + %'CURRENTID'% + '_        := if(left.orig.'  + %'CURRENTID'% + '  = 0  ,right.fields_and_values_suppressed(exists(IDs_To_Explode(trim(fieldname) = \''  + %'CURRENTID'% + '\'))) ,left.fields_and_values_suppressed(exists(IDs_To_Explode(trim(fieldname) = \''  + %'CURRENTID'% + '\'))));\n')
      #APPEND(PATCHIDS  ,'   get_ids_prep2_'  + %'CURRENTID'% + '_       := get_ids_prep_'  + %'CURRENTID'% + '_[1].IDs_To_Explode[1].fieldvalue;\n')
      #APPEND(PATCHIDS  ,'   suppression_counter_'  + %'CURRENTID'% + '_ := get_ids_prep_'  + %'CURRENTID'% + '_[1].suppression_counter;                                            \n')
      #APPEND(PATCHIDS  ,'\n')
      #APPEND(PATCHIDS  ,'   self.didexplode_'  + %'CURRENTID'% + '   := if(left.orig.'  + %'CURRENTID'% + '  = 0     ,right.didexplode_'  + %'CURRENTID'% + '  ,left.didexplode_'  + %'CURRENTID'% + ' ); // if this cluster had a record that was suppressed, make this sticky throughout the cluster.  first record in cluster should be record(s) that are suppressed based on above sort\n')
      #APPEND(PATCHIDS  ,'   self.'  + %'CURRENTID'% + '        := if(self.didexplode_'  + %'CURRENTID'% + '  = true  ,(typeof(right.' + %'CURRENTID'% + '))trim(get_field_value(trim(get_ids_prep2_' + %'CURRENTID'% + '_),row(right,recordof(ds_table))))        ,right.'  + %'CURRENTID'% + '     ); // if cluster has any records suppressed, explode the ID to its lower id.\n')

      #APPEND(PATCHIDS  ,'   self.fields_and_values_suppressed  := if(left.orig.'  + %'CURRENTID'% + '  = 0  ,right.fields_and_values_suppressed  ,left.fields_and_values_suppressed);\n')
      #APPEND(PATCHIDS  ,'   self               := right;\n')
      #APPEND(PATCHIDS  ,'));\n')
      
      #IF(%EXPLODECOUNTER% = 1)
        #APPEND(PATCHIDS  ,'ds_proj_iterate_'  + %'CURRENTID'% + '_ := map(exists(' + #TEXT(pSuppressionFile) + '(exists(IDs_To_Explode(trim(fieldname) = \''  + %'CURRENTID'% + '\')))) => group(ds_proj_iterate_'  + %'CURRENTID'% + ') + ds_proj(orig.'  + %'CURRENTID'% + ' = 0) ,ds_proj  );\n\n')
      #ELSE
        #APPEND(PATCHIDS  ,'ds_proj_iterate_'  + %'CURRENTID'% + '_ := map(exists(' + #TEXT(pSuppressionFile) + '(exists(IDs_To_Explode(trim(fieldname) = \''  + %'CURRENTID'% + '\')))) => group(ds_proj_iterate_'  + %'CURRENTID'% + ') + ds_proj_iterate_'  + %'PREVIOUSID'% + '_(orig.'  + %'CURRENTID'% + ' = 0)  ,ds_proj_iterate_'  + %'PREVIOUSID'% + '_  );\n\n')
      #END




      // ---------------------------------------------------------------------------------------------------------------------------
      // #APPEND(ID_STATS  ,' + map(exists(' + #TEXT(pSuppressionFile) + '(exists(IDs_To_Explode(trim(fieldname) = \''  + %'CURRENTID'% + '\')))) => \n')
      // #APPEND(ID_STATS  ,'+ dataset([\n')
      #IF(%EXPLODECOUNTER% = 1)
        #APPEND(ID_STATS  ,' ')
      #ELSE
        #APPEND(ID_STATS  ,',')
      #END
      
      #APPEND(ID_STATS  ,' {\'Input  File\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(' +  #TEXT(pDataset) + ' )) ,ut.fIntWithCommas(count(table(' +  #TEXT(pDataset) + '  ,{' + %'CURRENTID'% + '} ,' + %'CURRENTID'% + '  ,merge)))}\n')
      #APPEND(ID_STATS  ,',{\'Output File\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(ds_result)) ,ut.fIntWithCommas(count(table(ds_result ,{' + %'CURRENTID'% + '} ,' + %'CURRENTID'% + '  ,merge)))}\n')

      #APPEND(ID_STATS  ,',{\'Input  File Clusters Suppressed\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(ds_out(trim  (fields_suppressed            ) != \'\' ))) ,ut.fIntWithCommas(count(table(ds_out(trim  (fields_suppressed            ) != \'\' )  ,{orig.' + %'CURRENTID'% + '} ,orig.' + %'CURRENTID'% + '  ,merge)))}\n')
      #APPEND(ID_STATS  ,',{\'Ouput  File Clusters Suppressed\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(ds_out(trim  (fields_suppressed            ) != \'\' ))) ,ut.fIntWithCommas(count(table(ds_out(trim  (fields_suppressed            ) != \'\' )  ,{' + %'CURRENTID'% + '} ,' + %'CURRENTID'% + '  ,merge)))}\n')

      #IF(pShouldExplode = true)   
        #APPEND(ID_STATS  ,',{\'Input  File Clusters Exploded\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(ds_out(didexplode_'  + %'CURRENTID'% + ' = true) )) ,ut.fIntWithCommas(count(table(ds_out(didexplode_'  + %'CURRENTID'% + ' = true)  ,{orig.' + %'CURRENTID'% + '} ,orig.' + %'CURRENTID'% + '  ,merge)))}\n')
        #APPEND(ID_STATS  ,',{\'Output File Clusters Exploded\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(ds_out(didexplode_'  + %'CURRENTID'% + ' = true) )) ,ut.fIntWithCommas(count(table(ds_out(didexplode_'  + %'CURRENTID'% + ' = true)  ,{' + %'CURRENTID'% + '} ,' + %'CURRENTID'% + '  ,merge)))}\n')
      #END
      #APPEND(ID_STATS  ,',{\'Input  File cluster = 0\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(' +  #TEXT(pDataset) + ' (' + %'CURRENTID'% + ' = 0))) ,ut.fIntWithCommas(count(table(' +  #TEXT(pDataset) + ' (' + %'CURRENTID'% + ' = 0) ,{' + %'CURRENTID'% + '} ,' + %'CURRENTID'% + '  ,merge)))}\n')
      #APPEND(ID_STATS  ,',{\'Output File cluster = 0\',\'' + %'CURRENTID'% + '\'  ,ut.fIntWithCommas(count(ds_result(' + %'CURRENTID'% + ' = 0))) ,ut.fIntWithCommas(count(table(ds_result(' + %'CURRENTID'% + ' = 0) ,{' + %'CURRENTID'% + '} ,' + %'CURRENTID'% + '  ,merge)))}\n')
      
      
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(choosen(ds_proj_dist_'    + %'CURRENTID'% + '         ,300  ) ,named(\'LinkingTools_mac_Suppress_ds_proj_dist_'    + %'CURRENTID'% + '\'                 ),all)\n')
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(choosen(ds_proj_sort_'    + %'CURRENTID'% + '         ,300  ) ,named(\'LinkingTools_mac_Suppress_ds_proj_sort_'    + %'CURRENTID'% + '\'                 ),all)\n')
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(choosen(ds_proj_group_'   + %'CURRENTID'% + '         ,300  ) ,named(\'LinkingTools_mac_Suppress_ds_proj_group_'   + %'CURRENTID'% + '\'                 ),all)\n')
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(choosen(ds_proj_iterate_' + %'CURRENTID'% + '         ,300  ) ,named(\'LinkingTools_mac_Suppress_ds_proj_iterate_' + %'CURRENTID'% + '\'                 ),all)\n')

      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(topn(ds_proj_dist_'    + %'CURRENTID'% + '(didexplode_'  + %'CURRENTID'% + ' = true)         ,300  ,orig.'  + %'CURRENTID'% + ','  + %'CURRENTID'% + ') ,named(\'LinkingTools_mac_Suppress_ds_proj_dist_'    + %'CURRENTID'% + '_suppressed\'                 ),all)\n')
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(topn(ds_proj_sort_'    + %'CURRENTID'% + '(didexplode_'  + %'CURRENTID'% + ' = true)         ,300  ,orig.'  + %'CURRENTID'% + ','  + %'CURRENTID'% + ') ,named(\'LinkingTools_mac_Suppress_ds_proj_sort_'    + %'CURRENTID'% + '_suppressed\'                 ),all)\n')
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(topn(group(ds_proj_group_'   + %'CURRENTID'% + ')(didexplode_'  + %'CURRENTID'% + ' = true)         ,300  ,orig.'  + %'CURRENTID'% + ','  + %'CURRENTID'% + ') ,named(\'LinkingTools_mac_Suppress_ds_proj_group_'   + %'CURRENTID'% + '_suppressed\'                 ),all)\n')
      #APPEND(EXAMPLE_OUTPUTS  ,' ,output(topn(group(ds_proj_iterate_' + %'CURRENTID'% + ')(didexplode_'  + %'CURRENTID'% + ' = true)         ,300  ,orig.'  + %'CURRENTID'% + ','  + %'CURRENTID'% + ') ,named(\'LinkingTools_mac_Suppress_ds_proj_iterate_' + %'CURRENTID'% + '_suppressed\'                 ),all)\n')
      // #APPEND(EXAMPLE_OUTPUTS  ,'))\n')

      #SET(PREVIOUSID  ,pSetIDsFieldFilter[%MYCOUNTER%])
      #SET(EXPLODECOUNTER  ,%EXPLODECOUNTER% + 1)
    #END

    #SET(MYCOUNTER  ,%MYCOUNTER% + 1)
  #END

  #IF(trim(%'LIDFIELDFILTER'%) != '')
    #SET(LIDFIELDFILTER     ,'^(' + trim(%'LIDFIELDFILTER'%) + ')$')
  #END
  
  #SET(DIDEXPLODE_ALL  ,trim(%'DIDEXPLODE_ALL'%)[5..] + ';\n')
  
  #SET(PATCHED_REST  ,'ds_concat_'  + %'PREVIOUSID'% )
  #APPEND(ID_STATS  ,'  ],{string statname,string ID,string records ,string clusters});\n' )
  // --------------------------------------------------------------------------------------------------------------------------
  // -- get layout tools, use tablefields to dedup and slim down the full file to just suppression, context and ID fields
  // --------------------------------------------------------------------------------------------------------------------------
  layout_tools        := tools.macf_LayoutTools(recordof(pDataset),false,pSuppressionFieldFilter,true,%'LIDFIELDFILTER'%);
  get_field_value     := layout_tools.fGetFieldValueByNameTable;
  setall_fields       := layout_tools.setAllFields;
  get_field_name      := layout_tools.fGetFieldName;

  ds_table := layout_tools.slimfields(pDataset);  //slim down record

  // lay_calc := {string calculation ,boolean calculation_value};
  lay_debug_field := {dataset(LinkingTools.layouts.Suppression_field) calcs,LinkingTools.layouts.Suppression_field};
  lay_debug := {dataset(lay_debug_field) suppress_debug  , dataset(lay_debug_field) context_debug,recordof(lSuppressionFile)};

  // --------------------------------------------------------------------------------------------------------------------------
  // -- call LinkingTools.mac_Suppress_Field to figure out whether to suppress each field.  
  // -- Returns different value depending on last parameter.
  // --------------------------------------------------------------------------------------------------------------------------
  // -- return whether to suppress the field value('Suppress' = true, '' = false)
  suppress        (recordof(ds_table) pRow  ,string pfieldname  ,string pfieldvalue) := LinkingTools.mac_Suppress_Field(pRow  ,pfieldname ,pfieldvalue  ,'Suppress'       );

  // -- return suppressed field values
  suppresscontext (recordof(ds_table) pRow  ,string pfieldname  ,string pfieldvalue) := LinkingTools.mac_Suppress_Field(pRow  ,pfieldname ,pfieldvalue  ,'FieldValues'    );

  // -- return the set of suppression ids for that suppression, if any.  so that they can be counted later on.
  suppressids     (recordof(ds_table) pRow  ,string pfieldname  ,string pfieldvalue) := LinkingTools.mac_Suppress_Field(pRow  ,pfieldname ,pfieldvalue  ,'SuppressionIDs' );

  // -- return debug information about calculations that figure out the suppression.  useful for figuring out why something did not get suppressed.
  debuginfo       (recordof(ds_table) pRow  ,string pfieldname  ,string pfieldvalue) := LinkingTools.mac_Suppress_Field(pRow  ,pfieldname ,pfieldvalue  ,'Debug'          );

  #UNIQUENAME(SUPPRESSCOUNTER           )
  #UNIQUENAME(TRANSFORMECL              )
  #UNIQUENAME(SETFIELDS                 )
  #UNIQUENAME(FIELDSSUPPRESSED          )
  #UNIQUENAME(FIELDSANDVALUESSUPPRESSED )
  #UNIQUENAME(SUPPRESSIONIDS            )
  #UNIQUENAME(JOINCONDITION             )
  #UNIQUENAME(FIELDANDFILTER            )
  #UNIQUENAME(DEDUPFIELDS               )
  #UNIQUENAME(DEDUPIDS                  )
  #UNIQUENAME(DEDUPIDS_                 )
  #UNIQUENAME(PATCHJOINCONDITION        )
  #UNIQUENAME(DEBUGSTUFF                )
  
  #SET(MYCOUNTER                  ,1                                    )
  #SET(SUPPRESSCOUNTER            ,1                                    )
  #SET(TRANSFORMECL               ,''                                   )
  #SET(JOINCONDITION              ,''                                   )
  #SET(FIELDSSUPPRESSED           ,'fields_suppressed := \n'            )
  #SET(DEDUPFIELDS                ,''                                   )
  #SET(FIELDSANDVALUESSUPPRESSED  ,'fields_and_values_suppressed := \n' )
  #SET(SUPPRESSIONIDS             ,'self.suppressionids := \n'          )
  #SET(FIELDANDFILTER             ,''                                   )
  #SET(DEDUPIDS                   ,''                                   )
  #SET(DEDUPIDS_                  ,''                                   )
  #SET(PATCHJOINCONDITION         ,''                                   )
  #SET(DEBUGSTUFF                 ,'debug_stuff := \n'                  )

// fields_suppressed := 
  // if(suppress(left,'rcid',(string)left.rcid) = '' ,',rcid'  ,'')
// + if(suppress(left,'source',(string)left.source) = '' ,',source' ,'')
// ;
// self.fields_suppressed := trim(fields_suppressed)[2..];


  #IF(pOutputGeneratedEcl = false)

  lay_supp_context := {recordof(pSuppressionFile) - wuid - userid - comment};
  
  // --------------------------------------------------------------------------------------------------------------------------
  // -- Suppression project.  in this project it will apply the suppression and explosion.
  // --------------------------------------------------------------------------------------------------------------------------
  ds_proj := project(distribute(ds_table) ,transform(
    {#IF(pDebug = true) dataset(lay_debug) debug_calcs ,  #END     #IF(pShouldExplode = true) %DIDEXPLODE% #END boolean didexplode ,  string fields_suppressed  ,dataset(lay_supp_context) fields_and_values_suppressed  ,set of unsigned6 suppressionids,recordof(left),recordof(left) orig},
    
    // self.company_fein := if(suppress(left,'company_fein',left.company_fein) = ''  ,(typeof(left.pfieldname))''  ,left.pfieldname)
  #END
  
    #LOOP
    
      #IF(%MYCOUNTER% > count(setall_fields))
        #BREAK
      #END
      
      #IF((%'LIDFIELDFILTER'% = '' or not regexfind(%'LIDFIELDFILTER'% ,trim(get_field_name(%MYCOUNTER%))  ,nocase)) and (pContextFieldFilter = '' or not regexfind(pContextFieldFilter ,trim(get_field_name(%MYCOUNTER%))  ,nocase)))
        #APPEND(TRANSFORMECL ,'self.' + trim(get_field_name(%MYCOUNTER%)) + ' := if(trim(suppress(left,\''  + trim(get_field_name(%MYCOUNTER%)) + '\',(string)left.' + trim(get_field_name(%MYCOUNTER%)) + ')) = \'Suppress\' ,(typeof(left.' + trim(get_field_name(%MYCOUNTER%)) + '))\'\'  ,left.' + trim(get_field_name(%MYCOUNTER%)) + ');\n')
      #END
      
      #IF(%SUPPRESSCOUNTER% != 1)
        #APPEND(FIELDSSUPPRESSED          ,'+ ')
        #APPEND(FIELDSANDVALUESSUPPRESSED ,'+ ')
        #APPEND(SUPPRESSIONIDS            ,'+ ')
        #APPEND(DEBUGSTUFF                ,'+ ')
      #ELSE
        #APPEND(FIELDSSUPPRESSED          ,'  ')
        #APPEND(FIELDSANDVALUESSUPPRESSED ,'  ')
        #APPEND(SUPPRESSIONIDS            ,'  ')
        #APPEND(DEBUGSTUFF                ,'  ')
      #END
      
      #IF((%'LIDFIELDFILTER'% = '' or not regexfind(%'LIDFIELDFILTER'% ,trim(get_field_name(%MYCOUNTER%))  ,nocase)) and (pContextFieldFilter = '' or not regexfind(pContextFieldFilter ,trim(get_field_name(%MYCOUNTER%))  ,nocase)))
        #APPEND(FIELDSSUPPRESSED          ,'if(trim(suppress(left,\''  + trim(get_field_name(%MYCOUNTER%)) + '\',(string)left.' + trim(get_field_name(%MYCOUNTER%)) + ')) = \'Suppress\' ,\','  + trim(get_field_name(%MYCOUNTER%)) + '\',\'\')\n')

        #APPEND(FIELDSANDVALUESSUPPRESSED ,'suppresscontext(left,\''  + trim(get_field_name(%MYCOUNTER%)) + '\',(string)left.' + trim(get_field_name(%MYCOUNTER%)) + ')\n')
              
        #APPEND(SUPPRESSIONIDS            ,'suppressids(left,\''  + trim(get_field_name(%MYCOUNTER%)) + '\',(string)left.' + trim(get_field_name(%MYCOUNTER%)) + ')\n')
        #APPEND(DEBUGSTUFF                ,'debuginfo(left,\''    + trim(get_field_name(%MYCOUNTER%)) + '\',(string)left.' + trim(get_field_name(%MYCOUNTER%)) + ')\n')
      #END
      
      #APPEND(JOINCONDITION             ,'and left.' + trim(get_field_name(%MYCOUNTER%)) + ' = right.orig.' + trim(get_field_name(%MYCOUNTER%)) + '\n')

      #IF((%'LIDFIELDFILTER'% = '' or not regexfind(%'LIDFIELDFILTER'% ,trim(get_field_name(%MYCOUNTER%))  ,nocase)) and (pContextFieldFilter = '' or not regexfind(pContextFieldFilter ,trim(get_field_name(%MYCOUNTER%))  ,nocase)))
        #APPEND(FIELDANDFILTER            ,' or ' + trim(get_field_name(%MYCOUNTER%)) + ' != (TYPEOF(' + trim(get_field_name(%MYCOUNTER%)) + '))\'\'\n')
      #END
      
      #IF(%'LIDFIELDFILTER'% != '' and regexfind(%'LIDFIELDFILTER'% ,trim(get_field_name(%MYCOUNTER%))  ,nocase))
        // #APPEND(DEDUPIDS  ,',' + trim(get_field_name(%MYCOUNTER%))  + ',/*(TYPEOF(' + trim(get_field_name(%MYCOUNTER%)) + '))*/ ' + trim(get_field_name(%MYCOUNTER%)) + '_orig := orig.' + trim(get_field_name(%MYCOUNTER%)) )
        #APPEND(DEDUPIDS  ,',' + trim(get_field_name(%MYCOUNTER%))  + ', ' + trim(get_field_name(%MYCOUNTER%)) + '_orig := orig.' + trim(get_field_name(%MYCOUNTER%)) )
        #APPEND(DEDUPIDS_ ,',' + trim(get_field_name(%MYCOUNTER%))  + ',orig.' + trim(get_field_name(%MYCOUNTER%)) )

        #APPEND(PATCHJOINCONDITION  ,'and left.' + trim(get_field_name(%MYCOUNTER%)) + ' = right.' + trim(get_field_name(%MYCOUNTER%)) + '_orig\n')
        
      #END

      #IF(%'LIDFIELDFILTER'% = '' or not regexfind(%'LIDFIELDFILTER'% ,trim(get_field_name(%MYCOUNTER%))  ,nocase))
        #APPEND(DEDUPFIELDS               ,',orig.' + trim(get_field_name(%MYCOUNTER%)) )
      #END
      #IF((%'LIDFIELDFILTER'% = '' or not regexfind(%'LIDFIELDFILTER'% ,trim(get_field_name(%MYCOUNTER%))  ,nocase)) and (pContextFieldFilter = '' or not regexfind(pContextFieldFilter ,trim(get_field_name(%MYCOUNTER%))  ,nocase)))
        #SET(SUPPRESSCOUNTER  ,%SUPPRESSCOUNTER% + 1)
      #END




      #SET(MYCOUNTER  ,%MYCOUNTER% + 1)
      
    #END
    
   #APPEND(FIELDSSUPPRESSED           ,';\n')
   #APPEND(FIELDSSUPPRESSED           ,'self.fields_suppressed := trim(fields_suppressed)[2..];\n')
   #APPEND(FIELDSANDVALUESSUPPRESSED  ,';\n')
   #APPEND(FIELDSANDVALUESSUPPRESSED  ,'self.fields_and_values_suppressed := fields_and_values_suppressed;\n')
   #APPEND(SUPPRESSIONIDS             ,';\n')
   #APPEND(DEBUGSTUFF                 ,';\n')
   #APPEND(DEBUGSTUFF                 ,'self.debug_calcs := debug_stuff;\n')
    
   #IF(pOutputGeneratedEcl = false)
    %FIELDSSUPPRESSED%
    %FIELDSANDVALUESSUPPRESSED%
    %SUPPRESSIONIDS%
    %TRANSFORMECL%
    #IF(pShouldExplode = true)   
      %EXPLODEIDS%
    #END
   #IF(pDebug = true)
      %DEBUGSTUFF%
    #END
    #IF(pShouldExplode = true)   
    self.didexplode := %DIDEXPLODE_ALL% ;
    #ELSE
    self.didexplode := false ;
    #END
    self      := left;
    self.orig := left;
  ));


  #SET(FIELDANDFILTER     ,trim(%'FIELDANDFILTER'%      )[4..])
  #SET(JOINCONDITION      ,trim(%'JOINCONDITION'%       )[5..])
  #SET(DEDUPFIELDS        ,trim(%'DEDUPFIELDS'%         )[2..])
  #SET(DEDUPIDS           ,trim(%'DEDUPIDS'%            )[2..])
  #SET(DEDUPIDS_          ,trim(%'DEDUPIDS_'%           )[2..])
  #SET(PATCHJOINCONDITION ,trim(%'PATCHJOINCONDITION'%  )[5..])
  
  // -- PATCH IDS ONTO THE ds_rest, one at a time.
  #IF(pShouldExplode = true)   
    %PATCHIDS%
    #UNIQUENAME(last_iterate )
    #SET(last_iterate  ,'ds_proj_iterate_' + %'PREVIOUSID'% + '_' )
  #ELSE
    #UNIQUENAME(last_iterate )
    #SET(last_iterate  ,'ds_proj' )
  #END
  
  ds_out  := join(pDataset ,%last_iterate%   ,left.pRidField = right.pRidField ,transform({recordof(right) or recordof(left) },self := right,self := left)  ,hash  ,keep(1)  )
      :persist('~persist::LinkingTools::mac_Suppress::ds_out');

  
  ds_concat_all_prep := ds_out;
  
  ds_fields_suppressed_stats            := table(ds_out(trim  (fields_suppressed            ) != '' ) ,{fields_suppressed    ,unsigned cnt := count(group)} ,fields_suppressed   ,merge);
  ds_fields_and_values_suppressed_stats := table(ds_out(exists(fields_and_values_suppressed )       ) ,{%DEDUPFIELDS%        ,unsigned cnt := count(group)} ,%DEDUPFIELDS%       ,merge);
  ds_suppressionid_stats                := table(ds_out(count (suppressionids               )  > 0  ) ,{suppressionids       ,unsigned cnt := count(group)} ,suppressionids      ,merge);
  
  ds_samples                            := dedup(sort(distribute(%last_iterate%   (trim(fields_suppressed) != '')  ,hash(fields_suppressed,%DEDUPFIELDS%)) ,fields_suppressed,%DEDUPFIELDS%,local) ,fields_suppressed,%DEDUPFIELDS%,local,keep 5);
  ds_not_samples                        := dedup(sort(distribute(%last_iterate%   (trim(fields_suppressed)  = '')  ,hash(fields_suppressed,%DEDUPFIELDS%)) ,fields_suppressed,%DEDUPFIELDS%,local) ,fields_suppressed,%DEDUPFIELDS%,local,keep 5);

  // -------------------------------------------------------

  
  ds_result := 
  #IF(pReturnDebugFields = false)      
      project(ds_concat_all_prep    ,recordof(pDataset)) ;// suppressions + explosions
  #ELSE
      ds_concat_all_prep;
  #END
    // + project(ds_patch_ids          ,recordof(pDataset)) // explosions of other records in above clusters that had records suppressed
    // + project(ds_patch_ids_nomatch  ,recordof(pDataset)) // rest of records, nomatch
    // :persist('~persist::LinkingTools::mac_Suppress::ds_result');
    
  // proxid_persistence_stats := BIPV2_Strata.PersistenceStats(ds_result ,pDataset ,rcid ,proxid);
  // lgid3_persistence_stats  := BIPV2_Strata.PersistenceStats(ds_result ,pDataset ,rcid ,lgid3 );
  
  // string stat,string records, string clusters
  
  
/*  ds_overall_stats := dataset([
  
     {'count(pDataset)'                       ,ut.fIntWithCommas(count(pDataset                                   ))}
    ,{'count(ds_table)'                       ,ut.fIntWithCommas(count(ds_table                                   ))}
    ,{'count(ds_proj)'                        ,ut.fIntWithCommas(count(ds_proj                                    ))}
    ,{'count(ds_proj(didexplode = true))'                        ,ut.fIntWithCommas(count(ds_proj(didexplode = true)                                    ))}
    // ,{'count(pDataset(%FIELDANDFILTER%))'     ,ut.fIntWithCommas(count(pDataset             (  %FIELDANDFILTER% ) ))}
    // ,{'count(pDataset(~(%FIELDANDFILTER%)))'  ,ut.fIntWithCommas(count(pDataset             (~(%FIELDANDFILTER%)) ))}
    ,{'count(ds_out)'                         ,ut.fIntWithCommas(count(ds_out                                     ))}
    ,{'count(ds_out(didexplode = true))'                         ,ut.fIntWithCommas(count(ds_out(didexplode = true)                                     ))}
    // ,{'count(ds_rest)'                        ,ut.fIntWithCommas(count(ds_rest                                    ))}
  // ],{string statname,string statvalue})

  #IF(pShouldExplode = true)   
   %ID_STATS%
  #END
   // +  dataset([
     ,{'count(ds_concat_all_prep)'            ,ut.fIntWithCommas(count(ds_concat_all_prep                          ))}
    // ,{'count(ds_exploded_ids_table)'          ,ut.fIntWithCommas(count(ds_exploded_ids_table                      ))}
    // ,{'count(ds_patch_ids)'                   ,ut.fIntWithCommas(count(ds_patch_ids                               ))}
    // ,{'count(ds_patch_ids_nomatch)'           ,ut.fIntWithCommas(count(ds_patch_ids_nomatch                       ))}
    ,{'count(ds_result)'                      ,ut.fIntWithCommas(count(ds_result                                  ))}
    
  ],{string statname,string statvalue});
  #END
*/  
  #END

  
  #IF(pOutputGeneratedEcl = false)
    %ID_STATS%
    ds_example_suppressions := ds_samples (trim(fields_suppressed) != '');

    // ds_increment_suppression_file := project(pSuppressionFile ,transform(recordof(left) ,self.suppression_counter := left.suppression_counter + 1 ,self := left));
    // files_read               := Workman.get_FilesRead(workunit);
    // suppression_logical_name := '~' + trim(files_read(issuper = false,regexfind('suppression' ,name,nocase))[1].name) + '_2';
    // suppression_super_name   := '~' + trim(files_read(issuper = true ,regexfind('suppression' ,name,nocase))[1].name);

    #IF(pTurnOffExtraOutputs = false)
    return when(ds_result 
      ,parallel( 
                 output(ds_overall_stats                                                                                                                      ,named('LinkingTools_mac_Suppress_ds_overall_stats'                        ),all)  
                // #IF(pShouldExplode = true and pShouldRunPersistenceStats = true)     
                  // ,output(proxid_persistence_stats                                                                                                            ,named('LinkingTools_mac_Suppress_proxid_persistence_stats'                ),all)  
                  // ,output(lgid3_persistence_stats                                                                                                             ,named('LinkingTools_mac_Suppress_lgid3_persistence_stats'                 ),all)  
                // #END
                ,output(topn(ds_fields_suppressed_stats             ,300  ,-cnt                                                                               ) ,named('LinkingTools_mac_Suppress_ds_fields_suppressed_stats'            ),all)  
                ,output(topn(ds_fields_and_values_suppressed_stats  ,300  ,-cnt                                                                               ) ,named('LinkingTools_mac_Suppress_ds_fields_and_values_suppressed_stats' ),all)
                ,output(topn(ds_suppressionid_stats                 ,300  ,-cnt                                                                               ) ,named('LinkingTools_mac_Suppress_ds_suppressionid_stats'                ),all)
                ,output(topn(ds_example_suppressions                ,500  ,-(max(fields_and_values_suppressed,suppressionid)),fields_suppressed,%DEDUPFIELDS% ) ,named('LinkingTools_mac_Suppress_example_suppressions'                  ),all)
                ,output(choosen(ds_not_samples                      ,500                                                                                      ) ,named('LinkingTools_mac_Suppress_example_NOT_suppressed'                ),all)
                ,output(choosen(ds_table                            ,300                                                                                      ) ,named('LinkingTools_mac_Suppress_ds_table'                              ),all)
                ,output(choosen(ds_proj                             ,300                                                                                      ) ,named('LinkingTools_mac_Suppress_ds_proj'                               ),all)
                ,output(choosen(ds_proj(didexplode = true)                             ,300                                                                   ) ,named('LinkingTools_mac_Suppress_ds_proj_suppressed'                               ),all)
                ,output(choosen(ds_out                              ,300                                                                                      ) ,named('LinkingTools_mac_Suppress_ds_out'                                ),all)
                ,output(choosen(ds_out(didexplode = true)                              ,300                                                                   ) ,named('LinkingTools_mac_Suppress_ds_out_suppressed'                                ),all)
                // ,output(choosen(ds_rest                             ,300                                                                                      ) ,named('LinkingTools_mac_Suppress_ds_rest'                               ),all)
                #IF(pShouldExplode = true)   
                  %EXAMPLE_OUTPUTS%      
                #END
                ,output(choosen(ds_concat_all_prep                  ,300                                                                                      ) ,named('LinkingTools_mac_Suppress_ds_ds_concat_all_prep'                 ),all)
                // #IF(pShouldExplode = true and pShouldIncrementFile = true) 
                // ,sequential(
                   // output(ds_increment_suppression_file ,,suppression_logical_name)
                  // ,std.file.clearsuperfile(suppression_super_name)
                  // ,std.file.addsuperfile  (suppression_super_name ,suppression_logical_name)
                // )
                // #END
    ));
    #ELSE
      return when(ds_result 
        ,parallel(
           output(ds_overall_stats                                                                                                                        ,named('LinkingTools_mac_Suppress_ds_overall_stats'                        ),all)
          ,output(topn(ds_fields_suppressed_stats             ,300  ,-cnt                                                                               ) ,named('LinkingTools_mac_Suppress_ds_fields_suppressed_stats'            ),all)  
          ,output(topn(ds_fields_and_values_suppressed_stats  ,300  ,-cnt                                                                               ) ,named('LinkingTools_mac_Suppress_ds_fields_and_values_suppressed_stats' ),all)
          ,output(topn(ds_suppressionid_stats                 ,300  ,-cnt                                                                               ) ,named('LinkingTools_mac_Suppress_ds_suppressionid_stats'                ),all)
          // #IF(pShouldExplode = true and pShouldIncrementFile = true) 
            // ,sequential(
               // output(ds_increment_suppression_file ,,suppression_logical_name)
              // ,std.file.clearsuperfile(suppression_super_name)
              // ,std.file.addsuperfile  (suppression_super_name ,suppression_logical_name)
            // )
          // #END
        )
      );
    #END
  #ELSE
    return
          '// -- FIELDSSUPPRESSED\n'
        + %'FIELDSSUPPRESSED'% + '\n' 
        + '// -- FIELDSANDVALUESSUPPRESSED\n'
        + %'FIELDSANDVALUESSUPPRESSED'% + '\n' 
        + '// -- SUPPRESSIONIDS\n'
        + %'SUPPRESSIONIDS'% + '\n' 
        + '// -- DEBUGSTUFF\n'
        + %'DEBUGSTUFF'% + '\n' 
        + '// -- TRANSFORMECL\n'
        + %'TRANSFORMECL'%  + '\n'
        + '// -- EXPLODEIDS\n'
        + %'EXPLODEIDS'%  + '\n'
        + '// -- JOINCONDITION\n'
        + %'JOINCONDITION'%  + '\n'
        + '// -- FIELDANDFILTER\n'
        + %'FIELDANDFILTER'%  + '\n'
        + '// -- DEDUPFIELDS\n'
        + %'DEDUPFIELDS'% + '\n'
        + '// -- DEDUPIDS\n'
        + %'DEDUPIDS'% + '\n'
        + '// -- DEDUPIDS_\n'
        + %'DEDUPIDS_'% + '\n'
        + '// -- PATCHJOINCONDITION\n'
        + %'PATCHJOINCONDITION'% + '\n'
        + '// -- PATCHIDS\n'
        + %'PATCHIDS'% + '\n'
        + '// -- LIDFIELDFILTER\n'
        + %'LIDFIELDFILTER'% + '\n'
        + '// -- ID_STATS\n'
        + %'ID_STATS'% + '\n'
        + '// -- EXAMPLE_OUTPUTS\n'
        + %'EXAMPLE_OUTPUTS'% + '\n'
        + '// -- DIDEXPLODE\n'
        + %'DIDEXPLODE'% + '\n'
      ; 
  #END

endmacro;
