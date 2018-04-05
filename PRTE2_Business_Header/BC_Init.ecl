import AID, Business_Header, Address, NID, ut, PRTE2, STD;

export BC_Init (
	 
	 dataset(Layouts.Input.Layout_BusContact)	pInput_Bus_Contacts	= Files().Input.BusContact.using 
	,dataset(Layouts.Out.Layout_BH_Out			)	pInput_Bus_Header		= BH_Init()	
	// dataset(Business_Header.Layout_Business_Contact_Full_New)	pAll_Bus_Contacts_Sources	= Business_Sources.business_contacts	
	
) :=
function

	//*** Filtering off the business relatives records for the historical data.
	pIn_BusHdr := distribute(pInput_Bus_Header(trim(long_bus_name) <> ''), hash(link_fein, link_inc_date));
	dIn_BusHdr_ded := dedup(sort(pIn_BusHdr, link_fein, link_inc_date, bdid, long_bus_name, local), link_fein, link_inc_date, bdid, long_bus_name, local);

	dBC_In_Recs := pInput_Bus_Contacts;
	
	//*** Normalizing the Contact names and contact addresses.
	layouts.Temporary.Layout_BC_Norm trf_BC_Norm(dBC_In_Recs l, unsigned c) := transform,
			skip((c = 2 and trim(l.contact_lname2) ='') or 
					 (c = 3 and trim(l.contact_lname3) ='') or
					 (c = 4 and trim(l.contact_lname4) ='') or
					 (c = 5 and trim(l.contact_lname5) ='') or
					 (c = 6 and trim(l.contact_lname6) ='') or
				 	 (c = 7 and trim(l.contact_lname7) ='') or
				 	 (c = 8 and trim(l.contact_lname8) ='') or
				 	 (c = 9 and trim(l.contact_lname9) ='') or
				 	 (c = 10 and trim(l.contact_lname10) ='')
					)
			self.link_fein					:= l.link_fein;
			self.link_inc_date			:= l.link_inc_date;
			self.bdid 							:= if((unsigned6)l.bdid <> 0, (unsigned6)l.bdid, 0);
			self.contact_phone			:= choose(c, trim(l.contact_phone1), trim(l.contact_phone2), trim(l.contact_phone3), trim(l.contact_phone4), trim(l.contact_phone5), trim(l.contact_phone6), trim(l.contact_phone7), trim(l.contact_phone8), trim(l.contact_phone9), trim(l.contact_phone10));
			self.contact_did				:= choose(c, l.contact_did1, l.contact_did2, l.contact_did3, l.contact_did4, l.contact_did5, l.contact_did6, l.contact_did7, l.contact_did8, l.contact_did9, l.contact_did10 );
			self.contact_dob				:= choose(c, l.contact_dob1, l.contact_dob2, l.contact_dob3, l.contact_dob4, l.contact_dob5, l.contact_dob6, l.contact_dob7, l.contact_dob8, l.contact_dob9, l.contact_dob10 );
			self.contact_ssn				:= choose(c, l.contact_ssn1, l.contact_ssn2, l.contact_ssn3, l.contact_ssn4, l.contact_ssn5, l.contact_ssn6, l.contact_ssn7, l.contact_ssn8, l.contact_ssn9, l.contact_ssn10 );
			self.contact_title			:= choose(c, l.contact_title1, '', '', '', '', '', '', '', '', '' );
			self.contact_lname			:= choose(c, l.contact_lname1, l.contact_lname2, l.contact_lname3, l.contact_lname4, l.contact_lname5, l.contact_lname6, l.contact_lname7, l.contact_lname8, l.contact_lname9, l.contact_lname10 );
			self.contact_fname			:= choose(c, l.contact_fname1, l.contact_fname2, l.contact_fname3, l.contact_fname4, l.contact_fname5, l.contact_fname6, l.contact_fname7, l.contact_fname8, l.contact_fname9, l.contact_fname10 );
			self.contact_mname			:= choose(c, l.contact_mname1, l.contact_mname2, l.contact_mname3, l.contact_mname4, l.contact_mname5, l.contact_mname6, l.contact_mname7, l.contact_mname8, l.contact_mname9, l.contact_mname10 );
			self.contact_suffix			:= choose(c, l.contact_suffix1, '', '', '', '', '', '', '', '', '' );
			self.company_title			:= choose(c, l.company_title1, l.company_title2, l.company_title3, l.company_title4, l.company_title5, l.company_title6, l.company_title7, l.company_title8, l.company_title9, l.company_title10 );
			self.contact_addr				:= choose(c, l.contact_addr1, l.contact_addr2, l.contact_addr3, l.contact_addr4, l.contact_addr5, l.contact_addr6, l.contact_addr7, l.contact_addr8, l.contact_addr9, l.contact_addr10 );
			self.contact_city				:= choose(c, l.contact_city1, l.contact_city2, l.contact_city3, l.contact_city4, l.contact_city5, l.contact_city6, l.contact_city7, l.contact_city8, l.contact_city9, l.contact_city10 );
			self.contact_st					:= choose(c, l.contact_st1, l.contact_st2, l.contact_st3, l.contact_st4, l.contact_st5, l.contact_st6, l.contact_st7, l.contact_st8, l.contact_st9, l.contact_st10 );
			self.contact_zip				:= choose(c, l.contact_zip1, l.contact_zip2, l.contact_zip3, l.contact_zip4, l.contact_zip5, l.contact_zip6, l.contact_zip7, l.contact_zip8, l.contact_zip9, l.contact_zip10 );
			self.contact_zip_4			:= choose(c, l.contact_zip1_4, '');
			self.contact_county			:= choose(c, l.contact_county, '');
			self.contact_msa				:= choose(c, l.contact_msa, '');
			self.contact_geo_lat		:= choose(c, l.contact_geo_lat, '');
			self.contact_geo_long		:= choose(c, l.contact_geo_long, '');
			self 										:= l;
			self 										:= [];
	end;
	
	dBC_Name_norm := Normalize(dBC_In_Recs, 10, trf_BC_Norm(left, counter));
	
	dBC_norm_dis  := distribute(dBC_Name_norm, hash(link_fein, link_inc_date));
	
	//*** Getting the Business Header info (BDID, long_bus_name) from biz header file into biz contacts. 
	//*** Retaining the bdids as is for historical entities (Cust_name = '')
	layouts.Out.Layout_BC_Out tGetBH_Info(dBC_norm_dis l, dIn_BusHdr_ded r) := transform
			self.bdid 													:= if(trim(l.cust_name) = '', (unsigned6)l.bdid, (unsigned6)r.bdid);
			self.long_bus_name 									:= ut.CleanSpacesAndUpper(r.long_bus_name);
			self.bus_phone											:= l.bus_phone;
			self.orig_fein 											:= if(trim(l.cust_name) = '' and l.bdid <> 0 and (string)l.bdid <> trim(l.link_fein), trim(l.link_fein), r.orig_fein);
			self.bus_name 											:= ut.CleanSpacesAndUpper(l.bus_name);
			self.cust_name 											:= ut.CleanSpacesAndUpper(l.cust_name);
			self.did														:= (unsigned6)l.contact_did;
			self.src														:= ut.CleanSpacesAndUpper(l.Src);
			self 																:= l;
			self 																:= [];
	end;
	
	BC_W_BDID := join(dBC_norm_dis, dIn_BusHdr_ded, 
										left.link_fein 					= right.link_fein and
										left.link_inc_date 			= right.link_inc_date,
										tGetBH_Info(left, right), left outer, local);

	BC_W_BDID_ded := dedup(sort(BC_W_BDID, record, local), record, local);
	
	//*** Cleaning persion names using the OLD name cleaner.
	layouts.Out.Layout_BC_Out tStandardizeName(BC_W_BDID_ded l) := transform
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Map Fields
		// -- Name cleaning using old Name
		// -- Append DID's using the fn_AppendFakeID.DID fucntion
		// -- Preping the (Business and Contact)Addresses for AID call
		//////////////////////////////////////////////////////////////////////////////////////
		//*** CleanPersonLFM73_fields Name cleaner is flipping some names and messing up the names. so, only using the name clear title and suffix values if exists
		tempCleanName												:= Address.CleanPersonLFM73_fields(ut.CleanSpacesAndUpper(l.contact_lname+' '+l.contact_fname+' '+l.contact_mname));
		tfname															:= tempCleanName.fname;
		tlname															:= tempCleanName.lname;
		tsuffix															:= tempCleanName.name_suffix;

		self.title		        					 		:= if(trim(l.cust_name) = '', l.contact_title, tempCleanName.title);
		self.fname	           						 	:= if(trim(l.cust_name) = '', l.contact_fname, if(trim(tsuffix) <> '', regexreplace(trim(tsuffix), l.contact_fname,'',nocase), l.contact_fname));
		self.mname	            						:= if(trim(l.cust_name) = '', l.contact_mname, l.contact_mname);
		self.lname		       					  		:= if(trim(l.cust_name) = '', l.contact_lname, l.contact_lname);
		self.name_suffix	     						 	:= if(trim(l.cust_name) = '', l.contact_suffix, if(trim(tsuffix) <> '',tsuffix, l.contact_suffix));
		self.name_score	       						 	:= if(trim(l.cust_name) = '', '0', tempCleanName.name_score);
		self.contact_title							    := ut.CleanSpacesAndUpper(l.contact_title);
		self.contact_score							    := trim(l.contact_score);
		self.contact_ssn							   	 	:= trim(l.contact_ssn);
		
		self.uniq_id												:= 0;
		self.bdid														:= l.bdid;
		self.did														:= if(l.did <> 0, 
																							l.did,
																							PRTE2.fn_AppendFakeID.did(tfname, tlname, l.contact_ssn, l.contact_dob, l.cust_name)
																						 );
		self.cont_prep_addr_first						:= Address.fn_addr_clean_prep(regexreplace(' APT$',l.contact_Addr, ' APT 0'), 'first');
		self.cont_prep_addr_last						:= if(trim(l.contact_City) <> '', 
																							Address.fn_addr_clean_prep(l.contact_City+', '+l.contact_St+' '+l.contact_Zip, 'last'),
																							Address.fn_addr_clean_prep(l.contact_St+' '+l.contact_Zip, 'last'));
		self.bus_prep_addr_first						:= Address.fn_addr_clean_prep(regexreplace(' APT$',l.bus_addr1, ' APT 0'), 'first');
		self.bus_prep_addr_last							:= if(trim(l.bus_city) <> '', 
																							Address.fn_addr_clean_prep(l.bus_city+', '+l.bus_st+' '+l.bus_zip, 'last'),
																							Address.fn_addr_clean_prep(l.bus_st+' '+l.bus_zip, 'last'));
		
		self.contact_phone									:= STD.Str.CleanSpaces(l.contact_phone);
		self																:= l;
		self																:= [];
	end;
	
	dBC_StandardizedName := sort(project(BC_W_BDID_ded, tStandardizeName(left)), link_fein);
	
	ut.MAC_Sequence_Records(dBC_StandardizedName, uniq_id, dBC_StandardizedName_w_uid)
		
	dBC_w_Uniq_id := dBC_StandardizedName_w_uid : persist('~prte::PRTE2_Business_Header::BC_Init::Uniq_id');
	
	//*** Normalizing the Business and Contact addresses for AID call.
	Layouts.Temporary.Layout_For_AID_Addr tNormBusAddr(dBC_w_Uniq_id l, unsigned c) := transform
		self.addr_type					:= choose(c, 'B', 'C');
		self.prep_address_first	:= choose(c, l.bus_prep_addr_first, l.cont_prep_addr_first);
		self.prep_address_last	:= choose(c, l.bus_prep_addr_last, l.cont_prep_addr_last);
		self.uniq_id						:= l.uniq_id;
		self										:= l;
		self										:= [];
	end;
	
	BC_Addr_for_AID := normalize(dBC_w_Uniq_id, 2, tNormBusAddr(left, counter));
	
	dBC_with_addr := BC_Addr_for_AID(trim(prep_address_last) <> '');
	
	//*** Standardizing the addresses using the AID address cleaner
	unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;
	
	AID.MacAppendFromRaw_2Line(dBC_with_addr, prep_address_first, prep_address_last, RawAID, dWithAID, lFlags);
	
	//*** Appending cleaned contact address fields in this join
	Layouts.Out.Layout_BC_out MapClnContAddr(dBC_w_Uniq_id l, dWithAID r) := transform
		self.contact_rawaid              				:= r.AIDWork_RawAID;
		self.contact_aceaid              				:= r.AIDWork_ACECache.aid;
		self.contact_clean_addr.prim_range     	:= r.AIDWork_ACECache.prim_range;
		self.contact_clean_addr.predir         	:= r.AIDWork_ACECache.predir;
		self.contact_clean_addr.prim_name				:= r.AIDWork_ACECache.prim_name;
		self.contact_clean_addr.addr_suffix			:= r.AIDWork_ACECache.addr_suffix;
		self.contact_clean_addr.postdir        	:= r.AIDWork_ACECache.postdir;
		self.contact_clean_addr.unit_desig	   	:= r.AIDWork_AceCache.unit_desig;
		self.contact_clean_addr.sec_range      	:= if(r.AIDWork_ACECache.sec_range = '0', '', r.AIDWork_ACECache.sec_range);
		self.contact_clean_addr.p_city_name    	:= if(trim(l.cust_name) = '', ut.CleanSpacesAndUpper(l.contact_city), r.AIDWork_ACECache.p_city_name);
		self.contact_clean_addr.v_city_name    	:= if(trim(l.cust_name) = '', ut.CleanSpacesAndUpper(l.contact_city), r.AIDWork_ACECache.v_city_name);
		self.contact_clean_addr.st             	:= if(trim(l.cust_name) = '', ut.CleanSpacesAndUpper(l.contact_st), r.AIDWork_ACECache.st);
		self.contact_clean_addr.zip	          	:= if(trim(l.cust_name) = '', trim(l.contact_zip), r.aidwork_acecache.zip5);
		self.contact_clean_addr.zip4           	:= if(trim(l.cust_name) = '', trim(l.contact_zip_4), r.aidwork_acecache.zip4);
		self.contact_clean_addr.cart		       	:= r.AIDWork_AceCache.cart;
		self.contact_clean_addr.cr_sort_sz	   	:= r.AIDWork_AceCache.cr_sort_sz;
		self.contact_clean_addr.lot		       		:= r.AIDWork_AceCache.lot;
		self.contact_clean_addr.lot_order		  	:= r.AIDWork_AceCache.lot_order;
		self.contact_clean_addr.dbpc		       	:= r.AIDWork_AceCache.dbpc;
		self.contact_clean_addr.chk_digit		 		:= r.AIDWork_AceCache.chk_digit;
		self.contact_clean_addr.rec_type	      := r.AIDWork_AceCache.rec_type;
		self.contact_clean_addr.fips_state		  := r.AIDWork_AceCache.county[1..2];
		self.contact_clean_addr.fips_county   	:= if(trim(l.cust_name) = '', trim(l.contact_county), r.AIDWork_AceCache.county[3..]);
		self.contact_clean_addr.geo_lat		   		:= if(trim(l.cust_name) = '', trim(l.contact_geo_lat), r.AIDWork_AceCache.geo_lat);
		self.contact_clean_addr.geo_long		   	:= if(trim(l.cust_name) = '', trim(l.contact_geo_long), r.AIDWork_AceCache.geo_long);
		self.contact_clean_addr.msa			   			:= if(trim(l.cust_name) = '', trim(l.contact_msa), r.AIDWork_AceCache.msa);
		self.contact_clean_addr.geo_blk		   		:= r.AIDWork_AceCache.geo_blk;
		self.contact_clean_addr.geo_match		 		:= r.AIDWork_AceCache.geo_match;
		self.contact_clean_addr.err_stat		  	:= r.AIDWork_AceCache.err_stat;
		self																		:= l;
	end;

	jBC_CleanContAddr	:= JOIN(dBC_w_Uniq_id,
														dWithAID(addr_type = 'C'),
														left.uniq_id = right.uniq_id,
														MapClnContAddr(left,right),left outer);
												
	//*** Appending cleaned business address fields in this join
	Layouts.Out.Layout_BC_out MapClnBusAddr(dBC_w_Uniq_id l, dWithAID r) := transform
		self.company_rawaid              				:= r.AIDWork_RawAID;
		self.company_clean_addr.prim_range     	:= r.AIDWork_ACECache.prim_range;
		self.company_clean_addr.predir         	:= r.AIDWork_ACECache.predir;
		self.company_clean_addr.prim_name				:= r.AIDWork_ACECache.prim_name;
		self.company_clean_addr.addr_suffix			:= r.AIDWork_ACECache.addr_suffix;
		self.company_clean_addr.postdir        	:= r.AIDWork_ACECache.postdir;
		self.company_clean_addr.unit_desig	   	:= r.AIDWork_AceCache.unit_desig;
		self.company_clean_addr.sec_range      	:= if(r.AIDWork_ACECache.sec_range = '0', '', r.AIDWork_ACECache.sec_range);
		self.company_clean_addr.p_city_name    	:= if(trim(l.cust_name) = '', ut.CleanSpacesAndUpper(l.bus_city), r.AIDWork_ACECache.p_city_name);
		self.company_clean_addr.v_city_name    	:= if(trim(l.cust_name) = '', ut.CleanSpacesAndUpper(l.bus_city), r.AIDWork_ACECache.v_city_name);
		self.company_clean_addr.st             	:= if(trim(l.cust_name) = '', ut.CleanSpacesAndUpper(l.bus_st), r.AIDWork_ACECache.st);
		self.company_clean_addr.zip	          	:= if(trim(l.cust_name) = '', trim(l.bus_zip), r.aidwork_acecache.zip5);
		self.company_clean_addr.zip4           	:= if(trim(l.cust_name) = '', trim(l.bus_zip4), r.aidwork_acecache.zip4);
		self.company_clean_addr.cart		       	:= r.AIDWork_AceCache.cart;
		self.company_clean_addr.cr_sort_sz	   	:= r.AIDWork_AceCache.cr_sort_sz;
		self.company_clean_addr.lot		       		:= r.AIDWork_AceCache.lot;
		self.company_clean_addr.lot_order		  	:= r.AIDWork_AceCache.lot_order;
		self.company_clean_addr.dbpc		       	:= r.AIDWork_AceCache.dbpc;
		self.company_clean_addr.chk_digit		 		:= r.AIDWork_AceCache.chk_digit;
		self.company_clean_addr.rec_type	      := r.AIDWork_AceCache.rec_type;
		self.company_clean_addr.fips_state		  := r.AIDWork_AceCache.county[1..2];
		self.company_clean_addr.fips_county   	:= r.AIDWork_AceCache.county[3..];
		self.company_clean_addr.geo_lat		   		:= r.AIDWork_AceCache.geo_lat;
		self.company_clean_addr.geo_long		   	:= r.AIDWork_AceCache.geo_long;
		self.company_clean_addr.msa			   			:= r.AIDWork_AceCache.msa;
		self.company_clean_addr.geo_blk		   		:= r.AIDWork_AceCache.geo_blk;
		self.company_clean_addr.geo_match		 		:= r.AIDWork_AceCache.geo_match;
		self.company_clean_addr.err_stat		  	:= r.AIDWork_AceCache.err_stat;
		self																		:= l;
	end;

	jBC_CleanBusAddr	:= JOIN(jBC_CleanContAddr,
														dWithAID(addr_type = 'B'),
														left.uniq_id = right.uniq_id,
														MapClnBusAddr(left,right),left outer): persist('~prte::persist::PRTE2_Business_Header::BC_Init');
												
	returndataset := jBC_CleanBusAddr;
	
	return returndataset;
end;