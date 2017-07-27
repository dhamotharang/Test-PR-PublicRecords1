#workunit ('name', 'Query FBN Stats ' + FBN.FBN_Build_Date);

Valid_Name_Types := ['B',  // Business
                     'O',  // Owner
                     'R',  // Agent/Registrant
                     'A',  // Agent
                     'L',  // Alias
                     'F',  // Officer
                     'W'   // Owner/Agent
];

Valid_Name_Codes := ['1', // One name field
                     '2'  // (parsed) format is First Middle Last Suffix
];

Layout_FBN_Slim := RECORD
STRING2  file_st;
STRING1  record_cd;
STRING6  contrib_no;
STRING4  business_cat;
STRING20 name_adr_id;
STRING20 filing_num;
STRING1  name_cd;
STRING50 display_name;
STRING15 location_cd;
STRING20 job_no;
STRING8  insert_dt;
STRING1  disp_cd;
STRING8  filing_dt;
STRING1  name_typ;
STRING11 fed_tax_id;
STRING20 phone;
STRING60 street;
STRING30 city;
STRING20 orig_state;
STRING30 country;
STRING10 orig_zip;
STRING2  business_type;
STRING2  form_type;
STRING1  expiration_cd;
STRING8  expiration_dt;
END;

Layout_FBN_Slim InitFBN(FBN.Layout_FBN L) := TRANSFORM
SELF := L;
END;

FBN_Init := PROJECT(FBN.File_FBN, InitFBN(LEFT));

Layout_FBN_Stat := record
FBN_Init.file_st;

INTEGER4 record_cd_Count := SUM(GROUP, IF(FBN_Init.record_cd<>'',1,0));
INTEGER4 record_cd_Blank := SUM(GROUP, IF(FBN_Init.record_cd='',1,0));

INTEGER4 contrib_no_Count := SUM(GROUP, IF(FBN_Init.contrib_no<>'',1,0));
INTEGER4 contrib_no_Blank := SUM(GROUP, IF(FBN_Init.contrib_no='',1,0));

INTEGER4 business_cat_Count := SUM(GROUP, IF(FBN_Init.business_cat<>'',1,0));
INTEGER4 business_cat_Blank := SUM(GROUP, IF(FBN_Init.business_cat='',1,0));

INTEGER4 name_adr_id_Count := SUM(GROUP, IF(FBN_Init.name_adr_id>'',1,0));
INTEGER4 name_adr_id_Blank := SUM(GROUP, IF(FBN_Init.name_adr_id='',1,0));

INTEGER4 filing_num_Count := SUM(GROUP, IF(FBN_Init.filing_num<>'',1,0));
INTEGER4 filing_num_Blank := SUM(GROUP, IF(FBN_Init.filing_num='',1,0));

INTEGER4 name_cd_Count := SUM(GROUP, IF(FBN_Init.name_cd<>'',1,0));
INTEGER4 name_cd_1 := SUM(GROUP, IF(FBN_Init.name_cd='1',1,0));
INTEGER4 name_cd_2 := SUM(GROUP, IF(FBN_Init.name_cd='2',1,0));
INTEGER4 name_cd_Other := SUM(GROUP, IF(FBN_Init.name_cd<>'' AND FBN_Init.name_cd NOT IN Valid_Name_Codes,1,0));
INTEGER4 name_cd_Blank := SUM(GROUP, IF(FBN_Init.name_cd='',1,0));

INTEGER4 display_name_Count := SUM(GROUP, IF(FBN_Init.display_name<>'',1,0));
INTEGER4 display_name_Blank := SUM(GROUP, IF(FBN_Init.display_name='',1,0));

INTEGER4 location_cd_Count := SUM(GROUP, IF(FBN_Init.location_cd<>'',1,0));
INTEGER4 location_cd_Blank := SUM(GROUP, IF(FBN_Init.location_cd='',1,0));

INTEGER4 job_no_Count := SUM(GROUP, IF(FBN_Init.job_no<>'',1,0));
INTEGER4 job_no_Blank := SUM(GROUP, IF(FBN_Init.job_no='',1,0));

INTEGER4 insert_dt_Count := SUM(GROUP, IF(FBN_Init.insert_dt<>'',1,0));
INTEGER4 insert_dt_Blank := SUM(GROUP, IF(FBN_Init.insert_dt='',1,0));

