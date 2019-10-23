/*
  BIPV2_Tools.Refresh_Duns();
    Refreshes the D&B fields; active_duns_number, hist_duns_number, deleted_key(duns_number), company_fein, deleted_fein.
*/
import BIPV2_Build,bipv2,dnb_dmi,mdr,bipv2_files,ut,_control;
export Refresh_Duns(
     dataset(BIPV2.CommonBase.Layout)                     pds_in          = bipv2.commonbase.ds_base
    ,dataset(recordof(dnb_dmi.files().base.companies.qa)) pDuns_file      = dnb_dmi.files().base.companies.qa
    ,string                                               pPersistUnique  = ''
  ) := 
function
    l_dot := BIPV2.CommonBase.Layout;
  
    ds_active_duns_new2 :=  BIPV2_Tools.GetDuns(pDuns_file,pPersistUnique);
    
    // --------------------------------------
    // -- Refresh Duns number fields
    // --------------------------------------
    l_dot_temp := {unsigned6 lgid3_old := 0,unsigned proxid_old := 0,l_dot,string prev_deleted_duns := ''};
    isdmi(string src) := MDR.sourceTools.SourceIsDunn_Bradstreet(src);
    
    l_dot_temp tr_Refresh_Duns(l_dot L, ds_active_duns_new2 R) := 
    transform
      self.active_duns_number   := if(trim(R.status)       = 'Active'   and isdmi(L.source)  ,R.duns_number  ,''  ); //if it matches and duns status is Active  , populate this field 
      self.hist_duns_number     := if(trim(R.status)       = 'Historic' and isdmi(L.source)  ,R.duns_number  ,''  ); //if it matches and duns status is Historic, populate this field 
      self.deleted_key          := if(trim(R.status)       = 'Deleted'                       ,R.duns_number  ,''  ); //save deleted duns number here in a field not used for linking.
      self.company_fein         := if(trim(R.status)       = 'Deleted'                       ,''             ,if(L.company_fein != '' ,L.company_fein ,L.deleted_fein) ); //save deleted fein here in a field not used for linking.
      self.deleted_fein         := if(trim(R.status)       = 'Deleted'                       ,if(L.company_fein != '' ,L.company_fein ,L.deleted_fein) ,''              ); //save deleted fein here in a field not used for linking.
      self.prev_deleted_duns    := L.deleted_key                                                           ; //save previous deleted duns number here for stat purposes.
      self                      := L;
    end;
    // -- fix duns numbers, add D&B fein so their duns_numbers can get deleted too.
    ds_in_fix   := project(pds_in,transform(recordof(left)
      ,self.duns_number := map(
         left.duns_number != ''                                                                      => left.duns_number
        ,mdr.sourcetools.sourceisDunn_Bradstreet     (left.source) and left.active_duns_number != '' => left.active_duns_number 
        ,mdr.sourcetools.sourceisDunn_Bradstreet     (left.source) and left.hist_duns_number   != '' => left.hist_duns_number 
        ,mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(left.source) and length(trim(left.vl_id)) = 9  => left.vl_id
        ,mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(left.source) and trim(left.vl_id)[1..2] = 'DF' and length(trim(left.vl_id)) > 9 => trim(left.vl_id)[(length(trim(left.vl_id)) - 8)..]
        ,left.duns_number
      );
      ,self.company_fein := if(Left.company_fein != '' ,Left.company_fein ,Left.deleted_fein);
      ,self.deleted_fein := '';
      ,self := left)) 
      : persist('~persist::BIPV2_Tools::Refresh_Duns::ds_in_fix'+ pPersistUnique); 
    ds_blank_duns     := distribute(ds_in_fix(duns_number ='')) : persist('~persist::BIPV2_Tools::Refresh_Duns::ds_blank_duns'   + pPersistUnique);
    ds_nonblank_duns  := ds_in_fix(duns_number<>'') : persist('~persist::BIPV2_Tools::Refresh_Duns::ds_nonblank_duns'+ pPersistUnique);
    
    ds_refresh_duns  := join(
      ds_nonblank_duns, ds_active_duns_new2,
      trim(left.duns_number) = trim(right.duns_number) and trim(left.cnp_name) = trim(right.cnp_name),
      tr_Refresh_Duns(left,right),
      left outer, hash
    )
    : persist('~persist::BIPV2_Tools::Refresh_Duns::ds_refresh_duns'+ pPersistUnique);
    
    // -- Full file after duns refresh
    ds_result   := project(ds_blank_duns,transform(l_dot_temp,self.active_duns_number := '',self.hist_duns_number := '',self := left)) 
                            + ds_refresh_duns
      ;

   import wk_ut;
   dmi_input_file := wk_ut.Orbit_Item_list(workunit,'dmi'); //get the dmi file used
   dmi_filename := dmi_input_file[1].name;

    ds_stats := dataset([
       {'D&B DMI' ,''                   ,'filename'         ,dmi_filename                                           }
      ,{'Input'   ,''                   ,'Count Records'    ,(string)count(pds_in                                 ) }
      ,{'Output'  ,''                   ,'Count Records'    ,(string)count(ds_result                              ) ,realformat((count(ds_result                           ) / count(pds_in                          ) * 100.0) - 100,10,4)}
      ,{'Input'   ,'cnp_name'           ,'Count NonBlank'   ,(string)count(pds_in   (cnp_name             != '')  ) }
      ,{'Output'  ,'cnp_name'           ,'Count NonBlank'   ,(string)count(ds_result(cnp_name             != '')  ) ,realformat((count(ds_result(cnp_name            != '')) / count(pds_in(cnp_name           != '')) * 100.0) - 100,10,4)}
      ,{'Input'   ,'duns_number'        ,'Count NonBlank'   ,(string)count(pds_in   (duns_number          != '')  ) }
      ,{'Output'  ,'duns_number'        ,'Count NonBlank'   ,(string)count(ds_result(duns_number          != '')  ) ,realformat((count(ds_result(duns_number         != '')) / count(pds_in(duns_number        != '')) * 100.0) - 100,10,4)}
      ,{'Input'   ,'active_duns_number' ,'Count NonBlank'   ,(string)count(pds_in   (active_duns_number   != '')  ) }
      ,{'Output'  ,'active_duns_number' ,'Count NonBlank'   ,(string)count(ds_result(active_duns_number   != '')  ) ,realformat((count(ds_result(active_duns_number  != '')) / count(pds_in(active_duns_number != '')) * 100.0) - 100,10,4)}
      ,{'Input'   ,'hist_duns_number'   ,'Count NonBlank'   ,(string)count(pds_in   (hist_duns_number     != '')  ) }
      ,{'Output'  ,'hist_duns_number'   ,'Count NonBlank'   ,(string)count(ds_result(hist_duns_number     != '')  ) ,realformat((count(ds_result(hist_duns_number    != '')) / count(pds_in(hist_duns_number   != '')) * 100.0) - 100,10,4)}
      ,{'Input'   ,'deleted_key'        ,'Count NonBlank'   ,(string)count(pds_in   (deleted_key          != '')  ) }
      ,{'Output'  ,'deleted_key'        ,'Count NonBlank'   ,(string)count(ds_result(deleted_key          != '')  ) ,realformat((count(ds_result(deleted_key         != '')) / count(pds_in(deleted_key        != '')) * 100.0) - 100,10,4)}

//      ,{'Input'   ,'new deleted_key'    ,'Count NonBlank'   ,(string)count(pds_in   (deleted_key          != '',prev_deleted_duns = '')  ) }
      ,{'Output'  ,'new deleted_key'    ,'Count NonBlank'   ,(string)count(ds_result(deleted_key          != '',prev_deleted_duns = '')  ) ,realformat((count(ds_result(deleted_key         != '',prev_deleted_duns = '')) / count(pds_in(deleted_key        != '')) * 100.0),10,4)}

      ,{'Input'   ,'company_fein'       ,'Count NonBlank'   ,(string)count(pds_in   (company_fein         != '')  ) }
      ,{'Output'  ,'company_fein'       ,'Count NonBlank'   ,(string)count(ds_result(company_fein         != '')  ) ,realformat((count(ds_result(company_fein        != '')) / count(pds_in(company_fein       != '')) * 100.0) - 100,10,4)}
      ,{'Input'   ,'deleted_fein'       ,'Count NonBlank'   ,(string)count(pds_in   (deleted_fein         != '')  ) }
      ,{'Output'  ,'deleted_fein'       ,'Count NonBlank'   ,(string)count(ds_result(deleted_fein         != '')  ) ,realformat((count(ds_result(deleted_fein        != '')) / count(pds_in(deleted_fein       != '')) * 100.0) - 100,10,4)}
    
    
    ],{string file,string field,string stat,string value ,string pct_change := ''});


    return when(ds_result,output(ds_stats  ,named('Stats_BIPV2_Tools_Refresh_Duns')));
    
end;