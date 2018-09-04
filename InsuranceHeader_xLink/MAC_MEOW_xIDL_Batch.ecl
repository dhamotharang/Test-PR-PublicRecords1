 
EXPORT MAC_MEOW_xIDL_Batch(infile,Ref = '',Input_DID = '',Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_DERIVED_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = '',/*MMXBHACK01*/Input_fname2 = '',Input_lname2 = '',OutFile,AsIndex='true',/*MMXBHACK03*/ input_UpdateIDs='false',Stats='', In_disableForce = 'InsuranceHeader_xLink.Config.DOB_NotUseForce' /*HACK18*/) := MACRO
  #uniquename(ToProcess)
  IMPORT SALT37,InsuranceHeader_xLink;
  #uniquename(TPRec)
  %TPRec% := RECORD(InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout)
  END;
  #uniquename(InputT)
   %TPRec% %InputT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
  #IF ( #TEXT(Input_DID) <> '' AND /*MMXBHACK03*/ input_UpdateIDs=true)
    SELF.Entered_DID := (TYPEOF(SELF.Entered_DID))le.Input_DID;
  #ELSE
    SELF.Entered_DID := (TYPEOF(SELF.Entered_DID))'';
  #END
  #IF ( #TEXT(Input_SNAME) <> '' )
    SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
  #ELSE
    SELF.SNAME := (TYPEOF(SELF.SNAME))'';
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
  #IF ( #TEXT(Input_DERIVED_GENDER) <> '' )
    SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
  #ELSE
    SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))'';
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
  #IF ( #TEXT(Input_CITY) <> '' )
    SELF.CITY := (TYPEOF(SELF.CITY))le.Input_CITY;
  #ELSE
    SELF.CITY := (TYPEOF(SELF.CITY))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
    SELF.ST := (TYPEOF(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP_cases := le.Input_ZIP;
  #ELSE
    SELF.ZIP_cases := DATASET([],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases);
  #END
  #IF ( #TEXT(Input_SSN5) <> '' )
    SELF.SSN5 := (TYPEOF(SELF.SSN5))le.Input_SSN5;
  #ELSE
    SELF.SSN5 := (TYPEOF(SELF.SSN5))'';
  #END
  #IF ( #TEXT(Input_SSN4) <> '' )
    SELF.SSN4 := (TYPEOF(SELF.SSN4))le.Input_SSN4;
  #ELSE
    SELF.SSN4 := (TYPEOF(SELF.SSN4))'';
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
  #IF ( #TEXT(Input_DL_STATE) <> '' and #TEXT(Input_DL_NBR) <> '' ) /*MMXBHACK05*/
    SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))le.Input_DL_STATE;
  #ELSE
    SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))'';
  #END
  #IF ( #TEXT(Input_DL_NBR) <> '' )
    SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))le.Input_DL_NBR;
  #ELSE
    SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))'';
  #END
  #IF ( #TEXT(Input_SRC) <> '' )
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
  #ELSE
    SELF.SRC := (TYPEOF(SELF.SRC))'';
  #END
  #IF ( #TEXT(Input_SOURCE_RID) <> '' )
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))le.Input_SOURCE_RID;
  #ELSE
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))'';
  #END
  SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))''; /*MMXBHACK04a*/
  SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))''; /*MMXBHACK04b*/
  SELF.DT_EFFECTIVE_FIRST := (TYPEOF(SELF.DT_EFFECTIVE_FIRST))''; /*MMXBHACK04c*/
  SELF.DT_EFFECTIVE_LAST := (TYPEOF(SELF.DT_EFFECTIVE_LAST))''; /*MMXBHACK04d*/
  SELF.MAINNAME :=   '';/*MMXBHACK02a*/
  SELF.FULLNAME :=   '';/*MMXBHACK02b*/
  SELF.ADDR1 :=   '';/*MMXBHACK02c*/
  SELF.LOCALE :=   '';/*MMXBHACK02d*/  
  SELF.ADDRESS :=   '';/*MMXBHACK02e*/
  #IF ( #TEXT(Input_fname2) <> '' )
    SELF.fname2 := (TYPEOF(SELF.fname2))le.Input_fname2;
  #ELSE
    SELF.fname2 := (TYPEOF(SELF.fname2))'';
  #END
  #IF ( #TEXT(Input_lname2) <> '' )
    SELF.lname2 := (TYPEOF(SELF.lname2))le.Input_lname2;
  #ELSE
    SELF.lname2 := (TYPEOF(SELF.lname2))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%InputT%(LEFT));
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(%fats0% le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.SNAME := (TYPEOF(SELF.SNAME))InsuranceHeader_xLink.Fields.Make_SNAME((SALT37.StrType)le.SNAME);
    SELF.FNAME := (TYPEOF(SELF.FNAME))InsuranceHeader_xLink.Fields.Make_FNAME((SALT37.StrType)le.FNAME);
    SELF.MNAME := (TYPEOF(SELF.MNAME))InsuranceHeader_xLink.Fields.Make_MNAME((SALT37.StrType)le.MNAME);
    SELF.LNAME := (TYPEOF(SELF.LNAME))InsuranceHeader_xLink.Fields.Make_LNAME((SALT37.StrType)le.LNAME);
    SELF.DERIVED_GENDER := (TYPEOF(SELF.DERIVED_GENDER))InsuranceHeader_xLink.Fields.Make_DERIVED_GENDER((SALT37.StrType)le.DERIVED_GENDER);
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))InsuranceHeader_xLink.Fields.Make_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE);
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))InsuranceHeader_xLink.Fields.Make_PRIM_NAME((SALT37.StrType)le.PRIM_NAME);
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))InsuranceHeader_xLink.Fields.Make_SEC_RANGE((SALT37.StrType)le.SEC_RANGE);
    SELF.CITY := (TYPEOF(SELF.CITY))InsuranceHeader_xLink.Fields.Make_CITY((SALT37.StrType)le.CITY);
    SELF.ST := (TYPEOF(SELF.ST))InsuranceHeader_xLink.Fields.Make_ST((SALT37.StrType)le.ST);
    SELF.ZIP_cases := le.ZIP_cases;
    SELF.SSN5 := (TYPEOF(SELF.SSN5))InsuranceHeader_xLink.Fields.Make_SSN5((SALT37.StrType)le.SSN5);
    SELF.SSN4 := (TYPEOF(SELF.SSN4))InsuranceHeader_xLink.Fields.Make_SSN4((SALT37.StrType)le.SSN4);
    SELF.DOB := (TYPEOF(SELF.DOB))InsuranceHeader_xLink.Fields.Make_DOB((SALT37.StrType)le.DOB);
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.PHONE;
    SELF.DL_STATE := (TYPEOF(SELF.DL_STATE))InsuranceHeader_xLink.Fields.Make_DL_STATE((SALT37.StrType)le.DL_STATE);
    SELF.DL_NBR := (TYPEOF(SELF.DL_NBR))InsuranceHeader_xLink.Fields.Make_DL_NBR((SALT37.StrType)le.DL_NBR);
    SELF.SRC := (TYPEOF(SELF.SRC))InsuranceHeader_xLink.Fields.Make_SRC((SALT37.StrType)le.SRC);
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))InsuranceHeader_xLink.Fields.Make_SOURCE_RID((SALT37.StrType)le.SOURCE_RID);
    SELF.DT_FIRST_SEEN := (TYPEOF(SELF.DT_FIRST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_FIRST_SEEN((SALT37.StrType)le.DT_FIRST_SEEN);
    SELF.DT_LAST_SEEN := (TYPEOF(SELF.DT_LAST_SEEN))InsuranceHeader_xLink.Fields.Make_DT_LAST_SEEN((SALT37.StrType)le.DT_LAST_SEEN);
    SELF.DT_EFFECTIVE_FIRST := (TYPEOF(SELF.DT_EFFECTIVE_FIRST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_FIRST((SALT37.StrType)le.DT_EFFECTIVE_FIRST);
    SELF.DT_EFFECTIVE_LAST := (TYPEOF(SELF.DT_EFFECTIVE_LAST))InsuranceHeader_xLink.Fields.Make_DT_EFFECTIVE_LAST((SALT37.StrType)le.DT_EFFECTIVE_LAST);
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))InsuranceHeader_xLink.Fields.Make_MAINNAME((SALT37.StrType)le.MAINNAME);
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))InsuranceHeader_xLink.Fields.Make_FULLNAME((SALT37.StrType)le.FULLNAME);
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))InsuranceHeader_xLink.Fields.Make_ADDR1((SALT37.StrType)le.ADDR1);
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))InsuranceHeader_xLink.Fields.Make_LOCALE((SALT37.StrType)le.LOCALE);
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))InsuranceHeader_xLink.Fields.Make_ADDRESS((SALT37.StrType)le.ADDRESS);
    SELF.fname2 := (TYPEOF(SELF.fname2))le.fname2;
    SELF.lname2 := (TYPEOF(SELF.lname2))le.lname2;
    SELF := le;
  END;
  #uniquename(fats1)
  %fats1% := PROJECT(%fats0%,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT37.MAC_Dups_Note(%fats1%,%TPRec%,%fats%,%dups%,,InsuranceHeader_xLink.Config.meow_dedup);
  %ToProcess% := %fats%(Entered_DID = 0);
  #uniquename(OutputNewIDs)
#IF (#TEXT(Input_DID) <> '')
  #uniquename(ToUpdate)
  %ToUpdate% := %fats%(~(Entered_DID = 0));
  %OutputNewIDs% := InsuranceHeader_xLink.Process_xIDL_Layouts().UpdateIDs(%ToUpdate%);
#ELSE
  %OutputNewIDs% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputNAME)
