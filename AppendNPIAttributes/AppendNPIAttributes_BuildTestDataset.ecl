TestRec := RECORD
  string50 provider_key;
  string10 provider_npi;
  string12 provider_dea;
  string10 provider_taxonomy;
  string10 provider_tax_id;
  string5 provider_tax_id_suffix;
  string12 provider_num;
  string5 provider_num_suffix;
  string2 provider_num_qualifier;
  string2 provider_security_code;
  string3 network_code;
  string50 provider_facility_name;
  string12 provider_facility_num;
  string30 provider_first_name;
  string36 provider_last_name;
  string36 provider_address_1;
  string36 provider_address_2;
  string24 provider_city;
  string2 provider_state;
  string9 provider_zip_cd;
  string30 provider_county;
  string2 provider_country;
  string4 provider_region;
  string9 prov_specialty_cd_1;
  string9 prov_specialty_cd_2;
  string2 provider_type;
  string1 watch_cd;
  string8 provider_latest_update_date;
  string50 prov_user_def_01;
  string50 prov_user_def_02;
  string50 prov_user_def_03;
  string50 prov_user_def_04;
  string50 prov_user_def_05;
  string50 prov_user_def_06;
  string50 prov_user_def_07;
  string50 prov_user_def_08;
  string50 prov_user_def_09;
  string50 prov_user_def_10;
END;

TestData := DATASET
(
  [
    {'414001003','1851414882','','','521315843','','414001','3','','','N','','','JENNIFER','MEYER','1842 BEACON ST STE 402','','BROOKLINE','MA','24451922','','','','48','','1','','','','','','','','','','','',''},
    {'838001001','1164726121','','','43069692','','838001','1','','','N','','','KATHLEEN','MORRISSEY','1132 WESTFIELD ST','','WEST SPRINGFIELD','MA','10893878','','','','53','','2','','','','','','','','','','','',''},
    {'1212001004','1508078700','','','20222111','','1212001','4','','','N','','','MELISSA','BAUGHMAN','1 MEDICAL DR','','LEBANON','NH','37561000','','','','53','','2','','','','','','','','','','','',''}
  ],
  TestRec
);

OUTPUT(TestData,, '~dev::appendnpiattributes::appendnpiattributes::input', OVERWRITE);