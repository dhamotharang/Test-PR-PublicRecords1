IMPORT LinkingTools, BIPV2, tools;

EXPORT BIPStatsReport(inBaseAsBusinessLinking
                      ,inFatherAsBusinessLinkinG
											,datasetName
											,versionIn
											,IsTesting)
:= FUNCTIONMACRO

statReport := '~thor_data400::base::' +datasetName +'::stats::' +versionIn +'::data';
baseStatReport := '~thor_data400::base::' +datasetName +'::stats::qa::data';
fatherStatReport := '~thor_data400::base::' +datasetName +'::stats::father::data';

emailNotificationList := if(IsTesting,
                            'Kent.Wolf@lexisnexisrisk.com',
	                          'Laverne.Bentley@lexisnexisrisk.com'
                            + ';Sudhir.Kasavajjala@lexisnexisrisk.com');
												 
email_subject_header := datasetName +':BIP Stats Report Generated - See ' + workunit;

email_body_success := 'BIP Stats Report Generated - See ' + workunit +'\n\n'
                      +'See ' +statReport;

outStatsReport := LinkingTools.SourceStats(inBaseAsBusinessLinking
                                          ,inFatherAsBusinessLinking																	
																				  ,source_record_id
																				  ,source
																				  ,BIPV2.BIPStatsFields);

tools.mac_WriteFile(statReport, 
                    outStatsReport, Build_Base);

populateSuperfiles := sequential(FileServices.StartSuperFileTransaction()
                               ,FileServices.SwapSuperFile(baseStatReport
															                             ,fatherStatReport)
                               ,FileServices.ClearSuperFile(baseStatReport)
															 ,FileServices.AddSuperFile(baseStatReport
								                                          ,statReport) 
                               ,FileServices.FinishSuperFileTransaction());	 

success_email := tools.fun_SendEmail(emailNotificationList	
                                     ,email_subject_header 
																		 ,email_body_success);																		 
											 
final := sequential(
						        Build_Base
										,populateSuperfiles
									 ) : success(if(COUNT(outStatsReport) > 0, success_email));
					  
return final;

ENDMACRO;