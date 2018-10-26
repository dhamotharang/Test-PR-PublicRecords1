Input_Record := RECORD
  string50 ProviderKey;
  string10 NPINumber;
  string12 DEANumber;
  string10 Taxonomy;
  string10 ProviderTaxID;
  string5 ProviderTaxIDSuffix;
  string12 ProviderNumber;
  string5 ProviderNumberSuffix;
  string2 ProviderNumberQualifier;
  string2 SecurityAuthorizationCode;
  string3 NetworkCode;
  string50 FacilityName;
  string12 FacilityNumber;
  string30 FirstName;
  string36 LastName;
  string36 AddressLine1;
  string36 AddressLine2;
  string24 City;
  string2 State;
  string9 Zip5;
  string30 County;
  string2 Country;
  string4 Regions;
  string9 SpecialityCode1;
  string9 SpecialityCode2;
  string2 ProviderType;
  string1 WatchCode;
  string8 LastUpdateDate;
  string50 UserDefinedField01;
  string50 UserDefinedField02;
  string50 UserDefinedField03;
  string50 UserDefinedField04;
  string50 UserDefinedField05;
  string50 UserDefinedField06;
  string50 UserDefinedField07;
  string50 UserDefinedField08;
  string50 UserDefinedField09;
  string50 UserDefinedField10;
END;

ds := DATASET
    (
        [
            {'PDI12236','1396814414','BO0201854','','042743585','','10006','0126','EP','','X','BRIGHAM AND WOMENS','900060','DAVID','CAHAN','STE 5985','1155 CENTRE ST','JAMAICA PLAIN','MA','02130','SUFFOLK','','','4','30','P','','','CM','','','','','','','','',''}
        ],
        Input_Record
    );

OUTPUT(ds,,'~qa::cleanproviderdata::cleanproviderdata::input',OVERWRITE);