#IF(#TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'' AND #TEXT(Input_ST)<>'')
  #uniquename(HoldNAME)
  %HoldNAME% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_NAME().MAC_ScoredFetch_Batch(%HoldNAME%,UniqueId,FNAME,LNAME,ST,DERIVED_GENDER,SNAME,MNAME,SSN5,SSN4,PRIM_RANGE,PRIM_NAME,SEC_RANGE,CITY,DOB,%OutputNAME%,AsIndex,In_disableForce)
#ELSE
  %OutputNAME% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputADDRESS)
#IF(#TEXT(Input_PRIM_RANGE)<>'' AND #TEXT(Input_PRIM_NAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldADDRESS)
  %HoldADDRESS% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_ADDRESS().MAC_ScoredFetch_Batch(%HoldADDRESS%,UniqueId,PRIM_RANGE,PRIM_NAME,ZIP_cases,SEC_RANGE,FNAME,MNAME,LNAME,CITY,ST,DERIVED_GENDER,SNAME,DOB,%OutputADDRESS%,AsIndex,In_disableForce)
#ELSE
  %OutputADDRESS% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputSSN)
#IF(#TEXT(Input_SSN5)<>'' AND #TEXT(Input_SSN4)<>'')
  #uniquename(HoldSSN)
  %HoldSSN% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_SSN().MAC_ScoredFetch_Batch(%HoldSSN%,UniqueId,SSN5,SSN4,FNAME,MNAME,LNAME,CITY,ST,DERIVED_GENDER,SNAME,DOB,%OutputSSN%,AsIndex,In_disableForce)
