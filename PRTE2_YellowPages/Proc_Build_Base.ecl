IMPORT PromoteSupers, PRTE2, STD, ut, Address, AID, mdr, YellowPages, Cellphone;

EXPORT Proc_Build_Base(string pversion) := FUNCTION

	yellowpages_in := Files.YellowPages_In+Files.YellowPages_Ins_In(dt_first_seen<>'DT_FIRST_SEEN');
	
	//uppercase and remove spaces from in file
  PRTE2.CleanFields(yellowpages_in, yellowpages_clean_fields); 				//(Input,OutFile)
	
	//Sequence records so that we can join them, do the address cleaning, and rejoin them
	ut.MAC_Append_Rcid(yellowpages_clean_fields,source_rec_id,yellowpages_sequenced); 			//(Input,new_seq_field,Output)
	
  //Address Cleaning
  addr_clean_all := PRTE2.AddressCleaner(yellowpages_sequenced, //Incoming record set
                                            ['orig_street'], //Set of names of fields containing street addresses
                                            ['orig_city'+'orig_state'+'orig_zip'], //Set of names of fields containing city, state, and zip prepped and concatenated
                                            ['orig_city'], //Set of fields containing unprepped city
                                            ['orig_state'], //Set of fields containing unprepped state
                                            ['orig_zip'], //Set of fields containing unprepped zip
                                            ['clean_address'], //Set of fieldnames where addresses will be put in Address.Layout_Clean182_fips layout
                                            ['clean_raw_aid']); //Set of fields where RawAIDs will be put.		
				
	//Member file - transforming addresses and generating bdid and linkid
	yellowpages_cleaned_and_id :=  PROJECT(addr_clean_all,TRANSFORM({RECORDOF(Files.YellowPages_Base)},
																//move clean addresses to the correct fields
																SELF.prim_range := LEFT.clean_address.prim_range;
																SELF.predir := LEFT.clean_address.predir;
																SELF.prim_name := LEFT.clean_address.prim_name;
																//SELF.addr_suffix := LEFT.clean_address.addr_suffix;
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
																//SELF.dbpc := LEFT.clean_address.dbpc;
																SELF.chk_digit := LEFT.clean_address.chk_digit;
																SELF.rec_type := LEFT.clean_address.rec_type;
																SELF.fips := LEFT.clean_address.fips_state;
																SELF.countycode := LEFT.clean_address.fips_county;
																SELF.geo_lat := LEFT.clean_address.geo_lat;
																SELF.geo_long := LEFT.clean_address.geo_long;
																SELF.msa := LEFT.clean_address.msa;
																SELF.geo_blk := LEFT.clean_address.geo_blk;
																SELF.geo_match := LEFT.clean_address.geo_match;
																SELF.err_stat := LEFT.clean_address.err_stat;
																SELF.rawaid := LEFT.clean_raw_aid;
																SELF.source := mdr.sourceTools.src_Yellow_Pages;
																//generating bid
																SELF.bdid := prte2.fn_AppendFakeID.bdid(LEFT.business_name,	LEFT.clean_address.prim_range, LEFT.clean_address.prim_name, LEFT.clean_address.v_city_name, LEFT.clean_address.st, LEFT.clean_address.zip, LEFT.cust_name);
																//generating linkids
																vLinkingIds := prte2.fn_AppendFakeID.LinkIds(LEFT.business_name, LEFT.link_fein, LEFT.link_inc_date, LEFT.clean_address.prim_range, LEFT.clean_address.prim_name, LEFT.clean_address.sec_range, LEFT.clean_address.v_city_name, LEFT.clean_address.st, LEFT.clean_address.zip, LEFT.cust_name);														
																SELF.powid	:= vLinkingIds.powid;
																SELF.proxid	:= vLinkingIds.proxid;
																SELF.seleid	:= vLinkingIds.seleid;
																SELF.orgid	:= vLinkingIds.orgid;
																SELF.ultid	:= vLinkingIds.ultid;	 
																SELF := LEFT;
																SELF := [];
																	)                                  
																);
	//Append PhoneType
	YellowPages.NPA_PhoneType(yellowpages_cleaned_and_id,phone10,phoneType,PhoneType_Append);
										
	PromoteSupers.MAC_SF_BuildProcess(PhoneType_Append, constants.BASE_NAME, yellowpages_final,,,,pversion);
  RETURN SEQUENTIAL(yellowpages_final);

END;
