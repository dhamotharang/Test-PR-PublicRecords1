IMPORT Death_Master, 
						 address, 
						 ut;
						 
Shared rec_tmp:=record
unsigned seq:=0;
recordof(Death_Master.File_TexasDeath_Data.File_TexasDeath_Base_FIPScode);
end;

Shared file_in:=project(Death_Master.File_TexasDeath_Data.File_TexasDeath_Base_FIPScode,rec_tmp);
ut.MAC_Sequence_Records(file_in,seq,file_out);						 

Layout_DeathMaster_Texas_Supplement := Record
		string8 PROCESS_DATE;
		string2 SOURCE_STATE;
		string3 CERTIFICATE_VOL_NO;
		string4 CERTIFICATE_VOL_YEAR;
		string28 PUBLICATION;
		string44 DECEDENT_NAME;
		string93 DECEDENT_RACE;
		string69 DECEDENT_ORIGIN;
		string12 DECEDENT_SEX;
		string34 DECEDENT_AGE;
		string26 EDUCATION;
		string74 OCCUPATION;
		string62 WHERE_WORKED;
		string289 CAUSE;
		string9 SSN;
		string8 DOB;
		string8 DOD;
		string35 BIRTHPLACE;
		string38 MARITAL_STATUS;
		string44 FATHER;
		string44 MOTHER;
		string8 FILED_DATE;
		string4 YEAR;
		string77 COUNTY_RESIDENCE;
		string23 COUNTY_DEATH;
		string76 ADDRESS;
		string7 AUTOPSY;
		string44 AUTOPSY_FINDINGS;
		string4 PRIMARY_CAUSE_OF_DEATH;
		string50 UNDERLYING_CAUSE_OF_DEATH;
		string3 MED_EXAM;
		string6 EST_LIC_NO;
		string22 DISPOSITION;
		string8 DISPOSITION_DATE;
		string9 WORK_INJURY;
		string8 INJURY_DATE;
		string23 INJURY_TYPE;
		string50 INJURY_LOCATION;
		string7 SURG_PERFORMED;
		string8 SURGERY_DATE;
		string120 HOSPITAL_STATUS;
		string14 PREGNANCY;
		string70 FACILITY_DEATH;
		string6 EMBALMER_LIC_NO;
		string21 DEATH_TYPE;
		string5 TIME_DEATH;
		string12 BIRTH_CERT;
		string31 CERTIFIER;
		string20 CERT_NUMBER;
		string4 BIRTH_VOL_YEAR;
		string5 LOCAL_FILE_NO;
		string39 VDI;
		string28 CITE_ID;
		string5 FILE_ID;
		string8 DATE_LAST_TRANS;
		string1 AMENDMENT_CODE;
		string2 AMENDMENT_YEAR;
		string10 _ON_LEXIS;
		string9 _FS_PROFILE;
		string3 US_ARMED_FORCES;
		string49 PLACE_OF_DEATH;
		string16 state_death_id;
		string1 state_death_flag;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string3 name_score;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 p_city_name;
		string25 v_city_name;
		string2 state;
		string5 zip5;
		string4 zip4;
		string4 cart;
		string1 cr_sort_sz;
		string4 lot;
		string1 lot_order;
		string2 dpbc;
		string1 chk_digit;
		string2 rec_type;
		string2 fips_state;
		string3 fips_county;
		string10 geo_lat;
		string11 geo_long;
		string4 msa;
		string7 geo_blk;
		string1 geo_match;
		string4 err_stat;
		string1 lf;
End;

Layout_DeathMaster_Texas_Supplement tDeathMaster_Texas_Data_Supplement(file_out pInput) := Transform
		Self.PROCESS_DATE  :=  '20100930';
		Self.SOURCE_STATE  :=  pInput.RECORD_SRC;
		Self.CERTIFICATE_VOL_NO  :=  pInput.VOL_NUMB;
		Self.DECEDENT_RACE  :=  pInput.RACE;
		Self.DECEDENT_SEX  := If(pInput.GENDER = 'M', 'MALE', If(pInput.GENDER = 'F', 'FEMALE', ''));
		Self.SSN  :=  pInput.SSN;
		Self.DOB  :=  pInput.DOB[5..8]+pInput.DOB[1..4];
		Self.DOD  :=  pInput.DOD[5..8]+pInput.DOD[1..4];
		Self.MARITAL_STATUS  :=  pInput.MARITAL_STS;
		Self.COUNTY_DEATH  :=  pInput.COUNTY;
		Self.CERT_NUMBER  :=  pInput.CERTIF_NUM;
		Self.fname  :=  if(pInput.FIRST_NAME in ['UNIDENTIFIED MALE','UNKNOWN INDIVIDUAL','UNKNOWN'],'',pInput.FIRST_NAME);
		Self.mname  :=  pInput.MID_NAME;
		Self.lname  :=  if(pInput.LAST_NAME in ['UNIDENTIFIED MALE','UNKNOWN INDIVIDUAL','UNKNOWN'],'',pInput.LAST_NAME);
		Self.name_suffix  :=  pInput.SUFFIX;
		Self.state  :=  'TX';
		Self.zip5  :=  pInput.ZIP_LAST_RES;
		Self.fips_county := pInput.FipsCounty;
		Self.state_death_id := 'T'+thorlib.wuid()[2..7]+ thorlib.wuid()[11..12]+intformat(pInput.seq,7,1);
		Self.state_death_flag := 'Y';
		Self := [];
End;


pDeathMaster_Texas_Data_Supplement := Project(file_out, tDeathMaster_Texas_Data_Supplement(Left));

Tx_death_SupplementDist := distribute(pDeathMaster_Texas_Data_Supplement(~(fname = '' and lname = '')), Hash(fname,lname,DOD,DOB,zip5)); 
Tx_death_SupplementDistSrt  := Sort(Tx_death_SupplementDist,fname,lname,DOD,DOB,zip5,Local);
Tx_death_SupplementDistSrtDedup := dedup(Tx_death_SupplementDistSrt, fname,lname,DOD,DOB,zip5, local );


// output(Tx_death_SupplementDistSrtDedup,,'~thor_data400::Base::Death_Master_Texas_Supplement_20100930');

export map_Tx_death_Plus_initial := dataset('~thor_data400::Base::Death_Master_Texas_Plus_20100930', Layout_DeathMaster_Texas_Plus, thor);
