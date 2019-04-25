
import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, sghatti,Gateway, ut, lib_fileservices;
today := ut.getdate;
// yesterday := '20170322';
	// output(today);


		qa_nonFCRA_results 		:= 	Scoring_Project_DailyTracking.DDT_GetDeployedDatasets( 'Q', 'B', 'N', '');
		qa_FCRA_results 			:= 	Scoring_Project_DailyTracking.DDT_GetDeployedDatasets( 'Q', 'B', 'F', '');

filter := ['BN','B'];
header_check_non := qa_nonFCRA_results(cluster not in filter);
header_check_fcra := qa_FCRA_results(cluster not in filter);


layout := record
string datasetname;
string envment;
string cluster;
string buildversion;
string releasedate;
end;

date_form(string rel_date) := function
		a := Stringlib.StringFind(rel_date, '/', 1);
		b := Stringlib.StringFind(rel_date, '/', 2);
		c := b + 4;
		mo := intformat((integer)rel_date[1..(a-1)], 2, 1);
		dom := intformat((integer)rel_date[(a+1)..(b-1)], 2, 1);
		yr := intformat((integer)rel_date[(b+1)..c], 4, 1);
	return yr + mo + dom;
end;
layout trans(recordof(header_check_non) le) := transform
self.datasetname := le.datasetname;
self.envment := if(le.envment = 'Q', 'Cert', le.envment);
self.cluster := le.cluster;
self.buildversion := le.buildversion;
self.releasedate := date_form(le.releasedate);
self := [];
end;

get_header_dt_non := project(header_check_non, trans(left));
get_header_dt_FCRA := project(header_check_fcra, trans(left));

// filterdsnon := [	ACAInstitutionsKeys , 	AddressHRIKeys, 	AmericanstudentKeys, 	AVMV2Keys, 	BankruptcyV2Keys, 	BusinessHeaderKeys, CDSKeys, 	DeathMasterSsaKeys, DOCKeys, 	EmailDataKeys, EmergesKeys, 	FAAKeys, 	ForeclosureKeys, 	GongKeys, 	InfutorcidKeys, InquirytableKeys, 	InquiryTableUpdateKeys, 	LiensV2Keys, 	LNPropertyV2FullKeys, 	LNPropertyV2Keys, 	MariKeys, PAWV2Keys, 	PersonHeaderKeys,  PersonLABKeys, 	PhonesPlusV2Keys, 	ProfLicKeys, 	QuickHeaderKeys, 	RelativeV3Keys, RiskTableKeys, 



// get_header_dt_non(datasetname in filterdsnon);
// get_header_dt_non(datasetname in filter);

headersort_non := sort(get_header_dt_non, datasetname, buildversion);
headersort_FCRA := sort(get_header_dt_FCRA, datasetname, buildversion);
 
cert_res := 	headersort_non+headersort_FCRA;

get_yesterday_dt := cert_res(releasedate = today);
	output(get_yesterday_dt, all);

EXPORT BWR_Keys_Updated_Today_Cert := 'todo';