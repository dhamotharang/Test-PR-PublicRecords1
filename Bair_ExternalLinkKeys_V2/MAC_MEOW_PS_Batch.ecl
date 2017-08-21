 
EXPORT MAC_MEOW_PS_Batch(infile,Ref = '',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_P_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DOB = '',Input_PHONE = '',Input_DL_ST = '',Input_DL = '',Input_LEXID = '',Input_POSSIBLE_SSN = '',Input_CRIME = '',Input_NAME_TYPE = '',Input_CLEAN_GENDER = '',Input_CLASS_CODE = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DATA_PROVIDER_ORI = '',Input_VIN = '',Input_PLATE = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_SEARCH_ADDR1 = '',Input_SEARCH_ADDR2 = '',Input_CLEAN_COMPANY_NAME = '',Input_MAINNAME = '',Input_FULLNAME = '',OutFile,AsIndex='true',Stats='', In_disableForce = 'false') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT37,Bair_ExternalLinkKeys_V2;
  #uniquename(TPRec)
  %TPRec% := RECORD(Bair_ExternalLinkKeys_V2.Process_PS_Layouts.InputLayout)
  STRING56 LNAME_wb := ''; // Expanded wordbag field
  END;
  #uniquename(InputT)
   %TPRec% %InputT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
  #IF ( #TEXT(Input_NAME_SUFFIX) <> '' )
    SELF.NAME_SUFFIX := (TYPEOF(SELF.NAME_SUFFIX))le.Input_NAME_SUFFIX;
  #ELSE
    SELF.NAME_SUFFIX := (TYPEOF(SELF.NAME_SUFFIX))'';
  #END
  #IF ( #TEXT(Input_FNAME) <> '' )
    SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
  #ELSE
    SELF.FNAME := (TYPEOF(SELF.FNAME))'';
  #END
  #IF ( #TEXT(Input_MNAME) <> '' )
    SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
  #ELSE
    SELF.MNAME := (TYPEOF(SELF.MNAME))'';
  #END
  #IF ( #TEXT(Input_LNAME) <> '' )
    SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
  #ELSE
    SELF.LNAME := (TYPEOF(SELF.LNAME))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_P_CITY_NAME) <> '' )
    SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))le.Input_P_CITY_NAME;
  #ELSE
    SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
    SELF.ST := (TYPEOF(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
    SELF.ZIP := (TYPEOF(SELF.ZIP))'';
  #END
  #IF ( #TEXT(Input_DOB) <> '' )
    SELF.DOB := (TYPEOF(SELF.DOB))le.Input_DOB;
  #ELSE
    SELF.DOB := (TYPEOF(SELF.DOB))'';
  #END
  #IF ( #TEXT(Input_PHONE) <> '' )
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.Input_PHONE;
  #ELSE
    SELF.PHONE := (TYPEOF(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_DL_ST) <> '' )
    SELF.DL_ST := (TYPEOF(SELF.DL_ST))le.Input_DL_ST;
  #ELSE
    SELF.DL_ST := (TYPEOF(SELF.DL_ST))'';
  #END
  #IF ( #TEXT(Input_DL) <> '' )
    SELF.DL := (TYPEOF(SELF.DL))le.Input_DL;
  #ELSE
    SELF.DL := (TYPEOF(SELF.DL))'';
  #END
  #IF ( #TEXT(Input_LEXID) <> '' )
    SELF.LEXID := (TYPEOF(SELF.LEXID))le.Input_LEXID;
  #ELSE
    SELF.LEXID := (TYPEOF(SELF.LEXID))'';
  #END
  #IF ( #TEXT(Input_POSSIBLE_SSN) <> '' )
    SELF.POSSIBLE_SSN := (TYPEOF(SELF.POSSIBLE_SSN))le.Input_POSSIBLE_SSN;
  #ELSE
    SELF.POSSIBLE_SSN := (TYPEOF(SELF.POSSIBLE_SSN))'';
  #END
  #IF ( #TEXT(Input_CRIME) <> '' )
    SELF.CRIME := (TYPEOF(SELF.CRIME))le.Input_CRIME;
  #ELSE
    SELF.CRIME := (TYPEOF(SELF.CRIME))'';
  #END
  #IF ( #TEXT(Input_NAME_TYPE) <> '' )
    SELF.NAME_TYPE := (TYPEOF(SELF.NAME_TYPE))le.Input_NAME_TYPE;
  #ELSE
    SELF.NAME_TYPE := (TYPEOF(SELF.NAME_TYPE))'';
  #END
  #IF ( #TEXT(Input_CLEAN_GENDER) <> '' )
    SELF.CLEAN_GENDER := (TYPEOF(SELF.CLEAN_GENDER))le.Input_CLEAN_GENDER;
  #ELSE
    SELF.CLEAN_GENDER := (TYPEOF(SELF.CLEAN_GENDER))'';
  #END
  #IF ( #TEXT(Input_CLASS_CODE) <> '' )
    SELF.CLASS_CODE := (TYPEOF(SELF.CLASS_CODE))le.Input_CLASS_CODE;
  #ELSE
    SELF.CLASS_CODE := (TYPEOF(SELF.CLASS_CODE))'';
  #END
  #IF ( #TEXT(Input_DT_FIRST_SEEN) <> '' )
    SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))le.Input_DT_FIRST_SEEN;
  #ELSE
    SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))'';
  #END
  #IF ( #TEXT(Input_DT_LAST_SEEN) <> '' )
    SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))le.Input_DT_LAST_SEEN;
  #ELSE
    SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))'';
  #END
  #IF ( #TEXT(Input_DATA_PROVIDER_ORI) <> '' )
    SELF.DATA_PROVIDER_ORI := (TYPEOF(SELF.DATA_PROVIDER_ORI))le.Input_DATA_PROVIDER_ORI;
  #ELSE
    SELF.DATA_PROVIDER_ORI := (TYPEOF(SELF.DATA_PROVIDER_ORI))'';
  #END
  #IF ( #TEXT(Input_VIN) <> '' )
    SELF.VIN := (TYPEOF(SELF.VIN))le.Input_VIN;
  #ELSE
    SELF.VIN := (TYPEOF(SELF.VIN))'';
  #END
  #IF ( #TEXT(Input_PLATE) <> '' )
    SELF.PLATE := (TYPEOF(SELF.PLATE))le.Input_PLATE;
  #ELSE
    SELF.PLATE := (TYPEOF(SELF.PLATE))'';
  #END
  #IF ( #TEXT(Input_LATITUDE) <> '' )
    SELF.LATITUDE := (TYPEOF(SELF.LATITUDE))le.Input_LATITUDE;
  #ELSE
    SELF.LATITUDE := (TYPEOF(SELF.LATITUDE))'';
  #END
  #IF ( #TEXT(Input_LONGITUDE) <> '' )
    SELF.LONGITUDE := (TYPEOF(SELF.LONGITUDE))le.Input_LONGITUDE;
  #ELSE
    SELF.LONGITUDE := (TYPEOF(SELF.LONGITUDE))'';
  #END
  #IF ( #TEXT(Input_SEARCH_ADDR1) <> '' )
    SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))le.Input_SEARCH_ADDR1;
  #ELSE
    SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))'';
  #END
  #IF ( #TEXT(Input_SEARCH_ADDR2) <> '' )
    SELF.SEARCH_ADDR2 := (TYPEOF(SELF.SEARCH_ADDR2))le.Input_SEARCH_ADDR2;
  #ELSE
    SELF.SEARCH_ADDR2 := (TYPEOF(SELF.SEARCH_ADDR2))'';
  #END
  #IF ( #TEXT(Input_CLEAN_COMPANY_NAME) <> '' )
    SELF.CLEAN_COMPANY_NAME := (TYPEOF(SELF.CLEAN_COMPANY_NAME))le.Input_CLEAN_COMPANY_NAME;
  #ELSE
    SELF.CLEAN_COMPANY_NAME := (TYPEOF(SELF.CLEAN_COMPANY_NAME))'';
  #END
  #IF ( #TEXT(Input_MAINNAME) <> '' )
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))le.Input_MAINNAME;
  #ELSE
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))'';
  #END
  #IF ( #TEXT(Input_FULLNAME) <> '' )
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))le.Input_FULLNAME;
  #ELSE
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%InputT%(LEFT));
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(%fats0% le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.NAME_SUFFIX := (TYPEOF(SELF.NAME_SUFFIX))Bair_ExternalLinkKeys_V2.Fields.Make_NAME_SUFFIX((SALT37.StrType)le.NAME_SUFFIX);
    SELF.FNAME := (TYPEOF(SELF.FNAME))Bair_ExternalLinkKeys_V2.Fields.Make_FNAME((SALT37.StrType)le.FNAME);
    SELF.MNAME := (TYPEOF(SELF.MNAME))Bair_ExternalLinkKeys_V2.Fields.Make_MNAME((SALT37.StrType)le.MNAME);
    SELF.LNAME := (TYPEOF(SELF.LNAME))Bair_ExternalLinkKeys_V2.Fields.Make_LNAME((SALT37.StrType)le.LNAME);
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))Bair_ExternalLinkKeys_V2.Fields.Make_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE);
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))Bair_ExternalLinkKeys_V2.Fields.Make_PRIM_NAME((SALT37.StrType)le.PRIM_NAME);
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))Bair_ExternalLinkKeys_V2.Fields.Make_SEC_RANGE((SALT37.StrType)le.SEC_RANGE);
    SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))Bair_ExternalLinkKeys_V2.Fields.Make_P_CITY_NAME((SALT37.StrType)le.P_CITY_NAME);
    SELF.ST := (TYPEOF(SELF.ST))Bair_ExternalLinkKeys_V2.Fields.Make_ST((SALT37.StrType)le.ST);
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.ZIP;
    SELF.DOB := (TYPEOF(SELF.DOB))Bair_ExternalLinkKeys_V2.Fields.Make_DOB((SALT37.StrType)le.DOB);
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.PHONE;
    SELF.DL_ST := (TYPEOF(SELF.DL_ST))Bair_ExternalLinkKeys_V2.Fields.Make_DL_ST((SALT37.StrType)le.DL_ST);
    SELF.DL := (TYPEOF(SELF.DL))Bair_ExternalLinkKeys_V2.Fields.Make_DL((SALT37.StrType)le.DL);
    SELF.LEXID := (TYPEOF(SELF.LEXID))Bair_ExternalLinkKeys_V2.Fields.Make_LEXID((SALT37.StrType)le.LEXID);
    SELF.POSSIBLE_SSN := (TYPEOF(SELF.POSSIBLE_SSN))Bair_ExternalLinkKeys_V2.Fields.Make_POSSIBLE_SSN((SALT37.StrType)le.POSSIBLE_SSN);
    SELF.CRIME := (TYPEOF(SELF.CRIME))Bair_ExternalLinkKeys_V2.Fields.Make_CRIME((SALT37.StrType)le.CRIME);
    SELF.NAME_TYPE := (TYPEOF(SELF.NAME_TYPE))Bair_ExternalLinkKeys_V2.Fields.Make_NAME_TYPE((SALT37.StrType)le.NAME_TYPE);
    SELF.CLEAN_GENDER := (TYPEOF(SELF.CLEAN_GENDER))Bair_ExternalLinkKeys_V2.Fields.Make_CLEAN_GENDER((SALT37.StrType)le.CLEAN_GENDER);
    SELF.CLASS_CODE := (TYPEOF(SELF.CLASS_CODE))Bair_ExternalLinkKeys_V2.Fields.Make_CLASS_CODE((SALT37.StrType)le.CLASS_CODE);
    SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))Bair_ExternalLinkKeys_V2.Fields.Make_DT_FIRST_SEEN((SALT37.StrType)le.DT_FIRST_SEEN);
    SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))Bair_ExternalLinkKeys_V2.Fields.Make_DT_LAST_SEEN((SALT37.StrType)le.DT_LAST_SEEN);
    SELF.DATA_PROVIDER_ORI := (TYPEOF(SELF.DATA_PROVIDER_ORI))Bair_ExternalLinkKeys_V2.Fields.Make_DATA_PROVIDER_ORI((SALT37.StrType)le.DATA_PROVIDER_ORI);
    SELF.VIN := (TYPEOF(SELF.VIN))Bair_ExternalLinkKeys_V2.Fields.Make_VIN((SALT37.StrType)le.VIN);
    SELF.PLATE := (TYPEOF(SELF.PLATE))Bair_ExternalLinkKeys_V2.Fields.Make_PLATE((SALT37.StrType)le.PLATE);
    SELF.LATITUDE := (TYPEOF(SELF.LATITUDE))Bair_ExternalLinkKeys_V2.Fields.Make_LATITUDE((SALT37.StrType)le.LATITUDE);
    SELF.LONGITUDE := (TYPEOF(SELF.LONGITUDE))Bair_ExternalLinkKeys_V2.Fields.Make_LONGITUDE((SALT37.StrType)le.LONGITUDE);
    SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))Bair_ExternalLinkKeys_V2.Fields.Make_SEARCH_ADDR1((SALT37.StrType)le.SEARCH_ADDR1);
    SELF.SEARCH_ADDR2 := (TYPEOF(SELF.SEARCH_ADDR2))Bair_ExternalLinkKeys_V2.Fields.Make_SEARCH_ADDR2((SALT37.StrType)le.SEARCH_ADDR2);
    SELF.CLEAN_COMPANY_NAME := (TYPEOF(SELF.CLEAN_COMPANY_NAME))Bair_ExternalLinkKeys_V2.Fields.Make_CLEAN_COMPANY_NAME((SALT37.StrType)le.CLEAN_COMPANY_NAME);
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))Bair_ExternalLinkKeys_V2.Fields.Make_MAINNAME((SALT37.StrType)le.MAINNAME);
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))Bair_ExternalLinkKeys_V2.Fields.Make_FULLNAME((SALT37.StrType)le.FULLNAME);
  END;
  #uniquename(fats1)
  %fats1% := PROJECT(%fats0%,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT37.MAC_Dups_Note(%fats1%,%TPRec%,%fats%,%dups%,,Bair_ExternalLinkKeys_V2.Config.meow_dedup);
  #uniquename(key_LNAME)
  %key_LNAME% := Bair_ExternalLinkKeys_V2.specificities(Bair_ExternalLinkKeys_V2.file_Classify_PS).LNAME_values_key;
  #uniquename(A_LNAME)
  %A_LNAME% := SALT37.mac_wordbag_appendspecs_th(%fats%,LNAME,LNAME_wb,%key_LNAME%,LNAME,AsIndex);
  %ToProcess% := %A_LNAME%(Entered_EID_HASH = 0);
  #uniquename(OutputNAME)
#IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldNAME)
  %HoldNAME% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_NAME.MAC_ScoredFetch_Batch(%HoldNAME%,UniqueId,FNAME,LNAME_wb,ST,NAME_SUFFIX,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,P_CITY_NAME,DOB,SEARCH_ADDR1,SEARCH_ADDR2,LEXID,%OutputNAME%,AsIndex,In_disableForce)
#ELSE
  %OutputNAME% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputADDRESS)
#IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldADDRESS)
  %HoldADDRESS% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_ADDRESS.MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP,SEC_RANGE,FNAME,MNAME,LNAME_wb,P_CITY_NAME,ST,NAME_SUFFIX,DOB,%OutputADDRESS%,AsIndex,In_disableForce)
#ELSE
  %OutputADDRESS% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDOB)
#IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(HoldDOB)
  %HoldDOB% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_DOB.MAC_ScoredFetch_Batch(%HoldDOB%,UniqueId,DOB,LNAME_wb,FNAME,MNAME,ST,P_CITY_NAME,NAME_SUFFIX,%OutputDOB%,AsIndex,In_disableForce)
#ELSE
  %OutputDOB% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputZIP_PR)
#IF(#TEXT(Input_ZIP)<>'' AND #TEXT(Input_PRIM_RANGE)<>'')
  #uniquename(HoldZIP_PR)
  %HoldZIP_PR% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_ZIP_PR.MAC_ScoredFetch_Batch(%HoldZIP_PR%,UniqueId,ZIP,PRIM_RANGE,FNAME,LNAME_wb,PRIM_NAME,SEC_RANGE,P_CITY_NAME,ST,NAME_SUFFIX,DOB,%OutputZIP_PR%,AsIndex,In_disableForce)
