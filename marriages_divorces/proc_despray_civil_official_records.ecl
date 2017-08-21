#workunit('name', 'Marriage divorce - civil/official records')
import _control;

export proc_despray_civil_official_records(string date_pattern) := function

	mardiv_civil_matter_last_build_ds := FileServices.SuperFileContents('~thor_200::out::marriage_divorce_civil_matter_last_build');
	mardiv_civil_party_last_build_ds := FileServices.SuperFileContents('~thor_200::out::marriage_divorce_civil_party_last_build');
	civil_matter_ds := FileServices.LogicalFileList('thor_200::base::civil_matter_filtered_for_marrdiv'+ date_pattern + '*');
	civil_party_ds := FileServices.LogicalFileList('thor_200::base::civil_party_filtered_for_marrdiv'+ date_pattern +'*');

	marrdiv_official_records_last_build_ds := FileServices.SuperFileContents('~thor_200::out::marriage_divorce_official_records_last_build');
	official_records_ds := FileServices.SuperFileContents('~thor_200::base::official_records_party');
	
	mardiv_official_records := marriages_divorces.extract_official_records_marriage_divorces;
	
	despray_official_records := fileservices.despray(
							'~thor_200::out::official_records_marriage_divorce_party',
							_control.IPAddress.edata10,
							'/data_build_5/marriage_divorces/in/official_records/official_records_marriage_divorce_party.d00',
							,,, true);
							
	add_officialrecords_super := sequential(
									FileServices.StartSuperFileTransaction(),
									fileservices.clearsuperfile('~thor_200::out::marriage_divorce_official_records_last_build'),
									fileservices.addsuperfile('~thor_200::out::marriage_divorce_official_records_last_build', nothor('~'+official_records_ds[1].name)),
									FileServices.FinishSuperFileTransaction()
								);
	
	run_official_records := sequential(mardiv_official_records, despray_official_records, add_officialrecords_super);
	
	chk_officialrecords_build := if (nothor(official_records_ds[1].name != marrdiv_official_records_last_build_ds[1].name),
									run_official_records,
									output('No new official records build  available'));
	
	prev_month_dt_pattern := (string)((integer)date_pattern - 1);
	
	civil_matter_last_build_file := mardiv_civil_matter_last_build_ds[1].name;
	civil_party_last_build_file := mardiv_civil_party_last_build_ds[1].name;
	civil_matter_file := if (count(civil_matter_ds) > 0,
							 civil_matter_ds[1].name,
							 FileServices.LogicalFileList('thor_200::base::civil_matter_filtered_for_marrdiv'+ prev_month_dt_pattern + '*')[1].name);
	civil_party_file := if(count(civil_party_ds) > 0,
							civil_party_ds[1].name,
							FileServices.LogicalFileList('thor_200::base::civil_party_filtered_for_marrdiv'+ prev_month_dt_pattern +'*')[1].name);
	
	despray_civil_matter := fileservices.despray('~'+nothor(civil_matter_file), _control.IPAddress.edata10, '/data_build_5/marriage_divorces/in/civil/civil_matter.d00',,,, true);
	despray_civil_party := fileservices.despray('~'+nothor(civil_party_file), _control.IPAddress.edata10, '/data_build_5/marriage_divorces/in/civil/civil_party.d00',,,, true);
	
	add_civil_super := sequential(
									FileServices.StartSuperFileTransaction(),
									fileservices.clearsuperfile('~thor_200::out::marriage_divorce_civil_matter_last_build'),
									fileservices.addsuperfile('~thor_200::out::marriage_divorce_civil_matter_last_build', '~'+nothor(civil_matter_file)),
									fileservices.clearsuperfile('~thor_200::out::marriage_divorce_civil_party_last_build'),
									fileservices.addsuperfile('~thor_200::out::marriage_divorce_civil_party_last_build', '~'+nothor(civil_party_file)),
									FileServices.FinishSuperFileTransaction()
								);
	
	chk_civil_build := if (nothor(civil_matter_file != civil_matter_last_build_file and civil_party_file != civil_party_last_build_file),
							parallel(despray_civil_matter, despray_civil_party, add_civil_super),
							output('No new civil build avialable'));
							
	return sequential(chk_officialrecords_build, chk_civil_build);
end;