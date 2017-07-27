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

phones_match(string p1, string p2) := 
	p1 = p2 or 
	stringlib.stringfind(p1, p2, 1) > 0 or
	stringlib.stringfind(p2, p1, 1) > 0;

suffix_unk(string s1, string s2) := 
 s1='UNK' and s2='UNK' or 
 s1='UNK' and s2='' or
 s1='' and s2='UNK';

j := join(me_use,me_use,
                left.zip=right.zip and
                left.prim_name=right.prim_name and
                left.prim_range=right.prim_range and
                left.lname=right.lname and
                left.fname=right.fname and
                left.did=right.did and
                left.rid < right.rid and
               (mdr.isSourceGroupMatch(left.src,right.src) or 
			left.src=right.src and ~mdr.Source_is_on_Probation(left.src) and
			left.vendor_id[1..2]=right.vendor_id[1..2])and
               (ut.NNEQ_Suffix(left.name_suffix, right.name_suffix) or 
					suffix_unk(left.name_suffix,right.name_suffix))and
               header.near_dob(left.dob,right.dob) and
			   ut.Firstname_Match(left.mname,right.mname)>0 and
			   ut.NNEQ(left.ssn,right.ssn) and
			   ut.NNEQ(left.sec_range,right.sec_range) and 
			   phones_match(left.phone, right.phone),
                tra(left,right));
                
sj := sort(distribute(j,old_rid),old_rid,new_rid,local);

rr := dedup(sj,old_rid,local);

export Rollup1 := rr : persist('rollup1');