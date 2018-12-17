IMPORT AddrBest,didville,batchServices;
export Mac_Monitoring_Best_Addr
(
	infile, 
	did_field, 
	outfile,
	bool_want_street_address = 'false',
	match_file,
	dedup_option = 0,
	name_match_option = 0,
	partial_addr_dup = 0,
	non_thor_call = false,
	b_rollup_dtfirstseen = false,
	rollup_by_lastname = false,
	return_unserviceable_flag = false,
	unserviceable_dedup_option = 0,
	ff_flag = false,
	hist_match_codes = false,
	name_match = false,
	streetaddr_match = false,
	city_match = false,
	st_match = false,
	zip_match = false,
	ssn_match = false,
	dob_match = false,
	did_match = false,
	rank_in = 'dataset([],AddrBest.layout_header_ext)',
	Max_records = 1,
	did_append_in
) := MACRO

import Advo, NID, batchservices, ut;

#uniquename(Ranking_Requested)
boolean %Ranking_Requested% := exists(rank_in);

#uniquename(rfields_slim)
%rfields_slim% := record
	unsigned6    did_field;
	unsigned6    rid;
	string2      src;
	integer4      dt_first_seen;
	integer4      dt_last_seen;
	integer4      dt_vendor_last_reported;
	integer4      dt_vendor_first_reported;
	integer4      dt_nonglb_last_seen;
	string1      rec_type;
	qstring10     prim_range; // ?5 bytes
	string2      predir; // int1 lookup
	qstring28     prim_name;
	string4      suffix; // int1 lookup
	string2      postdir; // int1
	qstring10     unit_desig; // int1 lookup
	qstring8      sec_range; // ?
	qstring25     city_name; // ?int4 lookup?
	string2      st; // int1 lookup
	qstring5      zip; // udecimal5
	qstring4      zip4; // unsigned2
	string1 tnt := ' ';
	qstring3 		 county;
	qstring10    phone;
	qstring20    fname;
	qstring20    mname;
	qstring20    lname;
	qstring5     name_suffix;
	qstring9     ssn;
	integer4     dob;
	unsigned1    best_address_number;
	unsigned1 best_address_count := 0;
	boolean unserviceable := FALSE;
	boolean match_name := false;
	boolean match_street_address := false;
	boolean match_city := false;
	boolean match_state := false;
	boolean match_zip := false;
	boolean match_ssn := false;
	boolean match_dob := false;
	boolean match_did := false;
	boolean matches := false;
	string8 matchcodes := '';
	boolean ff_mover := FALSE;
	#IF(non_thor_call)
		dataset(AddrBest.Layout_BestAddr.rec_src) srcs := dataset([],AddrBest.Layout_BestAddr.rec_src);
	#END	
end;
#uniquename(rfields)
%rfields% := record
	%rfields_slim%;
	boolean is_input := FALSE;
	boolean pickup := FALSE;
	boolean next_most_current := FALSE;
	unsigned4 seq := 0;
	boolean no_inputs := FALSE;
	unsigned2 rollup_counter := 0;
