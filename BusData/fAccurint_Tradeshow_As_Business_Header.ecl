import Business_Header, ut, address,mdr;

export fAccurint_Tradeshow_As_Business_Header(

	 dataset(Layout_aca_internet_march_success_in	)	paca_internet_march_success = File_aca_internet_march_success_in
	,dataset(Layout_ace_check_serv_in							)	pace_check_serv_in 					= File_ace_check_serv_in
	,dataset(Layout_ace_icsp_in										)	pace_icsp_in								= File_ace_icsp_in
	,dataset(Layout_ace_international_in					)	pace_international_in				= File_ace_international_in
	,dataset(Layout_card_tech_securtech_in				)	pcard_tech_securtech_in			= File_card_tech_securtech_in
	,dataset(Layout_customer_info_system_in				)	pcustomer_info_system_in		= File_customer_info_system_in
	,dataset(Layout_factoring_conference_in				)	pfactoring_conference_in		= File_factoring_conference_in
	,dataset(Layout_factory_conference_in					)	pfactory_conference_in			= File_factory_conference_in
	,dataset(Layout_ins_fraud_manage_in						)	pins_fraud_manage_in				= File_ins_fraud_manage_in
	,dataset(Layout_las_vegas_recruit_expo_in			)	plas_vegas_recruit_expo_in	= File_las_vegas_recruit_expo_in
                                              
) :=
function

	// aca_internet_march_success
	Business_Header.Layout_Business_Header_New Extract_aca_internet_march_success(BusData.Layout_aca_internet_march_success_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_aca_internet_march_success +  '_' + 'aca_internet_march_success';
	self.dt_first_seen := (unsigned4)Busdata.Date_aca_internet_march_success;
	self.dt_last_seen := (unsigned4)Busdata.Date_aca_internet_march_success;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_aca_internet_march_success;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_aca_internet_march_success;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_aca_internet_march_success := project(paca_internet_march_success, Extract_aca_internet_march_success(left));

	// ace_check_serv
	Business_Header.Layout_Business_Header_New Extract_ace_check_serv(BusData.Layout_ace_check_serv_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_ace_check_serv + '_' + 'ace_check_serv';
	self.dt_first_seen := (unsigned4)Busdata.Date_ace_check_serv;
	self.dt_last_seen := (unsigned4)Busdata.Date_ace_check_serv;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_ace_check_serv;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_ace_check_serv;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ace_check_serv := project(pace_check_serv_in, Extract_ace_check_serv(left));

	// ace_icsp
	Business_Header.Layout_Business_Header_New Extract_ace_icsp(BusData.Layout_ace_icsp_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_ace_icsp + '_' + 'ace_icsp';
	self.dt_first_seen := (unsigned4)Busdata.Date_ace_icsp;
	self.dt_last_seen := (unsigned4)Busdata.Date_ace_icsp;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_ace_icsp;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_ace_icsp;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ace_icsp := project(pace_icsp_in, Extract_ace_icsp(left));

	// ace_international
	Business_Header.Layout_Business_Header_New Extract_ace_international(BusData.Layout_ace_international_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_ace_international + '_' + 'ace_international';
	self.dt_first_seen := (unsigned4)Busdata.Date_ace_international;
	self.dt_last_seen := (unsigned4)Busdata.Date_ace_international;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_ace_international;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_ace_international;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ace_international := project(pace_international_in, Extract_ace_international(left));

	// card_tech_securtech
	Business_Header.Layout_Business_Header_New Extract_card_tech_securtech(BusData.Layout_card_tech_securtech_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_card_tech_securtech + '_' + 'card_tech_securtech';
	self.dt_first_seen := (unsigned4)Busdata.Date_card_tech_securtech;
	self.dt_last_seen := (unsigned4)Busdata.Date_card_tech_securtech;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_card_tech_securtech;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_card_tech_securtech;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.prim_range := '';
	self.predir := '';
	self.prim_name := '';
	self.addr_suffix := '';
	self.postdir := '';
	self.unit_desig := '';
	self.sec_range := '';
	self.city := '';
	self.state := '';
	self.zip := 0;
	self.zip4 := 0;
	self.county := '';
	self.msa := '';
	self.geo_lat := '';
	self.geo_long := '';
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	end;

	tradeshow_card_tech_securtech := project(pcard_tech_securtech_in, Extract_card_tech_securtech(left));

	// customer_info_system
	Business_Header.Layout_Business_Header_New Extract_customer_info_system(BusData.Layout_customer_info_system_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_customer_info_system + '_' + 'customer_info_system';
	self.dt_first_seen := (unsigned4)Busdata.Date_customer_info_system;
	self.dt_last_seen := (unsigned4)Busdata.Date_customer_info_system;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_customer_info_system;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_customer_info_system;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_customer_info_system := project(pcustomer_info_system_in, Extract_customer_info_system(left));

	// factoring_conference
	Business_Header.Layout_Business_Header_New Extract_factoring_conference(BusData.Layout_factoring_conference_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_factoring_conference + '_' + 'factoring_conference';
	self.dt_first_seen := (unsigned4)Busdata.Date_factoring_conference;
	self.dt_last_seen := (unsigned4)Busdata.Date_factoring_conference;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_factoring_conference;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_factoring_conference;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_factoring_conference := project(pfactoring_conference_in, Extract_factoring_conference(left));

	// factory_conference
	Business_Header.Layout_Business_Header_New Extract_factory_conference(BusData.Layout_factory_conference_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_factory_conference + '_' + 'factory_conference';
	self.dt_first_seen := (unsigned4)Busdata.Date_factory_conference;
	self.dt_last_seen := (unsigned4)Busdata.Date_factory_conference;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_factory_conference;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_factory_conference;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_factory_conference := project(pfactory_conference_in, Extract_factory_conference(left));

	// ins_fraud_manage
	Business_Header.Layout_Business_Header_New Extract_ins_fraud_manage(BusData.Layout_ins_fraud_manage_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_ins_fraud_manage + '_' + 'ins_fraud_manage';
	self.dt_first_seen := (unsigned4)Busdata.Date_ins_fraud_manage;
	self.dt_last_seen := (unsigned4)Busdata.Date_ins_fraud_manage;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_ins_fraud_manage;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_ins_fraud_manage;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ins_fraud_manage := project(pins_fraud_manage_in, Extract_ins_fraud_manage(left));

	// las_vegas_recruit_expo
	Business_Header.Layout_Business_Header_New Extract_las_vegas_recruit_expo(BusData.Layout_las_vegas_recruit_expo_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;          // Source file type
	self.source_group := '';
	self.vendor_id := Busdata.Date_las_vegas_recruit_expo + '_' + 'las_vegas_recruit_expo';
	self.dt_first_seen := (unsigned4)Busdata.Date_las_vegas_recruit_expo;
	self.dt_last_seen := (unsigned4)Busdata.Date_las_vegas_recruit_expo;
	self.dt_vendor_first_reported := (unsigned4)Busdata.Date_las_vegas_recruit_expo;
	self.dt_vendor_last_reported := (unsigned4)Busdata.Date_las_vegas_recruit_expo;
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.current := true;          // Current/Historical indicator
	self := l;
	end;

	tradeshow_las_vegas_recruit_expo := project(plas_vegas_recruit_expo_in, Extract_las_vegas_recruit_expo(left));

	tradeshow_init := tradeshow_aca_internet_march_success +
					  tradeshow_ace_check_serv +
				   tradeshow_ace_icsp +
				   tradeshow_ace_international +
				   tradeshow_card_tech_securtech +
				   tradeshow_customer_info_system +
				   tradeshow_factoring_conference +
				   tradeshow_factory_conference +
				   tradeshow_ins_fraud_manage +
				   tradeshow_las_vegas_recruit_expo;
				   
	// Rollup
	Business_Header.Layout_Business_Header_New RollupTradeshow(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := TRANSFORM
	SELF.dt_first_seen := 
				ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	SELF.dt_last_seen := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	SELF.company_name := IF(L.company_name = '', R.company_name, L.company_name);
	SELF.group1_id := IF(L.group1_id = 0, R.group1_id, L.group1_id);
	SELF.vendor_id := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.vendor_id = '', R.vendor_id, L.vendor_id);
	SELF.source_group := IF((L.group1_id = 0 AND R.group1_id <> 0) OR
						 L.source_group = '', R.source_group, L.source_group);
	SELF.phone := IF(L.phone = 0, R.phone, L.phone);
	SELF.phone_score := IF(L.phone = 0, R.phone_score, L.phone_score);
	SELF.fein := IF(L.fein = 0, R.fein, L.fein);
	SELF.prim_range := IF(l.prim_range = '' AND l.zip4 = 0, r.prim_range, l.prim_range);
	SELF.predir := IF(l.predir = '' AND l.zip4 = 0, r.predir, l.predir);
	SELF.prim_name := IF(l.prim_name = '' AND l.zip4 = 0, r.prim_name, l.prim_name);
	SELF.addr_suffix := IF(l.addr_suffix = '' AND l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	SELF.postdir := IF(l.postdir = '' AND l.zip4 = 0, r.postdir, l.postdir);
	SELF.unit_desig := IF(l.unit_desig = ''AND l.zip4 = 0, r.unit_desig, l.unit_desig);
	SELF.sec_range := IF(l.sec_range = '' AND l .zip4 = 0, r.sec_range, l.sec_range);
	SELF.city := IF(l.city = '' AND l.zip4 = 0, r.city, l.city);
	SELF.state := IF(l.state = '' AND l.zip4 = 0, r.state, l.state);
	SELF.zip := IF(l.zip = 0 AND l.zip4 = 0, r.zip, l.zip);
	SELF.zip4 := IF(l.zip4 = 0, r.zip4, l.zip4);
	SELF.county := IF(l.county = '' AND l.zip4 = 0, r.county, l.county);
	SELF.msa := IF(l.msa = '' AND l.zip4 = 0, r.msa, l.msa);
	SELF.geo_lat := IF(l.geo_lat = '' AND l.zip4 = 0, r.geo_lat, l.geo_lat);
	SELF.geo_long := IF(l.geo_long = '' AND l.zip4 = 0, r.geo_long, l.geo_long);
	SELF := L;
	END;

	tradeshow_dist := DISTRIBUTE(tradeshow_init(company_name <> ''),
						HASH(zip, TRIM(prim_name), TRIM(prim_range), TRIM(source_group), TRIM(company_name)));

	tradeshow_sort := SORT(tradeshow_dist, zip, prim_range, prim_name, source_group, company_name,
						IF(sec_range <> '', 0, 1), sec_range,
						IF(phone <> 0, 0, 1), phone,
						IF(fein <> 0, 0, 1), fein,
						dt_vendor_last_reported, dt_vendor_first_reported, dt_last_seen, LOCAL);

	tradeshow_rollup := ROLLUP(tradeshow_sort,
						left.zip = right.zip and
						  left.prim_name = right.prim_name and
						  left.prim_range = right.prim_range and
						  left.company_name = right.company_name and
						  left.source_group = right.source_group and
						  (right.sec_range = '' OR left.sec_range = right.sec_range) and
						  (right.phone = 0 OR left.phone = right.phone) and
						  (right.fein = 0 OR left.fein = right.fein),
						RollupTradeshow(LEFT, RIGHT),
						LOCAL);

	return tradeshow_rollup;

end;