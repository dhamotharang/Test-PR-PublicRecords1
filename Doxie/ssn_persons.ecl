import ut, header;

export ssn_persons ( boolean checkRNA = false ) := function
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
glb_ok := mod_access.isValidGLB();
dppa_ok := mod_access.isValidDPPA();

keepOldSsns := doxie.keep_old_ssns_val;

dids_ssns := record
  string9 ssn;
  unsigned6 did;
  end;
		
csa := doxie.Comp_Subject_Addresses_wrap.raw;
recs := dedup (sort(csa, did,ssn), did, ssn);


trecs := recs((integer)ssn>1000000 and (integer)ssn not in ut.Set_IntBadSSN);
// eliminate old SSN before looking for imposters if prune_old_ssns
trecs_pruned := join(trecs, doxie.Key_DID_SSN_Date (), left.did = right.did and
                      left.ssn = right.ssn, TRANSFORM(LEFT),
											LEFT ONLY);
										
keep_trecs := IF(keepOldSsns, trecs, trecs_pruned);
use_trecs := project(keep_trecs, dids_ssns);
										
dids_ssns get_dds(use_trecs le, Doxie.Key_Header_SSN ri) := transform
  self.ssn := le.ssn;
  self := ri;
  end;

others_pre := join(use_trecs,Doxie.Key_Header_SSN,left.ssn[1]=right.s1 and
								   left.ssn[2]=right.s2 and
								   left.ssn[3]=right.s3 and
								   left.ssn[4]=right.s4 and
								   left.ssn[5]=right.s5 and
								   left.ssn[6]=right.s6 and
								   left.ssn[7]=right.s7 and
								   left.ssn[8]=right.s8 and
								   left.ssn[9]=right.s9,get_dds(left,right), atmost (5000), keep(ut.limits.DID_PER_SSN + 1));

others := choosen (others_pre, ut.limits.DID_PER_SSN);

// prune others that are old
others_pruned := join(others, doxie.Key_DID_SSN_Date (), left.did = right.did and
                      left.ssn = right.ssn, TRANSFORM(LEFT),
											LEFT ONLY);

use_others := IF(keepOldSsns, others, others_pruned);
											
the_set := dedup(use_others,did,ssn,all);

ssn_people := record
  string20 fname;
  string30 mname;
  string20 lname;
	qstring5  title;
  string5  name_suffix;
  string9  ssn;
  unsigned6 did;
  integer4  date_ob;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  boolean dead;
  end;
		
ssn_people_plus := record //some extra fields to allow us to use mac_glbclean and MAC_Filter_DMV_Info
	ssn_people;
	string1 	 pflag1;		//for original pflag purposes
	string1		 pflag2;		//for phone number related work
	string1		 pflag3;		//for marking records that will have to be split into multiples for despray
	string2      src;
	unsigned3    dt_vendor_last_reported;
	unsigned3    dt_vendor_first_reported;
	unsigned3    dt_nonglb_last_seen;
	string1      rec_type;
	qstring18    vendor_id;
	qstring10    phone;
	integer4     dob;
	qstring10    prim_range;
	string2      predir;
	qstring28    prim_name;
	qstring4     suffix;
	string2      postdir;
	qstring10    unit_desig;
	qstring8     sec_range;
	qstring25    city_name;
	string2      st;
	qstring5     zip;
	qstring4     zip4;
	string3      county;
	qstring7	   geo_blk;
	qstring5     cbsa;
	string1      tnt;
	string1	   valid_SSN;
	string1	   jflag1;  
	string1      jflag2;
	string1	   jflag3;
	string1 valid_dob := '';
	unsigned6    rid;
end;

ssn_people_plus get_people(doxie.Key_Header le) := transform
  self.dead := le.tnt='D';
  self.name_suffix := IF(ut.is_unk(le.name_suffix),'',le.name_suffix);
  self.date_ob := le.dob;
  self.dt_first_seen := MAP(le.dt_first_seen<>0 => le.dt_first_seen,le.dt_last_seen<>0 => le.dt_last_seen, 99999999);
  self.dt_last_seen := MAP(le.dt_last_seen<>0 => le.dt_last_seen,le.dt_first_seen);
  self := le;
end;
	
jdirty := join(the_set,doxie.Key_Header,
							 keyed(left.did=right.s_did) and 
							 (left.ssn = right.ssn or keepOldSsns),
							 get_people(right), LIMIT (ut.limits.DID_PER_PERSON, SKIP));

// if any DID/ssn pairs existed in keep_trecs but were not found in Key_Header_SSN (i.e., from the dailies)
// they need to be preserved
daily_ssns := join(keep_trecs, jdirty, left.did=right.did and left.ssn = right.ssn,
									 transform(ssn_people_plus, 
														 self.date_ob := left.dob, 
														 self.dead := left.tnt = 'D',
														 self := left), 
									 left only);
combined := jdirty+daily_ssns;
header.MAC_GlbClean_Header(combined,j_preRNA, , ,mod_access);
Header.MAC_GLB_DPPA_Clean_RNA(j_preRNA, j_postRNA, mod_access);
j:= if(checkRNA,j_postRNA,j_preRNA);

//back to original format
ut.MAC_Slim_Back(j,ssn_people,jslim)

if (count (others_pre) > ut.limits.DID_PER_SSN, ut.outputMessage (ut.constants_MessageCodes.IMPOSTERS_EXCEED_LIMIT));
return jslim;
END;