#ELSE
  %OutputZIP_PR% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDLN)
#IF(#TEXT(Input_DL)<>'' AND #TEXT(Input_DL_ST)<>'')
  #uniquename(HoldDLN)
  %HoldDLN% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_DLN.MAC_ScoredFetch_Batch(%HoldDLN%,UniqueId,DL,DL_ST,FNAME,MNAME,LNAME_wb,NAME_SUFFIX,DOB,%OutputDLN%,AsIndex,In_disableForce)
#ELSE
  %OutputDLN% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputPH)
#IF(#TEXT(Input_PHONE)<>'')
  #uniquename(HoldPH)
  %HoldPH% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_PH.MAC_ScoredFetch_Batch(%HoldPH%,UniqueId,PHONE,FNAME,MNAME,LNAME_wb,DOB,P_CITY_NAME,ST,%OutputPH%,AsIndex,In_disableForce)
#ELSE
  %OutputPH% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLFZ)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'')
  #uniquename(HoldLFZ)
  %HoldLFZ% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_LFZ.MAC_ScoredFetch_Batch(%HoldLFZ%,UniqueId,LNAME_wb,FNAME,ZIP,P_CITY_NAME,PRIM_RANGE,PRIM_NAME,MNAME,SEC_RANGE,NAME_SUFFIX,DOB,ST,%OutputLFZ%,AsIndex,In_disableForce)
