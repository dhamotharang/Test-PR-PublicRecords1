 
EXPORT MAC_MEOW_PS_Batch(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_P_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DOB = '',Input_PHONE = '',Input_DL_ST = '',Input_DL = '',Input_LEXID = '',Input_POSSIBLE_SSN = '',Input_CRIME = '',Input_NAME_TYPE = '',Input_CLEAN_GENDER = '',Input_CLASS_CODE = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DATA_PROVIDER_ORI = '',Input_VIN = '',Input_PLATE = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_SEARCH_ADDR1 = '',Input_SEARCH_ADDR2 = '',Input_CLEAN_COMPANY_NAME = '',Input_MAINNAME = '',Input_FULLNAME = '',OutFile,AsIndex='true',Stats='') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT33,Bair_ExternalLinkKeys;
  #uniquename(TPRec)
  %TPRec% := RECORD(Bair_ExternalLinkKeys.Process_PS_Layouts.InputLayout)
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
    SELF.NAME_SUFFIX := (TYPEOF(SELF.NAME_SUFFIX))Bair_ExternalLinkKeys.Fields.Make_NAME_SUFFIX((SALT33.StrType)le.NAME_SUFFIX);
    SELF.FNAME := (TYPEOF(SELF.FNAME))Bair_ExternalLinkKeys.Fields.Make_FNAME((SALT33.StrType)le.FNAME);
    SELF.MNAME := (TYPEOF(SELF.MNAME))Bair_ExternalLinkKeys.Fields.Make_MNAME((SALT33.StrType)le.MNAME);
    SELF.LNAME := (TYPEOF(SELF.LNAME))Bair_ExternalLinkKeys.Fields.Make_LNAME((SALT33.StrType)le.LNAME);
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))Bair_ExternalLinkKeys.Fields.Make_PRIM_RANGE((SALT33.StrType)le.PRIM_RANGE);
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))Bair_ExternalLinkKeys.Fields.Make_PRIM_NAME((SALT33.StrType)le.PRIM_NAME);
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))Bair_ExternalLinkKeys.Fields.Make_SEC_RANGE((SALT33.StrType)le.SEC_RANGE);
    SELF.P_CITY_NAME := (TYPEOF(SELF.P_CITY_NAME))Bair_ExternalLinkKeys.Fields.Make_P_CITY_NAME((SALT33.StrType)le.P_CITY_NAME);
    SELF.ST := (TYPEOF(SELF.ST))Bair_ExternalLinkKeys.Fields.Make_ST((SALT33.StrType)le.ST);
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.ZIP;
    SELF.DOB := (TYPEOF(SELF.DOB))Bair_ExternalLinkKeys.Fields.Make_DOB((SALT33.StrType)le.DOB);
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.PHONE;
    SELF.DL_ST := (TYPEOF(SELF.DL_ST))Bair_ExternalLinkKeys.Fields.Make_DL_ST((SALT33.StrType)le.DL_ST);
    SELF.DL := (TYPEOF(SELF.DL))Bair_ExternalLinkKeys.Fields.Make_DL((SALT33.StrType)le.DL);
    SELF.LEXID := (TYPEOF(SELF.LEXID))Bair_ExternalLinkKeys.Fields.Make_LEXID((SALT33.StrType)le.LEXID);
    SELF.POSSIBLE_SSN := (TYPEOF(SELF.POSSIBLE_SSN))Bair_ExternalLinkKeys.Fields.Make_POSSIBLE_SSN((SALT33.StrType)le.POSSIBLE_SSN);
    SELF.CRIME := (TYPEOF(SELF.CRIME))Bair_ExternalLinkKeys.Fields.Make_CRIME((SALT33.StrType)le.CRIME);
    SELF.NAME_TYPE := (TYPEOF(SELF.NAME_TYPE))Bair_ExternalLinkKeys.Fields.Make_NAME_TYPE((SALT33.StrType)le.NAME_TYPE);
    SELF.CLEAN_GENDER := (TYPEOF(SELF.CLEAN_GENDER))Bair_ExternalLinkKeys.Fields.Make_CLEAN_GENDER((SALT33.StrType)le.CLEAN_GENDER);
    SELF.CLASS_CODE := (TYPEOF(SELF.CLASS_CODE))Bair_ExternalLinkKeys.Fields.Make_CLASS_CODE((SALT33.StrType)le.CLASS_CODE);
    SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))Bair_ExternalLinkKeys.Fields.Make_DT_FIRST_SEEN((SALT33.StrType)le.DT_FIRST_SEEN);
    SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))Bair_ExternalLinkKeys.Fields.Make_DT_LAST_SEEN((SALT33.StrType)le.DT_LAST_SEEN);
    SELF.DATA_PROVIDER_ORI := (TYPEOF(SELF.DATA_PROVIDER_ORI))Bair_ExternalLinkKeys.Fields.Make_DATA_PROVIDER_ORI((SALT33.StrType)le.DATA_PROVIDER_ORI);
    SELF.VIN := (TYPEOF(SELF.VIN))Bair_ExternalLinkKeys.Fields.Make_VIN((SALT33.StrType)le.VIN);
    SELF.PLATE := (TYPEOF(SELF.PLATE))Bair_ExternalLinkKeys.Fields.Make_PLATE((SALT33.StrType)le.PLATE);
    SELF.LATITUDE := (TYPEOF(SELF.LATITUDE))Bair_ExternalLinkKeys.Fields.Make_LATITUDE((SALT33.StrType)le.LATITUDE);
    SELF.LONGITUDE := (TYPEOF(SELF.LONGITUDE))Bair_ExternalLinkKeys.Fields.Make_LONGITUDE((SALT33.StrType)le.LONGITUDE);
    SELF.SEARCH_ADDR1 := (TYPEOF(SELF.SEARCH_ADDR1))Bair_ExternalLinkKeys.Fields.Make_SEARCH_ADDR1((SALT33.StrType)le.SEARCH_ADDR1);
    SELF.SEARCH_ADDR2 := (TYPEOF(SELF.SEARCH_ADDR2))Bair_ExternalLinkKeys.Fields.Make_SEARCH_ADDR2((SALT33.StrType)le.SEARCH_ADDR2);
    SELF.CLEAN_COMPANY_NAME := (TYPEOF(SELF.CLEAN_COMPANY_NAME))Bair_ExternalLinkKeys.Fields.Make_CLEAN_COMPANY_NAME((SALT33.StrType)le.CLEAN_COMPANY_NAME);
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))Bair_ExternalLinkKeys.Fields.Make_MAINNAME((SALT33.StrType)le.MAINNAME);
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))Bair_ExternalLinkKeys.Fields.Make_FULLNAME((SALT33.StrType)le.FULLNAME);
  END;
  #uniquename(fats1)
  %fats1% := PROJECT(%fats0%,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT33.MAC_Dups_Note(%fats1%,%TPRec%,%fats%,%dups%,,Bair_ExternalLinkKeys.Config.meow_dedup);
  %ToProcess% := %fats%;
  #uniquename(OutputNAME)
#IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldNAME)
  %HoldNAME% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_NAME.MAC_ScoredFetch_Batch(%HoldNAME%,UniqueId,FNAME,LNAME,ST,NAME_SUFFIX,MNAME,PRIM_RANGE,PRIM_NAME,SEC_RANGE,P_CITY_NAME,DOB,SEARCH_ADDR1,SEARCH_ADDR2,LEXID,%OutputNAME%,AsIndex)
#ELSE
  %OutputNAME% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputADDRESS)
#IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldADDRESS)
  %HoldADDRESS% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_ADDRESS.MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP,SEC_RANGE,FNAME,MNAME,LNAME,P_CITY_NAME,ST,NAME_SUFFIX,DOB,%OutputADDRESS%,AsIndex)
#ELSE
  %OutputADDRESS% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputADDRESS1)
#IF(#TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_P_CITY_NAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldADDRESS1)
  %HoldADDRESS1% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_ADDRESS1.MAC_ScoredFetch_Batch(%HoldADDRESS1%,UniqueId,PRIM_NAME,P_CITY_NAME,ST,PRIM_RANGE,LNAME,FNAME,SEC_RANGE,ZIP,DOB,%OutputADDRESS1%,AsIndex)
#ELSE
  %OutputADDRESS1% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDOB)
#IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(HoldDOB)
  %HoldDOB% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_DOB.MAC_ScoredFetch_Batch(%HoldDOB%,UniqueId,DOB,LNAME,FNAME,MNAME,ST,P_CITY_NAME,NAME_SUFFIX,%OutputDOB%,AsIndex)
#ELSE
  %OutputDOB% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputZIP_PR)
#IF(#TEXT(Input_ZIP)<>'' AND #TEXT(Input_PRIM_RANGE)<>'')
  #uniquename(HoldZIP_PR)
  %HoldZIP_PR% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_ZIP_PR.MAC_ScoredFetch_Batch(%HoldZIP_PR%,UniqueId,ZIP,PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,P_CITY_NAME,ST,NAME_SUFFIX,DOB,%OutputZIP_PR%,AsIndex)
#ELSE
  %OutputZIP_PR% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputDLN)
