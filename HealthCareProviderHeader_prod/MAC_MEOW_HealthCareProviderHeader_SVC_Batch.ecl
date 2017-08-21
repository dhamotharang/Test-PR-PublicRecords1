
EXPORT MAC_MEOW_HealthCareProviderHeader_SVC_Batch(infile,Ref='',Input_VENDOR_ID = '',Input_DID = '',Input_NPI_NUMBER = '',Input_DEA_NUMBER = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_LIC_NBR = '',Input_UPIN = '',Input_ADDR1 = '',Input_ADDRESS = '',Input_TAX_ID = '',Input_DOB = '',Input_PRIM_NAME = '',Input_ZIP = '',Input_LOCALE = '',Input_PRIM_RANGE = '',Input_LNAME = '',Input_V_CITY_NAME = '',Input_MNAME = '',Input_FNAME = '',Input_SEC_RANGE = '',Input_SNAME = '',Input_ST = '',Input_GENDER = '',Input_LIC_STATE = '',Input_CNAME = '',Input_SRC = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_GEO_LAT = '',Input_GEO_LONG = '',OutFile,AsIndex='true',Stats='') := MACRO
#uniquename(ToProcess)
IMPORT SALT26b2,HealthCareProviderHeader_prod;
#uniquename(TPRec)
%TPRec% := record(HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.InputLayout)
end;
#uniquename(CleanT) // Transform to clean input data identically to online transform
%TPRec% %CleanT%(InFile le) := TRANSFORM
SELF.UniqueId := le.ref;
SELF.VENDOR_ID :=   #IF (#TEXT(Input_VENDOR_ID)<>'')
(typeof(SELF.VENDOR_ID))HealthCareProviderHeader_prod.Fields.Make_VENDOR_ID((SALT26b2.StrType)le.Input_VENDOR_ID);
#ELSE
(TYPEOF(SELF.VENDOR_ID))'';
#END
SELF.DID :=   #IF (#TEXT(Input_DID)<>'')
(typeof(SELF.DID))HealthCareProviderHeader_prod.Fields.Make_DID((SALT26b2.StrType)le.Input_DID);
#ELSE
(TYPEOF(SELF.DID))'';
#END
SELF.NPI_NUMBER :=   #IF (#TEXT(Input_NPI_NUMBER)<>'')
(typeof(SELF.NPI_NUMBER))HealthCareProviderHeader_prod.Fields.Make_NPI_NUMBER((SALT26b2.StrType)le.Input_NPI_NUMBER);
#ELSE
(TYPEOF(SELF.NPI_NUMBER))'';
#END
SELF.DEA_NUMBER :=   #IF (#TEXT(Input_DEA_NUMBER)<>'')
(typeof(SELF.DEA_NUMBER))HealthCareProviderHeader_prod.Fields.Make_DEA_NUMBER((SALT26b2.StrType)le.Input_DEA_NUMBER);
#ELSE
(TYPEOF(SELF.DEA_NUMBER))'';
#END
SELF.MAINNAME :=   #IF (#TEXT(Input_MAINNAME)<>'')
(typeof(SELF.MAINNAME))HealthCareProviderHeader_prod.Fields.Make_MAINNAME((SALT26b2.StrType)le.Input_MAINNAME);
#ELSE
(TYPEOF(SELF.MAINNAME))'';
#END
SELF.FULLNAME :=   #IF (#TEXT(Input_FULLNAME)<>'')
(typeof(SELF.FULLNAME))HealthCareProviderHeader_prod.Fields.Make_FULLNAME((SALT26b2.StrType)le.Input_FULLNAME);
#ELSE
(TYPEOF(SELF.FULLNAME))'';
#END
SELF.LIC_NBR :=   #IF (#TEXT(Input_LIC_NBR)<>'')
(typeof(SELF.LIC_NBR))HealthCareProviderHeader_prod.Fields.Make_LIC_NBR((SALT26b2.StrType)le.Input_LIC_NBR);
#ELSE
(TYPEOF(SELF.LIC_NBR))'';
#END
SELF.UPIN :=   #IF (#TEXT(Input_UPIN)<>'')
(typeof(SELF.UPIN))HealthCareProviderHeader_prod.Fields.Make_UPIN((SALT26b2.StrType)le.Input_UPIN);
#ELSE
(TYPEOF(SELF.UPIN))'';
#END
SELF.ADDR1 :=   #IF (#TEXT(Input_ADDR1)<>'')
(typeof(SELF.ADDR1))HealthCareProviderHeader_prod.Fields.Make_ADDR1((SALT26b2.StrType)le.Input_ADDR1);
#ELSE
(TYPEOF(SELF.ADDR1))'';
#END
SELF.ADDRESS :=   #IF (#TEXT(Input_ADDRESS)<>'')
(typeof(SELF.ADDRESS))HealthCareProviderHeader_prod.Fields.Make_ADDRESS((SALT26b2.StrType)le.Input_ADDRESS);
#ELSE
(TYPEOF(SELF.ADDRESS))'';
#END
SELF.TAX_ID :=   #IF (#TEXT(Input_TAX_ID)<>'')
(typeof(SELF.TAX_ID))HealthCareProviderHeader_prod.Fields.Make_TAX_ID((SALT26b2.StrType)le.Input_TAX_ID);
#ELSE
(TYPEOF(SELF.TAX_ID))'';
#END
SELF.DOB :=   #IF (#TEXT(Input_DOB)<>'')
(typeof(SELF.DOB))HealthCareProviderHeader_prod.Fields.Make_DOB((SALT26b2.StrType)le.Input_DOB);
#ELSE
(TYPEOF(SELF.DOB))'';
#END
SELF.PRIM_NAME :=   #IF (#TEXT(Input_PRIM_NAME)<>'')
(typeof(SELF.PRIM_NAME))HealthCareProviderHeader_prod.Fields.Make_PRIM_NAME((SALT26b2.StrType)le.Input_PRIM_NAME);
#ELSE
(TYPEOF(SELF.PRIM_NAME))'';
#END
SELF.ZIP :=   #IF (#TEXT(Input_ZIP)<>'')
(typeof(SELF.ZIP))HealthCareProviderHeader_prod.Fields.Make_ZIP((SALT26b2.StrType)le.Input_ZIP);
#ELSE
(TYPEOF(SELF.ZIP))'';
#END
SELF.LOCALE :=   #IF (#TEXT(Input_LOCALE)<>'')
(typeof(SELF.LOCALE))HealthCareProviderHeader_prod.Fields.Make_LOCALE((SALT26b2.StrType)le.Input_LOCALE);
#ELSE
(TYPEOF(SELF.LOCALE))'';
#END
SELF.PRIM_RANGE :=   #IF (#TEXT(Input_PRIM_RANGE)<>'')
(typeof(SELF.PRIM_RANGE))HealthCareProviderHeader_prod.Fields.Make_PRIM_RANGE((SALT26b2.StrType)le.Input_PRIM_RANGE);
#ELSE
(TYPEOF(SELF.PRIM_RANGE))'';
#END
SELF.LNAME :=   #IF (#TEXT(Input_LNAME)<>'')
(typeof(SELF.LNAME))HealthCareProviderHeader_prod.Fields.Make_LNAME((SALT26b2.StrType)le.Input_LNAME);
#ELSE
(TYPEOF(SELF.LNAME))'';
#END
SELF.V_CITY_NAME :=   #IF (#TEXT(Input_V_CITY_NAME)<>'')
(typeof(SELF.V_CITY_NAME))HealthCareProviderHeader_prod.Fields.Make_V_CITY_NAME((SALT26b2.StrType)le.Input_V_CITY_NAME);
#ELSE
(TYPEOF(SELF.V_CITY_NAME))'';
#END
SELF.LAT_LONG :=   #IF (#TEXT(Input_LAT_LONG)<>'')
;
#ELSE
(TYPEOF(SELF.LAT_LONG))'';
#END
SELF.MNAME :=   #IF (#TEXT(Input_MNAME)<>'')
(typeof(SELF.MNAME))HealthCareProviderHeader_prod.Fields.Make_MNAME((SALT26b2.StrType)le.Input_MNAME);
#ELSE
(TYPEOF(SELF.MNAME))'';
#END
SELF.FNAME :=   #IF (#TEXT(Input_FNAME)<>'')
(typeof(SELF.FNAME))HealthCareProviderHeader_prod.Fields.Make_FNAME((SALT26b2.StrType)le.Input_FNAME);
#ELSE
(TYPEOF(SELF.FNAME))'';
#END
SELF.SEC_RANGE :=   #IF (#TEXT(Input_SEC_RANGE)<>'')
(typeof(SELF.SEC_RANGE))HealthCareProviderHeader_prod.Fields.Make_SEC_RANGE((SALT26b2.StrType)le.Input_SEC_RANGE);
#ELSE
(TYPEOF(SELF.SEC_RANGE))'';
#END
SELF.SNAME :=   #IF (#TEXT(Input_SNAME)<>'')
(typeof(SELF.SNAME))HealthCareProviderHeader_prod.Fields.Make_SNAME((SALT26b2.StrType)le.Input_SNAME);
#ELSE
(TYPEOF(SELF.SNAME))'';
#END
SELF.ST :=   #IF (#TEXT(Input_ST)<>'')
(typeof(SELF.ST))HealthCareProviderHeader_prod.Fields.Make_ST((SALT26b2.StrType)le.Input_ST);
#ELSE
(TYPEOF(SELF.ST))'';
#END
SELF.GENDER :=   #IF (#TEXT(Input_GENDER)<>'')
IF ( HealthCareProviderHeader_prod.Fields.Invalid_GENDER((SALT26b2.StrType)le.Input_GENDER)=0,(typeof(SELF.GENDER))le.Input_GENDER,(typeof(SELF.GENDER))'');
#ELSE
(TYPEOF(SELF.GENDER))'';
#END
SELF.LIC_STATE :=   #IF (#TEXT(Input_LIC_STATE)<>'')
(typeof(SELF.LIC_STATE))HealthCareProviderHeader_prod.Fields.Make_LIC_STATE((SALT26b2.StrType)le.Input_LIC_STATE);
#ELSE
(TYPEOF(SELF.LIC_STATE))'';
#END
SELF.CNAME :=   #IF (#TEXT(Input_CNAME)<>'')
(typeof(SELF.CNAME))HealthCareProviderHeader_prod.Fields.Make_CNAME((SALT26b2.StrType)le.Input_CNAME);
#ELSE
(TYPEOF(SELF.CNAME))'';
#END
SELF.SRC :=   #IF (#TEXT(Input_SRC)<>'')
(typeof(SELF.SRC))HealthCareProviderHeader_prod.Fields.Make_SRC((SALT26b2.StrType)le.Input_SRC);
#ELSE
(TYPEOF(SELF.SRC))'';
#END
SELF.DT_FIRST_SEEN :=   #IF (#TEXT(Input_DT_FIRST_SEEN)<>'')
(typeof(SELF.DT_FIRST_SEEN))HealthCareProviderHeader_prod.Fields.Make_DT_FIRST_SEEN((SALT26b2.StrType)le.Input_DT_FIRST_SEEN);
#ELSE
(TYPEOF(SELF.DT_FIRST_SEEN))'';
#END
SELF.DT_LAST_SEEN :=   #IF (#TEXT(Input_DT_LAST_SEEN)<>'')
(typeof(SELF.DT_LAST_SEEN))HealthCareProviderHeader_prod.Fields.Make_DT_LAST_SEEN((SALT26b2.StrType)le.Input_DT_LAST_SEEN);
#ELSE
(TYPEOF(SELF.DT_LAST_SEEN))'';
#END
SELF.GEO_LAT :=   #IF (#TEXT(Input_GEO_LAT)<>'')
(typeof(SELF.GEO_LAT))HealthCareProviderHeader_prod.Fields.Make_GEO_LAT((SALT26b2.StrType)le.Input_GEO_LAT);
#ELSE
(TYPEOF(SELF.GEO_LAT))'';
#END
SELF.GEO_LONG :=   #IF (#TEXT(Input_GEO_LONG)<>'')
(typeof(SELF.GEO_LONG))HealthCareProviderHeader_prod.Fields.Make_GEO_LONG((SALT26b2.StrType)le.Input_GEO_LONG);
#ELSE
(TYPEOF(SELF.GEO_LONG))'';
#END
END;
#uniquename(fats0)
%fats0% := PROJECT(InFile,%CleanT%(LEFT));
#uniquename(fats)
#uniquename(dups)
// In case multiple copies of the same indicative are in there - remove them
SALT26b2.MAC_Dups_Note(%fats0%,%TPRec%,%fats%,%dups%);
%ToProcess% := %fats%;
#uniquename(AllRes)
%AllRes% := ;
#uniquename(All)
%All% := HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.CombineAllScores(%AllRes%);
SALT26b2.MAC_Dups_Restore(%All%,%dups%,OutFile);
#IF (#TEXT(Stats)<>'')
Stats := HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.ScoreSummary(OutFile);
#END
ENDMACRO;