#ELSE
  %OutputSSN% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputSSN4)
#IF(#TEXT(Input_SSN4)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(HoldSSN4)
  %HoldSSN4% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_SSN4().MAC_ScoredFetch_Batch(%HoldSSN4%,UniqueId,SSN4,FNAME,LNAME,DOB,SSN5,DERIVED_GENDER,SNAME,%OutputSSN4%,AsIndex,In_disableForce)
#ELSE
  %OutputSSN4% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputDOB)
#IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_LNAME)<>'')
  #uniquename(HoldDOB)
  %HoldDOB% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_DOB().MAC_ScoredFetch_Batch(%HoldDOB%,UniqueId,DOB,LNAME,FNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,%OutputDOB%,AsIndex,In_disableForce)
#ELSE
  %OutputDOB% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputDOBF)
#IF(#TEXT(Input_DOB)<>'' AND #TEXT(Input_FNAME)<>'')
  #uniquename(HoldDOBF)
  %HoldDOBF% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_DOBF().MAC_ScoredFetch_Batch(%HoldDOBF%,UniqueId,DOB,FNAME,LNAME,MNAME,ST,CITY,SSN5,SSN4,DERIVED_GENDER,DL_NBR,DL_STATE,SNAME,%OutputDOBF%,AsIndex,In_disableForce)
#ELSE
  %OutputDOBF% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputZIP_PR)
#IF(#TEXT(Input_ZIP)<>'' AND #TEXT(Input_PRIM_RANGE)<>'')
  #uniquename(HoldZIP_PR)
  %HoldZIP_PR% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_ZIP_PR().MAC_ScoredFetch_Batch(%HoldZIP_PR%,UniqueId,ZIP_cases,PRIM_RANGE,FNAME,LNAME,PRIM_NAME,SEC_RANGE,CITY,ST,DERIVED_GENDER,SNAME,DOB,%OutputZIP_PR%,AsIndex,In_disableForce)
