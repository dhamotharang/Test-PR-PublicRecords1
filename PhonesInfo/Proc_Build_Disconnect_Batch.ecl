import _control, std;

EXPORT Proc_Build_Disconnect_Batch(string version, string version2, const varstring eclsourceip):= function
	
	buildBase							:= output(PhonesInfo.Map_Disconnect_Batch(version, version2),,'~thor_data400::base::phones::disconnect_main_batch_'+version, csv(heading(1), terminator('\n'), separator('\t')), __compressed__);
													 
	clearDelete 					:= nothor(fileservices.clearsuperfile('~thor_data400::base::phones::disconnect_main_batch_delete', true));		
		
	moveBase							:= STD.File.PromoteSuperFileList(['~thor_data400::base::phones::disconnect_main_batch',
																														'~thor_data400::base::phones::disconnect_main_batch_father',
																														'~thor_data400::base::phones::disconnect_main_batch_grandfather',
																														'~thor_data400::base::phones::disconnect_main_batch_delete'], '~thor_data400::base::phones::disconnect_main_batch_'+version, true);
																								
	desprayFile						:= FileServices.DeSpray('~thor_data400::base::phones::disconnect_main_batch_'+version,
																								eclsourceip,
																								'/data/data_999/phones/metadata/'+version+'/Phones_Metadata_'+version+'.csv',
																								,
																								,
																								,
																								TRUE
																								);													
				
	breakdownStat					:= PhonesInfo.runSourceBreakdown;	
	
	emailNotice 					:= if(count(PhonesInfo.File_Deact_Batch(phone<>'')) > 0
																,sequential(fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'Phones Metadata Batch: Phones Disconnect File', 'Phones Metadata Disconnect File is Now Available.  Please see: '+'http://10.241.30.202:8010/?Wuid='+ workunit + '&Widget=WUDetailsWidget#/stub/Results-DL/Grid'))
																						,fileservices.SendEmail(_control.MyInfo.EmailAddressNotify + ';judy.tao@lexisnexisrisk.com' + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'Phones Metadata Batch: No Phones Disconnect File', 'There Were No Phones Metadata Disconnect Records in This Build'));	
	
	return 								sequential( buildBase,
																		clearDelete,
																		moveBase,
																		desprayFile,
																		breakdownStat,
																		emailNotice
																		);
	
end;