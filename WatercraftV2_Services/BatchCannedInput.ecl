/***************************************************************************************
	Sample input file for testing batch services.
 ***************************************************************************************/
tmp_layout := record
	WatercraftV2_Services.Layouts.batch_in.acctno;
	WatercraftV2_Services.Layouts.batch_in.did;	
	WatercraftV2_Services.Layouts.batch_in.name_last;
	WatercraftV2_Services.Layouts.batch_in.name_first;
	WatercraftV2_Services.Layouts.batch_in.addr;
	WatercraftV2_Services.Layouts.batch_in.prim_range;
	WatercraftV2_Services.Layouts.batch_in.predir;
	WatercraftV2_Services.Layouts.batch_in.prim_name;
	WatercraftV2_Services.Layouts.batch_in.addr_suffix;
	WatercraftV2_Services.Layouts.batch_in.sec_range;
	WatercraftV2_Services.Layouts.batch_in.p_city_name;
	WatercraftV2_Services.Layouts.batch_in.st;
	WatercraftV2_Services.Layouts.batch_in.z5;
	WatercraftV2_Services.Layouts.batch_in.ssn;
	WatercraftV2_Services.Layouts.batch_in.dob;
end;

_canned_recs := dataset([									
									{'001', '003023269958', '', '', '',	'',	'','','', '','','', '','',''}	,
									{'002', '', 'ADAMS', 'CORY', '', '', '', '', '', '', 'RICHVILLE', 'MN', '56576','',''},
									{'003', '', 'ADAMS', 'DALE', '', '', '', '', '', '', 'PRINEVILLE', 'OR', '','',''}			
									], tmp_layout);

EXPORT BatchCannedInput := project(_canned_recs, TRANSFORM(WatercraftV2_Services.Layouts.batch_in, SELF := LEFT, SELF := []));				