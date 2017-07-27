import doxie,doxie_crs;

nbr_record := record
  unsigned2 seq;
	unsigned6 did;
	boolean opposite := false;
	string prim_range;
	string prim_name;
	string10 sec_range; 
	string10 phone;
	boolean verified := false;
	string30 fname;
	string30 mname;
	string30 lname;
	unsigned2 age;
	unsigned2 distance;
  end;

nbr_record into(doxie_crs.layout_Historic_Nbr_Summary le, doxie.Comp_Names ri ) := transform
  self := le;
  self := ri;
	self.opposite := le.distance % 2 = 1;
  end;
	
j := join(doxie.Historic_Nbr_Summary(),doxie.Comp_Names,left.did=right.did,into(left,right));

nbr_record into1(j le, doxie.Comp_addresses ri ) := transform
  self.verified := ri.listed_phone<>'';
	self.phone := if ( ri.listed_phone<>'', ri.listed_phone, le.phone );
  self := le;
  end;

j1 := join(j,doxie.Comp_Addresses,left.did=right.did , into1(left,right));

j1n := j1(phone='');
j1p := j1(phone<>'');

nbr_record swipe_phone(j1n le,j1p ri) := transform
  self.phone := ri.phone;
  self := le;
  end;

j2 := join(j1n,j1p,left.prim_range=right.prim_range and left.sec_range=right.sec_range and left.lname=right.lname,swipe_phone(left,right),left outer);

j3 := j2+j1p;

export Person_Nbrs := dedup(sort(j3,seq),whole record);