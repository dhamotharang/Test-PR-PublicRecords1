export Mac_RAN_phone_append(f_append_in, f_append_out, data_restriction_mask='', glb_purpose, industry_class_value = '', checkRNA = false, dppa_purpose = 0) := macro
import gong, MDR, Phones, Phonesplus_v2,NID;
	
#uniquename(gong_addr_key)
%gong_addr_key% := gong.Key_Address_current;

#uniquename(append_gong_phone)
f_append_in %append_gong_phone%(f_append_in l, %gong_addr_key% r) := transform
	self.phone := if((unsigned)l.phone<>0 and (unsigned)(l.phone[4..10])<>0, l.phone, r.phone10);
	self := l;
end;

#uniquename(f_gong_app)
%f_gong_app% := join(f_append_in, %gong_addr_key%,
                     keyed(left.prim_name = right.prim_name) and
                     keyed(left.st = right.st) and
		                 keyed(left.zip = right.z5) and
		                 keyed(left.prim_range = right.prim_range) and 
			               (left.sec_range='' or
			                left.sec_range<>'' and metaphonelib.DMetaPhone1(left.lname) = metaphonelib.DMetaPhone1(right.lname) 
				              and NID.mod_PFirstTools.SubLinPFR(right.fname, left.fname)), 
			               %append_gong_phone%(left, right), left outer, keep(1));
				 
#uniquename(ppl_did_key)
%ppl_did_key% := phonesplus_v2.key_phonesplus_did;

//fetch phonesplus records
#uniquename(append_ppl_phone)
f_append_in %append_ppl_phone%(%f_gong_app% l, %ppl_did_key% r) := transform
	self.phone := if((unsigned)l.phone=0 and r.confidencescore>10, r.cellphone, l.phone);
	self := l;																			
end;

#uniquename(f_append_out_ready)
%f_append_out_ready% := join(%f_gong_app%, %ppl_did_key%,
                         keyed(left.did = right.l_did) and left.did<>0
												 and ~Phones.Functions.IsPhoneRestricted(right.origstate, 
																																 glb_purpose,
																																 dppa_purpose,
																																 industry_class_value,
																																 checkRNA,
																																 right.datefirstseen,
																																 right.dt_nonglb_last_seen,
																																 right.rules,
																																 right.src_all,
																																 data_restriction_mask
																																 )
												 and ~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, data_restriction_mask),
 	                    %append_ppl_phone%(left, right), left outer, limit(600, skip), keep(1));
// limit = 2*ut.limits.PHONE_PER_PERSON = 600, because phones in key_phonesplus_did are not unique

#uniquename(f_append_out_dep)
%f_append_out_dep% := dedup(sort(%f_append_out_ready%(phone<>''), seqTarget, prim_name, zip, prim_range, sec_range),
                            seqTarget, prim_name, zip, prim_range, sec_range);

//fill phones for the same address 
#uniquename(fill_same_addr)
f_append_in %fill_same_addr%(%f_append_out_ready% l, %f_append_out_dep% r) := transform
	self.phone := if((unsigned)l.phone=0, r.phone, l.phone);
	self := l;																			
end;
			
f_append_out := join(%f_append_out_ready%, %f_append_out_dep%,
			      left.seqTarget = right.seqTarget and 
                     left.prim_name = right.prim_name and
				 left.zip = right.zip and
				 left.prim_range = right.prim_range and
				 left.sec_range = right.sec_range, 
				 %fill_same_addr%(left, right), left outer, keep(1));

endmacro;