#ELSE
  %OutputZIP_PR% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputSRC_RID)
#IF(#TEXT(Input_SRC)<>'' AND #TEXT(Input_SOURCE_RID)<>'')
  #uniquename(HoldSRC_RID)
  %HoldSRC_RID% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_SRC_RID().MAC_ScoredFetch_Batch(%HoldSRC_RID%,UniqueId,SRC,SOURCE_RID,FNAME,DOB,CITY,DERIVED_GENDER,SNAME,ST,%OutputSRC_RID%,AsIndex,In_disableForce)
#ELSE
  %OutputSRC_RID% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputDLN)
#IF(#TEXT(Input_DL_NBR)<>'' AND #TEXT(Input_DL_STATE)<>'')
  #uniquename(HoldDLN)
  %HoldDLN% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_DLN().MAC_ScoredFetch_Batch(%HoldDLN%,UniqueId,DL_NBR,DL_STATE,FNAME,MNAME,LNAME,SSN5,SSN4,DERIVED_GENDER,SNAME,DOB,%OutputDLN%,AsIndex,In_disableForce)
#ELSE
  %OutputDLN% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputPH)
#IF(#TEXT(Input_PHONE)<>'')
  #uniquename(HoldPH)
  %HoldPH% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_PH().MAC_ScoredFetch_Batch(%HoldPH%,UniqueId,PHONE,FNAME,MNAME,LNAME,DOB,CITY,ST,SSN5,SSN4,%OutputPH%,AsIndex,In_disableForce)
#ELSE
  %OutputPH% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputLFZ)
#IF(#TEXT(Input_LNAME)<>'' AND #TEXT(Input_FNAME)<>'' AND #TEXT(Input_ZIP)<>'')
  #uniquename(HoldLFZ)
  %HoldLFZ% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_LFZ().MAC_ScoredFetch_Batch(%HoldLFZ%,UniqueId,LNAME,FNAME,ZIP_cases,CITY,PRIM_RANGE,PRIM_NAME,SSN5,SSN4,MNAME,SEC_RANGE,SNAME,DOB,ST,%OutputLFZ%,AsIndex,In_disableForce)
#ELSE
  %OutputLFZ% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(OutputRELATIVE)
#IF(#TEXT(Input_fname2)<>'' AND #TEXT(Input_lname2)<>'')
  #uniquename(HoldRELATIVE)
  %HoldRELATIVE% := %ToProcess%;
  InsuranceHeader_xLink.Key_InsuranceHeader_RELATIVE().MAC_ScoredFetch_Batch(%HoldRELATIVE%,UniqueId,fname2,lname2,FNAME,LNAME,%OutputRELATIVE%,AsIndex,In_disableForce)
#ELSE
  %OutputRELATIVE% := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch);
#END
  #uniquename(AllRes)
  %AllRes% := %OutputNAME%+%OutputADDRESS%+%OutputSSN%+%OutputSSN4%+%OutputDOB%+%OutputDOBF%+%OutputZIP_PR%+%OutputSRC_RID%+%OutputDLN%+%OutputPH%+%OutputLFZ%+%OutputRELATIVE%+%OutputNewIDs%;
  #uniquename(All)
  %All% := InsuranceHeader_xLink.Process_xIDL_Layouts().CombineAllScores(%AllRes%, In_disableForce);
  #uniquename(OutFile0)
  SALT37.MAC_Dups_Restore(%All%,%dups%,%OutFile0%);
  #uniquename(RestoreChildReference)
  TYPEOF(%OutFile0%) %RestoreChildReference%(%OutFile0% le) := TRANSFORM
    SELF.Results := PROJECT(le.Results, TRANSFORM(InsuranceHeader_xLink.Process_xIDL_Layouts().LayoutScoredFetch,SELF.Reference := le.Reference, SELF := LEFT));
    SELF := le;
  END;
  OutFile := PROJECT(%OutFile0%,%RestoreChildReference%(LEFT));
  #IF (#TEXT(Stats)<>'')
    Stats := InsuranceHeader_xLink.Process_xIDL_Layouts().ScoreSummary(OutFile);
  #END
ENDMACRO;
