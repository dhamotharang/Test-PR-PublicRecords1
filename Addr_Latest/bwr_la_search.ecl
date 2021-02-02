//this program is to match the input records agaist the header files and driver's
//license file to indentify people and to get their latest addresses from watchdog.file_best
import addr_latest,address,did_add,drivers,header,watchdog;

//prevent dup and heading records mixed into the infile
la_file_new := addr_latest.file_in(cubs<>'');
la_file_raw := distribute(la_file_new,hash(cubs));
la_file_in := dedup(sort(la_file_raw,cubs,local),cubs,local) : persist('per_la_file_in'); //do not remove

layout_addr_in := record
	la_file_in,
	string addr_line2,
end;

layout_addr_in get_addr2(la_file_in l) := transform
	self.addr_line2 := trim(l.city) +  ',' +
				    trim(l.state) + ' ' +
				    trim(l.zip);
     self := l;
end;

la_raw_addr := project(la_file_in, get_addr2(left));

address.mac_address_clean(la_raw_addr,
          	           addr_line1,
			           addr_line2,
			           true,
			           la_clean_addr);

layout_addr_clean := record
	la_file_in;
     string10        prim_range;
     string2         predir;
     string28        prim_name;
     string4         addr_suffix;
     string2         postdir;
     string10        unit_desig;
     string8         sec_range;
     string25        p_city_name;
     string25        v_city_name;
     string2         st;
     string5         zipcode;
     string4         zip4;
     string4         cart;
     string1         cr_sort_sz;
     string4         lot;
     string1         lot_order;
     string2         dbpc;
     string1         chk_digit;
     string2         rec_type;
     string5         countyname;
     string10        geo_lat_val;
     string11        geo_long_val;
     string4         msa;
     string7         geo_blk;
     string1         geo_match;
     string4         err_stat;
end;

layout_addr_clean get_parsed_addr(la_clean_addr l) := Transform
	self.prim_range := l.clean[1..10];
	self.predir := l.clean[11..12];
	self.prim_name := l.clean[13..40];
	self.addr_suffix := l.clean[41..44];
	self.postdir := l.clean[45..46];
	self.unit_desig := l.clean[47..56];
	self.sec_range := l.clean[57..64];
	self.p_city_name := l.clean[65..89];
	self.v_city_name := l.clean[90..114];
	self.st := l.clean[115..116];
	self.zipcode := l.clean[117..121];
	self.zip4 := l.clean[122..125];
	self.cart := l.clean[126..129];
	self.cr_sort_sz := l.clean[130];
	self.lot := l.clean[131..134];
	self.lot_order := l.clean[135];
	self.dbpc := l.clean[136..137];
	self.chk_digit := l.clean[138];
	self.rec_type := l.clean[139..140];
	self.countyname := l.clean[141..145];
	self.geo_lat_val := l.clean[146..155];
	self.geo_long_val := l.clean[156..166];
	self.msa := l.clean[167..170];
	self.geo_blk := l.clean[171..177];
	self.geo_match := l.clean[178];
	self.err_stat := l.clean[179..182];
	self := l;
end;

la_parse_addr := project(la_clean_addr, get_parsed_addr(left));

layout_name_in := record
	la_parse_addr;
     string73 clean_name;
end;

layout_name_in get_clean_name(la_parse_addr l) := transform
	self.clean_name := addrcleanlib.CleanPerson73(l.name);
	self := l;
end;

la_clean_name := project(la_parse_addr, get_clean_name(left));

layout_parse_name := record
  la_parse_addr;
  string5    title;
  string20   fname;
  string20   mname;
  string20   lname;
  string5    name_suffix;
  string3    name_error;
end;

integer clean_errorcode(la_clean_name L1) := (integer)(L1.clean_name[71..73]);

layout_parse_name get_parsed_name(la_clean_name L2) := Transform
  self.title := if(clean_errorcode(L2) < 70, '', L2.clean_name[1..5]);
  self.fname := if(clean_errorcode(L2) < 70, '', L2.clean_name[6..25]);
  self.mname := if(clean_errorcode(L2) < 70, '', L2.clean_name[26..45]);
  self.lname := if(clean_errorcode(L2) < 70, '', L2.clean_name[46..65]);
  self.name_suffix := if(clean_errorcode(L2) < 70, '', L2.clean_name[66..70]);
  self.name_error := if(clean_errorcode(L2) < 70, '', L2.clean_name[71..73]);
  self := L2;
