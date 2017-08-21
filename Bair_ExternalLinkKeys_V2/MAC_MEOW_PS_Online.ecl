 
EXPORT MAC_MEOW_PS_Online(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_P_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_DOB = '',Input_PHONE = '',Input_DL_ST = '',Input_DL = '',Input_LEXID = '',Input_POSSIBLE_SSN = '',Input_CRIME = '',Input_NAME_TYPE = '',Input_CLEAN_GENDER = '',Input_CLASS_CODE = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DATA_PROVIDER_ORI = '',Input_VIN = '',Input_PLATE = '',Input_LATITUDE = '',Input_LONGITUDE = '',Input_SEARCH_ADDR1 = '',Input_SEARCH_ADDR2 = '',Input_CLEAN_COMPANY_NAME = '',Input_MAINNAME = '',Input_FULLNAME = '',Soapcall_RoxieIP = '',Soapcall_Timeout = 3600,Soapcall_Time_Limit = 0,Soapcall_Retry = 0,Soapcall_Parallel = 2,OutFile,Stats='',In_MaxIds=50,In_LeadThreshold=0, In_disableForce = 'false') := MACRO
  IMPORT SALT37,Bair_ExternalLinkKeys_V2;
  ServiceModule := 'Bair_ExternalLinkKeys_V2.';
#uniquename(into)
Bair_ExternalLinkKeys_V2.Process_PS_Layouts.InputLayout %into%(infile le) := TRANSFORM
  SELF.UniqueId := le.Ref;
  SELF.MaxIds := In_MaxIds;
  SELF.LeadThreshold := In_LeadThreshold;
  SELF.disableForce := In_disableForce;
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
#uniquename(Soapcall_RoxieIP_temp)
  #IF ( #TEXT(Soapcall_RoxieIP) <> '' )
	  %Soapcall_RoxieIP_temp% := Soapcall_RoxieIP;
  #ELSE
      %Soapcall_RoxieIP_temp% := Bair_ExternalLinkKeys_V2.MEOW_roxieip;
  #END
#uniquename(pr)
  %pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT37.MAC_Soapcall(%pr%,Bair_ExternalLinkKeys_V2.Process_PS_Layouts.OutputLayout, %Soapcall_RoxieIP_temp%, ServiceModule+'MEOW_PS_Service', %res_out%,,,Soapcall_Timeout,Soapcall_Time_Limit,Soapcall_Retry,Soapcall_Parallel);
OutFile := %res_out%;
  #IF (#TEXT(Stats)<>'')
    Stats := Bair_ExternalLinkKeys_V2.Process_PS_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
