IMPORT PromoteSupers, PRTE2, STD, ut, Address, AID, codes, govdata;

EXPORT Proc_Build_Base(string pversion) := FUNCTION

	In_FCID := Files.FDIC_In;
	In_IRS := Files.IRS_In;
	In_SALESTAX_CA := Files.Salestax_CA_In;
	In_SALESTAX_IA := Files.Salestax_IA_In;
	In_SEC_BROKER := Files.Sec_Broker_In;

	//uppercase and remove spaces from in file
  PRTE2.CleanFields(In_FCID, In_FCID_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(In_IRS, In_IRS_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(In_SALESTAX_CA, In_SALESTAX_CA_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(In_SALESTAX_IA, In_SALESTAX_IA_clean_fields); //(Input,OutFile)
	PRTE2.CleanFields(In_SEC_BROKER, In_SEC_BROKER_clean_fields); //(Input,OutFile)
	
	//Sequence records so that we can join them, do the address cleaning, and rejoin them
	ut.MAC_Append_Rcid(In_FCID_clean_fields,source_rec_id,In_FCID_sequenced); //(Input,new_seq_field,Output)
	ut.MAC_Append_Rcid(In_IRS_clean_fields,source_rec_id,In_IRS_sequenced); //(Input,new_seq_field,Output)
	ut.MAC_Append_Rcid(In_SALESTAX_CA_clean_fields,source_rec_id,In_SALESTAX_CA_sequenced); //(Input,new_seq_field,Output)
	ut.MAC_Append_Rcid(In_SALESTAX_IA_clean_fields,source_rec_id,In_SALESTAX_IA_sequenced); //(Input,new_seq_field,Output)
	ut.MAC_Append_Rcid(In_SEC_BROKER_clean_fields,source_rec_id,In_SEC_BROKER_sequenced); //(Input,new_seq_field,Output)
	OUTPUT(COUNT(In_FCID_sequenced));
	
	//put all addresses in one file for cleaning
	In_FCID_Addr := PROJECT(In_FCID_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SElF := LEFT; 
                                       )
                             );

  	In_IRS_Addr := PROJECT(In_IRS_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SELF.source_rec_id := LEFT.source_rec_id;
									   SELF.zip_code := LEFT.Zip_Code[1..5];
                                       SElF := LEFT; 
                                       )
                             );

	In_SALESTAX_CA_Addr := PROJECT(In_SALESTAX_CA_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                    	SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.location_street;
										SELF.city := LEFT.location_city;
										SELF.state := LEFT.location_state;
										SELF.zip_code := LEFT.location_zip;
                                       )
                             );

	In_SALESTAX_IA_Addr := PROJECT(In_SALESTAX_IA_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                    	SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.location_street_1;
										SELF.city := LEFT.location_city;
										SELF.state := LEFT.location_state;
										SELF.zip_code := LEFT.location_zip_code;
                                       )
                             );

	In_SEC_BROKER_Addr := PROJECT(In_SEC_BROKER_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
										SELF.source_rec_id := LEFT.source_rec_id;
										SELF.street_address := LEFT.address1;
										//LEFT.address2;
										SELF.city := LEFT.city;
										SELF.state := LEFT.state_code;
										SELF.zip_code := LEFT.zip_code;
                                       SElF := LEFT; 
                                       )
                             );

	All_address := In_FCID_Addr+In_IRS_Addr+In_SALESTAX_CA_Addr+In_SALESTAX_IA_Addr+In_SEC_BROKER_Addr;
	
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
						TRANSFORM(RECORDOF(govdata.Layouts_FDIC.Base_AID),
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
						TRANSFORM(RECORDOF(govdata.Layouts_IRS_NonProfit.Base_AID),
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
	SALESTAX_CA_Base := JOIN(In_SALESTAX_CA_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id,
						TRANSFORM(RECORDOF(govdata.Layout_CA_Sales_Tax),
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
							//SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.fipscounty := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
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

	//transforming addresses and generating bdid and linkid
	SALESTAX_IA_Base := JOIN(In_SALESTAX_IA_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id,
						TRANSFORM(RECORDOF(govdata.Layout_IA_SalesTax_Base),
							/*
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
							//SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.fips_county := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
							*/
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

	//transforming addresses and generating bdid and linkid
	SEC_BROKER_Base := JOIN(In_SEC_BROKER_sequenced,
						addr_clean_all, 
						LEFT.source_rec_id = RIGHT.source_rec_id,
						TRANSFORM(RECORDOF(govdata.Layout_SEC_Broker_Dealer_BDID),
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
							//SELF.ace_fips_st := RIGHT.clean_address.fips_state;
							SELF.county := RIGHT.clean_address.fips_county;
							SELF.geo_lat := RIGHT.clean_address.geo_lat;
							SELF.geo_long := RIGHT.clean_address.geo_long;
							SELF.msa := RIGHT.clean_address.msa;
							SELF.geo_blk := RIGHT.clean_address.geo_blk;
							SELF.geo_match := RIGHT.clean_address.geo_match;
							SELF.err_stat := RIGHT.clean_address.err_stat;
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
