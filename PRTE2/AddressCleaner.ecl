// This macro takes one to many addresses and cleans them using the AID.MacAppendFromRaw_2Line cleaning macro. Cleaned addresses
// are placed in the fields enumerated in set_clean_addr_out.  Address 2 lines containing city, state, and zip can be
// passed in already prepared, in which case the set_city, set_state, and set_zip are all empty.  Otherwise the 
// city, state, and zip will be processed using address.fn_addr_clean_prep(Address.Addr2FromComponents.  The set_city_st_zip shouldn't
// empty in either case as the fields listed in it will be used to store the prepped city, state, zip concatenations.


//Example
// PRTE2.AddressCleaner(	in_file,   
											// ['street','streetA'],
											// ['physical_addr_2','mailing_addr_2'],
											// ['city','city_A'],
											// ['state','state_A'],
											// ['zip','zip_A'],
											// ['physical_address','mailing_address'],
											// ['physical_rawaid','mailing_rawaid']) ;
											

Import Address, AID;
EXPORT AddressCleaner(	infile,  //Incoming record set.  Required
												set_street  = [] , //Set of names of fields containing street addresses
												set_city_st_zip = [],	//Set of names of fields containing city, state, and zip prepped and concatenated
												set_city  = [], //Set of fields containing unprepped city
												set_state = [] ,	//Set of fields containing unprepped state
												set_zip = [],//Set of fields containing unprepped zip
												set_clean_addr_out = [],	//Set of fieldnames where addresses will be put in Address.Layout_Clean182_fips layout
												set_rawaid_out  = []) //Set of fields where RawAIDs will be put.
															:= FunctionMacro

