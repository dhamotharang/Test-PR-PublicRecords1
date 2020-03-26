EXPORT mac_Rollup_Gold_Seleid_Orgid_Persistence_Stats(
  
   pversion = 'bipv2.KeySuffix'
  ,pDataset = 'BIPV2_Strata.Files(\'base\').Gold_Seleid_Orgid_Persistence.logical'
  ,pEmail   = 'BIPV2_Build.mod_email.emailList' // -- if blank, will not email
  ,pDebug   = 'false'

) :=
functionmacro

  import tools;
  ds_sort_all_stats     := sort(pDataset,-version,statname);
  ds_project_all_stats  := project(ds_sort_all_stats ,transform({BIPV2_Strata.layouts.Gold_Seleid_Orgid_Persistence orig,BIPV2_Strata.layouts.Gold_Seleid_Orgid_Persistence_rollup rolledup} 
    ,self.orig                                        := left
    ,self.rolledup.version                            := left.version 
    ,self.rolledup.Gold_Seleids_new	                  := if(trim(left.statname)  =  'Gold Seleids new'	                  ,left.statvalue ,'')
    ,self.rolledup.Gold_Seleids_old	                  := if(trim(left.statname)  =  'Gold Seleids old'	                  ,left.statvalue ,'')
    ,self.rolledup.Gold_Seleids_in_common	            := if(trim(left.statname)  =  'Gold Seleids in common'	            ,left.statvalue ,'')
    ,self.rolledup.Gold_Seleids_with_same_orgid	      := if(trim(left.statname)  =  'Gold Seleids with same orgid'	      ,left.statvalue ,'')
    ,self.rolledup.Gold_Seleids_with_same_ultid	      := if(trim(left.statname)  =  'Gold Seleids with same ultid'	      ,left.statvalue ,'')
    ,self.rolledup.Gold_Seleids_with_different_orgid  := if(trim(left.statname)  =  'Gold Seleids with different orgid'   ,left.statvalue ,'')
    ,self.rolledup.Gold_Seleids_with_different_ultid  := if(trim(left.statname)  =  'Gold Seleids with different ultid'   ,left.statvalue ,'')
    ,self.rolledup.Pct_Gold_Seleids_with_same_orgid	  := if(trim(left.statname)  =  '% Gold Seleids with same orgid'	    ,left.statvalue ,'')
    ,self.rolledup.Pct_Gold_Seleids_with_same_ultid	  := if(trim(left.statname)  =  '% Gold Seleids with same ultid'	    ,left.statvalue ,'')
  ));

  ds_rollup_stats := rollup(ds_project_all_stats  ,left.orig.version = right.orig.version ,transform(recordof(left)
    ,self.orig := right.orig
    ,self.rolledup.version                            := left.orig.version 
    ,self.rolledup.Gold_Seleids_new	                  := if(trim(left.rolledup.Gold_Seleids_new	                ) != ''  ,left.rolledup.Gold_Seleids_new	                 ,right.rolledup.Gold_Seleids_new	                	)
    ,self.rolledup.Gold_Seleids_old	                  := if(trim(left.rolledup.Gold_Seleids_old	                ) != ''  ,left.rolledup.Gold_Seleids_old	                 ,right.rolledup.Gold_Seleids_old	                	)
    ,self.rolledup.Gold_Seleids_in_common	            := if(trim(left.rolledup.Gold_Seleids_in_common	          ) != ''  ,left.rolledup.Gold_Seleids_in_common	           ,right.rolledup.Gold_Seleids_in_common	          	)
    ,self.rolledup.Gold_Seleids_with_same_orgid	      := if(trim(left.rolledup.Gold_Seleids_with_same_orgid	    ) != ''  ,left.rolledup.Gold_Seleids_with_same_orgid	     ,right.rolledup.Gold_Seleids_with_same_orgid	    	)
    ,self.rolledup.Gold_Seleids_with_same_ultid	      := if(trim(left.rolledup.Gold_Seleids_with_same_ultid	    ) != ''  ,left.rolledup.Gold_Seleids_with_same_ultid	     ,right.rolledup.Gold_Seleids_with_same_ultid	    	)
    ,self.rolledup.Gold_Seleids_with_different_orgid  := if(trim(left.rolledup.Gold_Seleids_with_different_orgid) != ''  ,left.rolledup.Gold_Seleids_with_different_orgid ,right.rolledup.Gold_Seleids_with_different_orgid	)
    ,self.rolledup.Gold_Seleids_with_different_ultid  := if(trim(left.rolledup.Gold_Seleids_with_different_ultid) != ''  ,left.rolledup.Gold_Seleids_with_different_ultid ,right.rolledup.Gold_Seleids_with_different_ultid	)
    ,self.rolledup.Pct_Gold_Seleids_with_same_orgid	  := if(trim(left.rolledup.Pct_Gold_Seleids_with_same_orgid	) != ''  ,left.rolledup.Pct_Gold_Seleids_with_same_orgid	 ,right.rolledup.Pct_Gold_Seleids_with_same_orgid		)
    ,self.rolledup.Pct_Gold_Seleids_with_same_ultid	  := if(trim(left.rolledup.Pct_Gold_Seleids_with_same_ultid	) != ''  ,left.rolledup.Pct_Gold_Seleids_with_same_ultid	 ,right.rolledup.Pct_Gold_Seleids_with_same_ultid		)
  ));
  
  ds_result := project(ds_rollup_stats ,transform(BIPV2_Strata.layouts.Gold_Seleid_Orgid_Persistence_rollup,self := left.rolledup));

  send_email := tools.Send_Email_CSV_Attachment(
     ds_result 
    ,'BIPV2 Gold Seleids\' Orgid and Ultid Persistence Stats ' 
    ,'Please find the Gold Seleids Orgid and Ultid Persistence Stats for version ' + pversion + ' Attached.\nYou can open this in excel and transpose the data for easier viewing'
    ,'BIPV2_Gold_Seleids_Orgid_and_Ultid_Persistence_Stats_' + pversion +'.csv'
    ,pEmail
    ,pversion
  );
  
  output_debug := parallel(
     output(pDataset              ,named('ds_all_stats'         ))
    ,output(ds_sort_all_stats     ,named('ds_sort_all_stats'    ))
    ,output(ds_project_all_stats  ,named('ds_project_all_stats' ))
    ,output(ds_rollup_stats       ,named('ds_rollup_stats'      ))
    ,output(ds_result             ,named('ds_result'            ))
  );

  return when(ds_result 
    ,sequential(
       iff(pEmail != ''   ,send_email   ) 
      ,iff(pDebug  = true ,output_debug )
    )
  );
  
endmacro;