
rAddUniqueID := record
 string9 id;
 infutor.Layout_Infutor_FixedLength;
end;

rInfutor_d00 := record
 rAddUniqueID;
 string73 n;
 string73 n1;
 string73 n2;
 string73 n3;
 string182 a;
 string182 a1;
 string182 a2;
 string182 a3;
 string182 a4;
 string182 a5;
end;

dInfutorClean := dataset('~thor_dell400_2::out::infutor_clean',rInfutor_d00,flat);
//output(dInfutorClean);

rHas_DOB_or_SSN := record
 count_    := count(group);
 has_dob   := count(group,if(trim(dInfutorClean.dob)<>'',1,0));
 has_ssn   := count(group,if(trim(dInfutorClean.ssn_1)<>'' or trim(dInfutorClean.ssn_2)<>'',1,0));
 has_phone := count(group,trim(dInfutorClean.phone_number)<>'');
end;

dHas_DOB_or_SSN := table(dInfutorClean,rHas_DOB_or_SSN,few);
output(dHas_DOB_or_SSN);

rRedefineClean := record
 string9  id;
 string5  name_prefix;
 string20 fname;
 string20 mname;
 string20 lname;
 string5  name_suffix;
 string3  name_score;
 string9  ssn;
 string8  dob;
 string10 phone;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string4  suffix;
 string2  postdir;
 string10 unit_desig;
 string8  sec_range;
 string25 p_city_name;
 string25 v_city_name;
 string2  ace_state;
 string5  ace_zip;
 string4  ace_zip4;
 string4  cart;
 string1  cr_sort_sz;
 string4  lot;
 string1  lot_order;
 string2  dbpc;
 string1  chk_digit;
 string2  ace_rec_type;
 string5  ace_county;
 string10 geo_lat;
 string11 geo_long;
 string4  ace_msa;
 string7  geo_blk;
 string1  geo_match;
 string4  err_stat;
end;

Layout_New_Records := record
  rRedefineClean;
  unsigned6    did := 0;
  end;
  
d := dataset('~thor_dell400_2::out::infutor_clean_normalized',rRedefineClean,flat);
//output(d(id='000000001'));

/*
   matchset   -    should be set of char1's indicating the indicatives in infile
                          'A' = Address
                          'D' = DOB
                          'S' = ssn
                          'P' = phone
    ***                   'Q' = Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
					 '4' = ssn4 matching (last 4 digits of ssn)
					 'G' = age matching
					 'Z' = zip code matching
*/
/*
matchset := ['A','D','S','P','Z'];

did_add.MAC_Match_Flex
	(d, matchset,					
	 ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, ace_zip, ace_state, phone, 
	 DID, Layout_New_Records, false, DID_Score_field,
	 75, d_out)

output(d_out,,'~thor_dell400_2::out::infutor_did',__compressed__,overwrite);
*/

d_out := dataset('~thor_dell400_2::out::infutor_did',Layout_New_Records,flat);

rDID_Stat := record
 count_  := count(group);
 has_did := count(group,d_out.did<>0);
end;

dHasDID := table(d_out,rDID_Stat,few);
//output(dHasDID);

rSlimrec := record
 d_out.id;
 d_out.did;
end;

rSlimrec tSlimrec(d_out l) := transform
 self := l;
end;

dSlimrec       := dedup(project(d_out,tSlimrec(left)),all);
//count(dSlimrec);

//dSlimrec_dedup := dedup(sort(distribute(dSlimrec,hash(id,did)),id,-did,local),id,local);
dSlimrec_dedup := dedup(sort(dSlimrec,id,-did),id);
//output(min(dSlimrec_dedup,id));
//output(max(dSlimrec_dedup,id));
//count(dSlimrec_dedup);

rID_has_DID := record
 count_           := count(group);
 orig_record_dids := count(group,dSlimrec_dedup.did<>0);
end;

dID_has_DID := table(dSlimrec_dedup,rID_has_DID,few);
//output(dID_has_DID);

rAddrSlimRec := record
 d_out.prim_range;
 d_out.prim_name;
 d_out.ace_zip;
 d_out.sec_range;
end;

rAddrSlimRec tAddrSlimRec(d_out l) := transform
 self := l;
end;

rAddrSlimRec tSlimHeaderAddr(header.File_Headers l) := transform
 self.prim_range := l.prim_range;
 self.prim_name  := l.prim_name;
 self.ace_zip    := l.zip;
 self.sec_range  := l.sec_range;
end;

dAddrSlimrec := project(d_out(trim(prim_range)<>'' and trim(prim_name)<>'' and trim(ace_zip)<>''),tAddrSlimRec(left));
dAddrUnique  := dedup(sort(distribute(dAddrSlimRec,hash(prim_range,prim_name,ace_zip,sec_range)),prim_range,prim_name,ace_zip,sec_range,local),prim_range,prim_name,ace_zip,sec_range,local);

dHeaderUniqueAddr := dedup(sort(distribute(project(header.File_Headers,tSlimHeaderAddr(left)),hash(prim_range,prim_name,ace_zip,sec_range)),prim_range,prim_name,ace_zip,sec_range,local),prim_range,prim_name,ace_zip,sec_range,local);

rAddrSlimRec tInfutorAddressNotInHeader(dAddrUnique l, dHeaderUniqueAddr r) := transform
 self := l;
end;

dUniqueInfutorAddress := join(dAddrUnique,dHeaderUniqueAddr,
                              (left.prim_range=right.prim_range and
							   left.prim_name=right.prim_name and
							   left.ace_zip=right.ace_zip and
							   ut.NNEQ(left.sec_range,right.sec_range)),
							  tInfutorAddressNotInHeader(left,right),
							  left only,local);
//count(dUniqueInfutorAddress);