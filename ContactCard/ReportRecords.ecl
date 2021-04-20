import ContactCard, doxie_raw, doxie, header, ut, EmailV2_Services;


con := contactcard.constants;
rec := contactcard.layouts;
storeds := contactcard.storeds;

export ReportRecords(
  dataset(doxie.layout_references) gdids,
  doxie.IDataAccess mod_access
  ):=
FUNCTION


//****** MAKE SURE THE INPUT UNIQUELY IDENTIFIES SOMEONE
dids := limit(gdids, 1, fail(11, doxie.ErrorCodes(11)));


//****** FINDERS
srtd := contactcard.FinderRecords(dids, mod_access).results;


//****** GET THE ADDRESSES
head := contactcard.FinderRecords(dids, mod_access).head_subject;

comp_addr_plus_rec := record(rec.comp_addr_rec)
 string2 addr_ind;
 string2 best_addr_rank;
end;

addr_shared := project(head, transform(comp_addr_plus_rec,
                                       self.address_seq_no := counter,
                                       self.phones := [],
                                       self.hri_address := [],
                                       self := left));

ut.getTimeZone(addr_shared,phone,timezone,addr_shared_w_timezone0);
ut.getTimeZone(addr_shared_w_timezone0,listed_phone,listed_timezone,addr_shared_w_timezone);
//****** PHONES
subphones := doxie.fn_phone_records_wide(project(addr_shared_w_timezone, doxie.Layout_Comp_Addresses))
  (not business_flag);

//rec_plus := record(rec.comp_addr_rec)
rec_plus := record(comp_addr_plus_rec)
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
                           transform(comp_addr_plus_rec, self.phones := left.phones(trim(phone, all) <> ''),
                                                        self := left));

addr_phone_rolled :=
  rollup(addr_phone_srtd,
         left.address_seq_no = right.address_seq_no,
         transform(comp_addr_plus_rec,
                   self.phones := choosen((left.phones + right.phones)(phone <> ''), con.max_PhonesPerAddr),
                   self := left));
// AH Sort                        
 addr_phone_rolled_srtd_ah_sorted := sort(addr_phone_rolled, did,(unsigned) addr_ind, (unsigned) best_addr_rank);
 addr_phone_rolled_srtd := project(addr_phone_rolled_srtd_ah_sorted,rec.comp_addr_rec);
 
//****** BK
bks := choosen(Doxie_Raw.bkV2_raw(dids,,,,mod_access.ssn_mask), con.max_bankruptcies);

si := ContactCard.Addrs_Imposters_Rels_Assocs(dids, mod_access, false).bestrecs_w_issuance_contactcard;

//****** IMPOSTERS BECOME 'OTHERS WITH SSN' ONCE I MAKE SURE THE SUBJEST IN NOT IN THERE
imposters		:= Addrs_imposters_rels_assocs(dids, mod_access).imposters;
imposters_cln := imposters(min(akas, ut.NameMatch(name.first, name.middle, name.last, si[1].name.first,si[1].name.middle,si[1].name.last)) > 2);
SubjectIsMinor := (integer)si[1].age > 0 and (integer)si[1].age < 18;

//****** SUBJECT AND DEATH INFO
dr := contactcard.FinderRecords(dids, mod_access).SubjectDeathRecords;

// attach death indicators, using "best" death record; note, 'si' has no more than 1 row
rec.subject_rec dodWork(contactcard.layouts.subject_rec l) := transform
  r := topn(dr, 1, did, dod8, if(IsLimitedAccessDMF, 1, 0))[1];
  iDOB := (unsigned)l.dob.year * 10000 + (unsigned)l.dob.month * 100 + (unsigned)l.dob.day;
  iDOD := (unsigned)r.dod8;
  self.dod.year := (unsigned)r.dod8[1..4];
  self.dod.month := (unsigned)r.dod8[5..6];
  self.dod.day := (unsigned)r.dod8[7..8];
  self.age_at_death := if(iDOB < 18000000 or iDOD < 18000000, 0, ut.Age(iDOB, iDOD));
  self.deceased := if ((integer)r.did > 0 ,'Y','N');
  self.IsLimitedAccessDMF := r.IsLimitedAccessDMF;
  self := l;
END;
sdi := project (si, dodWork (Left));
//****** PROJECT TO FINAL LAYOUT AND PICK UP THE OTHER SECTIONS
// attach same death indicator to each of subject's AKAs
akas :=project(Addrs_Imposters_Rels_Assocs(dids, mod_access, false).akas, rec.aka_rec);
akas t_akas(akas l) := transform
  r := sdi[1];
  self.dod := r.dod;
  self.age_at_death := r.age_at_death;
  self.death_verification_code := r.death_verification_code;
  self.deceased := r.deceased;
   self.IsLimitedAccessDMF := r.IsLimitedAccessDMF;
  self:=l;
end;
l_akas := project(akas,t_akas(left));

email_v2 := Doxie.emailv2_records(dids, mod_access,,EmailV2_Services.Constants.Premium);

prop_count := doxie.Fn_comp_prop_count(dids[1].did,0,mod_access.dppa,mod_access.glb,mod_access.ln_branded,mod_access.probation_override);


individual :=
  dataset([
          transform(rec.result_ext_rec,
                    self.akas :=  choosen(l_akas, con.max_akas),
                    self.finders := choosen(project(srtd, rec.finder_rec), con.max_finders),
                    self.indicators := choosen(project(doxie.header_lookups(dids),
                                                       transform(rec.indicator_rec,
                                                                 self.comp_prop_count := prop_count,
                                                                 self.bk_count := if(left.bk_count > con.max_bankruptcies and count(bks) = con.max_bankruptcies, left.bk_count, count(bks)),
                                                                 self := left)), con.max_indicators),
                    self.bankruptcies := bks,
                    self.subject_information := choosen(sdi, 1);
                    self.imposters :=  choosen(imposters_cln, con.max_imposters),
                    self.addresses := choosen(addr_phone_rolled_srtd, con.max_addresses),
                    self.EmailV2Records := if(storeds.Include_Email_Addresses, email_v2.EmailV2Records),
                    self.EmailV2Royalties := if(storeds.Include_Email_Addresses, email_v2.EmailV2Royalties)
                   )
  ])(con.AllowMinors or (not SubjectIsMinor));

  return individual;
END;