loadxml('<XML/>');  
		
	#IF(count(set_city_st_zip) != count(set_street) or count(set_city_st_zip) != count(set_clean_addr_out) or count(set_city_st_zip) != count(set_rawaid_out) 
				or 
				(	(count(set_city) != 0 or count(set_state) != 0 or count(set_zip) !=0)
					and 
					(count(set_city_st_zip) !=count(set_city) or count(set_city_st_zip) !=count(set_state)  or count(set_city_st_zip) !=count(set_zip))
				)
			)
    #ERROR('Sets must have equal number of elements.');
    OUTPUT('Sets must have equal number of elements.');
  #END;

		
   #DECLARE(cnt_address_recs);
   #SET(cnt_address_recs,count(set_clean_addr_out));
   #DECLARE(rec_cnt);
   #SET(rec_cnt,0);
   #DECLARE(OutStr);
   #SET(OutStr,'');
  
   #LOOP
     #SET(rec_cnt,%rec_cnt%+1);
      #IF(%rec_cnt% > %cnt_address_recs%)
        #BREAK
      #ELSE   
        #APPEND(OutStr,'Address.Layout_Clean182_fips ' + set_clean_addr_out[%rec_cnt%] + ';\n');
        #APPEND(OutStr,'unsigned8 '  + set_rawaid_out[%rec_cnt%] + ' := 0;\n');
     #END;
   #END;
	
		base_layout := Record(Recordof(infile))
			#EXPAND(%'OutStr'%)
		end;
		
	#DECLARE(OutStr2);
  #SET(OutStr2,'');
	#SET(rec_cnt,0);
	#EXPORTXML(layout_xml,base_layout);
	#DECLARE(FIELD_FLAG_1);
	#SET(FIELD_FLAG_1, FALSE);
  #LOOP	
			#SET(rec_cnt,%rec_cnt%+1);
      #IF(%rec_cnt% > %cnt_address_recs%)
        #BREAK
      #ELSE   
				#FOR (layout_xml) 
					 #FOR(Field)
							#IF(%'{@label}'% = set_city_st_zip[%rec_cnt%])
								#SET(FIELD_FLAG_1, TRUE);
							#END
							
					 #END
				#END
				#APPEND(OutStr2, 'String street_address_field_' + %rec_cnt% + ' := \'\';\n');
				#IF(%FIELD_FLAG_1% = FALSE)
					#APPEND(OutStr2, 'String ' + set_city_st_zip[%rec_cnt%] + ' := \'\';\n');
				#END;
				// #IF(~PRTE2.ContainsField(set_city_st_zip[%rec_cnt%], base_layout))
					// #APPEND(OutStr2, 'String ' + set_city_st_zip[%rec_cnt%] + ' := \'\';\n');
				// #END;
			#END;
			#SET(FIELD_FLAG_1, FALSE);
  #END;
	addr_field_layout := record
			#EXPAND(%'OutStr2'%)
	end;
	
	final_layout := base_layout or addr_field_layout;
	seq_layout := Record(final_layout)
			unsigned4 unique_id;
	end;
	
		#DECLARE(OutStr3);
		#SET(OutStr3,'');
		#SET(rec_cnt,0);
		#LOOP	
				#SET(rec_cnt,%rec_cnt%+1);
				#IF(%rec_cnt% > %cnt_address_recs%)
					#BREAK
				#ELSE   	
					#APPEND(OutStr3, 
									'self.street_address_field_' + %'rec_cnt'% + '	:= address.fn_addr_clean_prep(l.'+set_street[%rec_cnt%]+',\'first\');\n'); 
					#IF(count(set_city) >= %rec_cnt% AND count(set_state) >= %rec_cnt% and count(set_zip) >= %rec_cnt%)
							#APPEND(OutStr3, 'self.' 
									+ set_city_st_zip[%rec_cnt%] 
									+ '	:= address.fn_addr_clean_prep(Address.Addr2FromComponents(l.' 
									+ set_city[%rec_cnt%] + ', l.' + set_state[%rec_cnt%] + ', l.' + set_zip[%rec_cnt%] + '),\'last\');\n');
					#ELSE
							#APPEND(OutStr3, 'self.' 
									+ set_city_st_zip[%rec_cnt%] 
									+ '	:= address.fn_addr_clean_prep(l.' + set_city_st_zip[%rec_cnt%]  + ',\'last\');\n');
					#END
				#END;
		#END;
		
	seq_layout clean_raw(infile l, integer c) := transform
		#EXPAND(%'OutStr3'%)
		self.unique_id := c;
		self := l; 
		self := [];
	end;
	
	local SeqFile := project(infile, clean_raw(left, counter));				
	
	m_temp_layout := RECORD(recordof(SeqFile))
		string150	Append_PrepAddr1;
		string100	Append_PrepAddr2;
		AID.Common.xAID	fm_RawAID_ := 0;
		integer addr_type_local_1234;
	END;
	

	
	#DECLARE(OutStr4);
	#SET(OutStr4,'');
	#DECLARE(OutStr5);
	#SET(OutStr5,'');
	#SET(rec_cnt,0);
	#LOOP	
			#SET(rec_cnt,%rec_cnt%+1);
			#IF(%rec_cnt% > %cnt_address_recs%)
				#BREAK
			#ELSE   	
				#APPEND(OutStr4, 'lh.street_address_field_' + %'rec_cnt'%);
				#APPEND(OutStr5, 'lh.' + set_city_st_zip[%rec_cnt%]);
			#IF(%rec_cnt% < %cnt_address_recs%)
          #APPEND(OutStr4,',');
					#APPEND(OutStr5,',');
        #END
     #END;
   #END;
	
	m_temp_layout xform(SeqFile lh, integer c) := transform
			self.Append_PrepAddr1 := choose(c,#expand(%'OutStr4'%));
			self.Append_PrepAddr2 := choose(c,#expand(%'OutStr5'%));
		self.addr_type_local_1234 := c;
		self := lh;
	end;

	local norm_infile := normalize(SeqFile, %cnt_address_recs%, xform(LEFT,counter));
	// OUTPUT(SeqFile, NAMED('SeqFile'));
	// OUTPUT(norm_infile, NAMED('norm_infile'));
	unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords|AID.Common.eReturnValues.NoNewCacheFiles;

	AID.MacAppendFromRaw_2Line(norm_infile, Append_PrepAddr1, Append_PrepAddr2, fm_RawAID_, dAddressCleaned, lAIDAppendFlags);							



		#DECLARE(OutStr6);
		#SET(OutStr6,'');
		#SET(rec_cnt,1);
		#LOOP	
				#SET(rec_cnt,%rec_cnt%+1);
				#IF(%rec_cnt% > %cnt_address_recs%)
					#BREAK
				#ELSE   	
						#APPEND(OutStr6, 'self.' + set_rawaid_out[%rec_cnt%] 		 + ' 							:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_RawAID, l.' + set_rawaid_out[%rec_cnt%] +');\n');	
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.prim_range		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.prim_range, l.' + set_clean_addr_out[%rec_cnt%] + '.prim_range);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.predir				:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.predir, l.' + set_clean_addr_out[%rec_cnt%] + '.predir);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.prim_name		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.prim_name	, l.' + set_clean_addr_out[%rec_cnt%] + '.prim_name);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.addr_suffix	:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.addr_suffix, l.' + set_clean_addr_out[%rec_cnt%] + '.addr_suffix);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.postdir			:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.postdir, l.' + set_clean_addr_out[%rec_cnt%] + '.postdir);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.unit_desig		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.unit_desig, l.' + set_clean_addr_out[%rec_cnt%] + '.unit_desig);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.sec_range		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.sec_range, l.' + set_clean_addr_out[%rec_cnt%] + '.sec_range);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.p_city_name	:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.p_city_name, l.' + set_clean_addr_out[%rec_cnt%] + '.p_city_name);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.v_city_name	:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.v_city_name, l.' + set_clean_addr_out[%rec_cnt%] + '.v_city_name);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.st						:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.st	, l.' + set_clean_addr_out[%rec_cnt%] + '.st);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.zip					:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.zip5	, l.' + set_clean_addr_out[%rec_cnt%] + '.zip);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.zip4					:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.zip4	, l.' + set_clean_addr_out[%rec_cnt%] + '.zip4);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.cart					:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.cart	, l.' + set_clean_addr_out[%rec_cnt%] + '.cart);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.cr_sort_sz		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.cr_sort_sz, l.' + set_clean_addr_out[%rec_cnt%] + '.cr_sort_sz);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.lot					:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.lot	, l.' + set_clean_addr_out[%rec_cnt%] + '.lot);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.lot_order		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.lot_order, l.' + set_clean_addr_out[%rec_cnt%] + '.lot_order);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.dbpc					:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.dbpc	, l.' + set_clean_addr_out[%rec_cnt%] + '.dbpc);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.chk_digit		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.chk_digit, l.' + set_clean_addr_out[%rec_cnt%] + '.chk_digit);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.rec_type			:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.rec_type, l.' + set_clean_addr_out[%rec_cnt%] + '.rec_type);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.fips_state		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.county[1..2], l.' + set_clean_addr_out[%rec_cnt%] + '.fips_state);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.fips_county	:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.county[3..5], l.' + set_clean_addr_out[%rec_cnt%] + '.fips_county);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.geo_lat			:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.geo_lat, l.' + set_clean_addr_out[%rec_cnt%] + '.geo_lat);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.geo_long			:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.geo_long, l.' + set_clean_addr_out[%rec_cnt%] + '.geo_long);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.msa					:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.msa	, l.' + set_clean_addr_out[%rec_cnt%] + '.msa);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.geo_blk			:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.geo_blk, l.' + set_clean_addr_out[%rec_cnt%] + '.geo_blk);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.geo_match		:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.geo_match, l.' + set_clean_addr_out[%rec_cnt%] + '.geo_match);\n');
						#APPEND(OutStr6, 'self.' + set_clean_addr_out[%rec_cnt%] + '.err_stat			:= if(r.addr_type_local_1234 = ' + %'rec_cnt'% + ', r.AIDWork_ACECache.err_stat, l.' + set_clean_addr_out[%rec_cnt%] + '.err_stat);\n');
				#END;
		#END;		