END;

la_parse_name := project(la_clean_name, get_parsed_name(left));

//did the clean file
la_did_rec := record
	unsigned6 did := 0,
	unsigned1 did_score := 0,
	la_parse_name,
	string8 dob_better,
end;

la_did_rec get_better_dob(la_parse_name l) := transform
	self.dob_better := l.dob[5..8] + l.dob[1..4];
	self := l;
end;

la_did_ready := project(la_parse_name,get_better_dob(left));

matchset := ['D','A','S'];

did_add.mac_match_flex(la_did_ready, matchset,
                       ssn, dob_better, fname, mname, lname, name_suffix,
				   prim_range, prim_name, sec_range, zipcode, st, foo,
				   did, la_did_rec,
                       true, did_score, 75,
				   la_did_raw);

addr_latest.Layout_File_Did get_slim_did(la_did_raw l) := transform
	self.did := intformat(l.did, 12, 1);
	self := l;
end;

la_did_file := project(la_did_raw, get_slim_did(left)) : persist('per_la_did_file'); //don't remove

in_file := la_did_file(did<>'000000000000');
in_header := header.file_headers;
in_driver := drivers.File_Dl;
in_best := watchdog.File_Best;

//get slim file to match against the header file
slim_in_rec := record
     string12   in_did,
	string     in_cubs,
	string20   in_lname,
     string20   in_fname,
	string20   in_mname,
     string10   in_prim_range,
	string28   in_prim_name,
	string8    in_sec_range,
     string25   in_city,
     string2    in_st,
	string5    in_zipcode,
     string8    in_dob,
	string9    in_ssn,
	string14   in_drl,
end;

slim_in_rec get_slim_in(in_file l) := transform
	self.in_did := l.did;
	self.in_cubs := l.cubs;
	self.in_lname := l.lname;
     self.in_fname := l.fname;
	self.in_mname := l.mname;
     self.in_prim_range := l.prim_range;
	self.in_prim_name := l.prim_name;
     self.in_sec_range := l.sec_range;
     self.in_city := l.v_city_name;
     self.in_st := l.st;
	self.in_zipcode := l.zipcode;
     self.in_dob := l.dob[5..8] + l.dob[1..4];
	self.in_ssn := l.ssn;
	self.in_drl := l.drl;
end;

slim_in := project(in_file, get_slim_in(left));

join_in := join(slim_in,in_header,(unsigned6)left.in_did=right.did, hash);

//get the matched driver's license
drl_in := join(slim_in(in_drl <>'', in_drl <>'NOL', in_drl<>'DRL'), in_driver,
               (unsigned6)left.in_did=right.did and
               trim(left.in_drl)= trim((string14)right.dl_number), hash);
srt_drl := sort(drl_in, in_did, in_drl);
dep_drl := dedup(srt_drl, in_did, in_drl);

//get the match type of name pieces, address pieces, dob, ssn and drl#

//match type -- 3 : hard match
//              2 : soft match
//              1 : not match
//              0 : not provided

match_rec := record
     string12   in_did,
	unsigned6  did,
	string     in_cubs,
	string20   in_lname,
	qstring20  lname,
     string20   in_fname,
	qstring20  fname,
	string20   in_mname,
	qstring20  mname,
     string10   in_prim_range,
	qstring10  prim_range,
	string28   in_prim_name,
	qstring28  prim_name,
	string8    in_sec_range,
	qstring8   sec_range,
     string25   in_city,
	qstring25  city_name;
     string2    in_st,
     string2    st,
     string5    in_zipcode,
	qstring5   zip,
	string8    in_dob,
	integer4   dob,
	string9    in_ssn,
	qstring9   ssn,
	string14   in_drl,
	string14   drl_nbr,
     unsigned1  lname_match,
     unsigned1  fname_match,
	unsigned1  mname_match,
	unsigned1  name_match := 0,
     unsigned1  prange_match,
     unsigned1  pname_match,
	unsigned1  srange_match,
     unsigned1  zip_match,
	unsigned1  addr_match := 0,
	unsigned1  dob_match,
     unsigned1  ssn_match,
     unsigned1  drl_match,
     unsigned1  final_match := 0,
end;

