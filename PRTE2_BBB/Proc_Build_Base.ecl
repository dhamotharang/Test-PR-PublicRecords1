IMPORT PromoteSupers, PRTE2, STD, ut, Address, AID;

EXPORT Proc_Build_Base(string pversion) := FUNCTION

	member_in := Files.bbb_member_In+Files.bbb_member_ins_In;
	nonmember_in := Files.bbb_nonmember_In+Files.bbb_nonmember_ins_In;
	
	//uppercase and remove spaces from in file
  PRTE2.CleanFields(member_in, member_clean_fields); 				//(Input,OutFile)
  PRTE2.CleanFields(nonmember_in, nonmember_clean_fields); 	//(Input,OutFile)
	
	//Sequence records so that we can join them, do the address cleaning, and rejoin them
	ut.MAC_Append_Rcid(member_clean_fields,source_rec_id,member_sequenced); 			//(Input,new_seq_field,Output)
	ut.MAC_Append_Rcid(nonmember_clean_fields,source_rec_id,nonmember_sequenced); //(Input,new_seq_field,Output)
	
	//put all addresses in one file for cleaning
  member_addr := PROJECT(member_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SELF.member_row_id := LEFT.source_rec_id;
                                       SElF := LEFT; 
                                       SELF := []
                                       )
                             ); 
    
  nonmember_addr := PROJECT(nonmember_sequenced, 
                             TRANSFORM(Layouts.temp_address_layout,
                                       SELF.nonmember_row_id := LEFT.source_rec_id;
                                       SElF := LEFT; 
                                       SELF := []
                                       )
                             ); 

	bbb_all_address := member_addr+nonmember_addr;

  //Address Cleaning
  addr_clean_all := PRTE2.AddressCleaner(bbb_all_address, //Incoming record set
                                            ['prep_addr_line1'], //Set of names of fields containing street addresses
                                            ['prep_addr_line_last'], //Set of names of fields containing city, state, and zip prepped and concatenated
                                            [], //Set of fields containing unprepped city
                                            [], //Set of fields containing unprepped state
                                            [], //Set of fields containing unprepped zip
                                            ['clean_address'], //Set of fieldnames where addresses will be put in Address.Layout_Clean182_fips layout
                                            ['clean_raw_aid']); //Set of fields where RawAIDs will be put.
				
	//Member file - transforming addresses and generating bdid and linkid
	member_cleaned_and_id := JOIN(addr_clean_all,
																	member_sequenced, 
																	LEFT.member_row_id = RIGHT.source_rec_id,
																	TRANSFORM(RECORDOF(member_in),
																		//move clean addresses to the correct fields
																		SELF.prim_range := LEFT.clean_address.prim_range;
																		SELF.predir := LEFT.clean_address.predir;
																		SELF.prim_name := LEFT.clean_address.prim_name;
																		SELF.addr_suffix := LEFT.clean_address.addr_suffix;
																		SELF.postdir := LEFT.clean_address.postdir;
																		SELF.unit_desig := LEFT.clean_address.unit_desig;
																		SELF.sec_range := LEFT.clean_address.sec_range;
																		SELF.p_city_name := LEFT.clean_address.p_city_name;
																		SELF.v_city_name := LEFT.clean_address.v_city_name;
																		SELF.st := LEFT.clean_address.st;
																		SELF.zip := LEFT.clean_address.zip;
																		SELF.zip4 := LEFT.clean_address.zip4;
																		SELF.cart := LEFT.clean_address.cart;
																		SELF.cr_sort_sz := LEFT.clean_address.cr_sort_sz;
																		SELF.lot := LEFT.clean_address.lot;
																		SELF.lot_order := LEFT.clean_address.lot_order;
																		SELF.dbpc := LEFT.clean_address.dbpc;
																		SELF.chk_digit := LEFT.clean_address.chk_digit;
																		SELF.rec_type := LEFT.clean_address.rec_type;
																		SELF.fips_state := LEFT.clean_address.fips_state;
																		SELF.fips_county := LEFT.clean_address.fips_county;
																		SELF.geo_lat := LEFT.clean_address.geo_lat;
																		SELF.geo_long := LEFT.clean_address.geo_long;
																		SELF.msa := LEFT.clean_address.msa;
																		SELF.geo_blk := LEFT.clean_address.geo_blk;
																		SELF.geo_match := LEFT.clean_address.geo_match;
																		SELF.err_stat := LEFT.clean_address.err_stat;
																		SELF.raw_aid := LEFT.clean_raw_aid;
																		//generating bid
																		SELF.bdid := prte2.fn_AppendFakeID.bdid(RIGHT.company_name,	LEFT.clean_address.prim_range, LEFT.clean_address.prim_name, LEFT.clean_address.v_city_name, LEFT.clean_address.st, LEFT.clean_address.zip, RIGHT.cust_name);
																		//generating linkids
																		vLinkingIds := prte2.fn_AppendFakeID.LinkIds(RIGHT.company_name, (string9)RIGHT.link_fein, RIGHT.link_inc_date, LEFT.clean_address.prim_range, LEFT.clean_address.prim_name, LEFT.clean_address.sec_range, LEFT.clean_address.v_city_name, LEFT.clean_address.st, LEFT.clean_address.zip, RIGHT.cust_name);														SELF.powid	:= vLinkingIds.powid;
																		SELF.proxid	:= vLinkingIds.proxid;
																		SELF.seleid	:= vLinkingIds.seleid;
																		SELF.orgid	:= vLinkingIds.orgid;
																		SELF.ultid	:= vLinkingIds.ultid;	 
																		//global_sid value
																		SELF.global_sid := 18235;
																		//source_rec_id
																		SELF.source_rec_id := HASH64(ut.CleanSpacesAndUpper(RIGHT.company_name) +
																			ut.CleanSpacesAndUpper(RIGHT.address) +
																			ut.CleanSpacesAndUpper(RIGHT.country) +
																			ut.CleanSpacesAndUpper(RIGHT.phone) +
																			ut.CleanSpacesAndUpper(RIGHT.phone_type) +
																			ut.CleanSpacesAndUpper(RIGHT.member_title) +
																			stringlib.stringcleanspaces(RIGHT.member_since_date) +
																			ut.CleanSpacesAndUpper(RIGHT.member_category)
																		);
																		SELF := RIGHT;
																		SELF := [];
																	)                                  
																);
										
	//Nonmember file - transforming addresses and generating bdid and linkid
	nonmember_cleaned_and_id := JOIN(addr_clean_all,
																		nonmember_sequenced, 
																		LEFT.nonmember_row_id = RIGHT.source_rec_id,
																		TRANSFORM(RECORDOF(nonmember_in),
																		//move clean addresses to the correct fields
																		SELF.prim_range := LEFT.clean_address.prim_range;
																		SELF.predir := LEFT.clean_address.predir;
																		SELF.prim_name := LEFT.clean_address.prim_name;
																		SELF.addr_suffix := LEFT.clean_address.addr_suffix;
																		SELF.postdir := LEFT.clean_address.postdir;
																		SELF.unit_desig := LEFT.clean_address.unit_desig;
																		SELF.sec_range := LEFT.clean_address.sec_range;
																		SELF.p_city_name := LEFT.clean_address.p_city_name;
																		SELF.v_city_name := LEFT.clean_address.v_city_name;
																		SELF.st := LEFT.clean_address.st;
																		SELF.zip := LEFT.clean_address.zip;
																		SELF.zip4 := LEFT.clean_address.zip4;
																		SELF.cart := LEFT.clean_address.cart;
																		SELF.cr_sort_sz := LEFT.clean_address.cr_sort_sz;
																		SELF.lot := LEFT.clean_address.lot;
																		SELF.lot_order := LEFT.clean_address.lot_order;
																		SELF.dbpc := LEFT.clean_address.dbpc;
																		SELF.chk_digit := LEFT.clean_address.chk_digit;
																		SELF.rec_type := LEFT.clean_address.rec_type;
																		SELF.fips_state := LEFT.clean_address.fips_state;
																		SELF.fips_county := LEFT.clean_address.fips_county;
																		SELF.geo_lat := LEFT.clean_address.geo_lat;
																		SELF.geo_long := LEFT.clean_address.geo_long;
																		SELF.msa := LEFT.clean_address.msa;
																		SELF.geo_blk := LEFT.clean_address.geo_blk;
																		SELF.geo_match := LEFT.clean_address.geo_match;
																		SELF.err_stat := LEFT.clean_address.err_stat;
																		SELF.raw_aid := LEFT.clean_raw_aid;
																		//generating bid
																		SELF.bdid := prte2.fn_AppendFakeID.bdid(RIGHT.company_name,	LEFT.clean_address.prim_range, LEFT.clean_address.prim_name, LEFT.clean_address.v_city_name, LEFT.clean_address.st, LEFT.clean_address.zip, RIGHT.cust_name);
																		//generating linkids
																		vLinkingIds := prte2.fn_AppendFakeID.LinkIds(RIGHT.company_name, (string9)RIGHT.link_fein, RIGHT.link_inc_date, LEFT.clean_address.prim_range, LEFT.clean_address.prim_name, LEFT.clean_address.sec_range, LEFT.clean_address.v_city_name, LEFT.clean_address.st, LEFT.clean_address.zip, RIGHT.cust_name);														SELF.powid	:= vLinkingIds.powid;
																		SELF.proxid	:= vLinkingIds.proxid;
																		SELF.seleid	:= vLinkingIds.seleid;
																		SELF.orgid	:= vLinkingIds.orgid;
																		SELF.ultid	:= vLinkingIds.ultid;	
																		//global_sid value
																		SELF.global_sid := 18237;
																		//source_rec_id
																		SELF.source_rec_id := HASH64(ut.CleanSpacesAndUpper(RIGHT.company_name) +
																			ut.CleanSpacesAndUpper(RIGHT.address) +
																			ut.CleanSpacesAndUpper(RIGHT.country) +
																			ut.CleanSpacesAndUpper(RIGHT.phone) +
																			ut.CleanSpacesAndUpper(RIGHT.phone_type) +
																			ut.CleanSpacesAndUpper(RIGHT.non_member_title) +
																			ut.CleanSpacesAndUpper(RIGHT.non_member_category)
																		);
																		SELF := RIGHT;
																		SELF := [];
																	)                                  
																);
	
	PromoteSupers.MAC_SF_BuildProcess(member_cleaned_and_id, constants.Base_Member, bbb_member_final,,,,pversion);
	PromoteSupers.MAC_SF_BuildProcess(nonmember_cleaned_and_id, constants.Base_NonMember, bbb_nonmember_final,,,,pversion);
                
  RETURN SEQUENTIAL(bbb_member_final, bbb_nonmember_final);

END;
