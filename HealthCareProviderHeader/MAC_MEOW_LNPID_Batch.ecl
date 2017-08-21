EXPORT MAC_MEOW_LNPID_Batch(infile,Ref='',Input_DID = '',Input_DOB = '',Input_PHONE = '',Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_GENDER = '',Input_DERIVED_GENDER = '',Input_LIC_NBR = '',Input_ADDRESS_ID = '',Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_V_CITY_NAME = '',Input_ST = '',Input_ZIP = '',Input_CNAME = '',Input_TAX_ID = '',Input_UPIN = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DT_LIC_EXPIRATION = '',Input_DT_DEA_EXPIRATION = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_FULLNAME_DOB = '',Input_ADDR = '',Input_LOCALE = '',Input_ADDRESS = '',Input_LIC_STATE = '',Input_SRC = '',OutFile,AsIndex='true',Stats='') := MACRO
  #uniquename(ToProcess)
  IMPORT SALT27,HealthCareProviderHeader;
  #uniquename(TPRec)
  %TPRec% := RECORD(HealthCareProviderHeader.Process_LNPID_Layouts.InputLayout)
  END;
  #uniquename(CleanT) // Transform to clean input data identically to online transform
  %TPRec% %CleanT%(InFile le) := TRANSFORM
    SELF.UniqueId := le.ref;
    SELF.DID :=   #IF (#TEXT(Input_DID)<>'')
(typeof(SELF.DID))le.Input_DID;
  #ELSE
(TYPEOF(SELF.DID))'';
  #END
    SELF.DOB :=   #IF (#TEXT(Input_DOB)<>'')
(typeof(SELF.DOB))HealthCareProviderHeader.Fields.Make_DOB((SALT27.StrType)le.Input_DOB);
  #ELSE
(TYPEOF(SELF.DOB))'';
  #END
    SELF.PHONE :=   #IF (#TEXT(Input_PHONE)<>'')
(typeof(SELF.PHONE))HealthCareProviderHeader.Fields.Make_PHONE((SALT27.StrType)le.Input_PHONE);
  #ELSE
(TYPEOF(SELF.PHONE))'';
  #END
    SELF.SNAME :=   #IF (#TEXT(Input_SNAME)<>'')
(typeof(SELF.SNAME))HealthCareProviderHeader.Fields.Make_SNAME((SALT27.StrType)le.Input_SNAME);
  #ELSE
(TYPEOF(SELF.SNAME))'';
  #END
    SELF.FNAME :=   #IF (#TEXT(Input_FNAME)<>'')
(typeof(SELF.FNAME))HealthCareProviderHeader.Fields.Make_FNAME((SALT27.StrType)le.Input_FNAME);
  #ELSE
(TYPEOF(SELF.FNAME))'';
  #END
    SELF.MNAME :=   #IF (#TEXT(Input_MNAME)<>'')
(typeof(SELF.MNAME))HealthCareProviderHeader.Fields.Make_MNAME((SALT27.StrType)le.Input_MNAME);
  #ELSE
(TYPEOF(SELF.MNAME))'';
  #END
    SELF.LNAME :=   #IF (#TEXT(Input_LNAME)<>'')
(typeof(SELF.LNAME))HealthCareProviderHeader.Fields.Make_LNAME((SALT27.StrType)le.Input_LNAME);
  #ELSE
(TYPEOF(SELF.LNAME))'';
  #END
    SELF.GENDER :=   #IF (#TEXT(Input_GENDER)<>'')
(typeof(SELF.GENDER))HealthCareProviderHeader.Fields.Make_GENDER((SALT27.StrType)le.Input_GENDER);
  #ELSE
(TYPEOF(SELF.GENDER))'';
  #END
    SELF.DERIVED_GENDER :=   #IF (#TEXT(Input_DERIVED_GENDER)<>'')
(typeof(SELF.DERIVED_GENDER))HealthCareProviderHeader.Fields.Make_DERIVED_GENDER((SALT27.StrType)le.Input_DERIVED_GENDER);
  #ELSE
(TYPEOF(SELF.DERIVED_GENDER))'';
  #END
    SELF.LIC_NBR :=   #IF (#TEXT(Input_LIC_NBR)<>'')
(typeof(SELF.LIC_NBR))HealthCareProviderHeader.Fields.Make_LIC_NBR((SALT27.StrType)le.Input_LIC_NBR);
  #ELSE
(TYPEOF(SELF.LIC_NBR))'';
  #END
    SELF.ADDRESS_ID :=   #IF (#TEXT(Input_ADDRESS_ID)<>'')
(typeof(SELF.ADDRESS_ID))le.Input_ADDRESS_ID;
  #ELSE
