import header, ut, gong_neustar;


// TNT Values
// N = Name+Address does not exist in Gong
// Y = Name+Address does exist in Gong
// P = Name+Address+Phone does exist in Gong
// D = Dead

	Gong_in := gong_neustar.File_GongHistory(current_record_flag='Y' OR deletion_date<>'', listing_type_res='R');

TNT_Candidates (dataset(recordof(header.Layout_Header_v2)) file_in)  := function

// Perform the GONG part of the final stages

	typeof(gong_in) filtern(gong_in l) := transform
		self.phone10 := if(l.publish_code = 'N' or l.omit_phone='Y', '', l.phone10);
		self := l;
	end;

	g := project(gong_in, filtern(left));
	h := file_in;

	sg := record
		g.prim_range;
		g.prim_name;
		g.z5;
		g.st;
		g.phone10;
		g.current_record_flag;
		string20 name_first := if ( g.name_first <> '', g.name_first, ut.word(g.listed_name,2));
		string20 name_last := if ( g.name_last <> '', g.name_last, ut.word(g.listed_name,1));
		boolean hi := true;
		end;

	sh := record
		h.prim_range;
		h.prim_name;
		h.zip;
		h.st;
		h.fname;
		h.lname;
		h.rid;
		end;

	slim_g := table(g,sg);
	slim_h := table(h,sh);

	/*
	Match rules :- Per Wyman
	1.  Exact match on zip, prim_range, prim_name and loose match on last name.

	2.  Exact match on zip, prim_range, prim_name and exact match between gong first name and header last name.

	3.  Exact match on zip, prim_range, prim_name and exact match between gong last name and header first name.

	4.  Exact match on state, prim_range, prim_name and loose match on last name.

	5.  Exact match on zip, prim_range, last name and loose match on street name.
	*/
	// Distribute by range/name - should handle rules 1-4

	hd := distribute(slim_h(prim_range<>'',prim_name<>''),hash(trim(prim_range),trim(prim_name)));
	gd := distribute(slim_g(prim_range<>'',prim_name<>''),hash(trim(prim_range),trim(prim_name)));
	hd1 := hd(zip<>'');
	gd1 := gd(z5<>'');

	rid_to_go := record
		integer8 rid;
		string10 phone10;
		string1 current_record_flag;
	end;

	rid_to_go add_tnt(sh le, sg ri) := transform
		self.rid := le.rid;
		self.phone10 := ri.phone10;
		self.current_record_flag := ri.current_record_flag;
	end;

	rule1to3 := join(hd1,gd1,left.zip=right.z5 and
													 left.prim_range=right.prim_range and
													 left.prim_name=right.prim_name and
													 ( ut.stringsimilar(left.lname,right.name_last)<4 or // rule 1
														 left.lname=right.name_first or // rule 2
														 left.fname=right.name_last ),// rule 3
							 add_tnt(left,right),local);

	try4_d := hd(st<>'');
	gd4 := gd(st<>'');

	rule4 := join(try4_d,gd4,left.st=right.st and
                         left.prim_range=right.prim_range and
                         left.prim_name=right.prim_name and
                         ut.stringsimilar(left.lname,right.name_last)<4,// rule 4
						 add_tnt(left,right),local);

	try5_d := distribute(slim_h(prim_range<>'',zip<>'',lname<>''),hash(trim(prim_range),trim(zip),trim(lname)));
	gd5 := distribute(slim_g(prim_range<>'',z5<>'',name_last<>''),hash(trim(prim_range),trim(z5),trim(name_last)));

	rule5 := join(try5_d,gd5,left.zip=right.z5 and
                         left.prim_range=right.prim_range and
                         left.lname=right.name_last and
                         ut.StringSimilar(left.prim_name,right.prim_name)<4,
                         add_tnt(left,right),local);

	result := dedup(rule1to3+rule4+rule5,rid,all);
/*count(hd1);
count(rule1to3);
count(rule4);
count(rule5);
count(result);
*/

	return result;
end; 

gong_current(dataset(header.layout_header) file_in) := function
		g := DISTRIBUTE(gong_neustar.Key_History_did(current_flag=true), l_did);
		
		result := JOIN(file_in, g, left.did=right.l_did
								AND			left.st = right.st
								AND			left.zip = right.z5
								AND 		left.prim_range = right.prim_range
								AND			left.prim_name = right.prim_name,
							TRANSFORM(header.layout_header,
										self.tnt := IF(right.st<>'', 'B', '');			// matches current gong address
										self := left;),
								LEFT OUTER, KEEP(1), LOCAL);
								
		return result;
END;

gong_other(dataset(header.layout_header_V2) file_in) := function
		tnt_f := TNT_Candidates(file_in);

		//Add TNT flag
		header.Layout_Header_V2 add_flag(file_in le, tnt_f ri) := transform
			self.tnt := if (ri.rid=0,'N',
										if (le.phone=ri.phone10 and (integer)le.phone!=0,
												IF(ri.current_record_flag='Y','p', 'P'),
												IF(ri.current_record_flag='Y','y','Y')
										)
									);
				self := le;
			end;

		jnd_1 := join(distribute(file_in, hash((unsigned)rid)),distribute(tnt_f,hash((unsigned)rid)),(unsigned)left.rid=(unsigned)right.rid,add_flag(left,right),left outer,local);

		return jnd_1;
END;

export Fn_Reset_Tnt(dataset(recordof(header.Layout_Header_v2)) file_in) := function
		f1 := DISTRIBUTE(PROJECT(file_in, TRANSFORM(header.layout_header,
									self.tnt := '';
									self := left;)), did);
									
		// match on current gong
		f2 := gong_current(f1);
		f3 := gong_other(f2(tnt=''));

		return f2(tnt<>'') + f3;
end;