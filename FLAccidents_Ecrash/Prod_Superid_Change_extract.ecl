import ut,Data_Services; 
EXPORT Prod_Superid_Change_extract(string filedate) := function 

Supplemental                := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_supplemental',FLAccidents_Ecrash.Layouts.ReportVersion,thor); 
Supplemental_f               := dataset(Data_Services.Data_location.Prefix('ecrash')+'thor_data400::base::ecrash_supplemental_father',FLAccidents_Ecrash.Layouts.ReportVersion,thor); 

j:= join (Supplemental_f,Supplemental  ,  left.report_id = right.report_id and
                                          left.incident_id = right.incident_id and 
                                          left.super_report_id <> right.super_report_id,
																					transform({Supplemental , string old_super_report_id , string new_super_report_id}, 
																					self.old_super_report_id := left.super_report_id ,
																					self.new_super_report_id := right.super_report_id , 
																					self:= right) 
																					); 

createfile := sequential(output(dedup(j,record,all),,'~thor_data400::out::ecrash::'+filedate+'::super_report_idchange'
												,csv(heading('super_report_id,report_id,hash_key,U_D_flag,Creation_Date,Sent_to_HPCC_DateTime,Incident_ID,accident_nbr,accident_date,report_code,jurisdiction,jurisdiction_state,orig_accnbr,addl_report_number,cru_order_id,CRU_Sequence_Nbr,work_type_id,report_type_id,agency_ori,agency_id,Vendor_Code,vendor_report_id,source_id,old_super_report_id,new_super_report_id\n','',SINGLE)
												,terminator('\n')
												,separator(','),quote('"'))
												,overwrite) ,
                        fileservices.Despray('~thor_data400::out::ecrash::'+filedate+'::super_report_idchange'
												, Constants.LandingZone
												, '/data/super_credit/ecrash/despray/supereport/super_report_idchange_'+filedate+'.csv'),
												
												fileservices.sendemail(
													'Ayeesha.kayttala@lexisnexis.com;Sudhir.Kasavajjala@lexisnexis.com;Hari.velappan@lexisnexis.com;Sai.Nagula@lexisnexis.com',
													'Super report id changed',
													'Super report id changed in eCrashbuild file is desprayed to LZ /super_credit/ecrash/alphabuild/ wuid'+workunit ));

despray := if(count(j) > 0 ,createfile,output('Super report id not changed in this build'));  

return despray ; 

end; 