match_rec match_them(join_in l, dep_drl r) := transform
	self.lname_match  := if(l.in_lname = l.lname, 3, 1);
	self.fname_match  := if(l.in_fname = l.fname, 3, 1);
	self.mname_match  := map(l.in_mname = '' and l.mname = '' => 3,
	                         l.in_mname = '' and l.mname <>'' => 1,
						l.in_mname <> '' and l.mname = '' => 2,
						l.in_mname[1] = l.mname[1] => 3,
						1);
	self.prange_match := if(l.in_prim_range = l.prim_range, 3, 1);
	self.pname_match  := if(l.in_prim_name = l.prim_name, 3, 1);
	self.srange_match  := map(l.in_sec_range = '' and l.sec_range = '' => 3,
	                          l.in_sec_range = '' and l.sec_range <>'' => 1,
					 	 l.in_sec_range <> '' and l.sec_range = '' => 2,
						 l.in_sec_range = l.sec_range => 3,
						 1);
	self.zip_match := map(l.in_zipcode = '' => if(l.in_city <> '' and
	                                              l.in_st <> '' and
	                                              l.in_city = l.city_name and
	                                              l.in_st = l.st, 3, 1),
                           l.in_zipcode = l.zip => 3,
                           1);
     self.dob_match := map(l.in_dob = '' => 0,
	                      l.in_dob = (string8)l.dob => 3,
					  l.in_dob[1..6] = ((string8)l.dob)[1..6] => 2,
					  1);
	self.ssn_match := map(l.in_ssn = '' => 0,
	                      l.in_ssn = l.ssn => 3,
				       1);
	self.drl_match := map(l.in_drl = '' => 0,
	                      l.in_drl = 'NOL' => 0,
                           l.in_drl = 'DRL' => 0,
	                      r.dl_number = '' => 1,
					  3);
     self.drl_nbr := r.dl_number;
     self := l;
end;

f_match := join(join_in, dep_drl,
                left.in_did = right.in_did,
			 match_them(left, right),
                left outer, hash);

//get name and address match type
match_rec get_na_match(f_match l) := transform
	self.name_match := map(l.lname_match = 1  or l.fname_match = 1 or
	                       l.mname_match = 1 => 1,
					   l.mname_match = 2 => 2,
					   3);
	self.addr_match := map(l.prange_match = 1  or l.pname_match = 1 or
	                       l.srange_match = 1  or l.zip_match = 1 => 1,
					   l.srange_match = 2 => 2,
					   3);
     self := l;
end;

f_match_ready := project(f_match, get_na_match(left));

f_match_sort := sort(f_match_ready, in_did);

match_rec best_match(f_match_sort l, f_match_sort r) := transform
     //names
     self.name_match := if(l.name_match < r.name_match, r.name_match, l.name_match);
     self.lname_match := if(l.name_match < r.name_match, r.lname_match, l.lname_match);
	self.lname := if(l.name_match < r.name_match, r.lname, l.lname);
	self.fname_match := if(l.name_match < r.name_match, r.fname_match, l.fname_match);
	self.fname := if(l.name_match < r.name_match, r.fname, l.fname);
	self.mname_match := if(l.name_match < r.name_match, r.mname_match, l.mname_match);
	self.mname := if(l.name_match < r.name_match, r.mname, l.mname);
	//address
	self.addr_match := if(l.addr_match < r.addr_match, r.addr_match, l.addr_match);
	self.prange_match := if(l.addr_match < r.addr_match, r.prange_match, l.prange_match);
	self.prim_range := if(l.addr_match < r.addr_match, r.prim_range, l.prim_range);
     self.pname_match := if(l.addr_match < r.addr_match, r.pname_match, l.pname_match);
	self.prim_name := if(l.addr_match < r.addr_match, r.prim_name, l.prim_name);
	self.srange_match := if(l.addr_match < r.addr_match, r.srange_match, l.srange_match);
	self.sec_range := if(l.addr_match < r.addr_match, r.sec_range, l.sec_range);
	self.zip_match := if(l.addr_match < r.addr_match, r.zip_match, l.zip_match);
	self.zip := if(l.addr_match < r.addr_match, r.zip, l.zip);
	self.city_name := if(l.addr_match < r.addr_match, r.city_name, l.city_name);
	self.st := if(l.addr_match < r.addr_match, r.st, l.st);
	//dob, ssn, drl
	self.dob_match := if(l.dob_match < r.dob_match, r.dob_match, l.dob_match);
	self.dob := if(l.dob_match < r.dob_match, r.dob, l.dob);
	self.ssn_match := if(l.ssn_match < r.ssn_match, r.ssn_match, l.ssn_match);
	self.ssn := if(l.ssn_match < r.ssn_match, r.ssn, l.ssn);
	self.drl_match := if(l.drl_match < r.drl_match, r.drl_match, l.drl_match);
	self.drl_nbr := if(l.drl_match < r.drl_match, r.drl_nbr, l.drl_nbr);

	self := l;
