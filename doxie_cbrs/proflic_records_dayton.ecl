import ut, suppress, doxie, business_header,Prof_LicenseV2;
doxie_cbrs.mac_Selection_Declare()

export proflic_records_dayton(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

//GET ADDRESSES AND COMPANY NAME TUPLES FOR THE BDID
subadd := doxie_Cbrs.best_address_full(bdids)(Include_ProfessionalLicenses_val);

// TRANSFORM TO PUT A SEQUENCE NUMBER ON THE ADDRESS-NAME TUPLES
{subadd,unsigned seq2} projbaf(subadd l, unsigned c) := transform
  self.seq2 := c;
	self := l;
end;

// ADD SEQUENCE NUMBER TO ADDRESS-NAME TUPLES
baf := project(subadd,projbaf(left,counter));

// if you are wondering why I did this and didn't reuse the existing proflic_records
// attribute, see bugzilla 14832.
boolean companies_match (string l, string r) := IF (ut.CompanySimilar100(l,r) <=30, true, false);

// TRANSFORM TO CAPTURE THE SEQUENCE NUMBERS OF THOSE ADDRESS-NAME TUPLES DEEMED "CLOSE MATCHES" TO OTHERS
{unsigned seq2} trimbaf(baf r) := transform
  self := r;
end;

// CAPTURE THE SEQUENCE NUMBERS TO ELIMINATE
baf2 := dedup(sort(join(baf,baf,
             left.seq2 < right.seq2 and
             left.prim_name <> '' and
             left.prim_name = right.prim_name and
						 left.prim_range = right.prim_range and
						 left.zip = right.zip and
						 ut.nneq(left.sec_range,right.sec_range) and
						 companies_match(left.company_name,right.company_name),
						 trimbaf(right),left outer),record),record);

// TRANSFORM TO CAPTURE THE NON-ELIMINATED ADDRESS-NAME TUPLES
subadd keepbaf(baf r) := transform
  self := r;
end;

// RIGHT OUTER JOIN TO GET ONLY THOSE ADDRESS-NAME TUPLES NOT ELIMINATED
baf3 := join(baf2,baf,left.seq2=right.seq2,keepbaf(right),right only);

// KEY INTO PROFESSIONAL LICENSES
kap := Prof_LicenseV2.key_addr_proflic;


// RR-14975 REMOVING CCPA RELATED FIELDS FROM QUERY OUTPUT
// DEFINING LAYOUT USING ACTUAL LAYOUT INSTEAD OF THE DATASET
kap_layout := RECORD
  Prof_LicenseV2.Layouts_ProfLic.Layout_Base - [global_sid, record_sid];
END;


// TRANSFORM TO CAPTURE PROLIC RECORDS MATCHING OUR ADDR-NAME TUPLES
kap_layout keepk(kap r) := transform
	self := r;
end;

// USE ADDR-NAME TO CAPTURE PROFESSIONAL LICENSES
sn := join(baf3, kap,
					 LEFT.prim_name<>'' AND
					 keyed(left.prim_name = right.prim_name) and
					 keyed(left.prim_range = right.prim_range) and
					 keyed(left.zip = right.zip) and
					 companies_match(left.company_name,right.company_name) and					 
					 ut.NNEQ(left.sec_range, right.sec_range),
					 keepk(right),
					 limit(50000));
					 
// MASK SSN
doxie_Cbrs.mac_mask_ssn(sn, msk1, best_ssn)

// SORT ON PROLIC IDENTIFIER AND ADDRESS
srtd := sort(msk1, prolic_key, prim_range, prim_name, zip);

// TRANSFORM TO ROLL UP DATE FIRST SEEN AND DATE LAST SEEN
srtd rollem(srtd l, srtd r) := transform
	ut.mac_roll_dfs(date_first_seen)
	ut.mac_roll_dls(date_last_seen)
	self := l;
end;

// ROLLUP DFS AND DLS ON PROLIC ID AND ADDRESS
rlld := rollup(srtd, 
							 left.prolic_key = right.prolic_key and
							 left.prim_range = right.prim_range and 
							 left.prim_name = right.prim_name and
							 left.zip = right.zip,
							 rollem(left, right));


// PICK THE FIRST N AFTER SORTING BY LICENSEE NAME
return choosen(sort(rlld, lname, fname, mname),Max_ProfessionalLicenses_val);
END;
