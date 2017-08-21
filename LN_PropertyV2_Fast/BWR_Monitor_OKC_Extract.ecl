//EXPORT BWR_Monitor_OKC_Extract := ''
// THIS DEFINITION CONTAINS BWR CODE. Please COPY code out and it in a NEW Builder Window Runnable IF the monitor is not running

import dops,ut,_Control;
emails_To_Notify:= LN_PropertyV2_Fast.Constants.email_DL_export;
last_extract 		:= LN_PropertyV2_Fast.BuildExtractPropertyLogger.getlastversion('99999999').version; 	// Last version extracted
Prod_Version		:= dops.GetBuildVersion('LNPropertyV2Keys','B','N','P')[1..8]; 												// Boca, non-FCRA, Production
Cert_version		:= dops.GetBuildVersion('LNPropertyV2Keys','B','N','C')[1..8]; 												// Boca, non-FCRA, Cert
max_date				:= IF((integer)Prod_Version = (integer)Cert_Version,'99999999',Cert_Version);					// If no new version in Cert, set max to '99999999'
Is_new_version	:= (integer)Prod_Version > (integer)last_extract;
dops_history		:= dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')((integer)prodversion[1..8] > (integer)last_extract and prodversion<>'NA');
next_version		:= set(sort(dops_history,prodversion), prodversion[1..8])[1];													// Next version to Extract
is_fast					:= (set(sort(dops_history,-updateflag,-prodversion), updateflag)[1])<>'F' ;						// If any Full released since last extract, include assessment

ecl_for_export		:= '#workunit(\'name\', \'property.okc_export '+Prod_Version+' \');\n'
										+'deleteexportfiles(string8 pdate) := function\n'
										+'	fileservices.DeleteLogicalFile(LN_PropertyV2_Fast.Filenames.exprt.assessment+\'_\'+pdate);\n'
										+'	fileservices.DeleteLogicalFile(LN_PropertyV2_Fast.Filenames.exprt.deed_mortg+\'_\'+pdate);\n'
										+'	fileservices.DeleteLogicalFile(LN_PropertyV2_Fast.Filenames.exprt.addl_names+\'_\'+pdate);\n'
										+'	fileservices.DeleteLogicalFile(LN_PropertyV2_Fast.Filenames.exprt.addl_legal+\'_\'+pdate);\n'
										+'	fileservices.DeleteLogicalFile(LN_PropertyV2_Fast.Filenames.exprt.search_prp+\'_\'+pdate);\n'
										+'	return true;\n'
										+'end;\n'
										+'LN_PropertyV2_Fast.proc_Extract_Property(\''+next_version+'\',\''+max_date+'\','+is_Fast+',\''+emails_To_Notify+'\') : success(sequential(deleteexportfiles('+next_version+')));\n';

launch_export			:= _Control.fSubmitNewWorkunit(ecl_for_export,'thor400_20');

checkIfExportShouldBeRun := sequential( output(max_date,named('max_date'));
																				output(last_extract,named('Last_extract_version'));
																				output(Prod_Version,named('Prod_Version'));
																				output(Is_new_version,named('New_Version_Released'));
																				output(next_version,named('next_version'));
																				output(is_fast,named('is_fast'));																
																				output(ut.getTimeDate()[1..10]+' '+ut.getTimeDate()[11..],named('Last_Checked')),
																				if(Is_new_version,sequential(launch_export)));

#workunit('name','Property OKC Export Monitor');

checkIfExportShouldBeRun :when(cron('45 12 * * 5')); // 8:45AM EDT - 7:45AM EST (UTC -4/5), every Friday