// return %'OutStr'%;
recordof(dAddressCleaned) final_xform(dAddressCleaned l, dAddressCleaned r) := transform
			self.#EXPAND(set_rawaid_out[1])				:= if(l.addr_type_local_1234 = 1, l.AIDWork_RawAID, l.#EXPAND(set_rawaid_out[1]));
			self.#EXPAND(set_clean_addr_out[1]).prim_range		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.prim_range, l.#EXPAND(set_clean_addr_out[1]).prim_range);
			self.#EXPAND(set_clean_addr_out[1]).predir			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.predir, l.#EXPAND(set_clean_addr_out[1]).predir);
			self.#EXPAND(set_clean_addr_out[1]).prim_name		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.prim_name	,l.#EXPAND(set_clean_addr_out[1]).prim_name);
			self.#EXPAND(set_clean_addr_out[1]).addr_suffix		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.addr_suffix,l.#EXPAND(set_clean_addr_out[1]).addr_suffix);
			self.#EXPAND(set_clean_addr_out[1]).postdir			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.postdir, l.#EXPAND(set_clean_addr_out[1]).postdir);
			self.#EXPAND(set_clean_addr_out[1]).unit_desig		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.unit_desig,l.#EXPAND(set_clean_addr_out[1]).unit_desig);
			self.#EXPAND(set_clean_addr_out[1]).sec_range		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.sec_range,l.#EXPAND(set_clean_addr_out[1]).sec_range);
			self.#EXPAND(set_clean_addr_out[1]).p_city_name		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.p_city_name,l.#EXPAND(set_clean_addr_out[1]).p_city_name);
			self.#EXPAND(set_clean_addr_out[1]).v_city_name		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.v_city_name,l.#EXPAND(set_clean_addr_out[1]).v_city_name);
			self.#EXPAND(set_clean_addr_out[1]).st			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.st	,l.#EXPAND(set_clean_addr_out[1]).st);
			self.#EXPAND(set_clean_addr_out[1]).zip			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.zip5	,l.#EXPAND(set_clean_addr_out[1]).zip);
			self.#EXPAND(set_clean_addr_out[1]).zip4			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.zip4	,l.#EXPAND(set_clean_addr_out[1]).zip4);
			self.#EXPAND(set_clean_addr_out[1]).cart			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.cart	,l.#EXPAND(set_clean_addr_out[1]).cart);
			self.#EXPAND(set_clean_addr_out[1]).cr_sort_sz		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.cr_sort_sz,l.#EXPAND(set_clean_addr_out[1]).cr_sort_sz);
			self.#EXPAND(set_clean_addr_out[1]).lot			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.lot	,l.#EXPAND(set_clean_addr_out[1]).lot);
			self.#EXPAND(set_clean_addr_out[1]).lot_order		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.lot_order,l.#EXPAND(set_clean_addr_out[1]).lot_order);
			self.#EXPAND(set_clean_addr_out[1]).dbpc			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.dbpc	,l.#EXPAND(set_clean_addr_out[1]).dbpc);
			self.#EXPAND(set_clean_addr_out[1]).chk_digit		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.chk_digit,l.#EXPAND(set_clean_addr_out[1]).chk_digit);
			self.#EXPAND(set_clean_addr_out[1]).rec_type			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.rec_type,l.#EXPAND(set_clean_addr_out[1]).rec_type);
			self.#EXPAND(set_clean_addr_out[1]).fips_state		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.county[1..2],l.#EXPAND(set_clean_addr_out[1]).fips_state);
			self.#EXPAND(set_clean_addr_out[1]).fips_county		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.county[3..5],l.#EXPAND(set_clean_addr_out[1]).fips_county);
			self.#EXPAND(set_clean_addr_out[1]).geo_lat			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.geo_lat,l.#EXPAND(set_clean_addr_out[1]).geo_lat);
			self.#EXPAND(set_clean_addr_out[1]).geo_long			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.geo_long,l.#EXPAND(set_clean_addr_out[1]).geo_long);
			self.#EXPAND(set_clean_addr_out[1]).msa			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.msa	,l.#EXPAND(set_clean_addr_out[1]).msa);
			self.#EXPAND(set_clean_addr_out[1]).geo_blk			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.geo_blk,l.#EXPAND(set_clean_addr_out[1]).geo_blk);
			self.#EXPAND(set_clean_addr_out[1]).geo_match		:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.geo_match,l.#EXPAND(set_clean_addr_out[1]).geo_match);
			self.#EXPAND(set_clean_addr_out[1]).err_stat			:= if(l.addr_type_local_1234 = 1, l.AIDWork_ACECache.err_stat,l.#EXPAND(set_clean_addr_out[1]).err_stat);
			
			#EXPAND(%'OutStr6'%)
	
		self := l;
		self := [];
