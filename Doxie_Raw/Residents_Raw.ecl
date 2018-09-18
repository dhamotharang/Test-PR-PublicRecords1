import doxie,ut,header,suppress;

export Residents_Raw(
	DATASET(doxie.layout_addressSearch_plus) addrs,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
	string6 ssn_mask_value = 'NONE',
	boolean ln_branded_value = false,
	boolean probation_override_value = false,
	unsigned3 MaxResidentsPerAddr = 10
) := FUNCTION

mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
  EXPORT unsigned1 dppa := dppa_purpose;
  EXPORT unsigned1 glb := glb_purpose;
  EXPORT boolean ln_branded := ln_branded_value;
  EXPORT boolean probation_override := probation_override_value;
  EXPORT unsigned3 dateVal := ^.dateVal;
  EXPORT string ssn_mask := ssn_mask_value;
END;  
	
//***** FIND THOSE WHO RESIDED AT ADDRS RECENTLY


k := header.Key_Nbr_Address;

midrec := record
	integer3 address_seq_no;
	k;
end;

midrec keepk(addrs l, k r) := transform
	self.address_seq_no := l.seq;
	self := r;
end;


j := join(addrs(prim_name <> '' and zip <> '' and 
								(sec_range <> '' or prim_range <> '' or ut.isPOBox(prim_name,RequireNumber:=true))),
					k,
					keyed(left.prim_name = right.prim_name) and
					keyed(left.zip = right.zip) and
					keyed(left.zip4[1..2] = right.z2) and
					keyed(left.suffix = right.suffix) and
					keyed(left.prim_range = right.prim_range) and
					left.sec_range = right.sec_range and				
					doxie.isrecent((string6)right.dt_last_seen, 3),
					keepk(left, right), limit(500, skip), keep(100));

jd1 := dedup(sort(j,address_seq_no,did,-dt_last_seen),address_seq_no,did);
jd 	:= dedup(jd1, address_seq_no, keep(MaxResidentsPerAddr));


//***** GATHER NAME/SSN/DOB INFO FOR THE DIDS WE FOUND
dids := dedup(project(jd, doxie.layout_references));
//b := doxie.best_records(dids,false,dppa_purpose,glb_purpose, , , , , , header.constants.checkRNA)
b := doxie.best_records(dids, checkRNA := header.constants.checkRNA, modAccess := mod_access)
			(dod = '');

outrec := record
	j;
	b.fname;
	b.mname;
	b.lname;
	b.name_suffix;
	b.ssn;
	b.dob;
	string9 ssn_unmasked := '';
end;

outrec addback(j l, b r) := transform
	self := l;
	self.ssn := r.ssn_unmasked;
	self := r;
end;

wadd := join(j,b, left.did = right.did, addback(left, right), keep(1));

suppress.MAC_Mask(wadd, msk, ssn, foo, true, false,, true, , mod_access.ssn_mask);

return msk;

END;