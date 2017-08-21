import header,ut;

export MAC_BasicMatch(infile0,outfile,pFastHeader = false) := macro

fn_strip_trailing_zeroes(integer in_dob) := function
  
  string dob_string := (string)in_dob;
  string v_yyyy     := dob_string[1..4];
  string v_mm       := dob_string[5..6];
  string v_dd       := dob_string[7..8];
 
  string v_yyyy2 := if(v_yyyy='0000','',v_yyyy);
  string v_mm2   := if(v_mm='00','',v_mm);
  string v_dd2   := if(v_dd='00','',v_dd);
  
  return if(in_dob=0,'',(string)(v_yyyy2+v_mm2+v_dd2));

end;

//-- slimmer record format for header file (match_to)
slim_for_addr := record
 integer8      did;
 integer8      rid;
 string10      phone;
 string9       ssn;
 integer4      dob;
 string20      fname;
 string20      mname;
 string20      lname;
 string5       name_suffix;
 string10      prim_range;
 string28      prim_name;
 string8       sec_range;
 string5       zip;
 string2       st;
 string2       src;
 string1       pflag3;
 string8       dob_string;
 integer       has_ssn_cnt;
 integer       has_dob_cnt;
 unsigned8     RawAID;
 string5	   Dodgy_tracking;
end;

r1 := record
 header.layout_header_strings;
 unsigned8 uid := 0;
end;

r1 t1(infile0 le) := transform
 self.lname      := trim(le.lname);
 self.prim_range := trim(le.prim_range);
 self.zip        := trim(le.zip);
 self            := le;
end;

infile := project(infile0,t1(left));

//****** where header file has valid name, project into slimmer record format
match_to      := if(pFastHeader,Header.File_headers + Header.File_TN_did, Header.File_headers);
nhr_fieldpops := if(pFastHeader,  header.new_header_records_fieldpopulations(true), header.new_header_records_fieldpopulations());

//-- transform used to push header into slimmer record format
slim_for_addr slim(match_to le, nhr_fieldpops ri) := transform
 self.lname         := trim(le.lname);
 self.prim_range    := trim(le.prim_range);
 self.zip           := trim(le.zip);
 self.dob_string    := fn_strip_trailing_zeroes(le.dob);
 self.has_ssn_cnt   := ri.has_ssn_cnt;
 self.has_dob_cnt   := ri.has_dob_cnt;
 self.RawAID        	:= le.RawAID;			//for documentation only
 self.dodgy_tracking	:= le.dodgy_tracking;	//for documentation only
 self               := le;
end;

j1    := join(match_to,nhr_fieldpops,left.src=right.src,slim(left,right),left outer,lookup);

hname := j1((prim_name<>'' and zip<>'' and fname<>'' and lname<>'') or (mdr.sourcetools.sourceisdeath(src) and fname<>'' and lname<>'' and ssn<>''));
h1    := distribute(hname,hash(prim_name,zip,lname));

r_flag_partials := record
 infile;
 string8 dob_string;
end;

r_flag_partials t_flag_partials(r1 le) := transform
 self.dob_string  := fn_strip_trailing_zeroes(le.dob);
 self             := le;
end;

the_rest := distribute(project(infile,t_flag_partials(left)),hash(prim_name,zip,lname));

//-- transform used by join to add rid and did

r1 add_rid_all(slim_for_addr l, r_flag_partials r) := transform

 boolean has_left_rec := l.did<>0;

 string9 choose_full_ssn := ut.keep_fuller_ssn(l.ssn,r.ssn);

 self.rid    := if(pFastHeader, r.rid, l.rid);
 self.did    := if(pFastHeader, r.did, l.did);
 self.vendor_id := r.vendor_id;
 self.pflag1 := IF(ut.Translate_Suffix(l.name_suffix)<>ut.Translate_Suffix(r.name_suffix),'?','');
 self.phone  := r.phone;  //always take new phone to remove incorrectly appended phones
 self.ssn    := if(choose_full_ssn<>'',choose_full_ssn,r.ssn);
 self.dob    := if(ut.date_quality(l.dob) > ut.date_quality(r.dob),l.dob,r.dob);
 self.RawAID		 := r.RawAID;			//always take RawAID from source
 self.dodgy_tracking := if(pFastHeader, r.dodgy_tracking,  l.dodgy_tracking);	//always take dodgy_tracking from header
 self        := r;
