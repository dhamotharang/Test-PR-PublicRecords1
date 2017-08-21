import ln_propertyv2;
//W20080911-151853
//see about 34M ln_fares_id's where the owner and seller are the same person
//approx 450k are deed correction records
//also see cases of an individual converting the deed to husband & wife (adding wife to deed)
//maricopa, az has an unusually high number of owner=seller records -> both fares and lexis have this
//...consider removing

srch  := ln_propertyv2.File_Search_DID(did>0);
deeds := distribute(ln_propertyv2.File_Deed,hash(ln_fares_id));

r1 := record
 srch.ln_fares_id;
 srch.did;
 boolean did_is_seller;
 boolean did_is_owner;
end;

r1 t1(srch le) := transform
 self.did_is_seller := le.source_code[1]='S';
 self.did_is_owner  := le.source_code[1] in ['B','O'];
 self               := le;
end;

p1      := project   (srch,t1(left));
p1_dist := distribute(p1,hash(ln_fares_id,did));
p1_sort := sort      (p1_dist,ln_fares_id,did,did_is_seller,did_is_owner,local);
p1_dupd := dedup     (p1_sort,ln_fares_id,did,did_is_seller,did_is_owner,local);

r1 t2(r1 le, r1 ri) := transform
 self.did_is_seller := if(le.did_is_seller=true,le.did_is_seller,ri.did_is_seller);
 self.did_is_owner  := if(le.did_is_owner =true,le.did_is_owner ,ri.did_is_owner);
 self               := le;
end;

p2        := rollup(p1_dupd,left.ln_fares_id=right.ln_fares_id and left.did=right.did,t2(left,right),local);
p2_redist := distribute(p2,hash(ln_fares_id));

r2 := record
 p2_redist;
 //this is just to see the breakdown
 string2 fid_trunc;
 boolean is_correction;
 boolean is_maricopa;
end;

r2 t3(r1 le, deeds ri) := transform
 self.fid_trunc     := le.ln_fares_id[1..2];
 self.is_correction := (ri.vendor_source_flag in ['D','O'] and trim(ri.document_type_code)='CR')
                       or
					   (ri.vendor_source_flag in ['F','S'] and trim(ri.document_type_code)='CD');
 self.is_maricopa   := (integer)ri.fips_code=4013 or (ri.state='AZ' and trim(ri.county_name)='MARICOPA');					   
 self               := le;
 self               := ri;
end;

j1 := join(p2_redist,deeds,left.ln_fares_id=right.ln_fares_id,t3(left,right),left outer,local);

f1 := j1(did_is_seller=true and did_is_owner=true);

r3 := record
 f1.fid_trunc;
 f1.did_is_owner;
 f1.did_is_seller;
 f1.is_correction;
 f1.is_maricopa;
 count_ := count(group);
end;

ta1 := sort(table(f1,r3,fid_trunc,did_is_owner,did_is_seller,is_correction,is_maricopa,few),fid_trunc,did_is_owner,did_is_seller,is_correction,is_maricopa);
output(ta1,named('potentially_bad_records'));

export get_fid_candidates := j1(~(did_is_seller=true and did_is_owner=true)) : persist('persist::ixi_fid_candidates');