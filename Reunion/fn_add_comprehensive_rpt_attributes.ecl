import Doxie;

EXPORT fn_add_comprehensive_rpt_attributes(DATASET(reunion.layouts.lMainRaw) input) := FUNCTION

    kD2C := pull(Doxie.key_D2C_lookup());
	
	input append_attributes(input le, kD2C re) := TRANSFORM	
		self.did := le.did;
		SELF.addresses_cnt	:= (STRING3)re.addresses_cnt;
		SELF.PhonesPlus_cnt := (STRING3)re.PhonesPlus_cnt;
		SELF.Email_cnt 		:= (STRING3)re.Email_cnt;
		SELF.Possible_Properties_owned_cnt := (STRING3)re.Possible_Properties_owned_cnt;
		SELF.Education_Student_cnt 	:= (STRING3)re.Education_Student_cnt;
		SELF.Criminal_Records_cnt 	:= (STRING3)re.Criminal_Records_cnt;
		SELF.Sexual_Offenses_cnt 	:= (STRING3)re.Sexual_Offenses_cnt;
		SELF.Liens_and_Judgements_cnt := (STRING3)re.Liens_and_Judgements_cnt;
		SELF.Bankruptcies_cnt 		  := (STRING3)re.Bankruptcies_cnt;
		SELF.Marriage_and_Divorce_cnt := (STRING3)re.Marriage_and_Divorce_cnt;
		SELF.Professional_Licenses_cnt:= (STRING3)re.Professional_Licenses_cnt;
		SELF.People_at_Work_possible_employment_records_cnt := (STRING3)re.People_at_Work_possible_employment_records_cnt;
		SELF.Businesses_records_cnt := (STRING3)re.Businesses_records_cnt;
		SELF.Corporate_affiliations_cnt 	:= (STRING3)re.Corporate_affiliations_cnt;
		SELF.UCC_cnt 						:= (STRING3)re.UCC_cnt;
		SELF.Hunting_and_Fishing_Permits_cnt:= (STRING3)re.Hunting_and_Fishing_Permits_cnt;
		SELF.Concealed_Weapon_Permits_cnt 	:= (STRING3)re.Concealed_Weapon_Permits_cnt;
		SELF.Firearms_and_Explosives_cnt 	:= (STRING3)re.Firearms_and_Explosives_cnt;
		SELF.FAA_Aircraft_cnt 				:= (STRING3)re.FAA_Aircraft_cnt;
		SELF.FAA_Pilot_cnt 					:= (STRING3)re.FAA_Pilot_cnt;
		// SELF := re;
		SELF := le;
	END;

	result := JOIN(distribute(input, hash(did)), distribute(kD2C, hash(did)), 
				LEFT.did = RIGHT.did,
				append_attributes(LEFT,RIGHT), LEFT OUTER, LOCAL);
	
	return result;

END;