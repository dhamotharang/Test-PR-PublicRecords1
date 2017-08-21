import ut;
rec := ngadl.Layout_Header;

export mod_StandardizeBoxes(dataset(rec) c) := 
MODULE


//****** IDENTIFY SOME BOX RECORDS

set_ints_or_blank := ['1','2','3','4','5','6','7','8','9',' '];
isRR(string prim_name) := prim_name[1..3] in ['RR ', 'RT '];
isO(string prim_name)  := prim_name[1..4] = 'BOX ' and prim_name[5] in set_ints_or_blank;

p := c(ut.isPOBox(prim_name));
r := c(isRR(prim_name));
o := c(isO(prim_name)); 

cskip := c(not ut.isPOBox(prim_name) and not isRR(prim_name) and not isO(prim_name));


//****** SUBTYPES OF RECORD WITH 'PO BOX'

potype(string prim_range, string prim_name, string sec_range) :=
	map(
		ut.isPOBox(prim_name, true) and prim_range <> ''
		=> 4,	//has a number in the prim_name field and something in the prim_range field
		ut.isPOBox(prim_name, true) and sec_range <> '' and stringlib.stringfind(prim_name[7..], sec_range, 1) > 0
		=> 5,	//has a number in the prim_name field and the same number in the sec_range field
		ut.isPOBox(prim_name, true) and sec_range <> ''
		=> 6,	//has a number in the prim_name field and something in the sec_range field
		ut.isPOBox(prim_name, true)
		=> 1,	//has a number in the prim_name field
		ut.isPOBox(prim_name) and not ut.isPOBox(prim_name,true) and sec_range <> ''
		=> 2, //says PO BOX only in prim_name, but has a sec_range
		ut.isPOBox(prim_name) and not ut.isPOBox(prim_name,true) and prim_range <> ''
		=> 3, //says PO BOX only in prim_name, but has a prim_range
		0
	);

//****** ... AND THEIR FIXES
	
rec pofix(rec l) := transform
		t := potype(l.prim_range, l.prim_name, l.sec_range);
		self.prim_range := if(t in [3], '',l.prim_range);
		self.prim_name 	:= 
			case(
				t,
				2 => trim(l.prim_name) + ' ' + l.sec_range, 
				3 => trim(l.prim_name) + ' ' + l.prim_range,
				l.prim_name	
			);
		self.unit_desig := '';
		self.suffix := '';
		self.sec_range  := if(t in [2,5], '', 					l.sec_range);
		self := l;
end;


pfixed := Project(p, pofix(left));


//****** SUBTYPES OF RECORDS WITH 'BOX'

otype(string prim_range, string prim_name, string sec_range) :=
	map(
		trim(prim_name,all) = 'BOX' and prim_range <> '' and sec_range = ''
		=> 1,
		trim(prim_name,all) = 'BOX' and prim_range = '' and sec_range <> ''
		=> 2,
		trim(prim_name,all) = 'BOX' and prim_range <> '' and sec_range <> ''
		=> 3,
		trim(prim_name,all) = 'BOX' and prim_range = '' and sec_range = ''
		=> 4,
		// prim_name[5] <> '' and sec_range <> '' and stringlib.stringfind(prim_name[5..], sec_range, 1) > 0
		prim_name[5] <> '' and prim_name[5..] = sec_range
		=> 5,
		// prim_name[5] <> '' and prim_range <> '' and stringlib.stringfind(prim_name[5..], prim_range, 1) > 0
		prim_name[5] <> '' and prim_name[5..] = prim_range
		=> 6,
		prim_range in ['0','O','P','PO','PO BOX']
		=> 7,
		0
	);

//****** ... AND THEIR FIXES
	
addpo(string pn) := stringlib.StringFindReplace(pn, 'BOX', 'PO POX'); 	
rec oofix(rec l) := transform
		t := otype(l.prim_range, l.prim_name, l.sec_range);
		self.prim_range := if(t in [1,6,7], '',l.prim_range);
		self.prim_name 	:= 
			case(
				t,
				1 => trim(addpo(l.prim_name)) + ' ' + l.prim_range,
				2 => trim(addpo(l.prim_name)) + ' ' + l.sec_range, 
				3 => trim(addpo(l.prim_name)) + ' ' + l.sec_range,
				addpo(l.prim_name)	
			);
		self.unit_desig := '';
		self.suffix := '';
		self.sec_range  := if(t in [2,3,5], '', 					l.sec_range);
		self := l;
end;

ofixed := Project(o, oofix(left));


//****** SUBTYPES OF RR AND RT RECORDS

Set_rrbox:=['RR BOX BOX','RR BOX','RR APT','RR ST BOX',
						'RR RR','RR PO','RR POB','RR PO BOX'];

rrtype(string prim_range, string prim_name, string sec_range) :=
	map(
		prim_name[1..3] = 'RR ' and prim_name[4] in set_ints_or_blank and sec_range <> ''
		=> 1, //good
		prim_name[1..3] = 'RR ' and prim_name[4] in set_ints_or_blank and sec_range = ''
		=> 2,	//nothing to be done
		prim_name in Set_rrbox and sec_range = ''
		=> 3,	//should make it RR + pr
		prim_name = 'RT'
		=> 4, //should make it RR + pr
		prim_name[1..3] = 'RT ' and prim_name[4] in set_ints_or_blank and sec_range = ''
		=> 5,	//replace RT with RR and put the pr in the sr
		prim_name[1..3] = 'RT ' and prim_name[4] not in set_ints_or_blank and sec_range = '' and stringlib.stringFilter(prim_name,'123456789') <> ''
		=> 8, //if pn has a word with numbers in it, put that word into sec_Range. 
		prim_name[1..3] = 'RT ' and prim_name[4..] not in ['P','O','BOX','APT','PO BOX'] and sec_range = ''
		=> 9,	//put pr into sr,  make pn RR
		prim_name[1..3] = 'RT ' and prim_name[4] not in set_ints_or_blank and sec_range = ''
		=> 6,	//put pr into sr,  make pn RR
		prim_name[1..3] = 'RT ' and prim_name[4] not in set_ints_or_blank and sec_range <> ''
		=> 7,	//just put RR into pn
		0
	);

//****** ... AND THEIR FIXES
	
rec rrfix(rec l) := transform
		t := rrtype(l.prim_range, l.prim_name, l.sec_range);
		self.prim_range := if(t in [3,4,5,6], '',l.prim_range);
		self.prim_name 	:= 
			case(
				t,
				3 => 'RR ' + l.prim_range,
				4 => 'RR ' + l.prim_range,
				6 => 'RR ' + l.prim_range,
				5 => 'RR ' + l.prim_name[4..],
				7 => 'RR ' + l.prim_name[4..],
				8 => 'RR ' + l.prim_name[4..],
				9 => 'RR ' + l.prim_name[4..],
				l.prim_name	
			);
		self.unit_desig := 'BOX';
		self.suffix := '';
		self.sec_range  := 
			case(
				t, 
				5 => l.prim_range,
				l.sec_range
			);
		self := l;
end;

rfixed := Project(r, rrfix(left));

export records := cskip + pfixed + rfixed + ofixed;

END;