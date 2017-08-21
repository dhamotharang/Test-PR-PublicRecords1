export MAC_MEOW_xADL2_Online(infile,Ref='',Input_NAME_SUFFIX = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_STATE = '',Input_ZIP = '',Input_ZIP4 = '',Input_COUNTY = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRS = '',OutFile) := MACRO
IMPORT SALT20;
#uniquename(into)
PRTE_PersonLinkingADL2V3.Process_xADL2_Layouts.InputLayout %into%(infile le) := transform
  self.UniqueId := le.Ref;
  #IF ( #TEXT(Input_NAME_SUFFIX) <> '' )
    self.NAME_SUFFIX := (typeof(SELF.NAME_SUFFIX))le.Input_NAME_SUFFIX;
  #ELSE
    self.NAME_SUFFIX := (typeof(SELF.NAME_SUFFIX))'';
  #END
  #IF ( #TEXT(Input_FNAME) <> '' )
    self.FNAME := (typeof(SELF.FNAME))le.Input_FNAME;
  #ELSE
    self.FNAME := (typeof(SELF.FNAME))'';
  #END
  #IF ( #TEXT(Input_MNAME) <> '' )
    self.MNAME := (typeof(SELF.MNAME))le.Input_MNAME;
  #ELSE
    self.MNAME := (typeof(SELF.MNAME))'';
  #END
  #IF ( #TEXT(Input_LNAME) <> '' )
    self.LNAME := (typeof(SELF.LNAME))le.Input_LNAME;
  #ELSE
    self.LNAME := (typeof(SELF.LNAME))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    self.PRIM_RANGE := (typeof(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    self.PRIM_RANGE := (typeof(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    self.PRIM_NAME := (typeof(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    self.PRIM_NAME := (typeof(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    self.SEC_RANGE := (typeof(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    self.SEC_RANGE := (typeof(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_CITY) <> '' )
    self.CITY := (typeof(SELF.CITY))le.Input_CITY;
  #ELSE
    self.CITY := (typeof(SELF.CITY))'';
  #END
  #IF ( #TEXT(Input_STATE) <> '' )
    self.STATE := (typeof(SELF.STATE))le.Input_STATE;
  #ELSE
    self.STATE := (typeof(SELF.STATE))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    self.ZIP := (typeof(SELF.ZIP))le.Input_ZIP;
  #ELSE
    self.ZIP := (typeof(SELF.ZIP))'';
  #END
  #IF ( #TEXT(Input_ZIP4) <> '' )
    self.ZIP4 := (typeof(SELF.ZIP4))le.Input_ZIP4;
  #ELSE
    self.ZIP4 := (typeof(SELF.ZIP4))'';
  #END
  #IF ( #TEXT(Input_COUNTY) <> '' )
    self.COUNTY := (typeof(SELF.COUNTY))le.Input_COUNTY;
  #ELSE
    self.COUNTY := (typeof(SELF.COUNTY))'';
  #END
  #IF ( #TEXT(Input_SSN5) <> '' )
    self.SSN5 := (typeof(SELF.SSN5))le.Input_SSN5;
  #ELSE
    self.SSN5 := (typeof(SELF.SSN5))'';
  #END
  #IF ( #TEXT(Input_SSN4) <> '' )
    self.SSN4 := (typeof(SELF.SSN4))le.Input_SSN4;
  #ELSE
    self.SSN4 := (typeof(SELF.SSN4))'';
  #END
  #IF ( #TEXT(Input_DOB) <> '' )
    self.DOB := (typeof(SELF.DOB))le.Input_DOB;
  #ELSE
    self.DOB := (typeof(SELF.DOB))'';
  #END
  #IF ( #TEXT(Input_PHONE) <> '' )
    self.PHONE := (typeof(SELF.PHONE))le.Input_PHONE;
  #ELSE
    self.PHONE := (typeof(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_MAINNAME) <> '' )
    self.MAINNAME := (typeof(SELF.MAINNAME))le.Input_MAINNAME;
  #ELSE
    self.MAINNAME := (typeof(SELF.MAINNAME))'';
  #END
  #IF ( #TEXT(Input_FULLNAME) <> '' )
    self.FULLNAME := (typeof(SELF.FULLNAME))le.Input_FULLNAME;
  #ELSE
    self.FULLNAME := (typeof(SELF.FULLNAME))'';
  #END
  #IF ( #TEXT(Input_ADDR1) <> '' )
    self.ADDR1 := (typeof(SELF.ADDR1))le.Input_ADDR1;
  #ELSE
    self.ADDR1 := (typeof(SELF.ADDR1))'';
  #END
  #IF ( #TEXT(Input_LOCALE) <> '' )
    self.LOCALE := (typeof(SELF.LOCALE))le.Input_LOCALE;
  #ELSE
    self.LOCALE := (typeof(SELF.LOCALE))'';
  #END
  #IF ( #TEXT(Input_ADDRS) <> '' )
    self.ADDRS := (typeof(SELF.ADDRS))le.Input_ADDRS;
  #ELSE
    self.ADDRS := (typeof(SELF.ADDRS))'';
  #END
end;
#uniquename(pr)
  %pr% := project(infile,%into%(left)); // Into roxie input format
#uniquename(res_out)
SALT20.MAC_Soapcall(%pr%,PRTE_PersonLinkingADL2V3.Process_xADL2_Layouts.OutputLayout, PRTE_PersonLinkingADL2V3.MEOW_roxieIP, 'PRTE_PersonLinkingADL2V3.MEOW_xADL2_Service', %res_out%);
OutFile := %res_out%;
ENDMACRO;
