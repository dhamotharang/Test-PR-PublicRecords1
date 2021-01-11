


EXPORT BusinessShell_Tracking_Report := FUNCTION 

// #workunit('name', 'BusinessShell Tracking Report');

import ut;
import std, Scoring_Project, ashirey,Scoring_Project_Macros, Scoring_Project_DailyTracking;

dt := ut.getdate;
decimal19_2 thresh := 1.25;


ds_curr := dataset('~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_' + dt + '_1',  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_*_1'));


filelist := sort(filenames_details, -modified);

p_file_name := filelist[2].name;
prev_date := p_file_name[length(p_file_name)-9.. length(p_file_name)-2];

cleaned_curr_date := dt;
cleaned_prev_date := prev_date;

ds_prev := dataset('~'+ p_file_name,  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


		join1 := JOIN(ds_curr, ds_prev, LEFT.acctno=RIGHT.acctno, transform(left));
		clean_file := join1(acctno <> '');
		ds_curr_join := JOIN(ds_curr, clean_file, LEFT.acctno=RIGHT.acctno, transform(left));
		ds_prev_join := JOIN(ds_prev, clean_file, LEFT.acctno=RIGHT.acctno, transform(left));

ashirey.flatten(ds_curr_join, curr_output, ,true , ,);
ashirey.flatten(ds_prev_join, prev_output, ,true , ,);
curr_ds := Scoring_Project.BusinessShell_Normalized_Code(curr_output, 'acctno');
prev_ds := 	Scoring_Project.BusinessShell_Normalized_Code(prev_output, 'acctno');




layout := record
recordof(curr_ds);
Integer flag;
end;


fcra_jn := JOIN(curr_ds, prev_ds, left.acctno = right.acctno and
														 left.field_name = right.field_name,
														TRANSFORM(layout, 
																			self.flag := If(left.field_value <> right.field_value, 1, 0);
																			self := Left;
																			));
														
fcra_filter_join := fcra_jn(flag = 1);	

fcra_recrd := record
fcra_filter_join.field_name;
Integer Difference_count := count(group);
decimal19_2  Difference_Percent :=  (count(group)/count(ds_curr_join))*100;
end;

fcra_result := table(fcra_filter_join, fcra_recrd, fcra_filter_join.field_name);


re_filter1:=fcra_result(field_name not in ['data_build_dates__bankruptcybuilddate', 'data_build_dates__BusinessHeaderBuildDate', 'data_build_dates__inquiriesbuilddate', 'data_build_dates__aircraftbuilddate', 'data_build_dates__WatercraftBuildDate', 'time_ms'], Difference_Percent > thresh);

re_filter2:=SORT(re_filter1, -Difference_Percent);

// ******** END: CURRENT MODE CALCULATIONS *********************************************************************************************************************


// ******** START: NONSBFE MODE CALCULATIONS *********************************************************************************************************************

ds_curr_archive := dataset('~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_' + dt + '_1',  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );

filenames_details_arch :=  nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_*_1'));


filelist_arch := sort(filenames_details_arch, -modified);

p_arch_file_name := filelist_arch[2].name;
prev_arch_date := p_arch_file_name[length(p_arch_file_name)-9.. length(p_arch_file_name)-2];

cleaned_curr_arch_date := dt;
cleaned_prev_arch_date := prev_arch_date;

ds_prev_archive := dataset('~'+ p_arch_file_name,  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


//***transform layout to subtract SBFE****//

lay1 := RECORD
 Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout - [SBFE];
END;

ds_curr_achive_new := PROJECT(ds_curr_archive, TRANSFORM( lay1, self:=left));
ds_prev_achive_new := PROJECT(ds_prev_archive, TRANSFORM( lay1 ,self:=left));

		join1_arch := JOIN(ds_curr_achive_new, ds_prev_achive_new, LEFT.acctno=RIGHT.acctno, transform(left));
		clean_file_archive := join1_arch(acctno <> '');
		ds_curr_arch_join := JOIN(ds_curr_achive_new, clean_file_archive, LEFT.acctno=RIGHT.acctno, transform(left));
		ds_prev_arch_join := JOIN(ds_prev_achive_new, clean_file_archive, LEFT.acctno=RIGHT.acctno, transform(left));

ashirey.flatten(ds_curr_arch_join, fcra_arch_curr_output, ,true , ,);
ashirey.flatten(ds_prev_arch_join, fcra_arch_prev_output, ,true, ,);
fcra_arch_curr_ds := Scoring_Project.BusinessShell_Normalized_Code(fcra_arch_curr_output, 'acctno');
fcra_arch_prev_ds := 	Scoring_Project.BusinessShell_Normalized_Code(fcra_arch_prev_output, 'acctno');

fcra_arch_layout := record
recordof(fcra_arch_curr_ds);
Integer flag;
end;


fcra_arch_jn := JOIN(fcra_arch_curr_ds, fcra_arch_prev_ds, left.acctno = right.acctno and
														 left.field_name = right.field_name,
														TRANSFORM(fcra_arch_layout, 
																			self.flag := If(left.field_value <> right.field_value, 1, 0);
																			self := Left;
																			));
														
fcra_arch_filter_join := fcra_arch_jn(flag = 1);	

fcra_arch_recrd := record
fcra_arch_filter_join.field_name;
Integer Difference_count := count(group);
decimal19_2  Difference_Percent :=  (count(group)/count(ds_curr_arch_join))*100;
end;

fcra_arch_result := table(fcra_arch_filter_join, fcra_arch_recrd, fcra_arch_filter_join.field_name);

re_filter1_archive := fcra_arch_result(field_name not in ['data_build_dates__bankruptcybuilddate', 'data_build_dates__BusinessHeaderBuildDate', 'data_build_dates__inquiriesbuilddate', 'data_build_dates__aircraftbuilddate', 'data_build_dates__WatercraftBuildDate', 'time_ms'], Difference_Percent > thresh);
re_filter2_archive := SORT(re_filter1_archive, -Difference_Percent);

// ******** END: NONSBFE MODE CALCULATIONS *********************************************************************************************************************
		

// ******** START: SBFE MODE CALCULATIONS *********************************************************************************************************************

nonfcra_ds_curr := dataset('~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_' + dt + '_1',  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


nonfcra_filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_*_1'));


nonfcra_filelist := sort(nonfcra_filenames_details, -modified);

nonfcra_p_file_name := nonfcra_filelist[2].name;
nonfcra_prev_date := nonfcra_p_file_name[length(nonfcra_p_file_name)-9.. length(nonfcra_p_file_name)-2];

cleaned_nonfcra_curr_date := dt;
cleaned_nonfcra_prev_date := nonfcra_prev_date;

nonfcra_ds_prev := dataset('~'+ nonfcra_p_file_name,  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout, thor)(length(trim(errorcode,left,right))= 0 );


//***transform layout to subtract NONSBFE****//

lay2 := RECORD
 Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout - [verification, business_activity, business_characteristics, firmographic, organizational_structure, sos, bankruptcy, lien_and_judgment, asset_information, public_record,
			 tradeline, inquiry, business_to_executive_link, business_to_person_link, input_characteristics, associates];
END;

nonfcra_ds_curr_new := PROJECT(nonfcra_ds_curr, TRANSFORM(lay2,self:=left));
nonfcra_ds_prev_new := PROJECT(nonfcra_ds_prev, TRANSFORM(lay2,self:=left));

		nonfcra_join1 := JOIN(nonfcra_ds_curr_new, nonfcra_ds_prev_new, LEFT.acctno=RIGHT.acctno, transform(left));
		nonfcra_clean_file := nonfcra_join1(acctno <> '');
		nonfcra_ds_curr_join := JOIN(nonfcra_ds_curr_new, nonfcra_clean_file, LEFT.acctno=RIGHT.acctno, transform(left));
		nonfcra_ds_prev_join := JOIN(nonfcra_ds_prev_new, nonfcra_clean_file, LEFT.acctno=RIGHT.acctno, transform(left));

/* LAYOUT FLATTENING */ 
				 ashirey.flatten(nonfcra_ds_curr_join, nonfcra_curr_output, ,true , ,);
         ashirey.flatten(nonfcra_ds_prev_join, nonfcra_prev_output, ,true , ,);
         nonfcra_curr_ds := Scoring_Project.BusinessShell_Normalized_Code(nonfcra_curr_output, 'acctno');
         nonfcra_prev_ds := Scoring_Project.BusinessShell_Normalized_Code(nonfcra_prev_output, 'acctno');
         
         nonfcra_layout := record
         recordof(nonfcra_curr_ds);
         Integer flag;
         end;
         
         
         nonfcra_jn := JOIN(nonfcra_curr_ds, nonfcra_prev_ds, left.acctno = right.acctno and
         														 left.field_name = right.field_name,
         														TRANSFORM(nonfcra_layout, 
         																			self.flag := If(left.field_value <> right.field_value, 1, 0);
         																			self := Left;
         																			));
         														
         nonfcra_filter_join := nonfcra_jn(flag = 1);	
         
         nonfcra_recrd := record
         nonfcra_filter_join.field_name;
         Integer Difference_count := count(group);
         decimal19_2  Difference_Percent :=  (count(group)/count(nonfcra_ds_curr_join))*100;
         end;
         
         nonfcra_result := table(nonfcra_filter_join, nonfcra_recrd, nonfcra_filter_join.field_name);



re_filter1_nonfcra := nonfcra_result(field_name not in ['data_build_dates__bankruptcybuilddate', 'data_build_dates__BusinessHeaderBuildDate', 'data_build_dates__inquiriesbuilddate', 'data_build_dates__aircraftbuilddate', 'data_build_dates__WatercraftBuildDate', 'time_ms'], Difference_Percent > thresh);
re_filter2_nonfcra := SORT(re_filter1_nonfcra, -Difference_Percent);

// ******** END: SBFE MODE CALCULATIONS *********************************************************************************************************************
		
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;

		max_diff := (STRING)SORT(re_filter1 + re_filter1_archive + re_filter1_nonfcra , -Difference_Percent)[1].Difference_Percent + '%';
		
		ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
		
		STRING filler := '                                                                                                                    ';

		outfile_cert_Total := IF(COUNT(re_filter2) > 0,
																			PROJECT(re_filter2, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..70] + (LEFT.Difference_count + filler)[1..25] + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
					
		outfile_cert_NonSBFE := IF(COUNT(re_filter2_archive) > 0,
																			PROJECT(re_filter2_archive, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..70] + (LEFT.Difference_count + filler)[1..25] + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
																			
		outfile_prod_SBFE := IF(COUNT(re_filter2_nonfcra) > 0,
																			PROJECT(re_filter2_nonfcra, TRANSFORM(MyRec, SELF.order := 2;
																			SELF.line := (TRIM(LEFT.Field_Name) + filler)[1..70] + (LEFT.Difference_count + filler)[1..25] + LEFT.Difference_Percent + '%')),
																			ds_no_diff);
																			
																			
		line_heading := ('Field Name' + filler)[1..70] + ('Difference Count' + filler)[1..25] + 'Difference Percent';

		main_head := DATASET([{1,   'BusinessShell Tracking Report' + '\n'
													+ '*** This report is produced by Scoring QA ***' + '\n\n'
													}], MyRec); 		
				
		Cert_Total := DATASET([{1,    
														'Environment:  CERT - BusinessShell All'	+ '\n'
													+ 'Previous run date:  ' + cleaned_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_prev) + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													

		Cert_NonSBFE := DATASET([{1,    
														'Environment:  CERT - NonSBFE'	+ '\n'
													+ 'Previous run date:  ' + cleaned_prev_arch_date + '\n'
													+ 'Current run date:  ' + cleaned_curr_arch_date + '\n' 
													+ 'Previous record count:  ' + COUNT(ds_prev_archive) + '\n'
													+ 'Current record count:  ' + COUNT(ds_curr_archive) + '\n'
													+ 'Compared records:  ' + COUNT(clean_file_archive) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec);
													
		Cert_SBFE := DATASET([{1,    
														'Environment:  CERT - SBFE'	+ '\n'
													+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
													+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
													+ 'Previous record count:  ' + COUNT(nonfcra_ds_prev) + '\n'
													+ 'Current record count:  ' + COUNT(nonfcra_ds_curr) + '\n'
													+ 'Compared records:  ' + COUNT(nonfcra_clean_file) + '\n'
													+ 'Threshold:  ' + thresh + '%' + '\n'  
													+ '\n' 
													+ line_heading + '\n'
													+ '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
												

		spacer := DATASET([{3,    
														'\n' 
													+ '\n' 
													+ '\n' 
													}], MyRec);
		
		spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
		spacer3 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

		output_cert_Total := PROJECT(SORT(Cert_Total + outfile_cert_Total, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
		output_cert_NonSBFE := PROJECT(SORT(Cert_NonSBFE + outfile_cert_NonSBFE, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
		output_prod_SBFE := PROJECT(SORT(Cert_SBFE + outfile_prod_SBFE, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));


		output_append := main_head + output_cert_Total + spacer + output_cert_NonSBFE + spacer2 + output_prod_SBFE + spacer3 ;
		output_full := SORT(output_append, order);
		// OUTPUT(output_full, NAMED('output_full'));

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := l;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));

	final := FileServices.SendEmail('Matthew.Ludewig@lexisnexisrisk.com; nathan.koubsky@lexisnexis.com; lea.smith@lexisnexisrisk.com;Todd.Steil@lexisnexisrisk.com;Michele.Walklin@lexisnexisrisk.com;David.Schlangen@lexisnexisrisk.com', 'BusinessShell Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
	// final := FileServices.SendEmail('bridgett.braaten@lexisnexis.com', 'BusinessShell Tracking Report: MaxDiff ' + max_diff, XtabOut[COUNT(XtabOut)].line):
								 // WHEN(CRON('0 12 * * *')), //run at 8:00 AM
									FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.Bocashell_collections_fail_list,'BusinessShell Tracking CRON job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));
									// FAILURE(FileServices.SendEmail('bridgett.braaten@lexisnexis.com','BusinessShell Tracking CRON job failed','The failed workunit is:' + WORKUNIT + FAILMESSAGE));



		RETURN final;
END;	