import ut, address, Business_Header, Busdata,mdr;

export fAccurint_Tradeshow_As_Business_Contact(

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

	// Extract main phone number
	string ExtractPhone(string phone) := map(stringlib.stringfind(phone, 'e', 1) > 0 => trim(phone[1..(stringlib.stringfind(phone, 'e', 1) - 1)]),
											 stringlib.stringfind(phone, 'E', 1) > 0 => trim(phone[1..(stringlib.stringfind(phone, 'E', 1) - 1)]),
									 trim(phone));

	// aca_internet_march_success
	Business_Header.Layout_Business_Contact_Full_New Extract_aca_internet_march_success(BusData.Layout_aca_internet_march_success_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_aca_internet_march_success +  '_' + 'aca_internet_march_success';
	self.dt_first_seen := (unsigned4)Busdata.Date_aca_internet_march_success;
	self.dt_last_seen := (unsigned4)Busdata.Date_aca_internet_march_success;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := '';
	self.company_title := '';
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_aca_internet_march_success := project(paca_internet_march_success, Extract_aca_internet_march_success(left));

	// ace_check_serv
	Business_Header.Layout_Business_Contact_Full_New Extract_ace_check_serv(BusData.Layout_ace_check_serv_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_ace_check_serv +  '_' + 'ace_check_serv';
	self.dt_first_seen := (unsigned4)Busdata.Date_ace_check_serv;
	self.dt_last_seen := (unsigned4)Busdata.Date_ace_check_serv;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := '';
	self.company_title := '';
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ace_check_serv := project(pace_check_serv_in, Extract_ace_check_serv(left));

	// ace_icsp
	Business_Header.Layout_Business_Contact_Full_New Extract_ace_icsp(BusData.Layout_ace_icsp_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_ace_icsp +  '_' + 'ace_icsp';
	self.dt_first_seen := (unsigned4)Busdata.Date_ace_icsp;
	self.dt_last_seen := (unsigned4)Busdata.Date_ace_icsp;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := '';
	self.company_title := '';
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ace_icsp := project(pace_icsp_in, Extract_ace_icsp(left));

	// ace_international
	Business_Header.Layout_Business_Contact_Full_New Extract_ace_international(BusData.Layout_ace_international_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_ace_international +  '_' + 'ace_international';
	self.dt_first_seen := (unsigned4)Busdata.Date_ace_international;
	self.dt_last_seen := (unsigned4)Busdata.Date_ace_international;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := '';
	self.company_title := '';
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ace_international := project(pace_international_in, Extract_ace_international(left));

	// card_tech_securtech
	Business_Header.Layout_Business_Contact_Full_New Extract_card_tech_securtech(BusData.Layout_card_tech_securtech_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_card_tech_securtech +  '_' + 'card_tech_securtech';
	self.dt_first_seen := (unsigned4)Busdata.Date_card_tech_securtech;
	self.dt_last_seen := (unsigned4)Busdata.Date_card_tech_securtech;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
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
	self.email_address := '';
	self.company_title := Stringlib.StringToUpperCase(l.Title);
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := '';
	self.company_predir := '';
	self.company_prim_name := '';
	self.company_addr_suffix := '';
	self.company_postdir := '';
	self.company_unit_desig := '';
	self.company_sec_range := '';
	self.company_city := '';
	self.company_state := '';
	self.company_zip := 0;
	self.company_zip4 := 0;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	end;

	tradeshow_card_tech_securtech := project(pcard_tech_securtech_in, Extract_card_tech_securtech(left));

	// customer_info_system
	Business_Header.Layout_Business_Contact_Full_New Extract_customer_info_system(BusData.Layout_customer_info_system_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_customer_info_system +  '_' + 'customer_info_system';
	self.dt_first_seen := (unsigned4)Busdata.Date_customer_info_system;
	self.dt_last_seen := (unsigned4)Busdata.Date_customer_info_system;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := l.Email_Address;
	self.company_title := Stringlib.StringToUpperCase(l.Title);
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_customer_info_system := project(pcustomer_info_system_in, Extract_customer_info_system(left));

	// factoring_conference
	Layout_factoring_conference_temp := record
	BusData.Layout_factoring_conference_in;
	string73 clean_name;
	end;

	Layout_factoring_conference_temp Norm_factoring_conference(BusData.Layout_factoring_conference_in l, unsigned1 c) := transform
	self.clean_name := choose(c, address.CleanPerson73(l.Name1),
								 address.CleanPerson73(l.Name2),
								 address.CleanPerson73(l.Name3),
								 address.CleanPerson73(l.Name_4),
								 address.CleanPerson73(l.Name_5),
								 address.CleanPerson73(l.Name_6),
								 address.CleanPerson73(l.Name_7),
								 address.CleanPerson73(l.Name_8));
							self := l;
	end;

	factoring_conference_norm := normalize(pfactoring_conference_in, 8, Norm_factoring_conference(left, counter));

	Business_Header.Layout_Business_Contact_Full_New Extract_factoring_conference(Layout_factoring_conference_temp l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_factoring_conference +  '_' + 'factoring_conference';
	self.dt_first_seen := (unsigned4)Busdata.Date_factoring_conference;
	self.dt_last_seen := (unsigned4)Busdata.Date_factoring_conference;
	self.title := L.clean_name[1..5];
	self.fname := L.clean_name[6..25];
	self.mname := L.clean_name[26..45];
	self.lname := L.clean_name[46..65];
	self.name_suffix := L.clean_name[66..70];
	self.name_score := Business_Header.CleanName(self.fname, self.mname, self.lname, self.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := '';
	self.company_title := '';
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_factoring_conference := project(factoring_conference_norm(clean_name[46..65] <> ''), Extract_factoring_conference(left));

	// factory_conference
	Business_Header.Layout_Business_Contact_Full_New Extract_factory_conference(BusData.Layout_factory_conference_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_factory_conference +  '_' + 'factory_conference';
	self.dt_first_seen := (unsigned4)Busdata.Date_factory_conference;
	self.dt_last_seen := (unsigned4)Busdata.Date_factory_conference;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := (unsigned6)address.CleanPhone(ExtractPhone(l.Phone));
	self.email_address := '';
	self.company_title := '';
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_factory_conference := project(pfactory_conference_in, Extract_factory_conference(left));

	// ins_fraud_manage
	Business_Header.Layout_Business_Contact_Full_New Extract_ins_fraud_manage(BusData.Layout_ins_fraud_manage_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_ins_fraud_manage +  '_' + 'ins_fraud_manage';
	self.dt_first_seen := (unsigned4)Busdata.Date_ins_fraud_manage;
	self.dt_last_seen := (unsigned4)Busdata.Date_ins_fraud_manage;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.email_address := '';
	self.company_title := Stringlib.StringToUpperCase(l.Position);
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
	self := l;
	end;

	tradeshow_ins_fraud_manage := project(pins_fraud_manage_in, Extract_ins_fraud_manage(left));

	// las_vegas_recruit_expo
	Business_Header.Layout_Business_Contact_Full_New Extract_las_vegas_recruit_expo(BusData.Layout_las_vegas_recruit_expo_in l) := transform
	self.source := MDR.sourceTools.src_Accurint_Trade_Show;
	self.vendor_id := Busdata.Date_las_vegas_recruit_expo +  '_' + 'las_vegas_recruit_expo';
	self.dt_first_seen := (unsigned4)Busdata.Date_las_vegas_recruit_expo;
	self.dt_last_seen := (unsigned4)Busdata.Date_las_vegas_recruit_expo;
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.name_suffix := l.name_suffix;
	self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142],
	self.city := l.v_city_name;
	self.state := l.st;
	self.zip := (unsigned3)l.zip;
	self.zip4 := (unsigned2)l.zip4;
	self.county := l.fipscounty;
	self.phone := 0;
	self.email_address := '';
	self.company_title := Stringlib.StringToUpperCase(l.Title);
	self.company_source_group := '';
	self.company_name := Stringlib.StringToUpperCase(l.Company_Name);
	self.company_prim_range := l.prim_range;
	self.company_predir := l.predir;
	self.company_prim_name := l.prim_name;
	self.company_addr_suffix := l.addr_suffix;
	self.company_postdir := l.postdir;
	self.company_unit_desig := l.unit_desig;
	self.company_sec_range := l.sec_range;
	self.company_city := l.v_city_name;
	self.company_state := l.st;
	self.company_zip := (unsigned3)l.zip;
	self.company_zip4 := (unsigned2)l.zip4;
	self.company_phone := 0;
	self.record_type := 'C';          // Current/Historical indicator
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

	return tradeshow_init((INTEGER)name_score < 3,
				  Business_Header.CheckPersonName(fname, mname, lname, name_suffix));
				  
end;