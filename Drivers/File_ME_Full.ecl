lMEUpdateBaseName := (Drivers.Cluster + 'in::drvlic_me_update_');

Layout_ME_Full_Old
 :=
  record
    string08    append_PROCESS_DATE;
    string06    orig_DOB;
    string09    orig_NameKey;
    string02    orig_DupKey;
    string01    orig_DupCode;
    string04    orig_LastTransTerm;
    string04    orig_LastTransTermSeq;
    string06    orig_LastTransTermDate;
    string08    orig_RenewalNum;
    string20    orig_LName;
    string15    orig_FName;
    string01    orig_MI;
    string03    orig_NameSuf;
    string20    orig_Street;
    string20    orig_City;
    string02    orig_State;
    string05    orig_Zip;
    string01    orig_DriverEd;
    string02    orig_StateLicensedBy;
    string01    orig_Sex;
    string01    orig_Height;
    string02    orig_Height2;
    string03    orig_Weight;
    string02    orig_Hair;
    string02    orig_Eyes;
    string02    orig_DLExpireDate;
    string01    orig_DLStat;
    string02    orig_StateReturnedBy;
    string06    orig_DLIssueDate;
    string01    orig_RestrictPermissCode;
    string01    orig_RestrictPermissCode2;
    string01    orig_RestrictPermissCode3;
    string01    orig_RestrictPermissCode4;
    string01    orig_RestrictPermissCode5;
    string01    orig_RestrictPermissCode6;
    string06    orig_OriginalIssueDate;
    string03    orig_SuspensionCount;
    string03    orig_ConvictionCount;
    string03    orig_AccidentCount;
    string01    orig_DrunkDriveCount;
    string01    orig_RenewalCode;
    string01    orig_Converted;
    string01    orig_OriginalIssueFlag;
    string01    orig_RegStatFR;
    string01    orig_RegStatCR;
    string01    orig_MaineDLReturned;
    string01    orig_DLClass;
    string06    orig_JuryIssueDate;
    string04    orig_FrameNum;
    string07    orig_HistoryNum;
    string01    orig_LastHistoryPointer;
    string03    orig_ReelNum;
    string05    orig_RegistrationCount;
    string05    orig_TitleCount;
    string01    orig_DisabledVet;
    string01    orig_HabitualOffender;
    string01    orig_JuryFlag;
    string01    orig_Photo;
    string01    orig_MiscFlag;
    string10    orig_Restrictions;
    string01    orig_Endorsements;
    string01    orig_Endorsements2;
    string01    orig_Endorsements3;
    string01    orig_Endorsements4;
    string01    orig_Endorsements5;
    string01    orig_Endorsements6;
    string01    orig_Endorsements7;
    string01    orig_Endorsements8;
    string01    orig_Endorsements9;
    string01    orig_Endorsements10;
    string09    orig_SSN;
    string01    orig_OldClass;
    string06    orig_ClassChangeDate;
    string01    orig_CDLISFlag;
    string01    orig_MailingListFlag;
    string01    orig_CVCFlag;
    string06    orig_AddrDate;
    string02    orig_AddrCode;
    string01    orig_NDRFlag;
    string25    orig_OSDL;
    string02    orig_OSStat;
    string01    orig_CDLStat;
    string20    orig_FormerStreet;
    string20    orig_FormerCity;
    string02    orig_FormerState;
    string05    orig_FormerZip;
    string01    orig_PrivacyFlag;
    string08    orig_PrivacyDate;
    string177   orig_Filler;
    string5     clean_name_prefix;
    string20    clean_name_first;
    string20    clean_name_middle;
    string20    clean_name_last;
    string5     clean_name_suffix;
    string3     clean_name_score;
    string10    clean_prim_range;
    string2     clean_predir;
    string28    clean_prim_name;
    string4     clean_addr_suffix;
    string2     clean_postdir;
    string10    clean_unit_desig;
    string8     clean_sec_range;
    string25    clean_p_city_name;
    string25    clean_v_city_name;
    string2     clean_st;
    string5     clean_zip;
    string4     clean_zip4;
    string4     clean_cart;
    string1     clean_cr_sort_sz;
    string4     clean_lot;
    string1     clean_lot_order;
    string2     clean_dpbc;
    string1     clean_chk_digit;
    string2     clean_record_type;
    string2     clean_ace_fips_st;
    string3     clean_fipscounty;
    string10    clean_geo_lat;
    string11    clean_geo_long;
    string4     clean_msa;
    string7     clean_geo_blk;
    string1     clean_geo_match;
    string4     clean_err_stat;
  end
 ;
 
File_ME_Old
 := dataset(Drivers.Cluster + 'in::drvlic_me_full',	Layout_ME_Full_Old,thor);
 
 
File_ME_New
 := dataset(Drivers.Cluster + 'in::drvlic_me_update',	drivers.Layout_ME_Full,thor);
 
File_ME_Cleaned_MedCert
 := dataset(Drivers.Cluster + 'in::dl2::me_medcert_clean_updates::superfile',	drivers.Layout_ME_Full,thor);
 
 Drivers.Layout_ME_Full tConvertOldToNew(File_ME_Old pInput)
 := 
  transform
	self.orig_Credential_Type    := '';
	self.orig_ID_Terminal_Date   := '';
	self.orig_Endorsements11_20  := '';
	self.orig_Comm_Driv_Status   := '';
	self.orig_Disabled_Vet_Type  := '';
	self.orig_Organ_Donor   	 := '';
	self.orig_CRLF               := ''; 
	self						 :=	pInput;
  end;
	

dOldAsNew := project(File_ME_Old, tConvertOldToNew(left)); 

export File_ME_Full 
  := dOldAsNew 
   + File_ME_New 
	 + File_ME_Cleaned_MedCert
 ;