#ELSE
  %OutputLFZ% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputVIN)
#IF(#TEXT(Input_VIN)<>'')
  #uniquename(HoldVIN)
  %HoldVIN% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_VIN.MAC_ScoredFetch_Batch(%HoldVIN%,UniqueId,VIN,LNAME_wb,P_CITY_NAME,ST,%OutputVIN%,AsIndex,In_disableForce)
#ELSE
  %OutputVIN% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLEXID)
#IF(#TEXT(Input_LEXID)<>'')
  #uniquename(HoldLEXID)
  %HoldLEXID% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_LEXID.MAC_ScoredFetch_Batch(%HoldLEXID%,UniqueId,LEXID,FNAME,MNAME,LNAME_wb,NAME_SUFFIX,DOB,DL,DL_ST,%OutputLEXID%,AsIndex,In_disableForce)
#ELSE
  %OutputLEXID% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputSSN)
#IF(#TEXT(Input_POSSIBLE_SSN)<>'')
  #uniquename(HoldSSN)
  %HoldSSN% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_SSN.MAC_ScoredFetch_Batch(%HoldSSN%,UniqueId,POSSIBLE_SSN,FNAME,MNAME,LNAME_wb,SEARCH_ADDR1,P_CITY_NAME,ST,DOB,%OutputSSN%,AsIndex,In_disableForce)