end;

f_match_best := rollup(f_match_sort, left.in_did = right.in_did, best_match(left, right));

match_rec get_final_match(f_match_best l) := transform
	self.final_match := map(l.name_match = 1 or l.addr_match = 1 or
                             l.dob_match = 1 or l.ssn_match = 1 or
					    l.drl_match = 1 => 1,
					    l.name_match = 2 or l.addr_match = 2 or l.dob_match = 2 => 2,
					    l.dob_match = 0 and l.ssn_match = 0 and l.drl_match = 0 => 2,
					    3);
	self := l;
end;

f_final_match := project(f_match_best, get_final_match(left));

//get the best address from watchdog.file_best
best_addr_rec := record
     string12   in_did,
     unsigned6  did,
	string     in_cubs,
	string20   in_lname,
     string20   lname,
     string20   in_fname,
     string20   fname,
	string20   in_mname,
     string20   mname,
     string10   in_prim_range,
     string10   prim_range,
     string2    predir,
	string28   in_prim_name,
     string28   prim_name,
     string4    addr_suffix,
     string2    postdir,
     string10   unit_desig,
	string8    in_sec_range,
     string8    sec_range,
     string25   in_city,
     string25   city_name,
     string2    in_st,
     string2    st,
     string5    in_zipcode,
     string5    zip5,
     string4    zip4,
     string1    new_addr_flag := '';
	string8    in_dob,
     string8    dob,
	string9    in_ssn,
     string9    ssn,
	string14   in_drl,
     string15   dl_number,
     string4    name_match_type,
     string4    addr_match_type,
	string4    dob_match_type,
     string4    ssn_match_type,
     string4    drl_match_type,
	string4    rec_match_type,
     string20   matched_last_name,
     string20   matched_mid_name,
     string20   matched_first_name,
     string9    matched_ssn,
     string8    matched_birth_date,
end;

best_addr_rec get_latest_addr(f_final_match l, in_best r) := transform
	self.did := r.did;
     self.lname := r.lname;
	self.fname := r.fname;
	self.mname := r.mname;
	self.prim_range := r.prim_range;
     self.predir := r.predir;
     self.prim_name := r.prim_name;
     self.addr_suffix := r.suffix;
     self.postdir := r.postdir;
     self.unit_desig := r.unit_desig;
     self.sec_range := r.sec_range;
     self.city_name := r.city_name;
     self.st := r.st;
     self.zip5 := r.zip;
     self.zip4 := r.zip4;
     self.dob := (string8)r.dob;
     self.ssn := r.ssn;
	self.dl_number := r.dl_number;
     self.name_match_type := map(l.name_match = 3 => 'HARD',
	                            l.name_match = 2 => 'SOFT',
			   		        'NO');
     self.addr_match_type := map(l.addr_match = 3 => 'HARD',
	                            l.addr_match = 2 => 'SOFT',
			   		        'NO');
     self.dob_match_type := map(l.dob_match = 3 => 'HARD',
	                           l.dob_match = 2 => 'SOFT',
                                l.dob_match = 0 => 'NP',
			   		        'NO');
     self.ssn_match_type := map(l.ssn_match = 3 => 'HARD',
                                l.ssn_match = 0 => 'NP',
			   		       'NO');
     self.drl_match_type := map(l.drl_match = 3 => 'HARD',
                                l.drl_match = 0 => 'NP',
			   		       'NO');
	self.rec_match_type := map(l.final_match = 3 => 'HARD',
	                           l.final_match = 2 => 'SOFT',
			   		       'NO');
     self.matched_last_name := l.lname;
     self.matched_mid_name := l.mname;
     self.matched_first_name := l.fname;
     self.matched_ssn := l.ssn;
     self.matched_birth_date := (string8)l.dob;
     self := l;
end;

f_latest_addr := join(f_final_match, in_best,
                     (unsigned)left.in_did = right.did and left.final_match > 1,
                      get_latest_addr(left, right),
                      left outer, hash);

