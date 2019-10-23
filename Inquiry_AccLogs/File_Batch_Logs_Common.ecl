import ut, Data_Services, inql_v2;

export File_Batch_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='BATCH'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions)
// dataset(Data_Services.foreign_logs + 'thor100_21::base::batch_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt)
(~(bus_intel.industry = 'DIRECT TO CONSUMER' and 
																search_info.function_description in [
																'ADDRBEST.BESTADDRESSBATCHSERVICE'
																,'BATCHSERVICES.AKABATCHSERVICE'
																,'BATCHSERVICES.DEATHBATCHSERVICE'
																,'BATCHSERVICES.EMAILBATCHSERVICE'
																,'BATCHSERVICES.PROPERTYBATCHSERVICE'
																,'DIDVILLE.DIDBATCHSERVICERAW'
																,'DIDVILLE.RANBESTINFOBATCHSERVICE'
																,'PROGRESSIVEPHONE.PROGRESSIVEPHONEWITHFEEDBACKBATCHSERVICE'])); 