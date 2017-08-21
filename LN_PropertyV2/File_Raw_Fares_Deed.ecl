import LN_PropertyV2, ut;

ds_d := dataset('~thor_data400::in::property::raw::frs::deed_archive', LN_PropertyV2.Layout_Raw_Fares.Payload_Deed, flat);

	LN_PropertyV2.Layout_Raw_Fares.Payload_Deed filterRec(ds_d l):= transform
		self.payload := stringlib.StringFilter(l.payload, ' !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVW XYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~');
	end;

ds_deed_payload := project(ds_d, filterRec(left));

	LN_PropertyV2.Layout_Raw_Fares.Input_Deed recComm(ds_deed_payload l):= transform
		self.fips := l.payload[1..5];
		self.fips_sub_code := l.payload[6..8];
		self.municipality_code := l.payload[9..14];
		self.apn_parcel_number_unformatted := l.payload[15..59];
		self.apn_parcel_number_formatted := l.payload[60..104];
		self.apn_sequence_number := l.payload[105..107];
		self.original_apn := l.payload[108..152];
		self.account_number := l.payload[153..167];
		self.corporate_indicator := l.payload[168..168];
		self.owner_buyer_last_name := l.payload[169..198];
		self.owner_buyer_first_name := l.payload[199..230];
		self.owner_etal_ind := l.payload[231..231];
		self.c_o_name := l.payload[232..251];
		self.owner_relationship_rights_code := l.payload[252..254];
		self.owner_relationship_type := l.payload[255..256];
		self.owner_house_number_prefix := l.payload[257..261];
		self.owner_house_number := l.payload[262..271];
		self.owner_house_number_suffix := l.payload[272..281];
		self.owner_street_direction := l.payload[282..283];
		self.owner_street_name := l.payload[284..313];
		self.owner_mode := l.payload[314..318];
		self.owner_quadrant := l.payload[319..320];
		self.owner_apartment_unit := l.payload[321..326];
		self.owner_city := l.payload[327..366];
		self.owner_state := l.payload[367..368];
		self.owner_zip_code := l.payload[369..377];
		self.carrier_code := l.payload[378..381];
		self.match_code := l.payload[382..385];
		self.address_indicator := l.payload[386..386];
		self.prop_house_number_prefix := l.payload[387..391];
		self.prop_house_number := l.payload[392..401];
		self.prop_house_number_suffix := l.payload[402..411];
		self.prop_street_name := l.payload[412..441];
		self.prop_mode := l.payload[442..446];
		self.prop_direction := l.payload[447..448];
		self.prop_quadrant := l.payload[449..450];
		self.prop_apt_unit_num := l.payload[451..456];
		self.prop_city := l.payload[457..496];
		self.prop_state := l.payload[497..498];
		self.prop_property_address_zip_code_ := l.payload[499..507];
		self.carrier_code1 := l.payload[508..511];
		self.batch_id := l.payload[512..523];
		self.batch_seq := l.payload[524..528];
		self.document_year := l.payload[529..532];
		self.seller_name := l.payload[533..592];
		self.sale_amount := l.payload[593..603];
		self.mortgage_amount := l.payload[604..614];
		self.sale_date_yyyymmdd := l.payload[615..622];
		self.recording_date_yyyymmdd := l.payload[623..630];
		self.document_type := l.payload[631..633];
		self.transaction_type := l.payload[634..636];
		self.document_number := l.payload[637..648];
		self.book_page_6x6 := l.payload[649..660];
		self.lender_last_name := l.payload[661..690];
		self.lender_first_name := l.payload[691..720];
		self.lender_address := l.payload[721..780];
		self.mortgage_company_code := l.payload[781..790];
		self.sale_code := l.payload[791..791];
		self.sales_transaction_code := l.payload[792..794];
		self.multi_apn := l.payload[795..795];
		self.multi_apn_count := l.payload[796..799];
		self.title_company_code := l.payload[800..804];
		self.residential_model_indicator := l.payload[805..805];
		self.mortgage_date := l.payload[806..813];
		self.mortgage_loan_type_code := l.payload[814..818];
		self.mortgage_deed_type := l.payload[819..824];
		self.mortgage_term_code := l.payload[825..828];
		self.mortgage_term := l.payload[829..833];
		self.mortgage_due_date := l.payload[834..841];
		self.mortgage_assumption_amount := l.payload[842..852];
		self.second_mortgage_amount := l.payload[853..863];
		self.second_mortgage_loan_type_code := l.payload[864..868];
		self.second_deed_type := l.payload[869..874];
		self.prior_doc_year := l.payload[875..878];
		self.prior_doc_number := l.payload[879..890];
		self.prior_book_page := l.payload[891..902];
		self.prior_sales_deed_category_code := l.payload[903..903];
		self.prior_recording_date := l.payload[904..911];
		self.prior_sales_date := l.payload[912..919];
		self.prior_sales_price := l.payload[920..930];
		self.prior_sales_code := l.payload[931..931];
		self.prior_sales_transaction_code := l.payload[932..934];
		self.prior_multi_apn_flag := l.payload[935..935];
		self.prior_multi_apn_count := l.payload[936..939];
		self.prior_mortgage_amount := l.payload[940..950];
		self.prior_deed_type := l.payload[951..951];
		self.absentee_indicator := l.payload[952..952];
		self.property_indicator_code := l.payload[953..954];
		self.building_square_feet := l.payload[955..963];
		self.partial_interest_indicator := l.payload[964..964];
		self.ownership_transfer_percentage := l.payload[965..967];
		self.universal_luse_code := l.payload[968..970];
		self.pri_cat_code := l.payload[971..972];
		self.mortgage_interest_rate_type := l.payload[973..975];
		self.title_company_name := l.payload[976..1035];
		self.seller_carry_back := l.payload[1036..1036];
		self.private_party_lender := l.payload[1037..1037];
		self.construction_loan := l.payload[1038..1038];
		self.resale_new_construction_m_resale_n_new_const := l.payload[1039..1039];
		self.inter_family := l.payload[1040..1040];
		self.cash_mortgage_purchase_q_cash_r_mortgage := l.payload[1041..1041];
		self.foreclosure := l.payload[1042..1042];
		self.refi_flag := l.payload[1043..1043];
		self.equity_flag := l.payload[1044..1044];
		self.tract := l.payload[1045..1050];
		self.block_group := l.payload[1051..1051];
		self.block := l.payload[1052..1053];
		self.block_suffix := l.payload[1054..1054];
		self.latitude_6_2 := l.payload[1055..1062];
		self.longitude_3_6 := l.payload[1063..1071];
		self.filler := l.payload[1072..1080];
		self.iris_apn := l.payload[1081..1140];
		self.crlf := l.payload[1141..1142];
	end;

EXPORT File_Raw_Fares_Deed := project(ds_deed_payload, recComm(left));