end;


recordof(dAddressCleaned) final_xform_one_addrfield(dAddressCleaned l) := transform
			self.#EXPAND(set_rawaid_out[1])				:= l.AIDWork_RawAID;
			self.#EXPAND(set_clean_addr_out[1]).prim_range		:= l.AIDWork_ACECache.prim_range;
			self.#EXPAND(set_clean_addr_out[1]).predir			:= l.AIDWork_ACECache.predir;
			self.#EXPAND(set_clean_addr_out[1]).prim_name		:= l.AIDWork_ACECache.prim_name;
			self.#EXPAND(set_clean_addr_out[1]).addr_suffix		:= l.AIDWork_ACECache.addr_suffix;
			self.#EXPAND(set_clean_addr_out[1]).postdir			:= l.AIDWork_ACECache.postdir;
			self.#EXPAND(set_clean_addr_out[1]).unit_desig		:= l.AIDWork_ACECache.unit_desig;
			self.#EXPAND(set_clean_addr_out[1]).sec_range		:= l.AIDWork_ACECache.sec_range;
			self.#EXPAND(set_clean_addr_out[1]).p_city_name		:= l.AIDWork_ACECache.p_city_name;
			self.#EXPAND(set_clean_addr_out[1]).v_city_name		:= l.AIDWork_ACECache.v_city_name;
			self.#EXPAND(set_clean_addr_out[1]).st			:= l.AIDWork_ACECache.st;
			self.#EXPAND(set_clean_addr_out[1]).zip			:= l.AIDWork_ACECache.zip5;
			self.#EXPAND(set_clean_addr_out[1]).zip4			:= l.AIDWork_ACECache.zip4;
			self.#EXPAND(set_clean_addr_out[1]).cart			:= l.AIDWork_ACECache.cart;
			self.#EXPAND(set_clean_addr_out[1]).cr_sort_sz		:= l.AIDWork_ACECache.cr_sort_sz;
			self.#EXPAND(set_clean_addr_out[1]).lot			:= l.AIDWork_ACECache.lot;
			self.#EXPAND(set_clean_addr_out[1]).lot_order		:= l.AIDWork_ACECache.lot_order;
			self.#EXPAND(set_clean_addr_out[1]).dbpc			:= l.AIDWork_ACECache.dbpc;
			self.#EXPAND(set_clean_addr_out[1]).chk_digit		:= l.AIDWork_ACECache.chk_digit;
			self.#EXPAND(set_clean_addr_out[1]).rec_type			:= l.AIDWork_ACECache.rec_type;
			self.#EXPAND(set_clean_addr_out[1]).fips_state		:= l.AIDWork_ACECache.county[1..2];
			self.#EXPAND(set_clean_addr_out[1]).fips_county		:= l.AIDWork_ACECache.county[3..5];
			self.#EXPAND(set_clean_addr_out[1]).geo_lat			:= l.AIDWork_ACECache.geo_lat;
			self.#EXPAND(set_clean_addr_out[1]).geo_long			:= l.AIDWork_ACECache.geo_long;
			self.#EXPAND(set_clean_addr_out[1]).msa			:= l.AIDWork_ACECache.msa;
			self.#EXPAND(set_clean_addr_out[1]).geo_blk			:= l.AIDWork_ACECache.geo_blk;
			self.#EXPAND(set_clean_addr_out[1]).geo_match		:= l.AIDWork_ACECache.geo_match;
			self.#EXPAND(set_clean_addr_out[1]).err_stat			:= l.AIDWork_ACECache.err_stat;
		self := l;
		self := [];
end;

clean_rolled := if (%cnt_address_recs% > 1,
										rollup(sort(dAddressCleaned, unique_id, addr_type_local_1234), final_xform(left,right), unique_id),
										project(dAddressCleaned, final_xform_one_addrfield(left)));
	final := project(clean_rolled, final_layout);
	// Output(dAddressCleaned,	named('dAddressCleaned'));
	return final;




	  //result := Project(infile, transform(base_layout, self := left, self := []));
	
ENDMACRO;