END;
	#uniquename(addr_filt)
	#if(bool_want_street_address)
	%addr_filt% := infile;
	#else
	%addr_filt% := infile(address.AddressQuality(prim_range,prim_name,suffix,sec_range,city_name,zip)=0);
	#end

	#uniquename(slim)
	%rfields% %slim%(infile le) := transform
	self := le;
	end;
	
	#uniquename(slim_h0)
	%slim_h0% := distribute(project(%addr_filt%,%slim%(left)),hash(did_field));
 	
	#uniquename(d_lseen)
	%d_lseen%(%rfields% rfile) := 
		map( rfile.src in ['LT','AE','EM'] => 0,
										rfile.src = 'EQ' and  rfile.ssn ='' => rfile.dt_first_seen,
										//%slim_h%.dt_last_seen=0 => %slim_h%.dt_vendor_last_reported, 
					 rfile.dt_last_seen);
	
	#uniquename(tnt_gd)
	%tnt_gd%(%rfields% rfile) := map(rfile.tnt='Y' => 1,
					rfile.tnt='P' => 2,0);
	
	#uniquename(street_addr)
	#if(bool_want_street_address)
	%street_addr%(%rfields% rfile) := map(
		rfile.prim_name = '' and rfile.prim_range = '' and rfile.city_name = '' and rfile.zip = '' and rfile.st = ''
			=> 0,
			rfile.prim_name = '' => 1, 
			rfile.prim_name[1..7] = 'PO BOX ' or rfile.prim_name[1..3] in ['RR ', 'HC ']
			=> 2, 3);
	#else
	%street_addr%(%rfields% rfile) := 1;
	#end

	#uniquename(add_score)
	%add_score%(%rfields% rfile) := map(rfile.zip4 != '' => 4,
						 rfile.prim_range != '' => 3,
						 rfile.sec_range != '' => 2,
						 rfile.prim_name != '' => 1,0);
	
	#uniquename(st_zip)
	%st_zip%(%rfields% rfile)  := if(ziplib.ZipToState2(rfile.zip)=rfile.st,1,0);

	#uniquename(get_partial_addr_matches)
	%rfields% %get_partial_addr_matches%(%rfields% l,%rfields% r,integer C) := transform
		self.is_input := TRUE;
	self.pickup := TRUE;
	r_dt_last_seen := %d_lseen%(r);
	l_dt_last_seen := %d_lseen%(l);
	self := if(r_dt_last_seen > l_dt_last_seen or C=1,r,l);
	END;
	
	#uniquename(partial_addr_matches)
	%partial_addr_matches% := denormalize(%slim_h0%(is_input),%slim_h0%(~is_input),
		left.did_field = right.did_field and // This contains Account number
		left.rid = right.rid and  // This contains actual did
		left.prim_range = right.prim_range 
		and stringlib.stringfind(trim(left.prim_name)+' ',trim(right.prim_name)+' ',1)>0
		and (left.st=right.st or left.st='')
		and (left.zip=right.zip or left.zip='')
		and (left.sec_range=right.sec_range or left.sec_range=''),
		%get_partial_addr_matches%(left,right,counter),local);

	#uniquename(no_addr_matches)
	%no_addr_matches% :=join(%slim_h0%(~is_input),%partial_addr_matches%,
		left.did_field = right.did_field and	// This contains Account number
		left.rid = right.rid and	// This contains actual did
		left.prim_name = right.prim_name and 
		left.prim_range = right.prim_range 
		and (left.st=right.st or right.st='')
		and (left.zip=right.zip or right.zip='')
		and (left.sec_range=right.sec_range),local,left only);

	#uniquename(slim_h_partial_match)
	%slim_h_partial_match% := %no_addr_matches% + %partial_addr_matches%;
	
	#uniquename(slim_h)
	%slim_h% := if(partial_addr_dup=1,%slim_h_partial_match%,%slim_h0%);
  
	#uniquename(srt_h_pre)
	#uniquename(fill_src)

	#IF(non_thor_call)
		%fill_src% := project(%slim_h%,transform(recordof(%slim_h%),self.srcs := dataset([{left.src}],AddrBest.Layout_BestAddr.rec_src),self := left));

		%srt_h_pre% := if(%Ranking_Requested%,
		                  sort(%fill_src%,did_field,rid,prim_range,predir,prim_name,suffix,postdir, 
											                zip, sec_range, lname,
																			-is_input, -%d_lseen%(%fill_src%),
		                                  -dt_first_seen, -%street_addr%(%fill_src%),-%tnt_gd%(%fill_src%),
																	    -dt_vendor_first_reported,-%add_score%(%fill_src%),
																	    -%st_zip%(%fill_src%) ,local),
		                  sort(%fill_src%,did_field,rid,prim_range,prim_name,
											                zip, sec_range, lname,
																			-is_input, -%d_lseen%(%fill_src%),
		                                  -dt_first_seen, -%street_addr%(%fill_src%),-%tnt_gd%(%fill_src%),
																	    -dt_vendor_first_reported,-%add_score%(%fill_src%),
																	    -%st_zip%(%fill_src%) ,local));

	#ELSE
		%srt_h_pre% := if(%Ranking_Requested%,
		                  sort(%slim_h%,did_field,rid,prim_range,predir,prim_name,suffix,postdir, 
											              zip, sec_range, lname, 
																		-is_input, -%d_lseen%(%slim_h%),
		                                -dt_first_seen, -%street_addr%(%slim_h%),-%tnt_gd%(%slim_h%),
																	  -dt_vendor_first_reported,-%add_score%(%slim_h%),
																	  -%st_zip%(%slim_h%) ,local),
		                  sort(%slim_h%,did_field,rid,prim_range,prim_name,
											              zip, sec_range, lname, 
																		-is_input, -%d_lseen%(%slim_h%),
		                                -dt_first_seen, -%street_addr%(%slim_h%),-%tnt_gd%(%slim_h%),
																	  -dt_vendor_first_reported,-%add_score%(%slim_h%),
																	  -%st_zip%(%slim_h%) ,local));
		
	#END	
	
	#uniquename(get_pickup_input)
	%rfields% %get_pickup_input%(%rfields% l,%rfields% r):=transform
	//bug 81032 - the prim_name+zip condition prevents cases where
	//dup_flag can return 'C' despite the input record not having an address
	self.pickup := map(l.is_input=true and r.rid>0 => l.is_input,
	                   l.prim_name<>'' and l.zip<>'' => r.is_input,
										 false);	
	self.is_input := if(r.is_input, r.is_input, l.is_input);
	self.rollup_counter := l.rollup_counter+ 1;
	self.dt_first_seen := if(b_rollup_dtfirstseen,
						// bug 81469: previously, we were dropping valid dates whenever a record with no dt_first_seen 
						// was found for the same address.  
						ut.Min2(l.dt_first_seen, r.dt_first_seen), 
						if(l.rollup_counter=0 and l.is_input,r.dt_first_seen,l.dt_first_seen));
	self.dt_last_seen := if(l.dt_last_seen<r.dt_last_seen, r.dt_last_seen, l.dt_last_seen);
	self.sec_range := if(r.sec_range<>'', r.sec_range, l.sec_range);
	// when input address matches found address get the dates and names from the first found address
	#IF(non_thor_call)
		self.srcs := choosen(l.srcs + dataset([{r.src}],AddrBest.Layout_BestAddr.rec_src),AddrBest.Constants.max_count_src);
	#end
	self.phone := if(trim(l.phone)='',r.phone,l.phone);
	self.ssn := if(trim(l.ssn)='',r.ssn,l.ssn);
	self.dob := if(l.dob=0,r.dob,l.dob);
	self := if(l.rollup_counter=0 and l.is_input,r,l);
	end;
	// Find input addresses that are duplicates of found addresses and mark them as pickups
	
	// Rollup similar address variations and when Gov Best Address "Ranking_Requested", 
	// also use predir, postdir & suffix as rollup conditions.
	#uniquename(noranking_rollup)
	%noranking_rollup% := rollup(%srt_h_pre%,
	           left.did_field  = right.did_field  and
						 left.rid  = right.rid  and
						 left.prim_range = right.prim_range and
						 left.prim_name  = right.prim_name  and
						 left.zip        = right.zip        and
						 (left.sec_range = right.sec_range or left.sec_range='' and ~left.is_input)
						 and (~rollup_by_lastname or left.lname = right.lname),
						 %get_pickup_input%(left,right),local);

	#uniquename(ranking_rollup)
	%ranking_rollup% := rollup(%srt_h_pre%,
	           left.did_field  = right.did_field  and
						 left.rid  = right.rid  and
						 left.prim_range = right.prim_range and
					   left.predir	   = right.predir	    and
						 left.prim_name  = right.prim_name  and
					   left.suffix     = right.suffix     and
					   left.postdir    = right.postdir    and  
						 left.zip        = right.zip        and
						 left.sec_range  = right.sec_range  and 
						 (~rollup_by_lastname or left.lname = right.lname),
						 %get_pickup_input%(left,right),local);
						 
	#uniquename(dep_h0)
	%dep_h0% :=IF(%ranking_requested%, %ranking_rollup%, %noranking_rollup%);
	
	#uniquename(calculate_matchcodes)
	%rfields% %calculate_matchcodes%(%rfields% l, match_file r):=transform		
			self.match_name :=  
				((l.fname = r.name_first and l.fname <> '') OR 
				(NID.mod_PFirstTools.PFLeqPFR(l.fname, r.name_first) AND l.fname <> '')) AND
				(l.lname = r.name_last AND l.lname <> '');
			self.match_street_address :=  
				(l.prim_range = r.prim_range AND l.prim_range <> '') AND
				(l.prim_name = r.prim_name AND l.prim_name <> '') AND
				(l.suffix = r.suffix AND l.suffix <> '') AND
				(l.predir = r.predir) AND
				(l.postdir = r.postdir);
			self.match_city  := l.city_name = r.p_city_name AND l.city_name <> '';
			self.match_state := l.st = r.st AND l.st <> '';
			self.match_zip  := l.zip = r.z5 AND l.zip <> '';
			//doesn't really do too much since input for right.ssn is string9 and thus implication is that - are not allowed
			//but keeping code here in case ssn input is at some point uncleaned on way into roxie service.
			self.match_ssn   := ((l.ssn = stringlib.stringfilterout(r.ssn, '-')) AND (l.ssn <> ''));
			self.match_dob   := l.dob = (integer4) r.dob AND l.dob <> 0;
			self.match_did   :=	l.rid = r.did AND l.rid <> 0; 		
			self.matches := 
									((~(name_match)) OR (self.match_name))
									AND 
										((~(streetaddr_match)) OR (self.match_street_address))
									AND
									((~(city_match)) OR (self.match_city))
									AND
									((~(st_match)) OR (self.match_state))
									AND
									((~(zip_match)) OR (self.match_zip))
									AND
									((~(ssn_match)) OR (self.match_ssn))
									AND
									((~(dob_match)) OR (self.match_dob))
									AND
									((~(did_match)) OR (self.match_did));
			self.matchcodes := 	batchServices.functions.match_code_result(
														self.match_name, self.match_street_address,
														self.match_city, self.match_state,
														self.match_zip, self.match_ssn, self.match_dob, self.match_did);	
			self := l;
	END;
	
	#uniquename(dep_h00)
	%dep_h00% := join(%dep_h0%, match_file, 
										 left.did_field = (unsigned) right.acctno,
										 %calculate_matchcodes%(left, right),
										 keep(1));	
	
	// Get rid of input addresses that are not duplicates from the resultset
	#uniquename(dep_h1)
	%dep_h1% := %dep_h00%(not(is_input and not pickup));
	
	
	// only do name matching if match type is specified from bestaddress service			
	#uniquename(match1)
	%match1%:= join(%dep_h1%, match_file, left.did_field =(unsigned) right.acctno and left.fname = right.name_first,
		transform(%rfields%,self := left));
	#uniquename(match2)
	%match2% := join(%dep_h1%, match_file, left.did_field =(unsigned) right.acctno and left.lname = right.name_last,
		transform(%rfields%,self := left));
	#uniquename(match3)
	 %match3% := join(%dep_h1%, match_file,left.did_field =(unsigned) right.acctno and left.fname =
				right.name_first and left.lname = right.name_last,
		transform(%rfields%,self := left));
	#uniquename(match4)
	 %match4% :=join(%dep_h1%, match_file,left.did_field =(unsigned) right.acctno and left.fname =
				right.name_first and left.lname = right.name_last and left.mname=right.name_middle,
		transform(%rfields%,self := left));
	#uniquename(match5)
	 %match5% :=join(%dep_h1%, match_file, left.did_field =(unsigned) right.acctno and left.fname[1] =
				right.name_first[1] and left.lname = right.name_last,transform(%rfields%,self := left));
	#uniquename(dep_h_pre)
	%dep_h_pre% :=case(name_match_option,1=>%match1%,2=>%match2%,3=>%match3%,4=>%match4%,5=>%match5%,%dep_h1%);
	

	#uniquename(dep_h_pre_w_serv)	
	%dep_h_pre_w_serv% := join(%dep_h_pre%, Advo.Key_Addr1,
			keyed(left.zip = right.zip) and
			keyed(left.prim_range = right.prim_range) and
			keyed(left.prim_name = right.prim_name) and
			keyed(left.suffix = right.addr_suffix) and
			keyed(left.predir = right.predir) and
			keyed(left.postdir = right.postdir) and
			keyed(left.sec_range = right.sec_range),
			transform(recordof(%dep_h_pre%), 
				self.unserviceable := (right.record_type_code IN ['R','P'] or // P = P.o. box  R = Rural route
															 																		    // B = P.o. box  R = Rural route G = General Delivery
																																		  // F = Residential Contract Box H = Residential Non-Personnel Unit or S = Street
																right.route_num[1] IN ['B','G','R'] and right.record_type_code NOT IN ['F','H','S'] or 
																right.address_vacancy_indicator = 'Y');
				self := left),
			left outer,
			limit(5000),
			keep(1));

	#uniquename(dep_h)
	%dep_h% := IF(return_unserviceable_flag or unserviceable_dedup_option>0, %dep_h_pre_w_serv%, %dep_h_pre%);	
		
	#uniquename(srt_h)
	%srt_h% := sort(%dep_h%,did_field,rid,-%d_lseen%(%dep_h%),-dt_first_seen,-%street_addr%(%dep_h%),-%tnt_gd%(%dep_h%),
					-dt_vendor_first_reported,-%add_score%(%dep_h%),-prim_range,-predir,-prim_name,
					-suffix,-postdir,-unit_desig,-sec_range,-city_name,-zip,-zip4,-%st_zip%(%dep_h%),st,local);
	#uniquename(grp0)
	%grp0% := group(%srt_h%,did_field,local);


	//*** Begin work to eliminate unwanted records for bestAddress.  This does not apply to monitoring
	
	#uniquename(get_seq)
	
	%rfields% %get_seq%(%grp0% l, %grp0% r, integer C):=transform
		self.seq := C;
		self.matchcodes := if(hist_match_codes and l.did_field<>0 and l.did_field=r.did_field, batchServices.functions.merge_match_codes(l.matchcodes, r.matchcodes), r.matchcodes);
		self := r;
	END;

	#uniquename(grp0_w_seq)
	%grp0_w_seq% := iterate(%grp0%,%get_seq%(left,right,counter));	
	
	#uniquename(set_hist_flags)
	%rfields% %set_hist_flags%(%grp0% l, %grp0% r):=transform
		self.ff_mover := ff_flag and r.seq = 1 and (integer) r.dt_last_seen<>0 and r.dt_last_seen = l.dt_last_seen;
		self.matchcodes := if(hist_match_codes and l.did_field<>0 and l.did_field=r.did_field, batchServices.functions.merge_match_codes(l.matchcodes, r.matchcodes), r.matchcodes);
		self := r;
	END;

	#uniquename(grp0_w_hist)
	%grp0_w_hist% := sort(iterate(sort(%grp0_w_seq%, -seq), %set_hist_flags%(left, right)), seq);	
	
	#uniquename(grp00)
	%grp00% := if(ff_flag or hist_match_codes, %grp0_w_hist%, %grp0_w_seq%);	
	
	#uniquename(grp1)
	#uniquename(pre_grp2)
	#uniquename(srt_pre_grp2)
	#uniquename(grp2)
	#uniquename(grp3)
	#uniquename(grp4)
	#uniquename(grp5)
	#uniquename(grp6)
	#uniquename(test_for_input)
	#uniquename(get_pickup)
	
	%grp1% := %grp00%(not is_input);	
	

	%rfields% %test_for_input%(%grp0_w_seq% l, %grp0_w_seq% r, integer C):=transform
		self.no_inputs := (~r.is_input and C=1) or l.no_inputs;
		self := r;
	END;

	// Check for dedup address because if there is none all found addresses should be returned 
	
	%pre_grp2% := iterate(sort(%grp00%,did_field,rid,if(is_input,0,1)),%test_for_input%(left,right,counter));
	
	%srt_pre_grp2% :=sort(%pre_grp2%,seq);
	
	%rfields% %get_pickup%(%grp0%  l,%grp0%  r,Integer C):=transform

	//** Each record after the first input record is marked as next most current
		self.next_most_current := l.is_input or l.next_most_current;
	self.rec_type := map(r.is_input and C=1=>'C',
												 r.is_input => 'H',
												 r.rec_type);
	self.is_input := r.is_input;
	self.pickup := r.pickup;
	self.best_address_number := r.best_address_number;
	self.did_field := r.did_field;
	self.rid := r.rid;
	self.unserviceable := r.unserviceable;
	self.matches := r.matches;
	self := if(not r.is_input,r);
	self := [];
	END;
	%grp2% := iterate(%srt_pre_grp2% ,%get_pickup%(left,right,counter));
	
	%grp3% := %grp2%((next_most_current and not is_input) or no_inputs);
	%grp4% := %grp2%((next_most_current or is_input) or no_inputs);
	%grp5% := %grp2%((not next_most_current and not is_input) or no_inputs);
	%grp6% := %grp2%((not next_most_current) or no_inputs);
	
	#uniquename(dep_grp0)
	%dep_grp0% := case(dedup_option,
		1=> %grp1%,2=> %grp2%,3=>%grp3%,4=>%grp4%,5=>%grp5%,6=>%grp6%,%grp00%)(prim_name <> '' or is_input);
	
	// picking up records with unserviceable addresses
	#uniquename(unserv_grp1)
	%unserv_grp1% := %dep_grp0%(~unserviceable);
	
	#uniquename(get_unserviceable)
	%rfields% %get_unserviceable%(%dep_grp0%  l,%dep_grp0%  r,Integer C):=transform
		self.next_most_current := r.next_most_current;
		self.rec_type := r.rec_type;
		self.is_input := r.is_input;
		self.pickup := r.pickup;
		self.best_address_number := r.best_address_number;
		self.did_field := r.did_field;
		self.rid := r.rid;
		self.unserviceable := r.unserviceable;
		self := if(not r.unserviceable,r);
		self := [];
	END;
	#uniquename(unserv_grp2)
	%unserv_grp2% := iterate(%dep_grp0% ,%get_unserviceable%(left,right,counter));
	
	#uniquename(dep_grp)
	%dep_grp% := case(unserviceable_dedup_option, 
									1=> %unserv_grp1%, // remove address and flag
									2=> %unserv_grp2%, // remove address but return flag
									%dep_grp0%); 	 		 // return address with or without flag
	
	
	//*** End work for BestAddress filtering
	
	#uniquename(rfields_exp)
	%rfields_exp% := record
		%rfields% and not [is_input,pickup,next_most_current,rollup_counter];
	boolean keep_these;
	end;

	//*** Account for Gov ranking order when non-empty rank_in was passed in
	#uniquename(rank_seq)
	#uniquename(getUpdateRankSeq)
	%rfields% %getUpdateRankSeq%(%dep_grp% l, AddrBest.layout_header_ext r) := transform
		self.best_address_number := r.best_address_number;
		self		 := l;
		self		 := [];
	end;
	%rank_seq% := join(%dep_grp%, rank_in,
											left.did		 		= right.did		 			and //account number
											left.rid 				= right.rid   			and   // actual did
											left.zip 				= right.zip					and
											left.prim_range = right.prim_range	and
											left.predir		 	= right.predir			and
											left.prim_name 	= right.prim_name		and
											left.postdir	 	= right.postdir			and
											left.suffix 		= right.suffix			and
											left.sec_range 	= right.sec_range,
											%getUpdateRankSeq%(left, right),
											inner, limit(0), keep(1));
	#uniquename(best_recs)
	%best_recs% := if(%Ranking_Requested%,sort(%rank_seq%,did,best_address_number),ungroup(%dep_grp%));	
	
	// Additional checks with didappend to return matching did 
	// In rare cases where top most did from bestrecs does not match did from didappend, we try to bring matching input didappend did records  to the top
	
	
	#uniquename(rfields_exp_didappend)

	%rfields_exp_didappend% := record
		%rfields% ;
		boolean isdidappend;
	end;
	
	#uniquename(best_recs_didappend)
	#uniquename(getUpdatebestdid)
	
	%rfields_exp_didappend% %getUpdatebestdid%(%best_recs% l,did_append_in  r) := TRANSFORM
				self.isdidappend := l.rid = r.did;
				self := l;
				self := [];
	end;
	
		
	
	%best_recs_didappend% :=  join(%best_recs% ,did_append_in,
																	(STRING)left.did = right.acctno and
																	left.rid = right.did,
											%getUpdatebestdid%(left, right),
											left outer, limit(0));
											
	#uniquename(sortbest_recs_didappend)									
												
	%sortbest_recs_didappend% := group(sort(%best_recs_didappend%,did,if(isdidappend,0,1)),did,local); 
	
	
	#uniquename(get_top_best)
	%rfields_exp% %get_top_best%(%sortbest_recs_didappend% l, unsigned cnt) := transform,skip( cnt>l.best_address_number or cnt > Max_records)
		self.keep_these := true;
		self.best_address_count := cnt;
		self := l;
	end;
	
	#uniquename(k2)
	%k2% := project(%sortbest_recs_didappend%,%get_top_best%(left, counter));
	outfile := project(group(%k2%), %rfields_slim%);

  // OUTPUT(infile,          NAMED('infile'));
  // OUTPUT(%slim_h%,        NAMED('slim_h'));
  // OUTPUT(%srt_h_pre%,     NAMED('srt_h_pre'));
	// OUTPUT(%dep_h0_rollup%, NAMED('dep_h0_rollup'));
	// OUTPUT(%dep_h1_rollup%, NAMED('dep_h1_rollup'));
	// OUTPUT(%noranking_rollup%, NAMED('noranking_rollup'));
	// OUTPUT(%ranking_rollup%,   NAMED('ranking_rollup'));
	// OUTPUT(%dep_h0%,        NAMED('dep_h0'));
	// OUTPUT(%dep_grp%,NAMED('dep_grp'));
	// OUTPUT(rank_in,         NAMED('rank_in'));
	// OUTPUT(%rank_seq%,NAMED('rank_seq'));
	// OUTPUT(%best_recs%,NAMED('best_recsMonitor'));
	// OUTPUT(%k2%,NAMED('k2'));
endmacro;
