 
EXPORT MAC_MEOW_xIDL_Batch(infile,Ref = '',Input_DID = '',Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_DERIVED_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = ''/*MMXBHACK01*/,Input_fname2 = '',Input_lname2 = '',Input_VIN = '',OutFile,AsIndex = 'true',In_UpdateIDs = 'false',Stats = '',In_disableForce = 'InsuranceHeader_xLink.Config.DOB_NotUseForce' /*HACK18*/,DoClean = 'true') := MACRO
  #UNIQUENAME(ToProcess)
  IMPORT SALT311,InsuranceHeader_xLink;
  #UNIQUENAME(TPRec)
  %TPRec% := RECORD(InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout)
  END;
  #UNIQUENAME(InputT)
  %TPRec% %InputT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
  #IF ( #TEXT(Input_DID) <> '' AND In_UpdateIDs=true)
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
    SELF.ZIP_cases := DATASET([],InsuranceHeader_xLink.Process_xIDL_Layouts().layout_ZIP_cases);
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
  #IF ( #TEXT(Input_VIN) <> '' )
    SELF.VIN := (TYPEOF(SELF.VIN))le.Input_VIN;
  #ELSE
    SELF.VIN := (TYPEOF(SELF.VIN))'';
  #END
  END;
  #UNIQUENAME(fats0)
  %fats0% := PROJECT(InFile,%InputT%(LEFT));
  InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch_InLayout(%fats0%,OutFile,AsIndex,In_UpdateIDs,Stats,In_disableForce,DoClean);
ENDMACRO;