INTEGER4 disp_cd_Count := SUM(GROUP, IF(FBN_Init.disp_cd<>'',1,0));
INTEGER4 disp_cd_Blank := SUM(GROUP, IF(FBN_Init.disp_cd='',1,0));

INTEGER4 filing_dt_Count := SUM(GROUP, IF(FBN_Init.filing_dt<>'',1,0));
INTEGER4 filing_dt_Blank := SUM(GROUP, IF(FBN_Init.filing_dt='',1,0));

INTEGER4 name_typ_Count := SUM(GROUP, IF(FBN_Init.name_typ<>'',1,0));
INTEGER4 name_typ_B := SUM(GROUP, IF(FBN_Init.name_typ='B',1,0));
INTEGER4 name_typ_O := SUM(GROUP, IF(FBN_Init.name_typ='O',1,0));
INTEGER4 name_typ_R := SUM(GROUP, IF(FBN_Init.name_typ='R',1,0));
INTEGER4 name_typ_A := SUM(GROUP, IF(FBN_Init.name_typ='A',1,0));
INTEGER4 name_typ_L := SUM(GROUP, IF(FBN_Init.name_typ='L',1,0));
INTEGER4 name_typ_F := SUM(GROUP, IF(FBN_Init.name_typ='F',1,0));
INTEGER4 name_tye_W := SUM(GROUP, IF(FBN_Init.name_typ='W',1,0));
INTEGER4 name_typ_Other := SUM(GROUP, IF(FBN_Init.name_typ<>'' AND FBN_Init.name_typ NOT IN Valid_Name_Types,1,0));
INTEGER4 name_typ_Blank := SUM(GROUP, IF(FBN_Init.name_typ='',1,0));

INTEGER4 fed_tax_id_Count := SUM(GROUP, IF(FBN_Init.fed_tax_id<>'',1,0));
INTEGER4 fed_tax_id_Blank := SUM(GROUP, IF(FBN_Init.fed_tax_id='',1,0));

INTEGER4 phone_Count := SUM(GROUP, IF(FBN_Init.phone<>'',1,0));
INTEGER4 phone_Blank := SUM(GROUP, IF(FBN_Init.phone='',1,0));

INTEGER4 street_Count := SUM(GROUP, IF(FBN_Init.street<>'',1,0));
INTEGER4 street_Blank := SUM(GROUP, IF(FBN_Init.street='',1,0));

INTEGER4 City_Count := SUM(GROUP, IF(FBN_Init.City<>'',1,0));
INTEGER4 City_Blank := SUM(GROUP, IF(FBN_Init.City='',1,0));

INTEGER4 orig_state_Count := SUM(GROUP, IF(FBN_Init.orig_state<>'',1,0));
INTEGER4 orig_state_Blank := SUM(GROUP, IF(FBN_Init.orig_state='',1,0));

INTEGER4 country_Count := SUM(GROUP, IF(FBN_Init.country<>'',1,0));
INTEGER4 country_Blank := SUM(GROUP, IF(FBN_Init.country='',1,0));

INTEGER4 orig_zip_Count := SUM(GROUP, IF(FBN_Init.orig_zip<>'',1,0));
INTEGER4 orig_zip_Blank := SUM(GROUP, IF(FBN_Init.orig_zip='',1,0));

INTEGER4 business_type_Count := SUM(GROUP, IF(FBN_Init.business_type<>'',1,0));
INTEGER4 business_type_Blank := SUM(GROUP, IF(FBN_Init.business_type='',1,0));

INTEGER4 form_type_Count := SUM(GROUP, IF(FBN_Init.form_type<>'',1,0));
INTEGER4 form_type_Blank := SUM(GROUP, IF(FBN_Init.form_type='',1,0));

INTEGER4 expiration_cd_Count := SUM(GROUP, IF(FBN_Init.expiration_cd<>'',1,0));
INTEGER4 expiration_cd_Blank := SUM(GROUP, IF(FBN_Init.expiration_cd='',1,0));

INTEGER4 expiration_dt_Count := SUM(GROUP, IF(FBN_Init.expiration_dt<>'',1,0));
INTEGER4 expiration_dt_Blank := SUM(GROUP, IF(FBN_Init.expiration_dt='',1,0));

INTEGER4 Total:= COUNT(GROUP);
END;

FBN_Stat := TABLE(FBN_Init, Layout_FBN_Stat, file_st, FEW);

count(FBN.File_FBN(did > 0));

OUTPUT(FBN_Stat);