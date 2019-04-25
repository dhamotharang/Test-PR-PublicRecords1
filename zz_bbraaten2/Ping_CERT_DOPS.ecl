

import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, sghatti,Gateway, ut, lib_fileservices;


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


headersort_non := sort(get_header_dt_non, datasetname, buildversion);
headersort_FCRA := sort(get_header_dt_FCRA, datasetname, buildversion);
 
cert_res := 	headersort_non+headersort_FCRA;
	
dt := ut.GetDate;	
	
	
outfile_name := '~scoringqa::Check_deployed_keys_' + dt + '_1'	;
																			
ds_find := lib_fileservices.fileservices.FileExists(outfile_name, false);


ds_infile := if(ds_find = true,  dataset(outfile_name,layout, thor));
ds_file := if(ds_find = false,  output(cert_res,, outfile_name, thor, compressed, OVERWRITE));



check := if(ds_infile = cert_res, true, false);

my_dopskeycheck(dataset(layout) ds) := function

// cert_res := ds;

MyRec := RECORD
			INTEGER order;
			STRING line;
		END;
		
		STRING filler := '                                                                                                                    ';
		

		result_set := 	project(cert_res, 
												transform(MyRec, 
													self.order := 2;
													self.line :=	(left.datasetname + filler )[1..25] + 
																				(left.envment + filler)[1..8] + 
																				(left.cluster + filler)[1..8] +
																				(left.buildversion + filler)[1..18] +
																				(left.releasedate + filler)[1..8];
																				) );
											

											
		line_heading := ('Dataset' + filler)[1..25] + 
												'\n' +
										('Name' + filler)[1..25] + 
										('envment' + filler)[1..8] + 
										('cluster' + filler)[1..8] + 
										('Build Version' + filler)[1..18] + 
										('Release Date' + filler)[1..8];


		detailed_head := DATASET([{1,    

													line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		spacer := DATASET([{3,    
														'\n' 
													+ '\n'  
													}], MyRec);
		

		output_data := PROJECT(SORT(result_set, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));


		output_append := detailed_head + spacer + output_data ;
		output_full := SORT(output_append, order);

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := L;
		END;

	XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));
	
	final := FileServices.SendEmail('bridgett.braaten@lexisnexis.com', 'Cert Check Keys ' , XtabOut[COUNT(XtabOut)].line);
		
		return final;
		
	end;
	
ds_run :=	if(check = false, my_dopskeycheck(cert_res), output('none'));
ds_run;

EXPORT Ping_CERT_DOPS := 'todo';
