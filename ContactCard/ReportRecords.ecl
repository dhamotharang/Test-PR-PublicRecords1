import doxie_raw, doxie, ut, std;

doxie.MAC_Header_Field_Declare()
doxie.MAC_Selection_Declare()

con := contactcard.constants;
rec := contactcard.layouts;
storeds := contactcard.storeds;

export ReportRecords( 
	dataset(doxie.layout_references) gdids
	):= 
FUNCTION


//****** MAKE SURE THE INPUT UNIQUELY IDENTIFIES SOMEONE
dids := limit(gdids, 1, fail(11, doxie.ErrorCodes(11)));


//****** FINDERS
srtd := contactcard.FinderRecords(dids).results;


//****** GET THE ADDRESSES 
head := contactcard.FinderRecords(dids).head_subject;

addr_shared := project(head, transform(rec.comp_addr_rec, 
																			 self.address_seq_no := counter,
																			 self.phones := [],
																			 self.hri_address := [],
																			 self := left));

ut.getTimeZone(addr_shared,phone,timezone,addr_shared_w_timezone0)
ut.getTimeZone(addr_shared_w_timezone0,listed_phone,listed_timezone,addr_shared_w_timezone)
//****** PHONES
subphones := doxie.fn_phone_records_wide(project(addr_shared_w_timezone, doxie.Layout_Comp_Addresses))
	(not business_flag);

rec_plus := record(rec.comp_addr_rec)
		unsigned2 ss;
end;

addr_phone := join(addr_shared_w_timezone, subphones,
					left.prim_name=right.prim_name and
					left.prim_range = right.prim_range and
					ut.nneq(left.sec_range, Right.sec_range) and
					left.zip = right.zip,
					transform(rec_plus, 
										self.phones := if(right.phone <> '', project(right, transform(rec.phone_ln_rec, self := left))),
										self.ss := ut.StringSimilar(left.fname+left.mname+left.lname, right.listing_name),
										self := left),
					left outer);
					
addr_phone_srtd := project(sort(addr_phone, address_seq_no, ss), 
													 transform(rec.comp_addr_rec, self.phones := left.phones(trim(phone, all) <> ''),
																												self := left));

addr_phone_rolled := 
	rollup(addr_phone_srtd, 
				 left.address_seq_no = right.address_seq_no,
				 transform(rec.comp_addr_rec,
									 self.phones := choosen((left.phones + right.phones)(phone <> ''), con.max_PhonesPerAddr),
									 self := left));

addr_phone_rolled_srtd := sort(addr_phone_rolled,  doxie.tnt_score(tnt), -if(dt_last_seen=0,dt_first_seen,dt_last_seen),phone<>listed_phone,lname,fname,mname,prim_range,did,phone,record);

//****** BK
bks := choosen(Doxie_Raw.bkV2_raw(dids,,,,ssn_mask_value), con.max_bankruptcies);

si := Addrs_Imposters_Rels_Assocs(dids, false).bestrecs_w_issuance_contactcard;

//****** IMPOSTERS BECOME 'OTHERS WITH SSN' ONCE I MAKE SURE THE SUBJEST IN NOT IN THERE
imposters		:= Addrs_imposters_rels_assocs(dids).imposters;
imposters_cln := imposters(min(akas, ut.NameMatch(name.first, name.middle, name.last, si[1].name.first,si[1].name.middle,si[1].name.last)) > 2);
SubjectIsMinor := (integer)si[1].age > 0 and (integer)si[1].age < 18;

//****** SUBJECT AND DEATH INFO
dr := contactcard.FinderRecords(dids).SubjectDeathRecords;
// attach death indicators, using "best" death record; note, 'si' has no more than 1 row
rec.subject_rec dodWork(si l) := transform
	r := dr[1];
	iDOB := (unsigned)l.dob.year * 10000 + (unsigned)l.dob.month * 100 + (unsigned)l.dob.day;
	iDOD := (unsigned)r.dod8;
	self.dod.year := (unsigned)r.dod8[1..4];
	self.dod.month := (unsigned)r.dod8[5..6];
	self.dod.day := (unsigned)r.dod8[7..8];
	self.age_at_death := if(iDOB < 18000000 or iDOD < 18000000, 0, ut.Age(iDOB, iDOD));
	self.deceased := if ((integer)r.did > 0 ,'Y','N');
	self := l;
END;
sdi := project (si, dodWork (Left));


//****** PROJECT TO FINAL LAYOUT AND PICK UP THE OTHER SECTIONS

// attach same death indicator to each of subject's AKAs 
akas :=project(Addrs_Imposters_Rels_Assocs(dids, false).akas, rec.aka_rec);
akas t_akas(akas l) := transform
	r := sdi[1];
  self.dod := r.dod;
  self.age_at_death := r.age_at_death;
  self.death_verification_code := r.death_verification_code;
  self.deceased := r.deceased;
	self:=l;
end;
l_akas := project(akas,t_akas(left));

return 
	dataset([
					transform(rec.result_rec2,
										self.akas :=  choosen(l_akas, con.max_akas),
										self.finders := choosen(project(srtd, rec.finder_rec), con.max_finders),
										self.indicators := choosen(project(doxie.header_lookups(dids), 
																											 transform(rec.indicator_rec,
																																 self.comp_prop_count := doxie.Fn_comp_prop_count(dids[1].did,0,dppa_purpose,glb_purpose,ln_branded_value,probation_override_value),
																																 self.bk_count := if(left.bk_count > con.max_bankruptcies and count(bks) = con.max_bankruptcies, left.bk_count, count(bks)),
																																 self := left)), con.max_indicators),
										self.bankruptcies := bks,
										self.subject_information := choosen(sdi, 1);
										self.imposters :=  choosen(imposters_cln, con.max_imposters),
										self.addresses := choosen(addr_phone_rolled_srtd, con.max_addresses),
										self := []
                   )
  ])(con.AllowMinors or (not SubjectIsMinor));

END;


