import CrimSrch, lib_stringlib;

integer2 fParenPosition(string pInputString)
 := lib_stringlib.stringlib.stringfind(pInputString,'(',1);

string4 f4DigitsAfterParen(string pInputString)
 := if(fParenPosition(pInputString)<>0,
	   pInputString[(fParenPosition(pInputString)+1)..(fParenPosition(pInputString)+4)],
	   '');

string8 fYearExtractToDate(string pInputString)
 := if((integer2)f4DigitsAfterParen(pInputString) >= 1900 and (integer2)f4DigitsAfterParen(pInputString) <= 2099,
	   f4DigitsAfterParen(pInputString) + '0101',
	   '');

	crimsrch.Layout_Moxie_Offenses_temp tNormalizeSexPred2asOffenses(Layout_Sex_Pred_2 pInput, unsigned pCounter) := transform
		self.date_first_reported		:= pInput.dt_last_reported;
		self.date_last_reported			:= pInput.dt_last_reported;
		self.offender_key				:= pInput.seisint_primary_key;
		self.vendor						:= pInput.vendor_code;
		self.state_of_origin			:= pInput.state_of_origin;
		self.source_file				:= pInput.source_file;
		self.off_name					:= pInput.name_orig;
		self.le_agency_desc				:= pInput.police_agency;
		self.le_agency_code				:= '';
		self.le_agency_case_number		:= '';
		self.traffic_ticket_number		:= '';
		self.court_code					:= '';
		self.court_final_plea			:= '';
		self.court_off_code				:= '';
		self.court_off_desc				:= '';
		self.court_off_level			:= '';
		self.court_statute				:= '';
		self.court_statute_desc			:= '';
		self.arrest_date				:= '';
		self.arrest_off_code			:= '';
		self.arrest_off_desc			:= '';
		self.arrest_off_level			:= '';
		self.arrest_off_statute			:= '';
		self.arrest_statute_desc		:= '';
		self.arrest_disp_date			:= '';
		self.arrest_disp_desc			:= '';
		self.court_disp_date			:= '';
		self.court_disp_code			:= '';
		self.court_disp_desc			:= '';
		self.sent_date					:= '';
		self.sent_code					:= '';
		self.sent_comp					:= '';
		self.sent_desc_3				:= '';
		self.sent_desc_4				:= '';
		self.inc_adm_date				:= '';
		self.conv_county_code			:= '';
		self.off_type					:= '';
		self.off_level					:= '';
		self.charge						:= '';
		self.counts						:= '';
		self.case_number				:= choose(pCounter,pInput.court_case_number_1,pInput.court_case_number_2,pInput.court_case_number_3,pInput.court_case_number_4,pInput.court_case_number_5);
		self.orig_offense_key			:= trim(pInput.seisint_primary_key) + choose(pCounter,pInput.court_case_number_1,pInput.court_case_number_2,pInput.court_case_number_3,pInput.court_case_number_4,pInput.court_case_number_5);
		self.fcra_offense_key			:= trim(pInput.seisint_primary_key) + choose(pCounter,pInput.court_case_number_1,pInput.court_case_number_2,pInput.court_case_number_3,pInput.court_case_number_4,pInput.court_case_number_5);
		self.conv_date					:= choose(pCounter,pInput.conviction_date_1,pInput.conviction_date_2,pInput.conviction_date_3,pInput.conviction_date_4,pInput.conviction_date_5);
		self.court_desc					:= choose(pCounter,pInput.court_1,pInput.court_2,pInput.court_3,pInput.court_4,pInput.court_5);
		self.conv_county				:= choose(pCounter,pInput.conviction_jurisdiction_1,pInput.conviction_jurisdiction_2,pInput.conviction_jurisdiction_3,pInput.conviction_jurisdiction_4,pInput.conviction_jurisdiction_5);
		self.sent_desc_1				:= choose(pCounter,pInput.sentence_description_1,pInput.sentence_description_2,pInput.sentence_description_3,pInput.sentence_description_4,pInput.sentence_description_5);
		self.sent_desc_2				:= choose(pCounter,pInput.sentence_description_1_2,pInput.sentence_description_2_2,pInput.sentence_description_3_2,pInput.sentence_description_4_2,pInput.sentence_description_5_2);
		self.off_date					:= choose(pCounter,pInput.offense_date_1,pInput.offense_date_2,pInput.offense_date_3,pInput.offense_date_4,pInput.offense_date_5);
		self.off_code					:= choose(pCounter,pInput.offense_code_or_statute_1,pInput.offense_code_or_statute_2,pInput.offense_code_or_statute_3,pInput.offense_code_or_statute_4,pInput.offense_code_or_statute_5);
		self.off_desc_1					:= choose(pCounter,pInput.offense_description_1,pInput.offense_description_2,pInput.offense_description_3,pInput.offense_description_4,pInput.offense_description_5);
		self.off_desc_2					:= choose(pCounter,pInput.offense_description_1_2,pInput.offense_description_2_2,pInput.offense_description_3_2,pInput.offense_description_4_2,pInput.offense_description_5_2);
		self.sor_off_victim_minor		:= choose(pCounter,pInput.victim_minor_1,pInput.victim_minor_2,pInput.victim_minor_3,pInput.victim_minor_4,pInput.victim_minor_5);
		self.sor_off_victim_age			:= choose(pCounter,pInput.victim_age_1,pInput.victim_age_2,pInput.victim_age_3,pInput.victim_age_4,pInput.victim_age_5);
		self.sor_off_victim_gender		:= choose(pCounter,pInput.victim_gender_1,pInput.victim_gender_2,pInput.victim_gender_3,pInput.victim_gender_4,pInput.victim_gender_5);
		self.sor_off_victim_relationship:= choose(pCounter,pInput.vicition_relationship_1,pInput.vicition_relationship_2,pInput.vicition_relationship_3,pInput.vicition_relationship_4,pInput.vicition_relationship_5);
		self.fcra_conviction_flag		:= 'Y';
		self.fcra_traffic_flag			:= 'N';
		self.fcra_date					:= pInput.dt_last_reported;
		self.fcra_date_type				:= 'R';
		self.conviction_override_date		:= if((integer4)self.conv_date<>0,
												  self.conv_date,
												  if(pInput.state_of_origin='CO',
													 fYearExtractToDate(self.off_desc_1),
													 ''
													)
												 );
		self.conviction_override_date_type	:= 'C';
		self.offense_score					:= 'S';
		self := pInput;
		self.process_date						:= self.date_last_reported;
		self := [];
	end;

dSexOffensesNorm		:= normalize(File_Sex_Pred_2,5,tNormalizeSexPred2asOffenses(left,Counter));
dSexOffensesNormFilled	:= dSexOffensesNorm(trim(off_code+off_desc_1+off_date+case_number)<>'');

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
	export Sex_Pred_2_as_CrimSrch_Offenses := dSexOffensesNormFilled : persist('persist::Sex_Pred_2_as_CrimSrch_Offenses');
#else
	export Sex_Pred_2_as_CrimSrch_Offenses := dSexOffensesNormFilled;
#end