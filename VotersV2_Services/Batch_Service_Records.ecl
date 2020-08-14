IMPORT Data_Services, AutokeyB2, Autokey_batch, VotersV2, VotersV2_services, BatchServices,AutoStandardI;

EXPORT Batch_Service_Records (DATASET(Autokey_batch.Layouts.rec_inBatchMaster) data_in,
                                      BatchServices.Interfaces.i_AK_Config cfgs) :=
FUNCTION
 //**** GET FAKEIDS - FLAPD SEARCH
  ak_key:= Data_Services.Data_location.Prefix('')+'thor_data400::key::voters::autokey::qa::';
  ak_out := Autokey_batch.get_fids(data_in, ak_key, cfgs);
  outpl_rec := DATASET([],VotersV2.Layouts_Voters.Layout_Voters_Autokeys);
  typestr := 'BC';
  AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec,outPLfat,did,0,typestr);
  appType := AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
  
  //** vtid and Acctno
  ids_acctno := DEDUP(SORT(PROJECT(UNGROUP(outplfat),VotersV2_Services.TRansforms.acct_rec),acctno,vtid),acctno,vtid);
  
  //** report layout
  res := votersV2_services.raw.SOURCE_VIEW.by_vtid (ids_acctno,,,appType);
  out_noacctno := DEDUP(SORT(res,did,vtid,politicalparty_exp,-LastDateVote)
                                ,did,vtid,politicalparty_exp);
  //** joining report layout to acctno
  out_acctno := JOIN(ids_acctno,out_noacctno
                     ,LEFT.vtid = RIGHT.vtid
                     ,VotersV2_Services.TRansforms.xfm_final(LEFT,RIGHT));
  RETURN out_acctno;
                     
END;
