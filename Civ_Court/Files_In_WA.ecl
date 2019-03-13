IMPORT Civ_Court, ut,  Data_Services;

EXPORT Files_In_WA := MODULE

	//Lookup files
	EXPORT cause_desc	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_case_cause_lkp',Civ_Court.Layouts_In_WA.cause_code_lkp,flat);
	EXPORT case_desc	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_case_disposition_lkp',Civ_Court.Layouts_In_WA.case_disp_lkp,flat);
	EXPORT court_desc	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_court_lkp',Civ_Court.Layouts_In_WA.court_code_lkp,flat);
	EXPORT judgement_disp	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_judgment_disposition_lkp',Civ_Court.Layouts_In_WA.judgement_disp_lkp,flat);
	EXPORT judgement_type	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_judgment_type_lkp',Civ_Court.Layouts_In_WA.judgement_type_lkp,flat);
	EXPORT participant_type	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_participant_type_lkp',Civ_Court.Layouts_In_WA.participant_type_lkp,flat);
	
	//Main files
	EXPORT Civil_in	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_civil',Civ_Court.Layouts_In_WA.Civil,flat);
	EXPORT Jud_in		:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_civil_jud',Civ_Court.Layouts_In_WA.Jud_Rec,flat);
	EXPORT Par_in		:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_civil_par',Civ_Court.Layouts_In_WA.Par_Rec,flat);
	//VC - DF-23245
	EXPORT Civ_sealed_in := dataset(Data_Services.foreign_prod +'thor_data400::in::civil::wa_civil_sealed' ,Civ_Court.Layouts_In_WA.sealed_rec,FLAT);	
  EXPORT Civ_NoSealed    := join(Civil_in,Civ_sealed_in,
                                     left.dist_mncp_court_code =right.courtid and 
                                     left.case_number = right.casenumber and 
																		 left.case_type = right.casetype,
																		 left only);
																		 
	//Join Civil and Judment Record
	Civ_Court.Layouts_In_WA.Civ_Jud xfrmJud(Jud_in L, Civ_NoSealed R)	:= TRANSFORM
		self.dist_mncp_court_code				:= ut.CleanSpacesAndUpper(L.dist_mncp_court_code);
		self.case_type									:= ut.CleanSpacesAndUpper(L.case_type);
		self.case_number								:= ut.CleanSpacesAndUpper(L.case_number);
		self.judgement_type_code				:= ut.CleanSpacesAndUpper(L.judgement_type_code);
		self.judgement_date							:= ut.CleanSpacesAndUpper(L.judgement_date);
		self.judgement_disposition_code	:= ut.CleanSpacesAndUpper(L.judgement_disposition_code);
		self.judgement_disposition_date	:= ut.CleanSpacesAndUpper(L.judgement_disposition_date);
		self.c_dist_mncp_court_code			:= ut.CleanSpacesAndUpper(R.dist_mncp_court_code);
		self.c_case_type								:= ut.CleanSpacesAndUpper(R.case_type);
		self.c_case_number							:= ut.CleanSpacesAndUpper(R.case_number);
		self.case_disposition_code			:= ut.CleanSpacesAndUpper(R.case_disposition_code);
		self.case_disposition_date			:= ut.CleanSpacesAndUpper(R.case_disposition_date);
		self.filing_date								:= ut.CleanSpacesAndUpper(R.filing_date);
		self.case_cause_number					:= ut.CleanSpacesAndUpper(R.case_cause_number);
		self.case_title									:= ut.CleanSpacesAndUpper(R.case_title);
	END;
	
	j_CivJud	:= join(sort(distribute(Jud_in,hash(dist_mncp_court_code,case_type,case_number)),dist_mncp_court_code,case_type,case_number,local),
										sort(distribute(Civ_NoSealed,hash(dist_mncp_court_code,case_type,case_number)),dist_mncp_court_code,case_type,case_number,local),
										trim(left.dist_mncp_court_code,all) = trim(right.dist_mncp_court_code,all) AND
										trim(left.case_type,all) = trim(right.case_type,all) AND
										trim(left.case_number,all) = trim(right.case_number,all),
										xfrmJud(left,right),local);
										
	EXPORT CivJud_in := j_CivJud;
	
	//Join Civil and Participant
	Civ_Court.Layouts_In_WA.Civ_Par xfrmPar(Par_in L, Civ_NoSealed R)	:= TRANSFORM
		self.dist_mncp_court_code				:= ut.CleanSpacesAndUpper(L.dist_mncp_court_code);
		self.case_type									:= ut.CleanSpacesAndUpper(L.case_type);
		self.case_number								:= ut.CleanSpacesAndUpper(L.case_number);
		self.participant_type_code			:= ut.CleanSpacesAndUpper(L.participant_type_code);
		self.participant_name						:= ut.CleanSpacesAndUpper(L.participant_name);
		self.judgement_rule_code				:= ut.CleanSpacesAndUpper(L.judgement_rule_code);
		self.c_dist_mncp_court_code			:= ut.CleanSpacesAndUpper(R.dist_mncp_court_code);
		self.c_case_type								:= ut.CleanSpacesAndUpper(R.case_type);
		self.c_case_number							:= ut.CleanSpacesAndUpper(R.case_number);
		self.case_disposition_code			:= ut.CleanSpacesAndUpper(R.case_disposition_code);
		self.case_disposition_date			:= ut.CleanSpacesAndUpper(R.case_disposition_date);
		self.filing_date								:= ut.CleanSpacesAndUpper(R.filing_date);
		self.case_cause_number					:= ut.CleanSpacesAndUpper(R.case_cause_number);
		self.case_title									:= ut.CleanSpacesAndUpper(R.case_title);
	END;
	
		j_CivPar	:= join(sort(distribute(Par_in,hash(dist_mncp_court_code,case_type,case_number)),dist_mncp_court_code,case_type,case_number,local),
										sort(distribute(Civ_NoSealed,hash(dist_mncp_court_code,case_type,case_number)),dist_mncp_court_code,case_type,case_number,local),
										trim(left.dist_mncp_court_code,all) = trim(right.dist_mncp_court_code,all) AND
										trim(left.case_type,all) = trim(right.case_type,all) AND
										trim(left.case_number,all) = trim(right.case_number,all),
										xfrmPar(left,right),local);
										
	EXPORT CivPar_in := j_CivPar;
	
END;