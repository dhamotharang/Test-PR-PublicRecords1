IMPORT Death_Master, 
						 address, 
						 ut;

rec_tmp:=record
unsigned seq:=0;
recordof(Death_Master.File_TexasDeath_Data.File_TexasDeath_Base_FIPScode);
end;

Shared file_in:=project(Death_Master.File_TexasDeath_Data.File_TexasDeath_Base_FIPScode,rec_tmp);
ut.MAC_Sequence_Records(file_in,seq,file_out);
Layout_DeathMaster_Texas_Plus := Record
string8 filedate;
string1 rec_type;
string1 rec_type_orig;
string9 ssn;
string20 lname;
string5 name_suffix;
string20 fname;
string20 mname;
string1 VorP_code;
string8 dod8;
string8 dob8;
string2 st_country_code;
string5 zip_lastres;
string5 zip_lastpayment;
string2 state;
string3 fipscounty;
string5 clean_title;
string20 clean_fname;
string20 clean_mname;
string20 clean_lname;
string5 clean_name_suffix;
string3 clean_name_score;
string16 state_death_id;
string1 state_death_flag;
string2 crlf;
End; 

Layout_DeathMaster_Texas_Plus tDeathMaster_Texas_Data(file_out pInput) := Transform
String73 clean_name  := address.CleanPersonFML73(TRIM(TRIM(pInput.FIRST_NAME)+' '+TRIM(pInput.MID_NAME)+' '+TRIM(pInput.LAST_NAME)));
self.clean_title := clean_name[1..5];
self.clean_fname := clean_name[6..25];
self.clean_mname := clean_name[26..45];
self.clean_lname := clean_name[46..65];
self.clean_name_suffix:= clean_name[66..70];
self.clean_name_score := clean_name[71..73];

Self.filedate := '20100930';
Self.ssn  := pInput.SSN;
Self.name_suffix  := pInput.SUFFIX;
Self.fname  :=  if(pInput.FIRST_NAME in ['UNIDENTIFIED MALE','UNKNOWN INDIVIDUAL','UNKNOWN'],'',pInput.FIRST_NAME);
Self.mname  := pInput.MID_NAME;
Self.lname  :=  if(pInput.LAST_NAME in ['UNIDENTIFIED MALE','UNKNOWN INDIVIDUAL','UNKNOWN'],'',pInput.LAST_NAME);	
Self.dod8  := pInput.DOD[5..8]+pInput.DOD[1..4];
Self.dob8  := pInput.DOB[5..8]+pInput.DOB[1..4];
Self.State := 'TX';
Self.fipscounty := pInput.FipsCounty;
Self.st_country_code  := pInput.STATE_CTRY;
Self.zip_lastres  := pInput.ZIP_LAST_RES;
Self.zip_lastpayment  := pInput.ZIP_PAYMENT;
Self.state_death_flag := 'Y';
Self.state_death_id := 'T'+thorlib.wuid()[2..7]+ thorlib.wuid()[11..12]+intformat(pInput.seq,7,1);
Self := [];
End;

pDeathMaster_Texas_Data_Plus := Project(file_out, tDeathMaster_Texas_Data(Left));

Tx_death_PlusDist := distribute(pDeathMaster_Texas_Data_Plus(~(fname = '' and lname = '')), Hash(fname,lname,DOD8,DOB8,zip_lastres)); 
Tx_death_PlusDistSrt  := Sort(Tx_death_PlusDist,fname,lname,DOD8,DOB8,zip_lastres,Local);
Tx_death_PlusDistSrtDedup := dedup(Tx_death_PlusDistSrt, fname,lname,DOD8,DOB8,zip_lastres, local );

// output(Tx_death_PlusDistSrtDedup,,'~thor_data400::Base::Death_Master_Texas_Plus_20100930');

export map_Tx_death_Plus_initial := dataset('~thor_data400::Base::Death_Master_Texas_Plus_20100930', Layout_DeathMaster_Texas_Plus, thor);