(TYPEOF(SELF.ADDRESS_ID))'';
  #END
    SELF.PRIM_NAME :=   #IF (#TEXT(Input_PRIM_NAME)<>'')
(typeof(SELF.PRIM_NAME))HealthCareProviderHeader.Fields.Make_PRIM_NAME((SALT27.StrType)le.Input_PRIM_NAME);
  #ELSE
(TYPEOF(SELF.PRIM_NAME))'';
  #END
    SELF.PRIM_RANGE :=   #IF (#TEXT(Input_PRIM_RANGE)<>'')
(typeof(SELF.PRIM_RANGE))HealthCareProviderHeader.Fields.Make_PRIM_RANGE((SALT27.StrType)le.Input_PRIM_RANGE);
  #ELSE
(TYPEOF(SELF.PRIM_RANGE))'';
  #END
    SELF.SEC_RANGE :=   #IF (#TEXT(Input_SEC_RANGE)<>'')
(typeof(SELF.SEC_RANGE))HealthCareProviderHeader.Fields.Make_SEC_RANGE((SALT27.StrType)le.Input_SEC_RANGE);
  #ELSE
(TYPEOF(SELF.SEC_RANGE))'';
  #END
    SELF.V_CITY_NAME :=   #IF (#TEXT(Input_V_CITY_NAME)<>'')
(typeof(SELF.V_CITY_NAME))HealthCareProviderHeader.Fields.Make_V_CITY_NAME((SALT27.StrType)le.Input_V_CITY_NAME);
  #ELSE
(TYPEOF(SELF.V_CITY_NAME))'';
  #END
    SELF.ST :=   #IF (#TEXT(Input_ST)<>'')
(typeof(SELF.ST))HealthCareProviderHeader.Fields.Make_ST((SALT27.StrType)le.Input_ST);
  #ELSE
(TYPEOF(SELF.ST))'';
  #END
    SELF.ZIP :=   #IF (#TEXT(Input_ZIP)<>'')
(typeof(SELF.ZIP))HealthCareProviderHeader.Fields.Make_ZIP((SALT27.StrType)le.Input_ZIP);
  #ELSE
(TYPEOF(SELF.ZIP))'';
  #END
    SELF.CNAME :=   #IF (#TEXT(Input_CNAME)<>'')
(typeof(SELF.CNAME))HealthCareProviderHeader.Fields.Make_CNAME((SALT27.StrType)le.Input_CNAME);
  #ELSE
(TYPEOF(SELF.CNAME))'';
  #END
    SELF.TAX_ID :=   #IF (#TEXT(Input_TAX_ID)<>'')
(typeof(SELF.TAX_ID))HealthCareProviderHeader.Fields.Make_TAX_ID((SALT27.StrType)le.Input_TAX_ID);
  #ELSE
(TYPEOF(SELF.TAX_ID))'';
  #END
    SELF.UPIN :=   #IF (#TEXT(Input_UPIN)<>'')
(typeof(SELF.UPIN))HealthCareProviderHeader.Fields.Make_UPIN((SALT27.StrType)le.Input_UPIN);
  #ELSE
(TYPEOF(SELF.UPIN))'';
  #END
    SELF.DEA_NUMBER :=   #IF (#TEXT(Input_DEA_NUMBER)<>'')
(typeof(SELF.DEA_NUMBER))HealthCareProviderHeader.Fields.Make_DEA_NUMBER((SALT27.StrType)le.Input_DEA_NUMBER);
  #ELSE
(TYPEOF(SELF.DEA_NUMBER))'';
  #END
    SELF.VENDOR_ID :=   #IF (#TEXT(Input_VENDOR_ID)<>'')
(typeof(SELF.VENDOR_ID))HealthCareProviderHeader.Fields.Make_VENDOR_ID((SALT27.StrType)le.Input_VENDOR_ID);
  #ELSE
(TYPEOF(SELF.VENDOR_ID))'';
  #END
    SELF.NPI_NUMBER :=   #IF (#TEXT(Input_NPI_NUMBER)<>'')
(typeof(SELF.NPI_NUMBER))HealthCareProviderHeader.Fields.Make_NPI_NUMBER((SALT27.StrType)le.Input_NPI_NUMBER);
  #ELSE
(TYPEOF(SELF.NPI_NUMBER))'';
  #END
    SELF.DT_FIRST_SEEN :=   #IF (#TEXT(Input_DT_FIRST_SEEN)<>'')
(typeof(SELF.DT_FIRST_SEEN))HealthCareProviderHeader.Fields.Make_DT_FIRST_SEEN((SALT27.StrType)le.Input_DT_FIRST_SEEN);
  #ELSE
(TYPEOF(SELF.DT_FIRST_SEEN))'';
  #END
    SELF.DT_LAST_SEEN :=   #IF (#TEXT(Input_DT_LAST_SEEN)<>'')
