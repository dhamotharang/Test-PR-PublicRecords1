//this is intended to handle situations where the
//maiden name gets a DID but the last_name does not
//if both return a DID, keep the last_name

export fn_collapse_maiden_dids(dataset(recordof(reunion.layouts.l_clean)) in_file) := function

f0 := in_file(vendor='1' and trim(clean_person_ind)=''  and orig_vendor_id<>'' and did<>0);
f1 := in_file(vendor='1' and trim(clean_person_ind)=''  and orig_vendor_id<>'' and did =0);
f2 := in_file(vendor='1' and      clean_person_ind ='M' and orig_vendor_id<>'' and did<>0);
f3 := in_file(trim(orig_vendor_id)='');
f4 := in_file(vendor='2');

recordof(in_file) t1(f1 le, f2 ri) := transform
 self.did       := if(le.did=0,ri.did,le.did);
 self.did_score := if(le.did=0,ri.did_score,le.did_score);
 self           := le;
end;

p1 := join(f1,f2,
           left.vendor           =right.vendor           and
           left.orig_vendor_id   =right.orig_vendor_id   and
		   left.orig_first_name  =right.orig_first_name  and
		   left.orig_last_name   =right.orig_last_name   and
		   left.orig_maiden_name =right.orig_maiden_name and
		   left.orig_dob         =right.orig_dob         and
		   left.orig_gender      =right.orig_gender      and
		   left.orig_zip         =right.orig_zip,
		   t1(left,right),
		   left outer
		  );

concat := f0+f3+f4+p1;

return concat;

end;