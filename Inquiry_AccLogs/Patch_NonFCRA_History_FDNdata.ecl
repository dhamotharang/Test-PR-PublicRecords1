import ut;

EXPORT Patch_NonFCRA_History_FDNdata := module

#OPTION ('multiplePersistInstances',FALSE); 

SHARED hasValueFilter(string source) := FUNCTION

accurintHasValue          			:= Inquiry_AccLogs.File_Accurint_Logs.processed.orig_RECORD_COUNT <> '' or
																	 Inquiry_AccLogs.File_Accurint_Logs.processed.orig_PRICE <> '' or 
																	 Inquiry_AccLogs.File_Accurint_Logs.processed.orig_REPORT_OPTIONS <> '' or
																	 Inquiry_AccLogs.File_Accurint_Logs.processed.orig_function_name <> '';

bankoHasValue 		         			:= Inquiry_AccLogs.File_Banko_Logs.processed.orig_RECORD_COUNT <> '' or
																	 Inquiry_AccLogs.File_Banko_Logs.processed.orig_PRICE <> '' or 
																	 Inquiry_AccLogs.File_Banko_Logs.processed.orig_function_name <> '';

customHasValue          				:= Inquiry_AccLogs.File_Custom_Logs.processed.orig_RECORD_COUNT <> '' or
																	 Inquiry_AccLogs.File_Custom_Logs.processed.orig_PRICE <> '' or 
																	 Inquiry_AccLogs.File_Custom_Logs.processed.orig_REPORT_OPTIONS <> '' or
																	 Inquiry_AccLogs.File_Custom_Logs.processed.orig_function_name <> '';

bridgerHasValue          				:= Inquiry_AccLogs.File_Bridger_Logs.processed.search_function_name <> '';

riskwiseHasValue          			:= Inquiry_AccLogs.File_Riskwise_Logs.processed.orig_RECORD_COUNT <> '' or
																	 Inquiry_AccLogs.File_Riskwise_Logs.processed.orig_PRICE <> '' or 
																	 Inquiry_AccLogs.File_Riskwise_Logs.processed.orig_REPORT_OPTIONS <> '' or
																	 Inquiry_AccLogs.File_Riskwise_Logs.processed.orig_function_name <> '';

idmHasValue      			    			:= Inquiry_AccLogs.File_IDM_Logs.processed.orig_function_name <> '';

return map(source='accurint' => accurintHasValue,
           source='banko'    => bankoHasValue,
           source='bridger'  => bridgerHasValue,					 
					 source='riskwise' => riskwiseHasValue,			
					 source='idm'      => idmHasValue,	
					 customHasValue);
					 
END;

SHARED periodFilter(string source) := Function

accurintPeriodFilter 						:= (INTEGER)ut.DateTimeToYYYYMMDD(Inquiry_AccLogs.File_Accurint_Logs.processed.orig_dateadded)[1..8] < 20160513;
bankoPeriodFilter 							:= (INTEGER)ut.DateTimeToYYYYMMDD(Inquiry_AccLogs.File_Banko_Logs.processed.orig_date_added)[1..8] < 20160513;
customPeriodFilter 							:= (INTEGER)ut.DateTimeToYYYYMMDD(Inquiry_AccLogs.File_Custom_Logs.processed.orig_dateadded)[1..8] < 20160513;
bridgerPeriodFilter 						:= (INTEGER)ut.DateTimeToYYYYMMDD(Inquiry_AccLogs.File_Bridger_Logs.processed.datetime)[1..8] < 20160513;
riskwisePeriodFilter 						:= (INTEGER)ut.DateTimeToYYYYMMDD(Inquiry_AccLogs.File_Riskwise_Logs.processed.orig_date_added)[1..8] < 20160513;
idmPeriodFilter 						    := (INTEGER)ut.DateTimeToYYYYMMDD(Inquiry_AccLogs.File_IDM_Logs.processed.orig_dateadded)[1..8] between 20151004 and 20160512;

return map(source='accurint' => accurintPeriodFilter,
           source='banko' => bankoPeriodFilter,
           source='bridger' => bridgerPeriodFilter,		
					 source='riskwise' => riskwisePeriodFilter,	
					 source='idm' => idmPeriodFilter,
					 customPeriodFilter);
END;

rToPatch := record
 string	 source                :='';
 string  orig_dateadded        :='';
 string  orig_transaction_id   :='';
 string  orig_sequence_number  :='';
 string  orig_RECORD_COUNT     :='';
 string	 orig_PRICE					   :='';
 string	 orig_REPORT_OPTIONS   :='';
 string  orig_function_name	   :='';
end;

accurintDataToPatch 						:=  project(Inquiry_AccLogs.File_Accurint_Logs.processed(hasValueFilter('accurint') and periodFilter('accurint')), 
                                     transform(rToPatch, 
																		          self.source              := 'ACCURINT';
																							self.orig_transaction_id := trim((string)left.orig_transaction_id ,left,right);
																							fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_dateadded);
																							fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
																							self.orig_dateadded      := fixtime;
                                              self.orig_function_name  := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.orig_function_name);
																							self := left));

