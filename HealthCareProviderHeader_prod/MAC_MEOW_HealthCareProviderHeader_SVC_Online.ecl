
EXPORT MAC_MEOW_HealthCareProviderHeader_SVC_Online(infile,Ref='',Input_VENDOR_ID = '',Input_DID = '',Input_NPI_NUMBER = '',Input_DEA_NUMBER = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_LIC_NBR = '',Input_UPIN = '',Input_ADDR1 = '',Input_ADDRESS = '',Input_TAX_ID = '',Input_DOB = '',Input_PRIM_NAME = '',Input_ZIP = '',Input_LOCALE = '',Input_PRIM_RANGE = '',Input_LNAME = '',Input_V_CITY_NAME = '',Input_MNAME = '',Input_FNAME = '',Input_SEC_RANGE = '',Input_SNAME = '',Input_ST = '',Input_GENDER = '',Input_LIC_STATE = '',Input_CNAME = '',Input_SRC = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_GEO_LAT = '',Input_GEO_LONG = '',OutFile,Stats='') := MACRO
IMPORT SALT26b2,HealthCareProviderHeader_prod;
ServiceModule := 'HealthCareProviderHeader_prod.';
#uniquename(into)
HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.InputLayout %into%(infile le) := TRANSFORM
SELF.UniqueId := le.Ref;
#IF ( #TEXT(Input_VENDOR_ID) <> '' )
SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))le.Input_VENDOR_ID;
#ELSE
SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))'';
#END
#IF ( #TEXT(Input_DID) <> '' )
SELF.DID := (TYPEOF(SELF.DID))le.Input_DID;
#ELSE
SELF.DID := (TYPEOF(SELF.DID))'';
#END
#IF ( #TEXT(Input_NPI_NUMBER) <> '' )
SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))le.Input_NPI_NUMBER;
#ELSE
SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))'';
#END
#IF ( #TEXT(Input_DEA_NUMBER) <> '' )
SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))le.Input_DEA_NUMBER;
#ELSE
SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))'';
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
#IF ( #TEXT(Input_LIC_NBR) <> '' )
SELF.LIC_NBR := (TYPEOF(SELF.LIC_NBR))le.Input_LIC_NBR;
#ELSE
SELF.LIC_NBR := (TYPEOF(SELF.LIC_NBR))'';
#END
#IF ( #TEXT(Input_UPIN) <> '' )
SELF.UPIN := (TYPEOF(SELF.UPIN))le.Input_UPIN;
#ELSE
SELF.UPIN := (TYPEOF(SELF.UPIN))'';
#END
#IF ( #TEXT(Input_ADDR1) <> '' )
SELF.ADDR1 := (TYPEOF(SELF.ADDR1))le.Input_ADDR1;
#ELSE
SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
#END
#IF ( #TEXT(Input_ADDRESS) <> '' )
SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))le.Input_ADDRESS;
#ELSE
SELF.ADDRESS := (TYPEOF(SELF.ADDRESS))'';
#END
#IF ( #TEXT(Input_TAX_ID) <> '' )
SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))le.Input_TAX_ID;
#ELSE
SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))'';
#END
#IF ( #TEXT(Input_DOB) <> '' )
SELF.DOB := (TYPEOF(SELF.DOB))le.Input_DOB;
#ELSE
SELF.DOB := (TYPEOF(SELF.DOB))'';
#END
#IF ( #TEXT(Input_PRIM_NAME) <> '' )
SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
#ELSE
SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
#END
#IF ( #TEXT(Input_ZIP) <> '' )
SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
#ELSE
SELF.ZIP := (TYPEOF(SELF.ZIP))'';
#END
#IF ( #TEXT(Input_LOCALE) <> '' )
SELF.LOCALE := (TYPEOF(SELF.LOCALE))le.Input_LOCALE;
#ELSE
SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
#END
#IF ( #TEXT(Input_PRIM_RANGE) <> '' )
SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
#ELSE
SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
#END
#IF ( #TEXT(Input_LNAME) <> '' )
SELF.LNAME := (TYPEOF(SELF.LNAME))le.Input_LNAME;
#ELSE
SELF.LNAME := (TYPEOF(SELF.LNAME))'';
#END
#IF ( #TEXT(Input_V_CITY_NAME) <> '' )
SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
#ELSE
SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))'';
#END
#IF ( #TEXT(Input_MNAME) <> '' )
SELF.MNAME := (TYPEOF(SELF.MNAME))le.Input_MNAME;
#ELSE
SELF.MNAME := (TYPEOF(SELF.MNAME))'';
#END
#IF ( #TEXT(Input_FNAME) <> '' )
SELF.FNAME := (TYPEOF(SELF.FNAME))le.Input_FNAME;
#ELSE
SELF.FNAME := (TYPEOF(SELF.FNAME))'';
#END
#IF ( #TEXT(Input_SEC_RANGE) <> '' )
SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
#ELSE
SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
#END
#IF ( #TEXT(Input_SNAME) <> '' )
SELF.SNAME := (TYPEOF(SELF.SNAME))le.Input_SNAME;
#ELSE
SELF.SNAME := (TYPEOF(SELF.SNAME))'';
#END
#IF ( #TEXT(Input_ST) <> '' )
SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
#ELSE
SELF.ST := (TYPEOF(SELF.ST))'';
#END
#IF ( #TEXT(Input_GENDER) <> '' )
SELF.GENDER := (TYPEOF(SELF.GENDER))le.Input_GENDER;
#ELSE
SELF.GENDER := (TYPEOF(SELF.GENDER))'';
#END
#IF ( #TEXT(Input_LIC_STATE) <> '' )
SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
#ELSE
SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))'';
#END
#IF ( #TEXT(Input_CNAME) <> '' )
SELF.CNAME := (TYPEOF(SELF.CNAME))le.Input_CNAME;
#ELSE
SELF.CNAME := (TYPEOF(SELF.CNAME))'';
#END
#IF ( #TEXT(Input_SRC) <> '' )
SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
#ELSE
SELF.SRC := (TYPEOF(SELF.SRC))'';
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
#IF ( #TEXT(Input_GEO_LAT) <> '' )
SELF.GEO_LAT := (TYPEOF(SELF.GEO_LAT))le.Input_GEO_LAT;
#ELSE
SELF.GEO_LAT := (TYPEOF(SELF.GEO_LAT))'';
#END
#IF ( #TEXT(Input_GEO_LONG) <> '' )
SELF.GEO_LONG := (TYPEOF(SELF.GEO_LONG))le.Input_GEO_LONG;
#ELSE
SELF.GEO_LONG := (TYPEOF(SELF.GEO_LONG))'';
#END
END;
#uniquename(pr)
%pr% := PROJECT(infile,%into%(LEFT)); // Into roxie input format
#uniquename(res_out)
SALT26b2.MAC_Soapcall(%pr%,HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.OutputLayout, HealthCareProviderHeader_prod.MEOW_roxieIP, ServiceModule+'MEOW_HealthCareProviderHeader_SVC_Service', %res_out%);
OutFile := %res_out%;
#IF (#TEXT(Stats)<>'')
Stats := HealthCareProviderHeader_prod.Process_HealthCareProviderHeader_SVC_Layouts.ScoreSummary(OutFile);
#END
ENDMACRO;
