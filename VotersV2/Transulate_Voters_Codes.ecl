import VotersV2, Codes, ut;

Cleaned_Norm_vbase := VotersV2.Norm_Voters_Cleaned_Base;

Layout_outfile := VotersV2.Layouts_Voters.Layout_Voters_base_new;

CleanedNormVbaseAndBase := Cleaned_Norm_vbase;

//*** Code to explode the description values for Race Ethnicity, Active Status, 
//*** Age Category, Political Party, Voter Status
Layout_outfile  getRaceEthnicity(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.race_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self          := L;
end;

Clean_file_Race_Exp := join(CleanedNormVbaseAndBase,
		                    codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'RACEETHNICITY'),
		                    trim(left.race, left, right) = trim(right.code, left, right),
		                    getRaceEthnicity(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getActiveStatus(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.active_status_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self                   := L;
end;

Clean_file_active_status_exp := join(Clean_file_Race_Exp,
		                             codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'ACTIVEORINACTIVE'),
		                             trim(left.active_status, left, right) = trim(right.code, left, right),
		                             getActiveStatus(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getAgeCat(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.ageCat_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self            := L;
end;

Clean_file_AgeCat_exp := join(Clean_file_active_status_exp,
		                      codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'AGECATEGORY'),
		                      trim(left.ageCat, left, right) = trim(right.code, left, right),
		                      getAgeCat(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getPoliticalParty(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.politicalparty_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self                    := L;
end;

Clean_file_PoliticalParty_exp := join(Clean_file_AgeCat_exp,
		                              codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'POLITICALPARTY'),
		                              trim(left.political_party, left, right) = trim(right.code, left, right),
		                              getPoliticalParty(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getVoterStatus(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.Voter_status_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self                  := L;
end;

Clean_file_Voter_Status_exp := join(Clean_file_PoliticalParty_exp,
		                            codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'VOTERSTATUS'),
		                            trim(left.voter_status, left, right) = trim(right.code, left, right),
		                            getVoterStatus(LEFT,RIGHT),left outer, lookup);
//*** End of code transulations.

/* per #Bug: 174413 / Received a complaint against one female individual being reported as Male, data set will be passed 
   Below VotersV2.Filters module to handle accordingly / wrong value(s) will be blanked out  */

//Barb O'Neill modified for DOPS-461
VoteRegBase_File := VotersV2.File_Voters_Base;
	 
ds_Clean_file_Voter_Status_exp := VotersV2.Filters.Base(Clean_file_Voter_Status_exp + VoteRegBase_File);

// generating a sequence number for "vtid"
ut.MAC_Sequence_Records(ds_Clean_file_Voter_Status_exp,vtid,vtidCleanedVotersBase);
					 
dist_vtidCleanedVotersBase := distribute(vtidCleanedVotersBase, hash64(source_state, lname, name_suffix, fname, mname, 
														 prim_range, prim_name, predir, addr_suffix, postdir,
														 unit_desig, sec_range, p_city_name, st, zip,
														 mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix,
														 mail_postdir, mail_unit_desig, mail_sec_range, mail_p_city_name,
														 mail_st, mail_ace_zip, phone, work_phone
														 ));

Srt_dist_vtidCleanedVotersBase := sort(dist_vtidCleanedVotersBase, source_state, lname, fname, mname, name_suffix, prim_range, 
                                prim_name, predir, addr_suffix, postdir, unit_desig, sec_range, p_city_name, st, zip,
								mail_prim_range, mail_prim_name, mail_predir, mail_addr_suffix,	mail_postdir, 
								mail_unit_desig, mail_sec_range, mail_p_city_name, mail_st, mail_ace_zip,
								phone, work_phone, -dob, -process_date, local);

Layout_outfile patchRecs(dist_vtidCleanedVotersBase l, dist_vtidCleanedVotersBase r) := transform
   same_group := if(trim(l.lname,left,right) = trim(r.lname,left,right) and 
	                trim(l.fname,left,right) = trim(r.fname,left,right) and 
					trim(l.mname,left,right) = trim(r.mname,left,right) and 
					trim(l.name_suffix,left,right) = trim(r.name_suffix,left,right) and 
					trim(l.prim_range,left,right) = trim(r.prim_range,left,right) and 
					trim(l.prim_name,left,right) = trim(r.prim_name,left,right) and 
					trim(l.predir,left,right) = trim(r.predir,left,right) and 
					trim(l.addr_suffix,left,right) = trim(r.addr_suffix,left,right) and 
					trim(l.postdir,left,right) = trim(r.postdir,left,right) and 
					trim(l.unit_desig,left,right) = trim(r.unit_desig,left,right) and 
					trim(l.sec_range,left,right) = trim(r.sec_range,left,right) and 
					trim(l.p_city_name,left,right) = trim(r.p_city_name,left,right) and 
					trim(l.st,left,right) = trim(r.st,left,right) and 
					trim(l.zip,left,right) = trim(r.zip,left,right) and
					trim(l.mail_prim_range,left,right) = trim(r.mail_prim_range,left,right) and 
					trim(l.mail_prim_name,left,right) = trim(r.mail_prim_name,left,right) and 
					trim(l.mail_predir,left,right) = trim(r.mail_predir,left,right) and 
					trim(l.mail_addr_suffix,left,right) = trim(r.mail_addr_suffix,left,right) and 
					trim(l.mail_postdir,left,right) = trim(r.mail_postdir,left,right) and 
					trim(l.mail_unit_desig,left,right) = trim(r.mail_unit_desig,left,right) and 
					trim(l.mail_sec_range,left,right) = trim(r.mail_sec_range,left,right) and 
					trim(l.mail_p_city_name,left,right) = trim(r.mail_p_city_name,left,right) and 
					trim(l.mail_st,left,right) = trim(r.mail_st,left,right) and 
					trim(l.mail_ace_zip,left,right) = trim(r.mail_ace_zip,left,right) and
					trim(l.phone,left,right) = trim(r.phone,left,right) and
					trim(l.work_phone,left,right) = trim(r.work_phone,left,right) and
					trim(l.source_state) = trim(r.source_state), true, false);
					
   self.dob  := if (same_group and 
                    ut.NNEQ_Date((integer)l.dob, (integer)r.dob) and 
				    l.dob[5..8] <> r.dob[5..8] and
				    (integer)r.dob[5..8] = 0, l.dob, r.dob);

   self.vtid := if (same_group and 
                    trim(self.dob) = trim(l.dob), l.vtid, r.vtid);
   self      := r;
end;


Clean_patched_vtid_dob_file := iterate(Srt_dist_vtidCleanedVotersBase, patchRecs(left,right),local);						  

export Transulate_Voters_Codes := Clean_patched_vtid_dob_file: persist(VotersV2.Cluster+ 'persisit::Cleaned_Voter_base');