bankoDataToPatch							 	:=  project(Inquiry_AccLogs.File_Banko_Logs.processed(hasValueFilter('banko') and periodFilter('banko')), 
                                     transform(rToPatch, 
																		          self.source              := 'BANKO';
																							fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_date_added);
																							fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
																							self.orig_dateadded      := fixtime;
																							self.orig_transaction_id := trim((string)left.orig_transaction_id ,left,right);
                                              self.orig_function_name  := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.orig_function_name);
																							self := left));

customDataToPatch 					  	:=  project(Inquiry_AccLogs.File_Custom_Logs.processed(hasValueFilter('custom') and periodFilter('custom')), 
                                     transform(rToPatch, 
																		          self.source              := 'CUSTOM';
																							fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_dateadded);
																							fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
																							self.orig_dateadded      := fixtime;
																							self.orig_transaction_id := trim((string)left.orig_transaction_id ,left,right);
                                              self.orig_function_name  := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.orig_function_name);
																							self := left));

binputfile := Inquiry_AccLogs.File_Bridger_Logs.processed(hasValueFilter('bridger') and periodFilter('bridger'));
inquiry_acclogs.fncleanfunctions.cleanfields(binputfile, bcleaned_fields);
bridgerDataToPatch 					  	:=  project(bcleaned_fields, 
                                     transform(rToPatch, 
																		          self.source              := 'BRIDGER';
																							fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.datetime);
																							fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
																							self.orig_dateadded      := fixTime;	
																							self.orig_transaction_id := trim((string)left.datetime ,left,right);
                                              self.orig_function_name  := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.search_function_name);
																							self := left));															 
																						
rinputfile                :=Inquiry_AccLogs.File_Riskwise_Logs.processed;//(hasValueFilter('riskwise') and periodFilter('riskwise'));
inquiry_acclogs.fncleanfunctions.cleanfields(rinputfile , rcleaned_fields);
normInputFile := normalize(rcleaned_fields, 2, transform({inquiry_acclogs.Layout_Riskwise_Logs.denorm,
																										string orig_transaction_type := '',
																										string orig_global_company_id := ''}, 
								self.sequence_number 			:= (string)counter;
								self.orig_fname 			:= choose(counter, left.orig_fname, left.orig_fname_2);
								self.orig_mname 			:= choose(counter, left.orig_mname, left.orig_mname_2);
								self.orig_lname 			:= choose(counter, left.orig_lname, left.orig_lname_2);
								self.orig_name_suffix := choose(counter, left.orig_name_suffix, left.orig_name_suffix_2);
								self.orig_address 		:= choose(counter, left.orig_address, left.orig_address_2);
								self.orig_city 				:= choose(counter, left.orig_city, left.orig_city_2);
								self.orig_state 			:= choose(counter, left.orig_state, left.orig_state_2);
								self.orig_zip 				:= choose(counter, left.orig_zip, left.orig_zip_2);
								self.orig_zip4 				:= choose(counter, left.orig_zip4, left.orig_zip4_2);
								self.orig_homephone 	:= choose(counter, left.orig_homephone, left.orig_homephone_2);
								self.orig_workphone 	:= choose(counter, left.orig_workphone, left.orig_workphone_2);
								self.orig_ssn 				:= choose(counter, left.orig_ssn, left.orig_ssn_2);
								self.orig_business_name := choose(counter, if(left.orig_business_name = '', left.orig_business_name_2, left.orig_business_name), 
																													 if(left.orig_business_name_2 = '', left.orig_business_name, left.orig_business_name_2));
								self.orig_dob 				:= choose(counter, left.orig_dob, left.orig_dob_2);
								self.orig_email 			:= choose(counter, left.orig_email, left.orig_email_2);
								self.orig_dl_number 	:= choose(counter, left.orig_dl_number, left.orig_dl_number_2);
								self.orig_full_name		:= choose(counter, left.orig_full_name, '');
								self.orig_phone				:= choose(counter, left.orig_phone, '');
								self.orig_login_id		:= left.orig_login_id;
								self := left));

riskwiseDataToPatch 					  	:=  project(normInputFile, 
                                     transform(rToPatch, 
																		          self.source              := 'RISKWISE';
																							self.orig_sequence_number     := left.sequence_number; 
																							fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_date_added);
																							fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
																							self.orig_dateadded      := fixTime;	
																							self.orig_transaction_id := stringlib.stringtouppercase(left.orig_transaction_id);;
                                              self.orig_function_name  := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.orig_function_name);
																							self := left));

