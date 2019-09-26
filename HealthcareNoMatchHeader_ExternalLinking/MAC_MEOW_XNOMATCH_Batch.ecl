IMPORT  STD, HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest;
EXPORT MAC_MEOW_XNOMATCH_Batch(
    pSrc
    ,pVersion
    ,pInfile
    , infile,Ref = '',Input_nomatch_id = '',Input_SRC = '',Input_SSN = '',Input_DOB = '',Input_LEXID = '',Input_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_GENDER = '',Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_MAINNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_FULLNAME = '',OutFile,AsIndex = 'true',In_UpdateIDs = 'false',Stats = '',In_disableForce = 'false',DoClean = 'true') := MACRO
  #UNIQUENAME(ToProcess)
  IMPORT SALT311,HealthcareNoMatchHeader_ExternalLinking;
  #UNIQUENAME(TPRec)
  %TPRec% := RECORD(HealthcareNoMatchHeader_ExternalLinking.Process_XNOMATCH_Layouts(pSrc,pVersion,pInfile).InputLayout)
  END;
  #UNIQUENAME(InputT)
  %TPRec% %InputT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
  #IF ( #TEXT(Input_nomatch_id) <> '' AND In_UpdateIDs=true)
    SELF.Entered_nomatch_id := (TYPEOF(SELF.Entered_nomatch_id))le.Input_nomatch_id;
  #ELSE
    SELF.Entered_nomatch_id := (TYPEOF(SELF.Entered_nomatch_id))'';
  #END
  #IF ( #TEXT(Input_SRC) <> '' )
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
  #ELSE
    SELF.SRC := (TYPEOF(SELF.SRC))'';
  #END
  #IF ( #TEXT(Input_SSN) <> '' )
    SELF.SSN := (TYPEOF(SELF.SSN))le.Input_SSN;
  #ELSE
    SELF.SSN := (TYPEOF(SELF.SSN))'';
  #END
  #IF ( #TEXT(Input_DOB) <> '' )
    SELF.DOB := (TYPEOF(SELF.DOB))le.Input_DOB;
  #ELSE
    SELF.DOB := (TYPEOF(SELF.DOB))'';
  #END
  #IF ( #TEXT(Input_LEXID) <> '' )
    SELF.LEXID := (TYPEOF(SELF.LEXID))le.Input_LEXID;
  #ELSE
    SELF.LEXID := (TYPEOF(SELF.LEXID))'';
  #END
  #IF ( #TEXT(Input_SUFFIX) <> '' )
    SELF.SUFFIX := (TYPEOF(SELF.SUFFIX))le.Input_SUFFIX;
  #ELSE
    SELF.SUFFIX := (TYPEOF(SELF.SUFFIX))'';
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
  #IF ( #TEXT(Input_GENDER) <> '' )
    SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
  #ELSE
    SELF.GENDER := (TYPEOF(SELF.GENDER))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_CITY_NAME) <> '' )
    SELF.CITY_NAME := (TYPEOF(SELF.CITY_NAME))le.Input_CITY_NAME;
  #ELSE
    SELF.CITY_NAME := (TYPEOF(SELF.CITY_NAME))'';
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
  #IF ( #TEXT(Input_MAINNAME) <> '' )
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))le.Input_MAINNAME;
  #ELSE
    SELF.MAINNAME := (TYPEOF(SELF.MAINNAME))'';
  #END
  #IF ( #TEXT(Input_ADDR1) <> '' )
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))le.Input_ADDR1;
  #ELSE
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
  #END
  #IF ( #TEXT(Input_LOCALE) <> '' )
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))le.Input_LOCALE;
  #ELSE
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
  #END
  #IF ( #TEXT(Input_ADDRESS) <> '' )
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))le.Input_ADDRESS;
  #ELSE
    SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))'';
  #END
  #IF ( #TEXT(Input_FULLNAME) <> '' )
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))le.Input_FULLNAME;
  #ELSE
    SELF.FULLNAME := (TYPEOF(SELF.FULLNAME))'';
  #END
  END;
  #UNIQUENAME(fats0)
  %fats0% := PROJECT(InFile,%InputT%(LEFT));
  HealthcareNoMatchHeader_ExternalLinking.MAC_MEOW_XNOMATCH_Batch_InLayout(pSrc,pVersion,pInfile,%fats0%,OutFile,AsIndex,In_UpdateIDs,Stats,In_disableForce,DoClean);
ENDMACRO;
