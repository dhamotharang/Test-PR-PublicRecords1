//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_TestExternal - Test External Linking - Precision and Recall - SALT V3.7.2');
IMPORT BizLinkFull,SALT37;
// This is the 'thor only' version (no roxie)
  SmallJob := FALSE;
  UpdateIDs := FALSE;
  Infile := BizLinkFull.File_BizHead; // You can make this a different file - but must be in 'as header' format
  Mapping := 'UniqueID:rcid,zip_cases:zip';
  MyInfile := SALT37.FromFlat(InFile,BizLinkFull.process_Biz_layouts.InputLayout,Mapping);
  BizLinkFull.MAC_Meow_Biz_Batch(myinfile,UniqueId,/* MY_proxid */,/* MY_seleid */,/* MY_orgid */,/* MY_ultid */,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,has_lgid,empid,source,source_record_id,source_docid,company_name,company_name_prefix,cnp_name,cnp_number,cnp_btype,cnp_lowv,company_phone,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,active_duns_number,prim_range,prim_name,sec_range,city,city_clean,st,zip_cases,company_url,isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,fallback_value,CONTACTNAME,STREETADDRESS,MyOutFile,SmallJob,UpdateIDs,Stats, TRUE, FALSE);
  Rec := { BOOLEAN Present; BOOLEAN Equal; BOOLEAN Resolved };
  Rec note(Infile le,MyOutFile ri) := TRANSFORM
    SELF.Present := ri.Results[1].proxid <> 0;
    SELF.Resolved := ri.Resolved;
    SELF.Equal := le.proxid=ri.Results[1].proxid;
  END;
  J := JOIN(infile,myoutfile,LEFT.rcid=RIGHT.Reference,note(LEFT,RIGHT),LEFT OUTER);
  TABLE(J,{ Recall := AVE(GROUP, IF (Present,100,0) ), AvailableTrueRecall := AVE( GROUP,IF (Present AND Equal, 100, 0 ) ), TrueRecall := AVE( GROUP,IF (Present AND Equal AND Resolved, 100, 0 ) ) });
  Errors := JOIN(infile,myoutfile,LEFT.rcid=RIGHT.Reference AND LEFT.proxid<>RIGHT.Results[1].proxid);
  Errors;
  MyOutFile;
  Stats;