#ELSE
  %OutputSSN% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLATLONG)
#IF(#TEXT(Input_LATITUDE)<>'' AND #TEXT(Input_LONGITUDE)<>'')
  #uniquename(HoldLATLONG)
  %HoldLATLONG% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_LATLONG.MAC_ScoredFetch_Batch(%HoldLATLONG%,UniqueId,LATITUDE,LONGITUDE,FNAME,MNAME,LNAME_wb,POSSIBLE_SSN,%OutputLATLONG%,AsIndex,In_disableForce)
#ELSE
  %OutputLATLONG% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputPLATE)
#IF(#TEXT(Input_PLATE)<>'')
  #uniquename(HoldPLATE)
  %HoldPLATE% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_PLATE.MAC_ScoredFetch_Batch(%HoldPLATE%,UniqueId,PLATE,FNAME,MNAME,LNAME_wb,P_CITY_NAME,ST,%OutputPLATE%,AsIndex,In_disableForce)
#ELSE
  %OutputPLATE% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputCOMPANY)
#IF(#TEXT(Input_CLEAN_COMPANY_NAME)<>'')
  #uniquename(HoldCOMPANY)
  %HoldCOMPANY% := %ToProcess%;
  Bair_ExternalLinkKeys_V2.Key_Classify_PS_COMPANY.MAC_ScoredFetch_Batch(%HoldCOMPANY%,UniqueId,CLEAN_COMPANY_NAME,SEARCH_ADDR1,P_CITY_NAME,ST,SEARCH_ADDR2,LEXID,%OutputCOMPANY%,AsIndex,In_disableForce)
#ELSE
  %OutputCOMPANY% := DATASET([],Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputNAME%+%OutputADDRESS%+%OutputDOB%+%OutputZIP_PR%+%OutputDLN%+%OutputPH%+%OutputLFZ%+%OutputVIN%+%OutputLEXID%+%OutputSSN%+%OutputLATLONG%+%OutputPLATE%+%OutputCOMPANY%;
  #uniquename(All)
  %All% := Bair_ExternalLinkKeys_V2.Process_PS_Layouts.CombineAllScores(%AllRes%, In_disableForce);
  #uniquename(OutFile0)
  SALT37.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #uniquename(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(Bair_ExternalLinkKeys_V2.Process_PS_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := Bair_ExternalLinkKeys_V2.Process_PS_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
