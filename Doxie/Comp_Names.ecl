import doxie_crs, ut, header;

doxie.mac_header_Field_declare();
doxie.MAC_Selection_Declare();

rt := record
	doxie_crs.layout_comp_names;
	unsigned1 var_cnt := 1; // the idea here is to use this counter to move records with multiple name variations to the top
end;

//relatives
rr := Relative_Records(header.constants.checkRNA);
  
rt fr(rr le) := transform
  self := le;
  end;  
  
rels := project(rr,fr(left));

//nbrs
hnrs := doxie.historic_nbr_records_crs(header.constants.checkRNA);

rt fn(hnrs le) := transform
  self := le;
  end;  
  
nb := project(hnrs,fn(left));

//new version of nbrs
nbrs := doxie_crs.nbr_records;

rt fn_nbr(nbrs le) := transform
  self := le;
  end;  
  
nb2 := project(nbrs,fn_nbr(left));

//residents
resrecs := doxie.Resident_Records;

rt fn2(resrecs le) := transform
  self := le;
  end;  
  
resrecs2 := project(resrecs,fn2(left));

allrecs := nb+nb2+rels+resrecs2;

doxie.MAC_PruneOldSSNs(allrecs, recs, ssn, did);
  
ta := sort(recs,did,fname,lname,mname,ssn,dob);

rt roll_into(rt le,rt ri) := transform
  self.dob := if ( ut.date_quality(le.dob)>ut.date_quality(ri.dob),le.dob,ri.dob );
  self.ssn := if ( length(trim(le.ssn)) > length(trim(ri.ssn)), le.ssn, ri.ssn );
	self.ssn_unmasked := if ( length(trim(le.ssn_unmasked)) > length(trim(ri.ssn_unmasked)), le.ssn_unmasked, ri.ssn_unmasked );
  self.mname := if ( length(trim(le.mname)) > length(trim(ri.mname)), le.mname, ri.mname );
	self.var_cnt := le.var_cnt + ri.var_cnt;
  self := le;
  end;
  
r := rollup( ta, left.did=right.did and left.fname=right.fname and ut.lead_contains(left.mname,right.mname) and
                 left.lname=right.lname and ut.NNEQ(left.ssn,right.ssn) and 
			  ut.NNEQ_Date(left.dob,right.dob),roll_into(left,right) ); 

//add the age
doxie_crs.layout_comp_names addage(rt l) := transform
	self.age := if ( l.dob = 0, 0, ut.age(l.dob) );
	self := l;
end;

// need to sort it again, now with var_cnt populated
wage := project(sort(r, did,-var_cnt,fname,lname,mname,ssn,dob), addage(left));

export Comp_names := wage;