(typeof(SELF.DT_LAST_SEEN))HealthCareProviderHeader.Fields.Make_DT_LAST_SEEN((SALT27.StrType)le.Input_DT_LAST_SEEN);
  #ELSE
(TYPEOF(SELF.DT_LAST_SEEN))'';
  #END
    SELF.DT_LIC_EXPIRATION :=   #IF (#TEXT(Input_DT_LIC_EXPIRATION)<>'')
(typeof(SELF.DT_LIC_EXPIRATION))HealthCareProviderHeader.Fields.Make_DT_LIC_EXPIRATION((SALT27.StrType)le.Input_DT_LIC_EXPIRATION);
  #ELSE
(TYPEOF(SELF.DT_LIC_EXPIRATION))'';
  #END
    SELF.DT_DEA_EXPIRATION :=   #IF (#TEXT(Input_DT_DEA_EXPIRATION)<>'')
(typeof(SELF.DT_DEA_EXPIRATION))HealthCareProviderHeader.Fields.Make_DT_DEA_EXPIRATION((SALT27.StrType)le.Input_DT_DEA_EXPIRATION);
  #ELSE
(TYPEOF(SELF.DT_DEA_EXPIRATION))'';
  #END
    SELF.MAINNAME :=   #IF (#TEXT(Input_MAINNAME)<>'')
(typeof(SELF.MAINNAME))HealthCareProviderHeader.Fields.Make_MAINNAME((SALT27.StrType)le.Input_MAINNAME);
  #ELSE
(TYPEOF(SELF.MAINNAME))'';
  #END
    SELF.FULLNAME :=   #IF (#TEXT(Input_FULLNAME)<>'')
(typeof(SELF.FULLNAME))HealthCareProviderHeader.Fields.Make_FULLNAME((SALT27.StrType)le.Input_FULLNAME);
  #ELSE
(TYPEOF(SELF.FULLNAME))'';
  #END
    SELF.FULLNAME_DOB :=   #IF (#TEXT(Input_FULLNAME_DOB)<>'')
(typeof(SELF.FULLNAME_DOB))HealthCareProviderHeader.Fields.Make_FULLNAME_DOB((SALT27.StrType)le.Input_FULLNAME_DOB);
  #ELSE
(TYPEOF(SELF.FULLNAME_DOB))'';
  #END
    SELF.ADDR :=   #IF (#TEXT(Input_ADDR)<>'')
(typeof(SELF.ADDR))HealthCareProviderHeader.Fields.Make_ADDR((SALT27.StrType)le.Input_ADDR);
  #ELSE
(TYPEOF(SELF.ADDR))'';
  #END
    SELF.LOCALE :=   #IF (#TEXT(Input_LOCALE)<>'')
(typeof(SELF.LOCALE))HealthCareProviderHeader.Fields.Make_LOCALE((SALT27.StrType)le.Input_LOCALE);
  #ELSE
(TYPEOF(SELF.LOCALE))'';
  #END
    SELF.ADDRESS :=   #IF (#TEXT(Input_ADDRESS)<>'')
(typeof(SELF.ADDRESS))HealthCareProviderHeader.Fields.Make_ADDRESS((SALT27.StrType)le.Input_ADDRESS);
  #ELSE
(TYPEOF(SELF.ADDRESS))'';
  #END
    SELF.LIC_STATE :=   #IF (#TEXT(Input_LIC_STATE)<>'')
(typeof(SELF.LIC_STATE))le.Input_LIC_STATE;
  #ELSE
(TYPEOF(SELF.LIC_STATE))'';
  #END
    SELF.SRC :=   #IF (#TEXT(Input_SRC)<>'')
(typeof(SELF.SRC))le.Input_SRC;
  #ELSE
(TYPEOF(SELF.SRC))'';
  #END
  END;
  #uniquename(fats0)
  %fats0% := PROJECT(InFile,%CleanT%(LEFT));
  #uniquename(fats)
  #uniquename(dups)
 // In case multiple copies of the same indicative are in there - remove them
  SALT27.MAC_Dups_Note(%fats0%,%TPRec%,%fats%,%dups%);
  %ToProcess% := %fats%;
  #uniquename(AllRes)
  %AllRes% := ;
  #uniquename(All)
  %All% := HealthCareProviderHeader.Process_LNPID_Layouts.CombineAllScores(%AllRes%);
  SALT27.MAC_Dups_Restore(%All%,%dups%,OutFile);
  #IF (#TEXT(Stats)<>'')
    Stats := HealthCareProviderHeader.Process_LNPID_Layouts.ScoreSummary(OutFile);
  #END
ENDMACRO;
