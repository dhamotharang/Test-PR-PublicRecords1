IMPORT PromoteSupers, PRTE2, STD, ut, Address, AID, codes, govdata, MDR;

EXPORT Proc_Build_Base(string pversion) := FUNCTION

	//uppercase and remove spaces from in file
  PRTE2.CleanFields(Files.FDIC_In, In_FCID_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(Files.IRS_In, In_IRS_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(Files.Salestax_CA_In, In_SALESTAX_CA_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(Files.Salestax_IA_In, In_SALESTAX_IA_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(Files.Sec_Broker_In, In_SEC_BROKER_clean_fields); //(Input,OutFile)

	Temp_FDIC_rec:=record
		RECORDOF(In_FCID_clean_fields);
		string2 source;
	end;
	
	Temp_FDIC_rec generate_FDIC_sounce_rec_id(In_FCID_clean_fields L) := transform
		self.source_rec_id :=	hash64(ut.CleanSpacesAndUpper(l.state) + ut.CleanSpacesAndUpper(l.cert) + ut.CleanSpacesAndUpper(l.docket) + ut.CleanSpacesAndUpper(l.active) + 
								ut.CleanSpacesAndUpper(l.address) + ut.CleanSpacesAndUpper(l.asset) + ut.CleanSpacesAndUpper(l.bkclass) + 
								ut.CleanSpacesAndUpper(l.conserve) + ut.CleanSpacesAndUpper(l.city) + ut.CleanSpacesAndUpper(l.clcode) + ut.CleanSpacesAndUpper(l.dateupdt) + 
								ut.CleanSpacesAndUpper(l.denovo) + ut.CleanSpacesAndUpper(l.dep) + ut.CleanSpacesAndUpper(l.effdate) + ut.CleanSpacesAndUpper(l.endefymd) + 
								ut.CleanSpacesAndUpper(l.insfdic) + ut.CleanSpacesAndUpper(l.primary_name_of_organization) + ut.CleanSpacesAndUpper(l.newcert) + ut.CleanSpacesAndUpper(l.oakar) + 
								ut.CleanSpacesAndUpper(l.occdist) + ut.CleanSpacesAndUpper(l.otsdist) + ut.CleanSpacesAndUpper(l.procdate) + ut.CleanSpacesAndUpper(l.qbprcoml) + 
								ut.CleanSpacesAndUpper(l.roaq) + ut.CleanSpacesAndUpper(l.roe) + ut.CleanSpacesAndUpper(l.roeq) +  
								ut.CleanSpacesAndUpper(l.stalp) + ut.CleanSpacesAndUpper(l.stcnty) + ut.CleanSpacesAndUpper(l.webaddr) + 
								ut.CleanSpacesAndUpper(l.zip_code) + ut.CleanSpacesAndUpper(l.fldoff) + ut.CleanSpacesAndUpper(l.regagnt) + ut.CleanSpacesAndUpper(l.stcnty)); 
		self.source  := MDR.sourceTools.src_FDIC;
		self := l;	
	end;
	In_FCID_sequenced := project(In_FCID_clean_fields,generate_FDIC_sounce_rec_id(LEFT));
	
	Temp_IRS_NonProfit_rec:=record
		RECORDOF(In_IRS_clean_fields);
		string2 source;
	end;

	Temp_IRS_NonProfit_rec generate_IRS_sounce_rec_id(In_IRS_clean_fields l) := transform
		self.source_rec_id := hash64(trim(l.Employer_ID_Number,left,right) +  trim(l.Primary_Name_Of_Organization,left,right) +  trim(l.In_Care_Of_Name,left,right) + 
							trim(l.Street_Address,left,right) +  trim(l.City,left,right) + trim(l.State,left,right) + trim(l.Zip_Code,left,right) +  trim(l.Group_Exemption_Number,left,right) +  trim(l.Subsection_Code,left,right) + 
							trim(l.Affiliation_Code,left,right) +  trim(l.Classification_Code,left,right) + trim(l.Ruling_Date,left,right) +  trim(l.Deductibility_Code,left,right) +  trim(l.Foundation_Code,left,right) + 
							trim(l.Activity_Codes,left,right) +  trim(l.Organization_Code,left,right) +  trim(l.Univ_Loc_Code,left,right) +  trim(l.Advance_Ruling_Exp_Date,left,right) +  trim(l.Tax_Period,left,right) + 
							trim(l.Asset_Code,left,right) +  trim(l.Income_Code,left,right) +  trim(l.Filing_Requirement_Code_part1,left,right) +  trim(l.Filing_Requirement_Code_part2,left,right) + 
							trim(l.Accounting_Period,left,right) +  trim(l.Asset_Amount,left,right) +  trim(l.Income_Amount,left,right) +  trim(l.Negative_Sign,left,right) +  trim(l.Form_990_Revenue_Amount,left,right) + 
							trim(l.Negative_Rev_Amount,left,right) +  trim(l.National_Taxonomy_Exempt,left,right) +  trim(l.Sort_Name,left,right));
		self.source := MDR.sourceTools.src_IRS_Non_Profit;
		self := l;	
	end;
	In_IRS_sequenced := project(In_IRS_clean_fields,generate_IRS_sounce_rec_id(LEFT));

	Temp_CA_Sales_Tax_rec:=record
		RECORDOF(In_SALESTAX_CA_clean_fields);
		string2 source;
	end;

	Temp_CA_Sales_Tax_rec generate_CA_Sales_Tax_sounce_rec_id(In_SALESTAX_CA_clean_fields l) := transform
		self.source_rec_id := (unsigned8) (hash64(l.account_number, l.sub_account_number));			
		self.source   	   := MDR.sourceTools.src_CA_Sales_Tax;	
		self := l;	
	end;
	In_SALESTAX_CA_sequenced := project(In_SALESTAX_CA_clean_fields,generate_CA_Sales_Tax_sounce_rec_id(LEFT));

	Temp_IA_Sales_Tax_rec:=record
		RECORDOF(In_SALESTAX_IA_clean_fields);
		string2 source;
	end;

	Temp_IA_Sales_Tax_rec generate_IA_Sales_Tax_sounce_rec_id(In_SALESTAX_IA_clean_fields l) := transform
		self.source_rec_id := (unsigned8) (hash64(l.prep_location_addr_line1, l.prep_location_addr_line_last));			
		self.source   	   := MDR.sourceTools.src_IA_Sales_Tax;	
		self := l;	
	end;
	In_SALESTAX_IA_sequenced := project(In_SALESTAX_IA_clean_fields,generate_IA_Sales_Tax_sounce_rec_id(LEFT));

	Temp_SEC_BROKER_rec:=record
		RECORDOF(In_SEC_BROKER_clean_fields);
		string2 source;
	end;

	Temp_SEC_BROKER_rec generate_SEC_BROKER_sounce_rec_id(In_SEC_BROKER_clean_fields l) := transform
		self.source_rec_id := (INTEGER)l.bdid;			
		self.source   	   := MDR.sourceTools.src_SEC_Broker_Dealer;	
		self := l;	
	end;
	In_SEC_BROKER_sequenced := project(In_SEC_BROKER_clean_fields,generate_SEC_BROKER_sounce_rec_id(LEFT));

	//put all addresses in one file for cleaning
	In_FCID_Addr := PROJECT(In_FCID_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SElF := LEFT; 
																			 SElF := [];
                                       )
                             );

  	In_IRS_Addr := PROJECT(In_IRS_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SELF.source_rec_id := LEFT.source_rec_id;
									   SELF.zip_code := LEFT.Zip_Code[1..5];
                                       SElF := LEFT; 
																			 SElF := [];
                                       )
                             );

	In_SALESTAX_CA_Loc_Addr := PROJECT(In_SALESTAX_CA_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                    	SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.location_street;
										SELF.city := LEFT.location_city;
										SELF.state := LEFT.location_state;
										SELF.zip_code := LEFT.location_zip;
										SELF.location_type := 'Location';
                                       )
                             );

	In_SALESTAX_CA_Mail_Addr := PROJECT(In_SALESTAX_CA_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                    	SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.mailing_street;
										SELF.city := LEFT.mailing_city;
										SELF.state := LEFT.mailing_state;
										SELF.zip_code := LEFT.mailing_zip;
										SELF.location_type := 'Mail';
                                       )
                             );

	In_SALESTAX_IA_Loc_Addr := PROJECT(In_SALESTAX_IA_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                    	SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.location_street_1;
										SELF.city := LEFT.location_city;
										SELF.state := LEFT.location_state;
										SELF.zip_code := LEFT.location_zip_code;
										SELF.location_type := 'Location';
                                       )
                             );
	
	In_SALESTAX_IA_Mail_Addr := PROJECT(In_SALESTAX_IA_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                    	SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.mailing_street_1;
										SELF.city := LEFT.mailing_city;
										SELF.state := LEFT.mailing_state;
										SELF.zip_code := LEFT.mailing_zip_code;
										SELF.location_type := 'Mail';
                                       )
                             );

	In_SEC_BROKER_Addr := PROJECT(In_SEC_BROKER_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
										SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.address1;
										SELF.city := LEFT.city;
										SELF.state := LEFT.state_code;
										SELF.zip_code := LEFT.zip_code;
                                       SElF := LEFT; 
																			 SElF := [];
                                       )
                             );

	All_address := In_FCID_Addr+In_IRS_Addr+In_SALESTAX_CA_Loc_Addr+In_SALESTAX_CA_Mail_Addr+In_SALESTAX_IA_Loc_Addr+In_SALESTAX_IA_Mail_Addr+In_SEC_BROKER_Addr;
	
	//Address Cleaning
	addr_clean_all := PRTE2.AddressCleaner(All_address, //Incoming record set
                                            ['street_address'], //Set of names of fields containing street addresses
                                            ['city'+'state'+'zip_code'], //Set of names of fields containing city, state, and zip prepped and concatenated
                                            ['city'], //Set of fields containing unprepped city
                                            ['state'], //Set of fields containing unprepped state
                                            ['zip_code'], //Set of fields containing unprepped zip
                                            ['clean_address'], //Set of fieldnames where addresses will be put in Address.Layout_Clean182_fips layout
                                            ['clean_raw_aid']); //Set of fields where RawAIDs will be put.

	//transforming addresses and generating bdid and linkid
	FDIC_Base := JOIN(In_FCID_sequenced,
						addr_clean_all,
						LEFT.source_rec_id = RIGHT.source_rec_id,
						TRANSFORM(RECORDOF(Layouts.FDIC_Base_Layout),
							SELF.stname := codes.St2Name(RIGHT.clean_address.st);
							SELF.address := LEFT.street_address;
							SELF.endefymd := '12319999';
							SELF.name := LEFT.primary_name_of_organization;
							SELF.stcnty := RIGHT.clean_address.fips_state;
							SELF.county := RIGHT.clean_address.fips_county;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.APPEND_RAWAID := RIGHT.clean_raw_aid;
							SELF.prim_range := RIGHT.clean_address.prim_range;
							SELF.predir := RIGHT.clean_address.predir;
							SELF.prim_name := RIGHT.clean_address.prim_name;
							SELF.addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.postdir := RIGHT.clean_address.postdir;
							SELF.unit_desig := RIGHT.clean_address.unit_desig;
							SELF.sec_range := RIGHT.clean_address.sec_range;
							SELF.p_city_name := RIGHT.clean_address.p_city_name;
							SELF.v_city_name := RIGHT.clean_address.v_city_name;
							SELF.st := RIGHT.clean_address.st;
							SELF.zip := RIGHT.clean_address.zip;
							SELF.zip4 := RIGHT.clean_address.zip4;
							SELF.cart := RIGHT.clean_address.cart;
							SELF.cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.lot := RIGHT.clean_address.lot;
							SELF.lot_order := RIGHT.clean_address.lot_order;
							SELF.dpbc := RIGHT.clean_address.dbpc;
							SELF.chk_digit := RIGHT.clean_address.chk_digit;
							SELF.record_type := RIGHT.clean_address.rec_type;
							SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.fipscounty := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa_code := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
							//generating bid
							SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.primary_name_of_organization,	RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);
							//generating linkids
							vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.primary_name_of_organization, (string9)LEFT.link_fein, LEFT.link_inc_date, RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.sec_range, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);														
							SELF.powid	:= vLinkingIds.powid;
							SELF.proxid	:= vLinkingIds.proxid;
							SELF.seleid	:= vLinkingIds.seleid;
							SELF.orgid	:= vLinkingIds.orgid;
							SELF.ultid	:= vLinkingIds.ultid;	 
							SELF := LEFT;
							SELF := [];
						), LEFT OUTER, KEEP(1)
					);

	//transforming addresses and generating bdid and linkid
	IRS_Base := JOIN(In_IRS_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id,
						TRANSFORM(RECORDOF(Layouts.IRS_NonProfit_Base_Layout),
							SELF.sort_name := LEFT.primary_name_of_organization;
							CleanName := address.CleanPerson73_Fields(LEFT.in_care_of_name);
							SELF.FNAME := CleanName.Fname;
							SELF.LNAME := CleanName.Lname;
							SELF.MNAME := CleanName.Mname;
							SELF.CNAME := LEFT.primary_name_of_organization;
							SELF.APPEND_RAWAID := RIGHT.clean_raw_aid;
							SELF.prim_range := RIGHT.clean_address.prim_range;
							SELF.predir := RIGHT.clean_address.predir;
							SELF.prim_name := RIGHT.clean_address.prim_name;
							SELF.addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.postdir := RIGHT.clean_address.postdir;
							SELF.unit_desig := RIGHT.clean_address.unit_desig;
							SELF.sec_range := RIGHT.clean_address.sec_range;
							SELF.p_city_name := RIGHT.clean_address.p_city_name;
							SELF.v_city_name := RIGHT.clean_address.v_city_name;
							SELF.st := RIGHT.clean_address.st;
							SELF.zip := RIGHT.clean_address.zip;
							SELF.zip4 := RIGHT.clean_address.zip4;
							SELF.cart := RIGHT.clean_address.cart;
							SELF.cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.lot := RIGHT.clean_address.lot;
							SELF.lot_order := RIGHT.clean_address.lot_order;
							SELF.dbpc := RIGHT.clean_address.dbpc;
							SELF.chk_digit := RIGHT.clean_address.chk_digit;
							SELF.rec_type := RIGHT.clean_address.rec_type;
							SELF.bug_num := LEFT.bug_name;
							//SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.county := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
							//generating bid
							SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.primary_name_of_organization,	RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);
							//generating linkids
							vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.primary_name_of_organization, (string9)LEFT.link_fein, LEFT.link_inc_date, RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.sec_range, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);														
							SELF.powid	:= vLinkingIds.powid;
							SELF.proxid	:= vLinkingIds.proxid;
							SELF.seleid	:= vLinkingIds.seleid;
							SELF.orgid	:= vLinkingIds.orgid;
							SELF.ultid	:= vLinkingIds.ultid;	 
							SELF := LEFT;
							SELF := [];
						),LEFT OUTER, KEEP(1)                       
					);

	//transforming addresses and generating bdid and linkid
	SALESTAX_CA_Base_1 := JOIN(In_SALESTAX_CA_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id
						AND RIGHT.location_type = 'Location',
						TRANSFORM(RECORDOF(Layouts.CA_Sales_Tax_Base_Layout),
							SELF.prim_range := RIGHT.clean_address.prim_range;
							SELF.predir := RIGHT.clean_address.predir;
							SELF.prim_name := RIGHT.clean_address.prim_name;
							SELF.addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.postdir := RIGHT.clean_address.postdir;
							SELF.unit_desig := RIGHT.clean_address.unit_desig;
							SELF.sec_range := RIGHT.clean_address.sec_range;
							SELF.p_city_name := RIGHT.clean_address.p_city_name;
							SELF.v_city_name := RIGHT.clean_address.v_city_name;
							SELF.st := RIGHT.clean_address.st;
							SELF.zip := RIGHT.clean_address.zip;
							SELF.zip4 := RIGHT.clean_address.zip4;
							SELF.cart := RIGHT.clean_address.cart;
							SELF.cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.lot := RIGHT.clean_address.lot;
							SELF.lot_order := RIGHT.clean_address.lot_order;
							SELF.dpbc := RIGHT.clean_address.dbpc;
							SELF.chk_digit := RIGHT.clean_address.chk_digit;
							SELF.record_type := RIGHT.clean_address.rec_type;
							SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.fipscounty := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
							SELF.bug_num := LEFT.bug_name;
							//generating bid
							SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.owner_name,	RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);
							//generating linkids
							vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.owner_name, (string9)LEFT.link_fein, LEFT.link_inc_date, RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.sec_range, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);														
							SELF.powid	:= vLinkingIds.powid;
							SELF.proxid	:= vLinkingIds.proxid;
							SELF.seleid	:= vLinkingIds.seleid;
							SELF.orgid	:= vLinkingIds.orgid;
							SELF.ultid	:= vLinkingIds.ultid;	 
							SELF := LEFT;
							SELF := [];
						),LEFT OUTER, KEEP(1)                       
					);

	SALESTAX_CA_Base := JOIN(SALESTAX_CA_Base_1,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id
						AND RIGHT.location_type = 'Mail',
						TRANSFORM(RECORDOF(Layouts.CA_Sales_Tax_Base_Layout),
							SELF.mail_prim_range := RIGHT.clean_address.prim_range;
							SELF.mail_predir := RIGHT.clean_address.predir;
							SELF.mail_prim_name := RIGHT.clean_address.prim_name;
							SELF.mail_addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.mail_postdir := RIGHT.clean_address.postdir;
							SELF.mail_unit_desig := RIGHT.clean_address.unit_desig;
							SELF.mail_sec_range := RIGHT.clean_address.sec_range;
							SELF.mail_p_city_name := RIGHT.clean_address.p_city_name;
							SELF.mail_v_city_name := RIGHT.clean_address.v_city_name;
							SELF.mail_st := RIGHT.clean_address.st;
							SELF.mail_zip := RIGHT.clean_address.zip;
							SELF.mail_zip4 := RIGHT.clean_address.zip4;
							SELF.mail_cart := RIGHT.clean_address.cart;
							SELF.mail_cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.mail_lot := RIGHT.clean_address.lot;
							SELF.mail_lot_order := RIGHT.clean_address.lot_order;
							SELF.mail_dpbc := RIGHT.clean_address.dbpc;
							SELF.mail_chk_digit := RIGHT.clean_address.chk_digit;
							SELF.mail_record_type := RIGHT.clean_address.rec_type;
							SELF.mail_ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.mail_fipscounty := RIGHT.clean_address.fips_county;
							SELF.mail_geo_lat := RIGHT.clean_address.geo_lat;
							SELF.mail_geo_long := RIGHT.clean_address.geo_long;
							SELF.mail_msa := RIGHT.clean_address.msa;
							SELF.mail_geo_blk := RIGHT.clean_address.geo_blk;
							SELF.mail_geo_match := RIGHT.clean_address.geo_match;
							SELF.mail_err_stat := RIGHT.clean_address.err_stat;
							SELF := LEFT;
							SELF := [];
						),LEFT OUTER, KEEP(1)                       
					);
					
	//transforming addresses and generating bdid and linkid
	SALESTAX_IA_Base_1 := JOIN(In_SALESTAX_IA_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id
						AND RIGHT.location_type = 'Location',
						TRANSFORM(RECORDOF(Layouts.IA_Sales_Tax_Base_Layout),
							SELF.business_name := LEFT.trade_name;
							SELF.location_address := TRIM(RIGHT.clean_address.prim_range+RIGHT.clean_address.predir+RIGHT.clean_address.prim_name+RIGHT.clean_address.addr_suffix+RIGHT.clean_address.postdir+RIGHT.clean_address.unit_desig+RIGHT.clean_address.sec_range);
							SELF.city_of_location := RIGHT.clean_address.p_city_name;
							SELF.state_of_location := RIGHT.clean_address.st;
							CleanName := address.CleanPerson73_Fields(LEFT.owner_name);
							SELF.ownername.TITLE := IF(LEFT.did<>'',CleanName.Title,'');
							SELF.ownername.FNAME := IF(LEFT.did<>'',CleanName.Fname,'');
							SELF.ownername.LNAME := IF(LEFT.did<>'',CleanName.Lname,'');
							SELF.ownername.MNAME := IF(LEFT.did<>'',CleanName.Mname,'');
							SELF.tradename.TITLE := IF(LEFT.did<>'',CleanName.Title,'');
							SELF.tradename.FNAME := IF(LEFT.did<>'',CleanName.Fname,'');
							SELF.tradename.LNAME := IF(LEFT.did<>'',CleanName.Lname,'');
							SELF.tradename.MNAME := IF(LEFT.did<>'',CleanName.Mname,'');
							SELF.COMPANY_NAME_1 := IF(LEFT.did<>'','',LEFT.owner_name);
							SELF.COMPANY_NAME_2 := IF(LEFT.did<>'','',SELF.business_name);
							SELF.locationaddress.prim_range := RIGHT.clean_address.prim_range;
							SELF.locationaddress.predir := RIGHT.clean_address.predir;
							SELF.locationaddress.prim_name := RIGHT.clean_address.prim_name;
							SELF.locationaddress.addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.locationaddress.postdir := RIGHT.clean_address.postdir;
							SELF.locationaddress.unit_desig := RIGHT.clean_address.unit_desig;
							SELF.locationaddress.sec_range := RIGHT.clean_address.sec_range;
							SELF.locationaddress.p_city_name := RIGHT.clean_address.p_city_name;
							SELF.locationaddress.v_city_name := RIGHT.clean_address.v_city_name;
							SELF.locationaddress.st := RIGHT.clean_address.st;
							SELF.locationaddress.zip := RIGHT.clean_address.zip;
							SELF.locationaddress.zip4 := RIGHT.clean_address.zip4;
							SELF.locationaddress.cart := RIGHT.clean_address.cart;
							SELF.locationaddress.cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.locationaddress.lot := RIGHT.clean_address.lot;
							SELF.locationaddress.lot_order := RIGHT.clean_address.lot_order;
							SELF.locationaddress.dbpc := RIGHT.clean_address.dbpc;
							SELF.locationaddress.chk_digit := RIGHT.clean_address.chk_digit;
							SELF.locationaddress.rec_type := RIGHT.clean_address.rec_type;
							SELF.locationaddress.fips_state := RIGHT.clean_address.fips_state;
							SELF.locationaddress.fips_county := RIGHT.clean_address.fips_county;
							SELF.locationaddress.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.locationaddress.geo_long := RIGHT.clean_address.geo_long;
							SELF.locationaddress.msa := RIGHT.clean_address.msa;
							SELF.locationaddress.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.locationaddress.geo_match := RIGHT.clean_address.geo_match;
							SELF.locationaddress.err_stat := RIGHT.clean_address.err_stat;
							SELF.bug_num := LEFT.bug_name;
							//generating bid
							SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.trade_name,	RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);
							//generating linkids
							vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.trade_name, (string9)LEFT.link_fein, LEFT.link_inc_date, RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.sec_range, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);														
							SELF.powid	:= vLinkingIds.powid;
							SELF.proxid	:= vLinkingIds.proxid;
							SELF.seleid	:= vLinkingIds.seleid;
							SELF.orgid	:= vLinkingIds.orgid;
							SELF.ultid	:= vLinkingIds.ultid;	 
							SELF := LEFT;
							SELF := [];
						),LEFT OUTER, KEEP(1)                       
					);


	SALESTAX_IA_Base := JOIN(SALESTAX_IA_Base_1,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id
						AND RIGHT.location_type = 'Mail',
						TRANSFORM(RECORDOF(Layouts.IA_Sales_Tax_Base_Layout),
							SELF.city_mailing_address := RIGHT.clean_address.p_city_name;
							SELF.mailing_address := TRIM(RIGHT.clean_address.prim_range+RIGHT.clean_address.predir+RIGHT.clean_address.prim_name+RIGHT.clean_address.addr_suffix+RIGHT.clean_address.postdir+RIGHT.clean_address.unit_desig+RIGHT.clean_address.sec_range);
							SELF.state_mailing_address := RIGHT.clean_address.st;
							SELF.mailingaddress.prim_range := RIGHT.clean_address.prim_range;
							SELF.mailingaddress.predir := RIGHT.clean_address.predir;
							SELF.mailingaddress.prim_name := RIGHT.clean_address.prim_name;
							SELF.mailingaddress.addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.mailingaddress.postdir := RIGHT.clean_address.postdir;
							SELF.mailingaddress.unit_desig := RIGHT.clean_address.unit_desig;
							SELF.mailingaddress.sec_range := RIGHT.clean_address.sec_range;
							SELF.mailingaddress.p_city_name := RIGHT.clean_address.p_city_name;
							SELF.mailingaddress.v_city_name := RIGHT.clean_address.v_city_name;
							SELF.mailingaddress.st := RIGHT.clean_address.st;
							SELF.mailingaddress.zip := RIGHT.clean_address.zip;
							SELF.mailingaddress.zip4 := RIGHT.clean_address.zip4;
							SELF.mailingaddress.cart := RIGHT.clean_address.cart;
							SELF.mailingaddress.cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.mailingaddress.lot := RIGHT.clean_address.lot;
							SELF.mailingaddress.lot_order := RIGHT.clean_address.lot_order;
							SELF.mailingaddress.dbpc := RIGHT.clean_address.dbpc;
							SELF.mailingaddress.chk_digit := RIGHT.clean_address.chk_digit;
							SELF.mailingaddress.rec_type := RIGHT.clean_address.rec_type;
							SELF.mailingaddress.fips_state := RIGHT.clean_address.fips_state;
							SELF.mailingaddress.fips_county := RIGHT.clean_address.fips_county;
							SELF.mailingaddress.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.mailingaddress.geo_long := RIGHT.clean_address.geo_long;
							SELF.mailingaddress.msa := RIGHT.clean_address.msa;
							SELF.mailingaddress.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.mailingaddress.geo_match := RIGHT.clean_address.geo_match;
							SELF.mailingaddress.err_stat := RIGHT.clean_address.err_stat;
							SELF.RAW_AID_MAILING := RIGHT.clean_raw_aid;
							SELF := LEFT;
							SELF := [];
						),LEFT OUTER, KEEP(1)                       
					);

	//transforming addresses and generating bdid and linkid
	SEC_BROKER_Base := JOIN(In_SEC_BROKER_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id,
						TRANSFORM(RECORDOF(Layouts.SEC_Broker_Dealer_Base_Layout),
							SELF.REPORTING_FILE_NUMBER := LEFT.reporting_file;
							SELF.CNAME := LEFT.company_name;
							SELF.prim_range := RIGHT.clean_address.prim_range;
							SELF.predir := RIGHT.clean_address.predir;
							SELF.prim_name := RIGHT.clean_address.prim_name;
							SELF.addr_suffix := RIGHT.clean_address.addr_suffix;
							SELF.postdir := RIGHT.clean_address.postdir;
							SELF.unit_desig := RIGHT.clean_address.unit_desig;
							SELF.sec_range := RIGHT.clean_address.sec_range;
							SELF.p_city_name := RIGHT.clean_address.p_city_name;
							SELF.v_city_name := RIGHT.clean_address.v_city_name;
							SELF.st := RIGHT.clean_address.st;
							SELF.zip := RIGHT.clean_address.zip;
							SELF.zip4 := RIGHT.clean_address.zip4;
							SELF.cart := RIGHT.clean_address.cart;
							SELF.cr_sort_sz := RIGHT.clean_address.cr_sort_sz;
							SELF.lot := RIGHT.clean_address.lot;
							SELF.lot_order := RIGHT.clean_address.lot_order;
							SELF.dpbc := RIGHT.clean_address.dbpc;
							SELF.chk_digit := RIGHT.clean_address.chk_digit;
							SELF.record_type := RIGHT.clean_address.rec_type;
							SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.county := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
							SELF.bug_num := LEFT.bug_name;
							//generating bid
							SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.company_name,	RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);
							//generating linkids
							vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.company_name, (string9)LEFT.link_fein, LEFT.link_inc_date, RIGHT.clean_address.prim_range, RIGHT.clean_address.prim_name, RIGHT.clean_address.sec_range, RIGHT.clean_address.v_city_name, RIGHT.clean_address.st, RIGHT.clean_address.zip, LEFT.cust_name);														
							SELF.powid	:= vLinkingIds.powid;
							SELF.proxid	:= vLinkingIds.proxid;
							SELF.seleid	:= vLinkingIds.seleid;
							SELF.orgid	:= vLinkingIds.orgid;
							SELF.ultid	:= vLinkingIds.ultid;	 
							SELF := LEFT;
							SELF := [];
						),LEFT OUTER, KEEP(1)                       
					);

	PromoteSupers.MAC_SF_BuildProcess(FDIC_Base, 		constants.FDIC_Base_Name, 			FDIC_Base_seq,			,,,pversion);
	PromoteSupers.MAC_SF_BuildProcess(IRS_Base, 		constants.IRS_Base_Name, 			IRS_Base_seq,			,,,pversion);
	PromoteSupers.MAC_SF_BuildProcess(SALESTAX_CA_Base, constants.Salestax_CA_Base_Name, 	SALESTAX_CA_Base_seq,	,,,pversion);
	PromoteSupers.MAC_SF_BuildProcess(SALESTAX_IA_Base, constants.Salestax_IA_Base_Name, 	SALESTAX_IA_Base_seq,	,,,pversion);
	PromoteSupers.MAC_SF_BuildProcess(SEC_BROKER_Base, 	constants.Sec_Broker_Base_Name, 	SEC_BROKER_Base_seq,	,,,pversion);
	
	RETURN SEQUENTIAL(FDIC_Base_seq,IRS_Base_seq,SALESTAX_CA_Base_seq,SALESTAX_IA_Base_seq,SEC_BROKER_Base_seq);

END;
