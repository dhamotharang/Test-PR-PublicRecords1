IMPORT Civ_Court, ut,  Data_Services;

EXPORT Files_In_UT := MODULE

	EXPORT	Case_Filing	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_civil_filing',Civ_Court.Layouts_In_UT.Filings,csv(heading(1), separator(',')));
	EXPORT	Case_Judgement	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_civil_judgement',Civ_Court.Layouts_In_UT.Judgements,csv(heading(1), separator(',')));
	EXPORT Case_Disposition	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_civil_disposition',Civ_Court.Layouts_In_UT.Disposition,csv(heading(1), separator(',')));
	
	//Lookup files
	EXPORT case_type_lkp	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_casetypes.lkp',Civ_Court.Layouts_In_UT.code_lkp,csv(heading(0), separator(',')));
	EXPORT court_loc_lkp	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_courtlocations.lkp',Civ_Court.Layouts_In_UT.code_lkp,csv(heading(0), separator(',')));
	EXPORT disposition_lkp	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_dispositioncodes.lkp',Civ_Court.Layouts_In_UT.code_lkp,csv(heading(0), separator(',')));
	EXPORT judgement_lkp	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_judgementcodes.lkp',Civ_Court.Layouts_In_UT.code_lkp,csv(heading(0), separator(',')));
	EXPORT party_type_lkp	:= dataset(Data_Services.foreign_prod +'thor_data400::in::civil::ut_partytypes.lkp',Civ_Court.Layouts_In_UT.code_lkp,csv(heading(0), separator(',')));
	
	//join input files for single file input
Civ_Court.Layouts_In_UT.Case_all jFilingJudge(Case_Filing L, Case_Judgement R) := TRANSFORM
	self.case_type		:= IF(L.case_type <> '',ut.CleanSpacesAndUpper(L.case_type),ut.CleanSpacesAndUpper(R.case_type));
	self.case_num			:= IF(L.case_num <> '',ut.CleanSpacesAndUpper(L.case_num),ut.CleanSpacesAndUpper(R.case_num));
	self.locn_code		:= ut.CleanSpacesAndUpper(R.locn_code);
	self.locn_descr		:= IF(L.locn_descr <> '',ut.CleanSpacesAndUpper(L.locn_descr),ut.CleanSpacesAndUpper(R.locn_descr));
	self.filing_date	:= IF(L.filing_date <> '',ut.CleanSpacesAndUpper(L.filing_date),ut.CleanSpacesAndUpper(R.jdmt_filing_date));
	self.party_code		:= IF(L.party_code <> '',ut.CleanSpacesAndUpper(L.party_code),ut.CleanSpacesAndUpper(R.party_code));
	self.last_name		:= IF(L.last_name <> '',ut.CleanSpacesAndUpper(L.last_name),ut.CleanSpacesAndUpper(R.last_name));
	self.first_name		:= IF(L.first_name <> '',ut.CleanSpacesAndUpper(L.first_name),ut.CleanSpacesAndUpper(R.first_name));
	self.disp_code		:= '';
	self.disp_date		:= trim(R.disp_date,left,right);
	self.jdmt_code		:= ut.CleanSpacesAndUpper(R.jdmt_code);
	self.jdmt_filing_date	:= trim(R.jdmt_filing_date,left,right);
END;

j_FilingJudge	:= join(sort(distribute(Case_Filing,hash(case_num,locn_descr)),case_num, locn_descr,local),
											sort(distribute(Case_Judgement,hash(case_num,locn_descr)),case_num, locn_descr,local),
											trim(left.case_num,all) = trim(right.case_num,all) and
											trim(left.locn_descr,all) = trim(right.locn_descr,all),
											jFilingJudge(left,right),full outer,local);
											
dd_FilingJudge	:= dedup(j_FilingJudge(case_num <> 'CASE_NUM'));											

Civ_Court.Layouts_In_UT.Case_all jFilingDisp(dd_FilingJudge L, Case_Disposition R) := TRANSFORM
	self.case_type		:= IF(L.case_type <> '',L.case_type,ut.CleanSpacesAndUpper(R.case_type));
	self.case_num			:= IF(L.case_num <> '',L.case_num,ut.CleanSpacesAndUpper(R.case_num));
	self.locn_code		:= IF(L.locn_code <> '',L.locn_code,ut.CleanSpacesAndUpper(R.locn_code));
	self.locn_descr		:= IF(L.locn_descr <> '',L.locn_descr,ut.CleanSpacesAndUpper(R.locn_descr));
	self.filing_date	:= L.filing_date;
	self.party_code		:= IF(L.party_code <> '',L.party_code,ut.CleanSpacesAndUpper(R.party_code));
	self.last_name		:= IF(L.last_name <> '',L.last_name,ut.CleanSpacesAndUpper(R.last_name));
	self.first_name		:= IF(L.first_name <> '',L.first_name,ut.CleanSpacesAndUpper(R.first_name));
	self.disp_code		:= ut.CleanSpacesAndUpper(R.disp_code);
	self.disp_date		:= IF(L.disp_date <> '',trim(L.disp_date,left,right),trim(R.disp_date,left,right));
	self.jdmt_code		:= L.jdmt_code;
	self.jdmt_filing_date	:= L.jdmt_filing_date;
END;

j_FilingDisp	:= join(sort(distribute(dd_FilingJudge,hash(case_num,locn_descr)),case_num, locn_descr,local),
											sort(distribute(Case_Disposition,hash(case_num,locn_descr)),case_num, locn_descr,local),
											trim(left.case_num,all) = trim(right.case_num,all) and
											trim(left.locn_descr,all) = trim(right.locn_descr,all),
											jFilingDisp(left,right),full outer,local);
											
	EXPORT Civil_in	:= dedup(j_FilingDisp(case_num <> 'CASE_NUM'));
	
END;