IMPORT Civ_Court, ut,  Data_Services;  

EXPORT Files_In_IA := MODULE

	EXPORT raw_party	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ia_party',Civ_Court.Layouts_In_IA.Party_in, flat);
	EXPORT raw_peopleIndx	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ia_crim_cpi',Civ_Court.Layouts_In_IA.PeopleIndx_in, flat);
	EXPORT raw_crim_case	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ia_crim',Civ_Court.Layouts_In_IA.Crim_Case_in, flat);
	EXPORT raw_jdmt_atty	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ia_jdmt_atty',Civ_Court.Layouts_In_IA.Judgmt_Atty_in,flat);
	EXPORT raw_chg		:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ia_crim_chg',Civ_Court.Layouts_In_IA.Crim_Charge_in,flat); //used only for filtering records
	
	//Join files to produce a single input file for all mappings
	//Join party file and people index to find DOB if available
	Civ_Court.Layouts_In_IA.Civil_join xPartyPI(raw_party L, raw_peopleIndx R) := TRANSFORM
		self.case_number			:= ut.CleanSpacesAndUpper(L.case_number);
		self.file_date				:= trim(L.file_date,left,right);
		self.filed_seq				:= trim(L.filed_seq);
		self.judmt_indicator	:= ut.CleanSpacesAndUpper(L.judmt_indicator);
		self.people_role_code	:= ut.CleanSpacesAndUpper(L.people_role_code);
		self.people_status		:= ut.CleanSpacesAndUpper(L.people_status);
		self.people_id				:= ut.CleanSpacesAndUpper(L.people_id);
		self.last_name				:= ut.CleanSpacesAndUpper(L.last_name);
		self.first_name				:= ut.CleanSpacesAndUpper(L.first_name);
		self.middle_name			:= ut.CleanSpacesAndUpper(L.middle_name);
		self.birth_date				:= trim(R.birth_date,left,right);
		self := [];
	END;
	
	ded_party	:= dedup(sort(raw_party(trim(last_name)<>'STATE OF IOWA'),case_number,last_name, first_name, middle_name));
	dedPI			:= dedup(sort(raw_peopleIndx,case_number,last_name, first_name, middle_name));
	
	jPartyPI	:= join(sort(distribute(ded_party,hash(case_number)),case_number,last_name, first_name, people_role_code,local),
										sort(distribute(dedPI,hash(case_number)),case_number,last_name, first_name, people_role_code,local),
										trim(left.case_number,all) = trim(right.case_number,all) and
										trim(left.people_role_code,all) = trim(right.people_role_code,all) and
										trim(left.last_name,all) = trim(right.last_name,all) and
										trim(left.first_name,all) = trim(right.first_name,all),
										xPartyPI(left,right),left outer,local);									
										
	//Join party to charge - Keep records where charge_desc = ''
	Civ_Court.Layouts_In_IA.Civil_join xPartyChg(jPartyPI L, raw_chg R) := TRANSFORM
		self.charge_desc	:= R.charge_desc;
		self := L;
		self := [];
	END;
	
	jPartyChg	:= join(sort(distribute(jPartyPI,hash(case_number)),case_number,local),
										sort(distribute(raw_chg,hash(case_number)),case_number,local),
										trim(left.case_number,all) = trim(right.case_number,all),
										xPartyChg(left,right),left outer,local);
		
	//Join Party with crim_case to populate initiated_date and case_title
	Civ_Court.Layouts_In_IA.Civil_join xPartyCase(jPartyChg L, raw_crim_case R) := TRANSFORM
		self.case_initiated_date	:= ut.CleanSpacesAndUpper(R.case_initiated_date);
		self.case_title						:= ut.CleanSpacesAndUpper(R.case_title);
		self	:= L;
	END;
	
	jPartyCase	:= join(sort(distribute(jPartyChg(charge_desc = ''),hash(case_number)),case_number,local),
											sort(distribute(raw_crim_case,hash(case_number)),case_number,local),
											trim(left.case_number,all) = trim(right.case_number,all),
											xPartyCase(left,right),left outer,local);
	
	EXPORT Civil_in	:= jPartyCase;
	
END;		