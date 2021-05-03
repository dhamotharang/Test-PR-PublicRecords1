/* 
  BIPV2_Tools.mac_Set_Statuses()
    -- Set statuses for each BIP ID, allowing for public(no use of DNB) and private(limited use of DNB to corroborate other sources' status)

   2. Create new Active Score field (scores should be based on source ranking , latest dt_last_seen)

*/
import BIPV2_Statuses;

EXPORT mac_Set_Statuses(

   infile                   = 'bipv2.CommonBase.ds_clean'                             // -- assuming this dataset is ds_clean or cleaned(no old records in it)
  ,pBIP_ID                  = 'seleid'                                                // -- BIP ID fieldname
  ,pActive_Fieldname        = 'seleid_status_private'                                 // -- active status fieldname
  ,pActive_Fieldname_score  = 'seleid_status_private_score'                           // -- active status score fieldname
  ,pUse_DNB                 = 'false'                                                 // -- should use DNB for active calculation.
  ,pBIP_ID_Test_Value       = '0'                                                     // -- optional BIP ID value to query all intermediate files for.
  ,pFuture_Dates            = 'true'                                                  // -- set future dates to 19700101 so they are treated as old.  
  ,pToday                   = 'bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate'  // -- in case you want to run as of a date in the past.  default to date of newest data.
  ,pShow_Work               = 'false'                                                 // -- produce debug outputs from active status calculations.
  ,pSet_High_Conf_Sources   = 'BIPV2_Statuses._Config.set_High_Conf'                  // -- sources used to calculate high confidence active status
  ,pSet_Medium_Conf_Sources = 'BIPV2_Statuses._Config.set_medium_conf'                // -- sources used to calculate medium confidence active status(high confidence sources are also added to this set)
  ,pSet_Low_Conf_Sources    = 'BIPV2_Statuses._Config.set_low_conf'                   // -- sources used to calculate low confidence active status(basically all sources are used, old way)

) :=
FUNCTIONMACRO

  import bipv2,ut,mdr,bipv2,AutoStandardI,BIPV2_PostProcess,BIPV2_Statuses;
  
  // -- Buckets of sources based on dt_last_seen confidence(does their dt_last_seen reflect how current the data in the record is?)
  set_high_conf_sources   := pSet_High_Conf_Sources    ;
  set_medium_conf_sources := pSet_Medium_Conf_Sources  ;
  set_low_conf_sources    := pSet_Low_Conf_Sources     ;//this is rest of sources in bip header actually

  // -- Set active status field using each of the three buckets of sources
  ds_status_high   := BIPV2_Statuses.mac_Set_Statuses(infile ,pBIP_ID  ,pActive_Fieldname  ,pUse_DNB ,pBIP_ID_Test_Value ,pFuture_Dates  ,pToday ,pShow_Work ,set_high_conf_sources                           ,false  ,'HIGH'  );
  ds_status_medium := BIPV2_Statuses.mac_Set_Statuses(infile ,pBIP_ID  ,pActive_Fieldname  ,pUse_DNB ,pBIP_ID_Test_Value ,pFuture_Dates  ,pToday ,pShow_Work ,set_high_conf_sources + set_medium_conf_sources ,false  ,'MEDIUM');
  ds_status_low    := BIPV2_Statuses.mac_Set_Statuses(infile ,pBIP_ID  ,pActive_Fieldname  ,pUse_DNB ,pBIP_ID_Test_Value ,pFuture_Dates  ,pToday ,pShow_Work ,[]                                              ,true   ,'LOW'   );

/*  -- need to add the active_calculation child dataset to this after the above three calls so we have the detailed calculations by source and we can compare them.!!!!!!
  #IF(pShow_Work = false)
      {recordof(infile) or {string1 pActive_Fieldname}},
#ELSIF
      {recordof(infile) or {string1 pActive_Fieldname},dataset(lay_active_calc) active_calculation },
#END
*/
  // -- dedup medium and high tables
  ds_status_medium_table  := table(ds_status_medium ,{pBIP_ID  ,pActive_Fieldname}  ,pBIP_ID  ,pActive_Fieldname ,merge);
  ds_status_high_table    := table(ds_status_high   ,{pBIP_ID  ,pActive_Fieldname}  ,pBIP_ID  ,pActive_Fieldname ,merge);
  
  // -- join the tables together to get all three statuses and all the records(low is not uniqued so it contains all records)
  ds_join1 := join(ds_status_low  ,ds_status_medium_table ,left.pBIP_ID = right.pBIP_ID ,transform({recordof(left),string1 active_status_medium} ,self := left,self.active_status_medium := right.pActive_Fieldname) ,keep(1)  ,hash);
  ds_join2 := join(ds_join1       ,ds_status_high_table   ,left.pBIP_ID = right.pBIP_ID ,transform({recordof(left),string1 active_status_high  } ,self := left,self.active_status_high   := right.pActive_Fieldname) ,keep(1)  ,hash);

  // -- set active status and score field for output
  ds_output := project(ds_join2 ,transform(
      {recordof(infile) or {string1 pActive_Fieldname,unsigned1 pActive_Fieldname_score}},
    self.pActive_Fieldname        := left.pActive_Fieldname;
    self.pActive_Fieldname_score  := map(

       left.pActive_Fieldname  = left.active_status_high    => 3  // if status on record(old way) matches high confidence status, then it is high confidence
      ,left.pActive_Fieldname  = left.active_status_medium  => 2  // elseif status on record matches medium confidence status, then it is medium confidence
      ,                                                        1  // else low confidence

    );
    self                          := left
  ));

  // -- generate table counts on active status and scores
  ds_table_stats        := table(ds_output      ,{pBIP_ID ,pActive_Fieldname ,pActive_Fieldname_score                                } ,pBIP_ID  ,pActive_Fieldname ,pActive_Fieldname_score  ,merge);
  ds_table_stats2       := table(ds_table_stats ,{         pActive_Fieldname ,pActive_Fieldname_score   ,unsigned cnt := count(group)}           ,pActive_Fieldname ,pActive_Fieldname_score  ,merge);
  ds_table_stats_total  := table(ds_table_stats ,{         pActive_Fieldname                            ,unsigned cnt := count(group)}           ,pActive_Fieldname                           ,merge);

  ds_table_stats_out := project(ds_table_stats2       ,transform({string1 pActive_Fieldname,string pActive_Fieldname_score  ,unsigned cnt},self.pActive_Fieldname_score := (string)left.pActive_Fieldname_score ,self := left))
                      + project(ds_table_stats_total  ,transform({string1 pActive_Fieldname,string pActive_Fieldname_score  ,unsigned cnt},self.pActive_Fieldname_score := 'Total'                              ,self := left))
                      + dataset([{'Total ' + trim(#TEXT(pBIP_ID)) + 's' ,'' ,sum(ds_table_stats_total,cnt)   }]  ,{string1 pActive_Fieldname,string pActive_Fieldname_score  ,unsigned cnt})
                      ;


  // return dataset with new status and score and output status counts
  return when(ds_output ,output(sort(ds_table_stats_out ,pActive_Fieldname,pActive_Fieldname_score) ,named('BIPV2_Tools__mac_Set_Statuses__Stats__' + trim(#TEXT(pActive_Fieldname))),extend));

ENDMACRO;
