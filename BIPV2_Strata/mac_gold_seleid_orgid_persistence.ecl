import BIPV2,BIPV2_Build;
EXPORT mac_gold_seleid_orgid_persistence(

   pversion         = 'bipv2.KeySuffix'
  ,pNew_Base_File   = 'bipv2.CommonBase.DS_CLEAN'
  ,pOld_Base_File   = 'bipv2.CommonBase.DS_CLEAN_BASE'
  ,pReturn_dataset  = 'false'
  ,pDebug           = 'false'
  ,pEmail           = 'BIPV2_Build.mod_email.emailList' // -- if blank, will not email
) :=
functionmacro

  import tools,BIPV2_Strata;
  
  ds_new  := pNew_Base_File ;
  ds_old  := pOld_Base_File ;

  ds_gold_seleids_new   := table(ds_new(trim(sele_gold) = 'G') ,{seleid,orgid,ultid} ,seleid,orgid,ultid ,merge) : persist('~persist::BIPV2_Strata::mac_gold_seleid_orgid_persistence::ds_gold_seleids_new_' + pversion );
  ds_gold_seleids_old   := table(ds_old(trim(sele_gold) = 'G') ,{seleid,orgid,ultid} ,seleid,orgid,ultid ,merge) : persist('~persist::BIPV2_Strata::mac_gold_seleid_orgid_persistence::ds_gold_seleids_old_' + pversion );

  ds_gold_seleids_in_common            := join(ds_gold_seleids_new  ,ds_gold_seleids_old  ,left.seleid = right.seleid ,transform(left)  ,hash);
  ds_gold_seleids_in_common_same_orgid := join(ds_gold_seleids_new  ,ds_gold_seleids_old  ,left.seleid = right.seleid and left.orgid = right.orgid ,transform(left)  ,hash);
  ds_gold_seleids_in_common_same_ultid := join(ds_gold_seleids_new  ,ds_gold_seleids_old  ,left.seleid = right.seleid and left.ultid = right.ultid ,transform(left)  ,hash);

  ds_gold_seleids_in_common_diff_orgid := join(ds_gold_seleids_new  ,ds_gold_seleids_old  ,left.seleid = right.seleid and left.orgid != right.orgid ,transform(left)  ,hash);
  ds_gold_seleids_in_common_diff_ultid := join(ds_gold_seleids_new  ,ds_gold_seleids_old  ,left.seleid = right.seleid and left.ultid != right.ultid ,transform(left)  ,hash);

  pct_gold_seleids_with_same_orgid := count(ds_gold_seleids_in_common_same_orgid) / count(ds_gold_seleids_in_common) * 100.0;
  pct_gold_seleids_with_same_ultid := count(ds_gold_seleids_in_common_same_ultid) / count(ds_gold_seleids_in_common) * 100.0;

  ds_stats := dataset([
    {pversion,'Gold Seleids new'	                  ,(string)count(ds_gold_seleids_new                 )}
   ,{pversion,'Gold Seleids old'	                  ,(string)count(ds_gold_seleids_old                 )}
   ,{pversion,'Gold Seleids in common'	            ,(string)count(ds_gold_seleids_in_common           )}
   ,{pversion,'Gold Seleids with same orgid'	      ,(string)count(ds_gold_seleids_in_common_same_orgid)}
   ,{pversion,'Gold Seleids with same ultid'	      ,(string)count(ds_gold_seleids_in_common_same_ultid)}
   ,{pversion,'Gold Seleids with different orgid'   ,(string)count(ds_gold_seleids_in_common_diff_orgid)}
   ,{pversion,'Gold Seleids with different ultid'   ,(string)count(ds_gold_seleids_in_common_diff_ultid)}
   ,{pversion,'% Gold Seleids with same orgid'	    ,realformat(pct_gold_seleids_with_same_orgid ,6,2)  }
   ,{pversion,'% Gold Seleids with same ultid'	    ,realformat(pct_gold_seleids_with_same_ultid ,6,2)  }

  ],BIPV2_Strata.layouts.Gold_Seleid_Orgid_Persistence);

  #IF(pReturn_dataset = true)
    return_result := ds_stats;
  
  #ELSE
                    
    output_file := tools.macf_writefile(BIPV2_Strata.filenames(pversion).Gold_Seleid_Orgid_Persistence.logical  ,ds_stats,true,,true);
    //output rolled up version for excel
    // {string version,string statname,string statvalue}
    ds_all_stats := BIPV2_Strata.Files('base').Gold_Seleid_Orgid_Persistence.logical;

    ds_output_rollup := BIPV2_Strata.mac_Rollup_Gold_Seleid_Orgid_Persistence_Stats(pversion,ds_all_stats,pEmail,pDebug);

    return_result := sequential(
       output_file
      ,BIPV2_Strata.Promote(pversion,pClearSuperFirst := false).new2base  //I will put all stats in this superfile for reference later
      ,output(sort(ds_output_rollup,-version)  ,named('Historical_Seleid_Orgid_Persistence_stats_' + pversion))
    );
  #END
  

  return return_result;
  
endmacro;