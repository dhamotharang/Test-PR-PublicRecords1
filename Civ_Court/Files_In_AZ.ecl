IMPORT Civ_Court, ut,  Data_Services;

EXPORT Files_In_AZ := MODULE

	EXPORT CS	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::az_civil',Civ_Court.Layouts_In_AZ.CS_in,csv(heading(0), separator('|')));
	EXPORT CS_Party	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::az_party',Civ_Court.Layouts_In_AZ.Party_in,csv(heading(0), separator('|')));
	EXPORT CS_Address	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::az_address',Civ_Court.Layouts_In_AZ.Addr_In,csv(heading(0), separator('|')));
	EXPORT CS_Event	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::az_event',Civ_Court.Layouts_In_AZ.Event_In,csv(heading(0), separator('|')));
	
//Join CS, Party, and Address files
Civ_Court.Layouts_In_AZ.Civil_In xCivilPrty(CS L, CS_Party R) := TRANSFORM
		self.case_id							:= IF(L.case_id <> '',ut.CleanSpacesAndUpper(L.case_id),ut.CleanSpacesAndUpper(R.case_id));
		self.court_id							:= IF(L.court_id <> '',ut.CleanSpacesAndUpper(L.court_id),ut.CleanSpacesAndUpper(R.court_id));
		self.full_case_num				:= IF(L.full_case_num <> '',ut.CleanSpacesAndUpper(L.full_case_num),ut.CleanSpacesAndUpper(R.full_case_num));
		self.case_title						:= ut.CleanSpacesAndUpper(L.case_title);
		self.judicial_officer_name	:= ut.CleanSpacesAndUpper(L.judicial_officer_name);
		self.filing_date					:= trim(L.filing_date,left,right);
		self.disposition_date			:= trim(L.disposition_date,left,right);
		self.case_category				:= ut.CleanSpacesAndUpper(L.case_category);
		self.prty_id							:= ut.CleanSpacesAndUpper(R.prty_id);
		self.source_system_prty_type_parta	:= ut.CleanSpacesAndUpper(R.source_system_prty_type_parta);
		self.source_system_prty_description	:= ut.CleanSpacesAndUpper(R.source_system_prty_description);
		self.party_court_id					:= ut.CleanSpacesAndUpper(R.court_id);
		self.party_case_search_key	:= ut.CleanSpacesAndUpper(R.case_search_key);
		self.party_prty_name				:= ut.CleanSpacesAndUpper(R.prty_name);
		self.party_birth_date				:= ut.CleanSpacesAndUpper(R.birth_date);
		self.party_city							:= ut.CleanSpacesAndUpper(R.city);
		self.party_state						:= ut.CleanSpacesAndUpper(R.state);
		self.party_zip							:= ut.CleanSpacesAndUpper(R.zip);
		self.party_full_case_num		:= ut.CleanSpacesAndUpper(R.full_case_num);
		self.party_f_name						:= ut.CleanSpacesAndUpper(R.f_name);
		self.party_l_name						:= ut.CleanSpacesAndUpper(R.l_name);
		self.prty_search_key				:= ut.CleanSpacesAndUpper(R.prty_search_key);
		self.prty_gender						:= ut.CleanSpacesAndUpper(R.prty_gender);
		self.party_state_id					:= ut.CleanSpacesAndUpper(R.state_id);
		self.prty_origin						:= ut.CleanSpacesAndUpper(R.prty_origin);
		self.Address_1	:= '';
		self.Address_2	:= '';
		self.city				:= '';
		self.state			:= '';
		self.zip				:= '';
		self.country		:= '';
		self.phone			:= '';
	END;
	
	j_CivPrty		:= join(sort(distribute(CS,hash(full_case_num)),full_case_num,local),
											sort(distribute(CS_Party(trim(prty_name) <> 'DO NOT USE NONE'),hash(full_case_num)),full_case_num,local),
											trim(left.full_case_num,all) = trim(right.full_case_num,all),
											xCivilPrty(left,right),full outer,local);
											
//Join with address
	Civ_Court.Layouts_In_AZ.Civil_In xPrtyAddr(j_CivPrty L, CS_Address R) := TRANSFORM
		self.Address_1	:= ut.CleanSpacesAndUpper(R.Address_1);
		self.Address_2	:= ut.CleanSpacesAndUpper(R.Address_2);
		self.city				:= ut.CleanSpacesAndUpper(R.city);
		self.state			:= ut.CleanSpacesAndUpper(R.state);
		self.zip				:= ut.CleanSpacesAndUpper(R.zip);
		self.country		:= ut.CleanSpacesAndUpper(R.country);
		self.phone			:= ut.CleanSpacesAndUpper(R.phone);
		self	:= L;
	END;
	
j_PartyAddr	:= join(sort(distribute(j_CivPrty(case_category = 'CIVIL'),hash(case_id, prty_id)),case_id, prty_id,local),
										sort(distribute(CS_Address,hash(case_id, prty_id)),case_id, prty_id,local),
										trim(left.case_id,all) = trim(right.case_id,all) and
										trim(left.prty_id,all) = trim(right.prty_id,all),
										xPrtyAddr(left,right), left outer, local);
										
EXPORT Civil_in := dedup(j_PartyAddr); 
	
END;
