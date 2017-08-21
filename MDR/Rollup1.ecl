import header,ut;
string5 prob := 'false' : stored('probation');
inf := header.File_Headers(header.Blocked_data());

// Have to have hard match on lname,prim_name,prim_range,zip

//-- Slim record to ease the join burdone
sm_rec := record
	inf.did;
	inf.rid;
	inf.ssn;
	inf.dob;
	inf.phone;
    inf.src;
	inf.vendor_id;
	inf.fname;
	inf.lname;
	inf.name_suffix;
    inf.mname;
	inf.prim_range;
	inf.prim_name;
	inf.zip;
    inf.sec_range;
	inf.RawAID; 
	end;

//****** Slim down the infile
sm_rec slimHead(header.layout_header L) := transform
 self.src := if(prob = 'true' and l.src='MC','MI',l.src);
 self := l;
end;

me_use := project(inf,slimHead(left)); 

//-- Transform that assigns the right file ID as old_rid and the left file ID as new_rid
//	 Sets flag to RU1 (rule 1)
header.Layout_PairMatch tra(me_use ll, me_use r) := transform
  self.old_rid := r.rid;
  self.new_rid := ll.rid;
  self.pflag := 20;
  end;

//****** Join the infile to itself
//	     Join on zip, prim_name, prim_range, lname, fname
//		 Loose dob, name_suffix, ssn, vendor_id
//	     Keep the lower ID as the new_rid

//****** Join the infile to itself

j := join(me_use,me_use,
                header.fn_bm_lr_commonality(left.fname,left.lname,left.prim_range,left.prim_name,left.zip,
				                            right.fname,right.lname,right.prim_range,right.prim_name,right.zip,
							                left.mname,right.mname,
							                left.name_suffix,right.name_suffix,
							                left.sec_range,right.sec_range,
							                left.phone,right.phone,
							                left.src,right.src,
											left.RawAID,right.RawAID) and
                left.did=right.did                  and
                left.rid < right.rid                and
                header.near_dob(left.dob,right.dob) and
			    ut.NNEQ(left.ssn,right.ssn),
                tra(left,right));
                
sj := sort(distribute(j,old_rid),old_rid,new_rid,local);

rr := dedup(sj,old_rid,local);

export Rollup1 := rr : persist('rollup1');