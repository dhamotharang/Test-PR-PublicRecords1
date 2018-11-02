/*  Comments:
Made roxie friendl(ier) ... avoid flag in # statement
*/
export MAC_DID_Zip(inrec,outrec,best_appended) := macro

import dx_BestRecords;

#uniquename(k)
#uniquename(r)
%k% := Doxie.Key_Zip_Did;

%r% := record
  unsigned4	seq;
  unsigned6 	did1;
  unsigned6 	did2;
  %k%.fname;
  %k%.lname;
  %k%.cnt;
  %k%.dt_last_seen;
  real 		distance;
  boolean 	in_radius;
  unsigned1 	confidence := 0;
  real 		tir;
  unsigned2	numrecs := 0;
end;

#uniquename(calc_vals)
%r% %calc_vals%(inrec L, %k% R) := transform
  self.distance := if (R.cnt <= L.maxdidcount,ut.zip_dist((string5)R.zip,(string5)L.zip),0);
  self.did1 := if (R.cnt <= L.maxdidcount,R.l_did,0);
  self.did2 := if (R.cnt <= L.maxdidcount,R.b_did,0);
  self.in_radius := self.distance<(real)L.innerradius;
  self.tir := if (R.cnt <= L.maxdidcount,didville.history_scale(R.dt_last_seen)*
              (IF (self.in_radius,
                     70*((real)L.innerradius-self.distance)/(reaL)L.innerradius,
                     0)+
               if(self.distance<(real)L.outerradius,
                     30*((real)L.outerradius-self.distance)/(real)L.outerradius,
                     0)
               ),0);
  self.seq := L.seq;
  self := R;
end;

#uniquename(rec1)
%rec1% := join(inrec(length(trim(firstname))>1),%k%,keyed(left.firstname[1] = right.fi) and keyed(left.firstname = right.fname) and keyed(left.lastname = right.lname) 
					and ut.zip_Dist((string5)left.zip,(string5)right.zip)<=(real)left.outerradius,
				%calc_vals%(LEFT,RIGHT),left outer,atmost(left.firstname[1] = right.fi and left.firstname = right.fname and left.lastname = right.lname,9000));

#uniquename(rec2)
%rec2% := join(inrec(length(trim(firstname))<2),%k%,left.firstname<>'' and left.lastname<>'' and keyed((string1)(left.firstname[1]) = right.fi) and keyed(left.lastname = right.lname) 
					and ut.zip_Dist((string5)left.zip,(string5)right.zip)<=(real)left.outerradius,
				%calc_vals%(LEFT,RIGHT),left outer,atmost((string1)(left.firstname[1]) = right.fi and left.lastname = right.lname,9000));


#uniquename(recs)
%recs% := %rec2%+%rec1%;

#uniquename(r2)
%r2% := record
  unsigned4	seq;
  unsigned6 	did;
  %k%.fname;
  %k%.lname;
  %k%.cnt;
  %k%.dt_last_seen;
  real 		distance;
  boolean 	in_radius;
  unsigned1 	confidence := 0;
  real 		tir;
  unsigned2	numrecs := 0;
end;

#uniquename(normIt)
%r2% %normIt%(%r% L, integer C) := transform
	self.did := if (c = 1, l.did1, l.did2);
	self := L;
end;

#uniquename(fset2)
%fset2% := group(sort(normalize(%recs%,2,%normIt%(LEFT,COUNTER)),seq),seq);

#uniquename(res1)
%res1% := dedup(sort(%fset2%,did,distance),did);

#uniquename(sumtir)
%r2% %sumtir%(%r2% le, %r2% ri) := transform
self.tir := le.tir + ri.tir;
self.confidence := ri.tir;
self.numrecs := Le.numrecs + 1;
self := ri;
end;

#uniquename(i1)
%i1% := iterate(%res1%, %sumtir%(LEFT,RIGHT));

#uniquename(s_conf)
%r2% %s_conf%(%r2% le, %r2% ri) := transform
  self.tir := IF(le.tir = 0, ri.tir, le.tir);
  self.confidence := ( 95 * ri.confidence ) / self.tir;
  self := ri;
  end;

#uniquename(res2)
%res2% := iterate(sort(%i1%(in_radius), -tir),%s_conf%(left, right));

#uniquename(slim)
didville.Layout_DID_Zip_Out %slim%(%r2% L) := transform
	self := L;
end;

#uniquename(Pre_out)
%pre_out% := project(%res2%,%slim%(LEFT));

#uniquename(os)
#uniquename(add_flds)
%os%(string i) := if (i='','',trim(i)+' ');
%pre_out% %add_flds%(%pre_out% le, dx_BestRecords.layout_best ri) := transform
  self.best_phone :=  ri.phone;
  self.best_ssn :=  ri.ssn;
  self.best_name :=  %os%(ri.title)+%os%(ri.fname)+%os%(ri.mname)+%os%(ri.lname)+%os%(ri.NAME_suffix);
  self.best_addr1 := %os%(ri.prim_range)+%os%(ri.predir)+%os%(ri.prim_name)+%os%(ri.suffix)+%os%(ri.postdir)+%os%(ri.unit_desig)+trim(ri.sec_range);
  self.best_city := ri.city_name;
  self.best_state := ri.st;
  self.best_zip := ri.zip;
  self.best_zip4 := ri.zip4;
  self.best_dob := (string8)ri.dob;
  self.best_dod := (string8)ri.dod;
  self := le;
end;

#uniquename(brecs)
#uniquename(jt)
#uniquename(sjt)
%brecs% := dx_BestRecords.append(%pre_out%, did, dx_BestRecords.Constants.perm_type.nonglb);
%jt% := project(%brecs%, %add_flds%(left, left._best));
%sjt% := sort(%jt%,-confidence);


outrec := if(best_appended,%sjt%,%pre_out%);

endmacro;