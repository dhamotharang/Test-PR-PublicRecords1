import STD, Data_Services;
BaseFile0 := dataset(mod_Utilities.Location + 'thor_data400::base::ecrash',FLAccidents_Ecrash.Layout_Basefile,thor)(~(trim(case_identifier,left,right) in  FLAccidents_Ecrash.Suppress_Id and report_code in ['EA', 'TF'])); 
BaseFile1 := BaseFile0(trim(report_id,left,right) not in Suppress_report_d);

suppressrec := record
string Incident_ID;
string ORI_Number;
string State_Report_Number;
string Agency_ID;
end;


tosuppress := dataset(mod_Utilities.Location + 'thor_data400::in::ecrash::suppress_tf.csv',suppressrec,csv(heading(1),terminator(['\n','\r\n']), separator(','),quote('"')));

export BaseFile := join(BaseFile1(incident_id not in FLAccidents_Ecrash.supress_incident_id and incident_id not in Set(tosuppress,Incident_ID)) , FLAccidents_Ecrash.Files.deletes, 
                         trim(left.case_identifier,left,right) = trim(right.case_identifier,left,right) and 
												 trim(left.State_Report_Number,left,right) = trim(right.State_Report_Number,left,right) and 
												 trim(left.Source_ID ,left,right)= trim(right.Source_ID ,left,right)and 
												 trim(left.Loss_State_Abbr,left,right) = trim(right.Loss_State_Abbr,left,right) and 
												 trim(left.Crash_Date,left,right) = STD.Str.FilterOut(trim(right.Crash_Date,left,right),'-') and 
												 trim(left.Agency_ID,left,right) = trim(right.Agency_ID,left,right) and 
												 trim(left.Work_Type_ID ,left,right)= trim(right.Work_Type_ID,left,right)  , many lookup , left only ):persist('~thor_data::persist::eCrash_suppressed'); 

												 

                                                                                                  
									 			 