iinputfile := Inquiry_AccLogs.File_IDM_Logs.processed(hasValueFilter('idm') and periodFilter('idm'));
inquiry_acclogs.fncleanfunctions.cleanfields(iinputfile, icleaned_fields);
idmDataToPatch 					  				:=  project(icleaned_fields, 
                                     transform(rToPatch, 
																		          self.source              := 'IDM_BLS';
																							fixDate := Inquiry_AccLogs.fncleanfunctions.tDateAdded(left.orig_dateadded);
																							fixTime := Inquiry_AccLogs.fncleanfunctions.tTimeAdded(fixDate);
																							self.orig_dateadded      := fixtime;
																							self.orig_transaction_id := left.orig_transaction_id;
                                              self.orig_function_name  := Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.orig_function_name);
																							self := left));		


allSourcesDataToPatch   := accurintDataToPatch + 
                           customDataToPatch  +
													 bankoDataToPatch + 
													 bridgerDataToPatch + 													 
													 riskwiseDataToPatch +
													 idmDataToPatch ;
																							
SHARED sourceDataToPatch 		       	:= 	dedup(sort(distribute(allSourcesDataToPatch,
																			  hash(source, orig_transaction_id,  orig_dateadded, orig_sequence_number)) 
																			 ,source, orig_transaction_id, orig_dateadded, orig_sequence_number, local)
																			 ,source, orig_transaction_id, orig_dateadded, orig_sequence_number, local)
																			 :PERSIST('~persist::in::data_topatch_history');
																			
EXPORT Update_History_File (string processMode = 'Test') := FUNCTION

////////// For Test only ////////////////////////////////

hasValue								:= Inquiry_AccLogs.File_Inquiry_MBS.orig_RECORD_COUNT <> '' or
													 Inquiry_AccLogs.File_Inquiry_MBS.orig_PRICE <> '' or 
													 Inquiry_AccLogs.File_Inquiry_MBS.orig_REPORT_OPTIONS <> '' or 													 
													 Inquiry_AccLogs.File_Inquiry_MBS.orig_function_name <> '';
isUpdated      					:= (INTEGER)Inquiry_AccLogs.File_Inquiry_MBS.search_info.datetime[1..8]>=20160513;
isToKeep       					:= hasValue and isUpdated;

isAccurint     					:= Inquiry_AccLogs.File_Inquiry_MBS.source = 'ACCURINT';
withinPeriod	      		:= (INTEGER)Inquiry_AccLogs.File_Inquiry_MBS.search_info.datetime[1..8] BETWEEN 20151001 AND 20160512;
isToUpdate     					:= isAccurint and withinPeriod;

testHistFileToKeep	 		:= choosen(Inquiry_AccLogs.File_Inquiry_MBS(isToKeep),600);
													//:PERSIST('~persist::inquiry_tracking::weekly_historical::sample::tokeep');

testHistFileToUpdate 		:= choosen(Inquiry_AccLogs.File_Inquiry_MBS(isToUpdate),600);
													//:PERSIST('~persist::inquiry_tracking::weekly_historical::sample::toupdate');

testHistFile  					:= testHistFileToKeep + testHistFileToUpdate
													:PERSIST('~persist::inquiry_tracking::weekly_historical::sample::few');
													
///////////////////////////////////////////////////////////////////////////////////////////

histFile            			:= if (processMode='Prod', Inquiry_AccLogs.File_Inquiry_MBS, testHistFile);

histFileClean       			:= project(histFile, transform({recordof(Inquiry_AccLogs.File_Inquiry_MBS)}, 
																							self.source                      := trim((string)left.source,left,right);
																							self.search_info.transaction_id  := trim((string)left.search_info.transaction_id ,left,right);
																							self.search_info.datetime        := trim((string)left.search_info.datetime,left,right);
																							self.search_info.Sequence_Number := trim((string)left.search_info.Sequence_Number,left,right);
																							self := left));
																							
histFileDist 							:= distribute(histFileClean, hash(source, search_info.transaction_id, search_info.datetime ,search_info.Sequence_Number));
											 
histFileUpdated 					:= join(histFileDist, sourceDataToPatch,
																		left.search_info.transaction_id = right.orig_transaction_id and 
																		left.source 										= right.source and 
                                    left.search_info.datetime       = right.orig_dateadded and 
																		left.search_info.Sequence_Number = right.orig_sequence_number, 
																		TRANSFORM(recordof(histfileDist),
																		SELF.orig_RECORD_COUNT    :=RIGHT.orig_RECORD_COUNT;
																		SELF.orig_PRICE					  :=RIGHT.orig_PRICE;
																		SELF.orig_REPORT_OPTIONS  :=RIGHT.orig_REPORT_OPTIONS;
																		SELF.orig_function_name 	:=RIGHT.orig_function_name; 
																		SELF := LEFT;
																		), LEFT OUTER,LOCAL, KEEP(1));

sc 			:= nothor(fileservices.superfilecontents('~thor100_21::out::inquiry_tracking::weekly_historical'))[1].name;
findex 	:= stringlib.stringfind(sc, '::', 3)+2;
history_v := sc[findex..findex+7];

updateHist           			:= sequential(output(histFileUpdated,,'~thor100_20::out::inquiry::'+history_v+'::mbs::fields_patched::few', compressed, overwrite));

Return updateHist;								

End;

END;