//check if the address from the best file is a new address
best_addr_rec check_new_addr(f_latest_addr l) := transform
	self.new_addr_flag := map(l.in_zipcode <> '' and
                               l.in_sec_range = '' and
                               l.sec_range <> '' and
                               l.in_prim_range = l.prim_range and
                               l.in_prim_name = l.prim_name and
                               l.in_zipcode = l.zip5 => 'Y', //miss sec_range

                               l.in_zipcode = '' and
                               l.in_sec_range = '' and
                               l.sec_range <> '' and
                               l.in_prim_range = l.prim_range and
                               l.in_prim_name = l.prim_name and
                               l.in_city = l.city_name and
                               l.in_st = l.st => 'Y',       //miss sec_range, zip

                               l.in_zipcode <> '' and
                               l.in_prim_range = l.prim_range and
                               l.in_prim_name = l.prim_name and
                               l.in_zipcode = l.zip5 => 'N',//same addr

                               l.in_zipcode = '' and
                               l.in_prim_range = l.prim_range and
                               l.in_prim_name = l.prim_name and
                               l.in_city = l.city_name and
                               l.in_st = l.st => 'N',       //no zip, same addr

                               l.prim_name <> '' and
                               l.zip5 <> '' => 'Y',         //new addr
                               '');
     self := l;
end;

f_new_addr := project(f_latest_addr, check_new_addr(left)) : persist('per_f_new_addr'); //don't remove

addr_latest.Layout_File_Out get_final_out(la_file_in l, f_new_addr r) := transform
	self.prim_range := if(r.new_addr_flag = 'Y', r.prim_range, ''),
     self.predir := if(r.new_addr_flag = 'Y', r.predir, ''),
     self.prim_name := if(r.new_addr_flag = 'Y', r.prim_name, ''),
     self.addr_suffix := if(r.new_addr_flag = 'Y', r.addr_suffix, ''),
     self.postdir := if(r.new_addr_flag = 'Y', r.postdir, ''),
     self.unit_desig := if(r.new_addr_flag = 'Y', r.unit_desig, ''),
     self.sec_range := if(r.new_addr_flag = 'Y', r.sec_range, ''),
     self.city_name := if(r.new_addr_flag = 'Y', r.city_name, ''),
     self.st := if(r.new_addr_flag = 'Y', r.st, ''),
     self.zip5 := if(r.new_addr_flag = 'Y', r.zip5, ''),
     self.zip4 := if(r.new_addr_flag = 'Y', r.zip4, ''),
     self.name_match_type := r.name_match_type,
     self.addr_match_type := r.addr_match_type,
	self.dob_match_type := r.dob_match_type,
     self.ssn_match_type := r.ssn_match_type,
     self.drl_match_type := r.drl_match_type,
	self.rec_match_type := r.rec_match_type,
     self.in_last_name := r.in_lname;
     self.matched_last_name := r.matched_last_name,
     self.in_mid_name := r.in_mname,
     self.matched_mid_name := r.matched_mid_name,
     self.in_first_name := r.in_fname,
     self.matched_first_name := r.matched_first_name,
     self.in_ssn := r.in_ssn,
     self.matched_ssn := if(r.in_ssn <> '', r.matched_ssn, ''),
     self.in_birth_date := r.in_dob,
     self.matched_birth_date := if(r.in_dob <> '',r.matched_birth_date, ''),
     self := l;
end;

f_out := join(la_file_in, f_new_addr,
              left.cubs = right.in_cubs,
              get_final_out(left,right),
              left outer, hash);

addr_latest.mac_csvsf_buildprocess(f_out, '~thor_data400::base::linebarger_watch', write_out,'out');

//write the stat data into a csv file
dep_new_addr := dedup(sort(f_new_addr(new_addr_flag = 'Y'),in_cubs),in_cubs);

hit_price := if(count(addr_latest.file_in)>=100000,0.20,0.25);

f_stat := dataset([{count(la_file_in),count(dep_new_addr),hit_price,hit_price *count(dep_new_addr)}],
                  {unsigned4 total_rec, unsigned4 hits, decimal5_2 unit_price, decimal10_2 total_price});

addr_latest.mac_csvsf_buildprocess(f_stat, '~thor_data400::base::linebarger_stat', write_stat, 'stat');

export bwr_la_search := parallel(write_out, write_stat);
