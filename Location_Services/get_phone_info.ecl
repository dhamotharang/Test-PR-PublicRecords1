import gong, doxie;


export get_phone_info(string10 in_phone, string20 lname, string10 prim_range, string2 predir, string28 prim_name, string8 sec_range, string2 st, string5 zip) := function

	dk := LIMIT(gong.Key_History_phone(keyed(p7 = in_phone[4..10]),
					    keyed(p3 = in_phone[1..3]), 
					    current_flag), 20, keyed, SKIP);

  dk_added := dk;
//  dk_updated := DEDUP (dk_added, record, ALL);
	
	temprec := record
		layout_person_phone;
		string10	phone;
		string20	lname;
		string10	prim_range;
		string2	predir;
		string28	prim_name;
		string8	sec_range;
		string2	st;
		string5	zip;
	end;
	
	temprec into_phone (dk_added L) := transform
		self.phone10 := in_phone;
		self.listed_phone := L.phone10;
		self.listed_name := L.listed_name;
		self.phonepubnonpub := L.publish_code;
		self.phone := self.phone10;
		self.prim_range := prim_range;
		self.predir := predir;
		self.prim_name := Prim_name;
		self.sec_range := sec_range;
    self.st := st;
		self.zip := zip;
		self.lname := Lname;
		self.hri_phone := [];
	end;
	
	outf1 := project (dk_added, into_phone(LEFT));
	
	
	maxHRIPer_Value := consts.max_hri_phone;
	
	doxie.mac_AddHRIPhone(outf1, outf2)
	
  outf3 := DEDUP (outf2, record, ALL);
	return project (outf3, TRANSFORM (layout_person_phone, SELF := LEFT));
end;	