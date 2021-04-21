
EXPORT MAC_MEOW_Biz_Batch_InLayout(infile,OutFile,AsIndex = 'true',In_UpdateIDs = 'false',Stats = '',In_bGetAllScores = 'true',In_disableForce = 'false',DoClean = 'true') := MACRO
  IMPORT SALT44,BizLinkFull;
  #UNIQUENAME(ToProcess)
  #UNIQUENAME(TPRec)
  %TPRec% := RECORD(BizLinkFull.Process_Biz_Layouts.InputLayout)
    STRING240 cnp_name_wb := ''; // Expanded wordbag field
    STRING240 company_url_wb := ''; // Expanded wordbag field
  END;
  #UNIQUENAME(infile_updateids)
  %infile_updateids% := IF(In_UpdateIDs, PROJECT(infile, %TPRec%), PROJECT(infile, TRANSFORM(%TPRec%, SELF.Entered_proxid := (TYPEOF(SELF.Entered_proxid))'', SELF := LEFT)));
  #UNIQUENAME(infile_clean)
  %infile_clean% := IF(DoClean, PROJECT(BizLinkFull.Process_Biz_Layouts.CleanInput(%infile_updateids%), %TPRec%), %infile_updateids%);
  #UNIQUENAME(fats)
  #UNIQUENAME(dups)
  // In case multiple copies of the same indicative are in there - remove them
  SALT44.MAC_Dups_Note(%infile_clean%,%TPRec%,%fats%,%dups%,,BizLinkFull.Config_BIP.meow_dedup);

  #UNIQUENAME(key_cnp_name)
  %key_cnp_name% := BizLinkFull.Specificities(BizLinkFull.file_BizHead).cnp_name_values_key;
  #UNIQUENAME(A_cnp_name)
  %A_cnp_name% := SALT44.mac_wordbag_appendspecs_th(%fats%,cnp_name,cnp_name_wb,%key_cnp_name%,cnp_name,AsIndex);
  #UNIQUENAME(key_company_url)
  %key_company_url% := BizLinkFull.Specificities(BizLinkFull.file_BizHead).company_url_values_key;
  #UNIQUENAME(A_company_url)
  %A_company_url% := SALT44.mac_wordbag_appendspecs_th(%A_cnp_name%,company_url,company_url_wb,%key_company_url%,company_url,AsIndex);

  %ToProcess% := %A_company_url%(Entered_proxid = 0 AND Entered_seleid = 0 AND Entered_orgid = 0 AND Entered_ultid = 0);
    #UNIQUENAME(OutputNewIDs)
    #IF (#TEXT(Input_proxid) <> '' OR #TEXT(Input_seleid) <> '' OR #TEXT(Input_orgid) <> '' OR #TEXT(Input_ultid) <> '')
    #UNIQUENAME(ToUpdate)
      %ToUpdate% := %A_company_url%(~(Entered_proxid = 0 AND Entered_seleid = 0 AND Entered_orgid = 0 AND Entered_ultid = 0));
      %OutputNewIDs% := BizLinkFull.Process_Biz_Layouts.UpdateIDs(%ToUpdate%);
    #ELSE
      %OutputNewIDs% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
    #END
  #UNIQUENAME(OutputL_CNPNAME_ZIP)
  #IF(#TEXT(Input_cnp_name)<>'' AND #TEXT(Input_zip)<>'')
    #UNIQUENAME(HoldL_CNPNAME_ZIP)
    %HoldL_CNPNAME_ZIP% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_ZIP%,UniqueId,cnp_name_wb,zip_cases,prim_name,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CNPNAME_ZIP%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CNPNAME_ZIP% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CNPNAME_ST)
  #IF(#TEXT(Input_cnp_name)<>'' AND #TEXT(Input_st)<>'')
    #UNIQUENAME(HoldL_CNPNAME_ST)
    %HoldL_CNPNAME_ST% := %ToProcess%(~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(ROW(%ToProcess%)));
    BizLinkFull.Key_BizHead_L_CNPNAME_ST.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_ST%,UniqueId,cnp_name_wb,st,prim_name,zip_cases,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CNPNAME_ST%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CNPNAME_ST% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CNPNAME)
  #IF(#TEXT(Input_cnp_name)<>'')
    #UNIQUENAME(HoldL_CNPNAME)
    %HoldL_CNPNAME% := %ToProcess%(~BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(ROW(%ToProcess%)) AND ~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(ROW(%ToProcess%)));
    BizLinkFull.Key_BizHead_L_CNPNAME.MAC_ScoredFetch_Batch(%HoldL_CNPNAME%,UniqueId,cnp_name_wb,prim_name,city,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,zip_cases,%OutputL_CNPNAME%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CNPNAME% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CNPNAME_FUZZY)
  #IF(#TEXT(Input_company_name_prefix)<>'')
    #UNIQUENAME(HoldL_CNPNAME_FUZZY)
    %HoldL_CNPNAME_FUZZY% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.MAC_ScoredFetch_Batch(%HoldL_CNPNAME_FUZZY%,UniqueId,company_name_prefix,cnp_name_wb,st,zip_cases,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CNPNAME_FUZZY%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CNPNAME_FUZZY% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_ADDRESS1)
  #IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_city)<>'' AND #TEXT(Input_st)<>'')
    #UNIQUENAME(HoldL_ADDRESS1)
    %HoldL_ADDRESS1% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_ADDRESS1.MAC_ScoredFetch_Batch(%HoldL_ADDRESS1%,UniqueId,prim_name,city,st,prim_range,cnp_name_wb,zip_cases,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_ADDRESS1%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_ADDRESS1% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_ADDRESS2)
  #IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_zip)<>'')
    #UNIQUENAME(HoldL_ADDRESS2)
    %HoldL_ADDRESS2% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_ADDRESS2.MAC_ScoredFetch_Batch(%HoldL_ADDRESS2%,UniqueId,prim_name,zip_cases,prim_range,cnp_name_wb,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_ADDRESS2%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_ADDRESS2% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_ADDRESS3)
  #IF(#TEXT(Input_prim_name)<>'' AND #TEXT(Input_prim_range)<>'' AND #TEXT(Input_zip)<>'')
    #UNIQUENAME(HoldL_ADDRESS3)
    %HoldL_ADDRESS3% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_ADDRESS3.MAC_ScoredFetch_Batch(%HoldL_ADDRESS3%,UniqueId,prim_name,prim_range,zip_cases,cnp_name_wb,st,city,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_ADDRESS3%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_ADDRESS3% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_PHONE)
  #IF(#TEXT(Input_company_phone_7)<>'')
    #UNIQUENAME(HoldL_PHONE)
    %HoldL_PHONE% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_PHONE.MAC_ScoredFetch_Batch(%HoldL_PHONE%,UniqueId,company_phone_7,cnp_name_wb,company_phone_3,company_phone_3_ex,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_PHONE%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_PHONE% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_FEIN)
  #IF(#TEXT(Input_company_fein)<>'')
    #UNIQUENAME(HoldL_FEIN)
    %HoldL_FEIN% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_FEIN.MAC_ScoredFetch_Batch(%HoldL_FEIN%,UniqueId,company_fein,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_FEIN%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_FEIN% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_URL)
  #IF(#TEXT(Input_company_url)<>'')
    #UNIQUENAME(HoldL_URL)
    %HoldL_URL% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_URL.MAC_ScoredFetch_Batch(%HoldL_URL%,UniqueId,company_url_wb,st,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_URL%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_URL% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CONTACT_ZIP)
  #IF(#TEXT(Input_fname_preferred)<>'' AND #TEXT(Input_lname)<>'' AND #TEXT(Input_zip)<>'')
    #UNIQUENAME(HoldL_CONTACT_ZIP)
    %HoldL_CONTACT_ZIP% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_CONTACT_ZIP.MAC_ScoredFetch_Batch(%HoldL_CONTACT_ZIP%,UniqueId,fname_preferred,lname,zip_cases,mname,cnp_name_wb,st,fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CONTACT_ZIP%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CONTACT_ZIP% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CONTACT_ST)
  #IF(#TEXT(Input_fname_preferred)<>'' AND #TEXT(Input_lname)<>'' AND #TEXT(Input_st)<>'')
    #UNIQUENAME(HoldL_CONTACT_ST)
    %HoldL_CONTACT_ST% := %ToProcess%(~BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(ROW(%ToProcess%)));
    BizLinkFull.Key_BizHead_L_CONTACT_ST.MAC_ScoredFetch_Batch(%HoldL_CONTACT_ST%,UniqueId,fname_preferred,lname,st,mname,cnp_name_wb,fname,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_name,city,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CONTACT_ST%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CONTACT_ST% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CONTACT_SSN)
  #IF(#TEXT(Input_contact_ssn)<>'')
    #UNIQUENAME(HoldL_CONTACT_SSN)
    %HoldL_CONTACT_SSN% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_CONTACT_SSN.MAC_ScoredFetch_Batch(%HoldL_CONTACT_SSN%,UniqueId,contact_ssn,contact_email,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_CONTACT_SSN%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CONTACT_SSN% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_EMAIL)
  #IF(#TEXT(Input_contact_email)<>'')
    #UNIQUENAME(HoldL_EMAIL)
    %HoldL_EMAIL% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_EMAIL.MAC_ScoredFetch_Batch(%HoldL_EMAIL%,UniqueId,contact_email,company_sic_code1,cnp_name_wb,cnp_number,cnp_btype,cnp_lowv,zip_cases,prim_name,city,st,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_EMAIL%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_EMAIL% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_SIC)
  #IF(#TEXT(Input_company_sic_code1)<>'' AND #TEXT(Input_zip)<>'')
    #UNIQUENAME(HoldL_SIC)
    %HoldL_SIC% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_SIC.MAC_ScoredFetch_Batch(%HoldL_SIC%,UniqueId,company_sic_code1,zip_cases,cnp_name_wb,prim_name,%OutputL_SIC%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_SIC% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_SOURCE)
  #IF(#TEXT(Input_source_record_id)<>'' AND #TEXT(Input_source)<>'')
    #UNIQUENAME(HoldL_SOURCE)
    %HoldL_SOURCE% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_SOURCE.MAC_ScoredFetch_Batch(%HoldL_SOURCE%,UniqueId,source_record_id,source,cnp_name_wb,prim_name,zip_cases,city,st,company_sic_code1,cnp_number,cnp_btype,cnp_lowv,prim_range,sec_range,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,sele_flag,org_flag,ult_flag,%OutputL_SOURCE%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_SOURCE% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(OutputL_CONTACT_DID)
  #IF(#TEXT(Input_contact_did)<>'')
    #UNIQUENAME(HoldL_CONTACT_DID)
    %HoldL_CONTACT_DID% := %ToProcess%;
    BizLinkFull.Key_BizHead_L_CONTACT_DID.MAC_ScoredFetch_Batch(%HoldL_CONTACT_DID%,UniqueId,contact_did,%OutputL_CONTACT_DID%,AsIndex,In_disableForce)
  #ELSE
    %OutputL_CONTACT_DID% := DATASET([],BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch);
  #END
  #UNIQUENAME(AllRes)
  %AllRes% := %OutputL_CNPNAME_ZIP%+%OutputL_CNPNAME_ST%+%OutputL_CNPNAME%+%OutputL_CNPNAME_FUZZY%+%OutputL_ADDRESS1%+%OutputL_ADDRESS2%+%OutputL_ADDRESS3%+%OutputL_PHONE%+%OutputL_FEIN%+%OutputL_URL%+%OutputL_CONTACT_ZIP%+%OutputL_CONTACT_ST%+%OutputL_CONTACT_SSN%+%OutputL_EMAIL%+%OutputL_SIC%+%OutputL_SOURCE%+%OutputL_CONTACT_DID%+%OutputNewIDs%;
  #UNIQUENAME(All)
  %All% := BizLinkFull.Process_Biz_Layouts.CombineAllScores(%AllRes%, In_bGetAllScores, In_disableForce);
  #UNIQUENAME(OutFile0)
  SALT44.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #UNIQUENAME(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := BizLinkFull.Process_Biz_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