end;

j_all :=  join(h1, the_rest,
                header.fn_bm_lr_commonality(left.fname,left.lname,left.prim_range,left.prim_name,left.zip,
				                            right.fname,right.lname,right.prim_range,right.prim_name,right.zip,
							                left.mname,right.mname,
							                left.name_suffix,right.name_suffix,
							                left.sec_range,right.sec_range,
							                left.phone,right.phone,
							                left.src,right.src,
											left.RawAID,right.RawAID) and 
				// if the source doesn't have SSN's in new_header_records skip the SSN check
				// see Header.translatePflag3 for pflag3 translation
			    //for keep_fuller_ssn to have something it means one is a partial of the other
				if(left.has_ssn_cnt=0 or ut.keep_fuller_ssn(left.ssn,right.ssn)<>'',true,
				if(left.pflag3 not in ['','W'],ut.nneq(left.ssn,right.ssn),
				left.ssn=right.ssn))
				and
                //at one point EQ gave us DOB's, today they do not so like SSN's above if the source doesn't provide an element in new_header_records exclude it from basic match
				//some sources over time have changed from giving us full DOB's to only a partial value
				if(left.has_dob_cnt=0,true,left.dob_string[1..4]=right.dob_string[1..4] and ut.nneq(left.dob_string[5..6],right.dob_string[5..6]) and ut.nneq(left.dob_string[7..8],right.dob_string[7..8]))
				/*
						//need to have tight dob matching for BM
						//pairs 2225521273/2226239920
						//using NNEQ and you could bring in the dob from the other DID
						//same holds true for SSN's?
						,left.dob    = right.dob)
						)
				*/
				,add_rid_all(left,right)
				,right outer
				,local
				);



j_all_fasth :=  join(h1, the_rest,
                header.fn_bm_lr_commonality(left.fname,left.lname,left.prim_range,left.prim_name,left.zip,
				                            right.fname,right.lname,right.prim_range,right.prim_name,right.zip,
							                left.mname,right.mname,
							                left.name_suffix,right.name_suffix,
							                left.sec_range,right.sec_range,
							                left.phone,right.phone,
							                left.src,right.src,
											left.RawAID,right.RawAID) and 
				// if the source doesn't have SSN's in new_header_records skip the SSN check
				// see Header.translatePflag3 for pflag3 translation
			    //for keep_fuller_ssn to have something it means one is a partial of the other
				if(left.has_ssn_cnt=0 or ut.keep_fuller_ssn(left.ssn,right.ssn)<>'',true,
				if(left.pflag3 not in ['','W'],ut.nneq(left.ssn,right.ssn),
				left.ssn=right.ssn))
				and
                //at one point EQ gave us DOB's, today they do not so like SSN's above if the source doesn't provide an element in new_header_records exclude it from basic match
				//some sources over time have changed from giving us full DOB's to only a partial value
				if(left.has_dob_cnt=0,true,left.dob_string[1..4]=right.dob_string[1..4] and ut.nneq(left.dob_string[5..6],right.dob_string[5..6]) and ut.nneq(left.dob_string[7..8],right.dob_string[7..8]))
				/*
						//need to have tight dob matching for BM
						//pairs 2225521273/2226239920
						//using NNEQ and you could bring in the dob from the other DID
						//same holds true for SSN's?
						,left.dob    = right.dob)
						)
				*/
				,add_rid_all(left,right)
				,right only
				,local
				);
				
			
concat_dupd := dedup(if(pFastHeader, j_all_fasth, j_all), record,all,local);

header.layout_new_records t_slim(concat_dupd le) := transform
 self := le;
end;

p_slim := project(concat_dupd,t_slim(left));
			   
//****** join to find matches between infile and header file
//       where match found, add rid and did to result from header file 
//       'right outer' join keeps infile records 

outfile := p_slim;		//set outfile to recordset that joined in first(strict) join

endmacro;