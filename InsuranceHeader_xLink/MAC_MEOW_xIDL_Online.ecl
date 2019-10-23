 
EXPORT MAC_MEOW_xIDL_Online(infile,Ref='',Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_DERIVED_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DT_EFFECTIVE_FIRST = '',Input_DT_EFFECTIVE_LAST = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_fname2 = '',Input_lname2 = '',Soapcall_RoxieIP = '',Soapcall_Timeout = 3600,Soapcall_Time_Limit = 0,Soapcall_Retry = 0,Soapcall_Parallel = 2,OutFile,Stats='',In_MaxIds=50,In_LeadThreshold=0, In_disableForce = 'InsuranceHeader_xLink.Config.DOB_NotUseForce' /*HACK18*/) := MACRO
  IMPORT SALT37,InsuranceHeader_xLink;
  ServiceModule := 'InsuranceHeader_xLink.';
#uniquename(into)
InsuranceHeader_xLink.Process_xIDL_Layouts().InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.Ref;
  SELF.MaxIds := In_MaxIds;
  SELF.LeadThreshold := In_LeadThreshold;
  SELF.disableForce := In_disableForce;
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
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
    SELF.ZIP := (TYPEOF(SELF.ZIP))'';
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
  #IF ( #TEXT(Input_DL_STATE) <> '' )
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
  #IF ( #TEXT(Input_DT_EFFECTIVE_FIRST) <> '' )
    SELF.DT_EFFECTIVE_FIRST := (TYPEOF(SELF.DT_EFFECTIVE_FIRST))le.Input_DT_EFFECTIVE_FIRST;
  #ELSE
    SELF.DT_EFFECTIVE_FIRST := (TYPEOF(SELF.DT_EFFECTIVE_FIRST))'';
  #END
  #IF ( #TEXT(Input_DT_EFFECTIVE_LAST) <> '' )
    SELF.DT_EFFECTIVE_LAST := (TYPEOF(SELF.DT_EFFECTIVE_LAST))le.Input_DT_EFFECTIVE_LAST;
  #ELSE
    SELF.DT_EFFECTIVE_LAST := (TYPEOF(SELF.DT_EFFECTIVE_LAST))'';
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
#uniquename(Soapcall_RoxieIP_temp)
  #IF ( #TEXT(Soapcall_RoxieIP) <> '' )
	  %Soapcall_RoxieIP_temp% := Soapcall_RoxieIP;
  #ELSE
      %Soapcall_RoxieIP_temp% := InsuranceHeader_xLink.MEOW_roxieip;
  #END
#uniquename(pr)
  %pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT37.MAC_Soapcall(%pr%,InsuranceHeader_xLink.Process_xIDL_Layouts().OutputLayout, %Soapcall_RoxieIP_temp%, ServiceModule+'MEOW_xIDL_Service', %res_out%,,,Soapcall_Timeout,Soapcall_Time_Limit,Soapcall_Retry,Soapcall_Parallel);
OutFile := %res_out%;
  #IF (#TEXT(Stats)<>'')
    Stats := InsuranceHeader_xLink.Process_xIDL_Layouts().ScoreSummary(OutFile);
  #END
ENDMACRO;