#IF(#TEXT(Input_DL)<>'' AND #TEXT(Input_DL_ST)<>'')
  #uniquename(HoldDLN)
  %HoldDLN% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_DLN.MAC_ScoredFetch_Batch(%HoldDLN%,UniqueId,DL,DL_ST,FNAME,MNAME,LNAME,NAME_SUFFIX,DOB,%OutputDLN%,AsIndex)
#ELSE
  %OutputDLN% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputPH)
#IF(#TEXT(Input_PHONE)<>'')
  #uniquename(HoldPH)
  %HoldPH% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_PH.MAC_ScoredFetch_Batch(%HoldPH%,UniqueId,PHONE,FNAME,MNAME,LNAME,DOB,P_CITY_NAME,ST,%OutputPH%,AsIndex)
#ELSE
  %OutputPH% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLFZ)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'')
  #uniquename(HoldLFZ)
  %HoldLFZ% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_LFZ.MAC_ScoredFetch_Batch(%HoldLFZ%,UniqueId,LNAME,FNAME,ZIP,P_CITY_NAME,PRIM_RANGE,PRIM_NAME,MNAME,SEC_RANGE,NAME_SUFFIX,DOB,%OutputLFZ%,AsIndex)
#ELSE
  %OutputLFZ% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputVIN)
#IF(#TEXT(Input_VIN)<>'')
  #uniquename(HoldVIN)
  %HoldVIN% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_VIN.MAC_ScoredFetch_Batch(%HoldVIN%,UniqueId,VIN,LNAME,P_CITY_NAME,%OutputVIN%,AsIndex)
#ELSE
  %OutputVIN% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLEXID)
#IF(#TEXT(Input_LEXID)<>'')
  #uniquename(HoldLEXID)
  %HoldLEXID% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_LEXID.MAC_ScoredFetch_Batch(%HoldLEXID%,UniqueId,LEXID,FNAME,MNAME,LNAME,NAME_SUFFIX,DOB,DL,%OutputLEXID%,AsIndex)
#ELSE
  %OutputLEXID% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputSSN)
#IF(#TEXT(Input_POSSIBLE_SSN)<>'')
  #uniquename(HoldSSN)
  %HoldSSN% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_SSN.MAC_ScoredFetch_Batch(%HoldSSN%,UniqueId,POSSIBLE_SSN,FNAME,MNAME,LNAME,SEARCH_ADDR1,P_CITY_NAME,ST,DOB,%OutputSSN%,AsIndex)
#ELSE
  %OutputSSN% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputLATLONG)
#IF(#TEXT(Input_LATITUDE)<>'' AND #TEXT(Input_LONGITUDE)<>'')
  #uniquename(HoldLATLONG)
  %HoldLATLONG% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_LATLONG.MAC_ScoredFetch_Batch(%HoldLATLONG%,UniqueId,LATITUDE,LONGITUDE,FNAME,MNAME,LNAME,POSSIBLE_SSN,%OutputLATLONG%,AsIndex)
#ELSE
  %OutputLATLONG% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputPLATE)
#IF(#TEXT(Input_PLATE)<>'')
  #uniquename(HoldPLATE)
  %HoldPLATE% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_PLATE.MAC_ScoredFetch_Batch(%HoldPLATE%,UniqueId,PLATE,FNAME,MNAME,LNAME,P_CITY_NAME,ST,%OutputPLATE%,AsIndex)
#ELSE
  %OutputPLATE% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(OutputCOMPANY)
#IF(#TEXT(Input_CLEAN_COMPANY_NAME)<>'')
  #uniquename(HoldCOMPANY)
  %HoldCOMPANY% := %ToProcess%;
  Bair_ExternalLinkKeys.Key_Classify_PS_COMPANY.MAC_ScoredFetch_Batch(%HoldCOMPANY%,UniqueId,CLEAN_COMPANY_NAME,SEARCH_ADDR1,P_CITY_NAME,ST,SEARCH_ADDR2,LEXID,%OutputCOMPANY%,AsIndex)
#ELSE
  %OutputCOMPANY% := DATASET([],Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputNAME%+%OutputADDRESS%+%OutputADDRESS1%+%OutputDOB%+%OutputZIP_PR%+%OutputDLN%+%OutputPH%+%OutputLFZ%+%OutputVIN%+%OutputLEXID%+%OutputSSN%+%OutputLATLONG%+%OutputPLATE%+%OutputCOMPANY%;
  #uniquename(All)
  %All% := Bair_ExternalLinkKeys.Process_PS_Layouts.CombineAllScores(%AllRes%);
  #uniquename(OutFile0)
  SALT33.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #uniquename(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(Bair_ExternalLinkKeys.Process_PS_Layouts.LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := Bair_ExternalLinkKeys.Process_PS_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
