import person_models,moxie_phonesplus_server,doxie_raw,header,Relocations,doxie,dx_death_master,address,PhonesFeedback_Services,
      AutoStandardI,DeathV2_Services,suppress, ContactCard, STD, MDR,
      PhonesFeedback;  // PhonesFeedback is used in macro Mac_Append_Feedback()

death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());

doxie.MAC_Header_Field_Declare(); // dial_contactprecision_value, score_threshold_value
doxie.MAC_Selection_Declare();

con := ContactCard.constants;
rec := ContactCard.layouts;
storeds := ContactCard.storeds;

contact_addr_rec := RECORD
 rec.contact_rec;
 rec.addr_rec;
END;
getSubjectDeceasedData (unsigned _subjectDID, DeathV2_Services.IParam.DeathRestrictions _death_params) := FUNCTION
//***** SEE IF DECEASED
  subject_did := dataset([{_subjectDID}], doxie.layout_references);
  subject_death_recs := dx_death_master.Get.byDid(subject_did, did, _death_params, , con.max_subject);

  dodpadlock_rec := RECORD
    dx_death_master.layout_death;
    boolean IsLimitedAccessDMF:= false;
  END;

  SubjectDeathRecords_info := project(subject_death_recs, transform(dodpadlock_rec, self.IsLimitedAccessDMF := (left.death.src = MDR.sourceTools.src_Death_Restricted), self := left.death));
  Death_source_grp :=  sort(group(sort(SubjectDeathRecords_info, did, dod8), did, dod8), if(IsLimitedAccessDMF, 1, 0));

  Subject_DeathRecords := ungroup(iterate(Death_source_grp,
                                              transform(dodpadlock_rec,
                                                        self.IsLimitedAccessDMF := if(counter = 1, ((integer)right.dod8 != 0 and right.IsLimitedAccessDMF), left.IsLimitedAccessDMF) ,
                                                        self := right)));

  RETURN Subject_DeathRecords;
END;

newEnough(unsigned2 yr) := yr + con.max_AgeOfData >= (unsigned2)(((STRING)STD.Date.Today())[1..4]);

getRelativesAssociates(dataset(doxie.layout_references) dids, doxie.IDataAccess mod_access) := FUNCTION
//***** GET THE RELATIVES
//	depth is input to service and defaults to 1 by #stored('RelativeDepth',con.default_RelativeDepth) in ContactCard.ReportService,
//	so we can have depth beyond 1 in allrel
  allrel := Doxie_Raw.relative_raw(dids, mod_access,
                                              true, true,
                                              Relative_Depth, max_relatives);

// rel is the group that i will actually consider relatives in the final output
// there are some refs to allrel because we use them to figure out some of the relationships
// note that depth>1 is allowed if newEnough
  rel := allrel(depth=1 or newEnough((unsigned2)(((STRING)recent_cohabit)[1..4])));


  rel_det := choosen(project(rel(isRelative and depth = 1),
                                transform(rec.pridid_rec,
                                            self.did:=left.person2,
                                            self.priority := con.priority_relative,
                                            self.relationship := if(left.titleNo <> 0, Header.relative_titles.fn_get_str_title(left.titleNo), con.str_Relative),
                                            self:=left)),
                                  con.max_relatives);

//***** DID SETS
  AssocDIDs 		:= 	choosen(sort(dedup(
                          project(rel(~isRelative, number_cohabits >= con.min_number_cohabits),
                                  transform(rec.pridid_rec,
                                            self.did := left.person2,
                                            self.priority := con.priority_associate,
                                            self.relationship := con.str_Associate +
                                              if(left.titleno=Header.relative_titles.num_transactionalAssociate,'',' ' + header.translateRelativePrimrange(left.rel_prim_range)),
                                            self := left)),
                          all),-recent_cohabit), con.max_associates);
  deg2rels 	:= 	choosen(sort(dedup(
                          project(rel(depth > 1, isRelative, number_cohabits >= con.min_number_cohabits),
                                  transform(rec.pridid_rec,
                                            self.did := left.person2,
                                            self.priority := con.priority_relative,
                                            self.relationship := if(left.titleNo <> 0, Header.relative_titles.fn_get_str_title(left.titleNo), con.str_Relative),
                                            self := left)),
                          all),depth,-recent_cohabit), con.max_relatives);

// this just removes the deceased
  all_rels := dx_death_master.Exclude(AssocDIDs+deg2rels+rel_det, did, death_params);

  RETURN all_rels;
END;
getSubjectRelAssocAddressHistory (dataset(doxie.layout_references) dids,
                                  unsigned6 subjectDID,
                                  doxie.IDataAccess mod_access) := FUNCTION

 csa := doxie.Comp_Subject_Addresses(dids, , dial_contactprecision_value, , mod_access);

 head_nopull := csa.raw;

//***** PULL IDS
Suppress.MAC_Suppress(head_nopull,head_pull1,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
Suppress.MAC_Suppress(head_pull1,head_pull2,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

rna_IN := head_pull2(did<>subjectDID);
header.MAC_GLB_DPPA_Clean_RNA(rna_in,head_pull2_rna,mod_access);

 head := head_pull2_rna + head_pull2(did = subjectDID);


 head_slim := sort(PROJECT(head,
                      transform(contact_addr_rec,
                                self.subject_dt_last_seen := if(left.did = subjectdid, left.dt_last_seen, 0),  //mark subject recs so i can use them to populate subject_dt_last_seen in next join
                                self.verified := address.isVerified(left.tnt, left.phone, left.listed_phone),
                                self.timezone:='',self.listed_timezone :='',self := left)),
                  did, prim_range, prim_name, zip);

head_slim rollem(head_slim l, head_slim r) := transform
  ut.mac_roll_DLS(dt_last_seen)
  ut.mac_roll_DLS(subject_dt_last_seen)
  ut.mac_roll_DFS(dt_first_seen)
  self.sec_range := if(l.sec_range > r.sec_range, l.sec_range, r.sec_range);
  self.unit_desig := if(l.unit_desig  > r.unit_desig , l.unit_desig , r.unit_desig);
  self.tnt := if(doxie.tnt_score(l.tnt) < doxie.tnt_score(r.tnt), l.tnt, r.tnt);
  self.verified := l.verified or r.verified;
  self.isSubject := if(l.did=subjectdid,true,false);
  self := r;
end;

//***** ROLLUP BY ADDRESS
head_roll1 := rollup(head_slim, rollem(left, right), did, prim_range, prim_name, zip)
              (not Address.isDeathRecord(prim_name));

//***** DETERMINE SHARED ADDRESSES
shared_addrs := join(head_roll1(did = subjectDID), head_roll1(did <> subjectDID),
                      left.prim_name=right.prim_name and
                      left.prim_range = right.prim_range and
                      ut.nneq(left.sec_range, Right.sec_range) and
                      left.zip = right.zip,
                      transform({head_roll1.prim_name, head_roll1.prim_range, head_roll1.zip}, self := left));

  all_addresses := join(head_roll1, dedup(shared_addrs, prim_name, prim_range, zip, all),
                          left.prim_name=right.prim_name and
                          left.prim_range = right.prim_range and
                          left.zip = right.zip,
                          transform({head_roll1},
                                      self.shared_address := if(right.zip <> '', 'S',''),
                                      self := left),
                          left outer);

  RETURN all_addresses;
END;

//TO DO: replace this function logic with AH sorting
getMostRecentAddresses(dataset(contact_addr_rec) all_addresses,
                         dataset(doxie.layout_references) deg2relDIDs) := FUNCTION

head_shared := all_addresses(newEnough(dt_last_seen div 100) and not ut.isPOBox(prim_name));

//***** APPEND SUBJECT_DT_LAST_SEEN
head_roll2 := join(head_shared,
                  head_shared(subject_dt_last_seen > 0),  //aka subject recs
                  left.prim_range = right.prim_range and
                  left.prim_name = right.prim_name and
                  left.zip = right.zip,
                  transform({head_shared},
                            self.subject_dt_last_seen := right.dt_last_seen,
                            self.isSubject:=true,
                            self := left),
                  left outer,
                  keep(1));

//***** ONLY KEEP ADDRESSES THAT ARE YOUR NEWEST
did_date1 := dedup(sort(head_roll2, did, -dt_last_seen), did);

//***** ENFORCE STRICT DATE FOR 2ND DEGREE RELS
did_date := join(did_date1, deg2relDIDs,
                left.did = right.did,
                transform({did_date1},
                          self.dt_last_seen := if(right.did = 0, left.dt_last_seen, max(did_date1, dt_last_seen)),
                          self := left),
                left outer);

latest_addrs :=
            join(head_roll2, did_date,
                  left.did = right.did and
                  left.dt_last_seen = right.dt_last_seen,
                  transform(contact_addr_rec, self := left));

RETURN latest_addrs;
END;

rank_apt(boolean aptOff, string listing_name) :=
  map(not aptOff => 0,
      aptOff     => map(exists(con.ds_AptWords(STD.STR.Find(listing_name, trim(word), 1) > 0)) => 1,
                        2),
      0);

getGongData(dataset(contact_addr_rec) head_roll_wnei,
            dataset(doxie.layout_references) allDIDs,
            dataset({string lname}) rel_lnames,
            doxie.IDataAccess mod_access) := FUNCTION

//***** FIND GONG BY ADDRESS
fgong := dedup(project(head_roll_wnei, transform(doxie.layout_AppendGongByAddr_input,
                                  self.listing_name := '',
                                  self.phone := '',
                                  self := left)),
                all);

wgong := dedup(doxie.fn_AppendGongByAddr(fgong,mod_access)(phone <> ''), all);

//***** FIND GONG BY DID
didgong := doxie.mod_gong_records(project(allDIDs, doxie.layout_references), mod_access);

//***** ATTACH PHONE TO ADDR
rec.contact_phone_addr_rec_ext tra_pa(head_roll_wnei l, wgong r) := transform

  aptOff := l.sec_range <> '' and r.sec_range = '' and r.phone <> '' and r.fname = '' and r.lname = '';
  lname_match := exists(rel_lnames(lname = r.lname));
  blank_out_phone := l.tnt = 'H' and not aptOff and not lname_match;

  self.phone.phone := 				  if(blank_out_phone, '', r.phone);
  self.phone.feedback :=[];
  self.phone.TimeZone := '';
  self.phone.listing_name :=    if(blank_out_phone, '', r.listing_name);
  self.phone.publish_code :=    if(r.phone = contactCard.constants.str_unlisted, con.str_publish_code_no, con.str_publish_code_yes);
  self.phone.ApartmentOffice := aptOff;
  self.addr := l;
  self.contact := l;
  self.phone.PhoneType := '';
  self.phone.dt_last_seen := l.dt_last_seen;
end;

all_gong_res := join(head_roll_wnei, wgong,
                  left.prim_Range = right.prim_range and
                  left.prim_name = right.prim_name and
                  left.zip = right.zip and
                  (left.sec_range = right.sec_range or
                  (right.sec_range = '' and right.fname = '' and right.lname = '')	or //could be the building and looks like its listed to a business
                    ut.NameMatch(left.fname, left.mname, left.lname, right.fname, right.mname, right.lname) <= 2 or
                    // length(trim(left.lname)) > 1 and STD.STR.Find(right.listing_name,left.lname,1) > 0
                    left.lname = right.lname
                    ),//has a convincing name match
                  tra_pa(left, right),
                  left outer)+		//this left outer is what allows phoneless addresses...may need to go
            join(head_roll_wnei, didgong,
                  left.did = right.did and
                  left.zip = right.z5 and
                  (left.prim_Range = right.prim_range or right.prim_range = '') and
                  (left.prim_name = right.prim_name or right.prim_name = '') and
                  (left.sec_range = right.sec_range or right.sec_range = ''),
                  tra_pa(left, project(right, transform(recordof(wgong),
                                        self.zip := left.z5,
                                        self.listing_name := left.listed_name,
                                        self.fname := left.name_first,
                                        self.mname := left.name_middle,
                                        self.lname := left.name_last,
                                        self.phone := left.phone10,
                                        self := left,
                                        self := []))));


  RETURN all_gong_res;
END;

//***** NEIGHBORS FOR SUBJECT AT MOST RECENT ADDRESS(ES)
getNeighbors(DATASET(contact_addr_rec) subject_addrs, UNSIGNED6 subjectDID,
             doxie.IDataAccess mod_access) := FUNCTION

targetRecs := project(subject_addrs,
                      transform(doxie.layout_nbr_targets,
                                self.seqTarget := COUNTER;
                                self := left
                                ));

mode := 'C';
nbr := choosen(doxie.nbr_records(
  targetRecs,
  mode,

  // attrs declared in doxie.MAC_Selection_Declare
  Max_Neighborhoods,
  Neighbors_PerAddress,
  Neighbors_Per_NA,
  Neighbor_Recency,
  mod_access := mod_access
)(did <> subjectDID), con.max_neighbors);

  all_nbrs :=
   project(nbr, transform(contact_addr_rec,
                        self.subject_dt_last_seen := 0,
                        self.shared_address := '';
                        self.address_seq_no := -1,
                        self.listed_phone := '',
                        self.company_name := '',
                        self.timezone :='',
                        self.listed_timezone :='',
                        self.verified := false,  //hard to compute here with no listed phone
                        self.isSubject :=false,
                          self.dt_vendor_first_reported := 0,
                        self.dt_vendor_last_reported := 0,
                        // self.Feedback:=[],
                        self := left,
                        self := []));

  RETURN all_nbrs;
END;

getWorkPhones(dataset(doxie.layout_references) _dids,
              dataset(rec.pridid_rec) spouseDIDs,
              DATASET(contact_addr_rec) old_shared,
              doxie.IDataAccess mod_access) := FUNCTION

  wphones_chsn1 := choosen(sort(doxie.Fn_PhonesAtWork(_dids+PROJECT(spouseDIDs, doxie.layout_references),
                                  mod_access, con.min_PAWRecencyInDays,con.min_PAWConfidencescore),
                              ut.StringSimilar100(contact.lname, phone.listing_name)),
                        con.max_workphones);

  wphones_chsn := join(wphones_chsn1, old_shared,
                    left.contact.did = right.did and
                    left.addr.prim_range = right.prim_range and
                    left.addr.prim_name = right.prim_name and
                    left.addr.zip = right.zip,
                    transform({wphones_chsn1, contact_addr_rec.shared_address, contact_addr_rec.verified, contact_addr_rec.tnt},
                              self.shared_address := right.shared_address,
                              self.verified := right.verified,
                              self.tnt := right.tnt,
                              self := left),
                    left outer,
                    keep(1));

  work_phones := join(wphones_chsn, spouseDIDs,
            (unsigned6)left.contact.did = right.did,
              transform(rec.rollup_rec2,
                        self.relationship := if(right.did = 0, con.str_Subject, right.relationship);
                        self.relationship_last_seen := right.recent_cohabit,
                        self.priority := con.priority_WorkPhone,
                        self.ReachMe := con.str_ReachMe(con.priority_WorkPhone);
                        self.addr.shared_address := left.shared_address,
                        self.addr.verified := left.verified,
                        self := left,
                        self := []), left outer);

  RETURN work_phones;
END;

getSubjectPhonesPlus(
   DATASET(doxie.layout_references) dids,
   doxie.IDataAccess mod_access) := FUNCTION


//get PP data for input subject only:
ophones :=  moxie_phonesplus_server.phonesplus_did_records(dids,
                      con.max_phonesplus, score_threshold_value, mod_access.glb, mod_access.dppa, con.min_PhonesPlusConfidencescore, true).w_timezoneSeenDt;

ophones_chsn := choosen(sort(dedup(sort(ophones,phoneno,-last_seen),phoneno),-last_seen),con.max_phonesplus);

pp_subject := project(ophones_chsn, transform(rec.rollup_rec2,
                        self.relationship := con.str_Subject;
                        self.priority := con.priority_PhonesPlus,
                        self.ReachMe := con.str_ReachMe(con.priority_PhonesPlus);
                        self.phone.phone := left.phoneno,
                        self.phone.listing_name := left.listed_name,
                        self.phone.publish_code := con.str_publish_code_yes,
                        self.phone.PhoneType := con.str_phonesPlusType,
                        self.phone.dt_last_seen := left.last_seen,
                        self.contact.did := (unsigned6)left.did,
                        self.contact.lname := left.name_last,
                        self.contact.mname := left.name_middle,
                        self.contact.fname := left.name_first,
                        self.addr.city_name := left.city,
                        self.addr.zip := left.z5,
                        self.addr.zip4 := left.z4,
                        self.addr.dt_last_seen := left.last_seen,
                        self.addr.dt_first_seen := left.first_seen,
                        self.addr := left,
                        self := []));

  RETURN pp_subject;
END;


//get Phones+ for RNA separately since GLB restrictions are different for RNA vs. subject
// and we need to skip calculating penalties for relatives,associates,neighbors' dids as they are based on global module input:
getPhonesPlusRNA(
               DATASET(doxie.layout_references) _all_dids,
               DATASET(contact_addr_rec) nbrAddrDIDs,
               doxie.IDataAccess mod_access
               ) := FUNCTION

ophones_rna := moxie_phonesplus_server.phonesplus_did_records(_all_dids,
                              con.max_phonesplus, score_threshold_value, mod_access.glb, mod_access.dppa, con.min_PhonesPlusConfidencescore, false, false, header.constants.checkRNA).w_timezoneSeenDt;

// we will keep only one record per phone/did combination similar to pa_ddp above and upto 10 Phones+ per did
ophones_rna_grpd := group(dedup(sort(ophones_rna,did,phoneno,-last_seen,-first_seen),did,phoneno),did);
ophones_rna_chsn := topn(ophones_rna_grpd,con.max_phonesplus,did,-last_seen,record);

// for neighbors we pull addresses from header, for others from Phones+
// Instead of populating the cell phone address in the neighbors address results, populate the address used to identify person as a neighbor of the subject (based on up to 3-month-old addresses from header).
pplus_rna := join(ungroup(ophones_rna_chsn), nbrAddrDIDs,
(unsigned6)left.did=right.did, transform(rec.contact_phone_addr_rec_ext,
                        self.phone.phone := left.phoneno,
                        self.phone.listing_name := left.listed_name,
                        self.phone.PhoneType := con.str_phonesPlusType,
                        self.phone.publish_code := con.str_publish_code_yes,
                        self.phone.dt_last_seen := left.last_seen,
                        self.contact.did := (unsigned6)left.did,
                        self.contact.lname := left.name_last,
                        self.contact.mname := left.name_middle,
                        self.contact.fname := left.name_first,
                        self.addr.city_name := if(right.did > 0, right.city_name,left.city),
                        self.addr.zip := if(right.did > 0, right.zip,left.z5),
                        self.addr.zip4 := if(right.did > 0, right.zip4,left.z4),
                        self.addr.dt_last_seen := if(right.did > 0, right.dt_last_seen,left.last_seen),
                        self.addr.dt_first_seen := if(right.did > 0, right.dt_first_seen,left.first_seen),
                        self.addr.prim_range := if(right.did > 0, right.prim_range,left.prim_range),
                        self.addr.predir := if(right.did > 0, right.predir,left.predir),
                        self.addr.prim_name := if(right.did > 0, right.prim_name,left.prim_name),
                        self.addr.suffix := if(right.did > 0, right.suffix,left.suffix),
                        self.addr.postdir := if(right.did > 0, right.postdir,left.postdir),
                        self.addr.unit_desig := if(right.did > 0, right.unit_desig,left.unit_desig),
                        self.addr.sec_range := if(right.did > 0, right.sec_range,left.sec_range),
                        self.addr.st := if(right.did > 0, right.st,left.st),
                        self := []),
                        left outer);
  RETURN pplus_rna;
END;

getRelocation(UNSIGNED6 subjectDID) := FUNCTION

  relo_chsn := choosen(Relocations.wdtg.get_gong_by_did(subjectDID,,storeds.targetRadius,storeds.maxDaysBefore,storeds.maxDaysAfter), con.max_Relocation);

  relocation_ph := project(relo_chsn,
              transform(rec.rollup_rec2,
                        self.relationship := con.str_PossibleSubject;
                        self.relationship_last_seen := 0;//right.recent_cohabit,
                        self.priority := con.priority_Relocation,
                        self.ReachMe := con.str_ReachMe(con.priority_Relocation);
                        self.dt_last_seen := (unsigned)left.dt_last_seen,
                        self.contact.did := left.did,
                        self.contact.fname := left.name_first,
                        self.contact.mname := left.name_middle,
                        self.contact.lname := left.name_last,
                        self.addr.dt_last_seen := (unsigned)left.dt_last_seen div 100,
                        self.addr.city_name := left.p_city_name,
                        self.addr.zip := left.z5,
                        self.addr.zip4 := left.z4,
                        self.addr.dt_first_seen := (unsigned)left.dt_first_seen,//
                        self.addr := left,
                        self.phone.phone := left.phone10,
                        self.phone.listing_name := left.listed_name,
                        self.phone.publish_code := con.str_publish_code_yes,
                        self := left,
                        self := []));
  RETURN relocation_ph;
END;


EXPORT FinderRecords(
  dataset(doxie.layout_references) dids,
  doxie.IDataAccess mod_access):=
MODULE

SHARED subjectDIDs := dids;
SHARED subjectDID := max(subjectDIDs, did);

EXPORT SubjectDeathRecords := getSubjectDeceasedData(subjectDID, death_params);


SHARED rel := getRelativesAssociates(dids, mod_access);


//***** GET ALL THE HEADER RECORDS
SHARED relassocdids := project(rel, transform(doxie.layout_references, self.did := left.did));

SHARED old_shared := getSubjectRelAssocAddressHistory(dids + relassocdids, subjectDID, mod_access);

EXPORT head_subject := old_shared(did = subjectDID);

 spouseDIDs 		:=  rel(titleNo in Header.relative_titles.set_Spouse);
 allDIDs_noNeibhors	:= 	dedup(sort(
                              project(subjectDIDs,
                                      transform(rec.pridid_rec,
                                                self.priority := con.priority_subject,
                                                self.relationship := con.str_Subject;
                                                self := left,
                                                self:=[]))
                              + rel,
                              did, priority, depth),
                            did);

 boolean SubjectIsDeceased :=
  exists(SubjectDeathRecords) or
  exists(head_subject(address.isDeathRecord(prim_name)));


// this join removes associates and also relatives beyond depth of 1
 head_lessassoc := join(old_shared, rel(~isRelative or depth > 1),
                      left.did = right.did,
                      transform({string lname}, self.lname := left.lname),
                      left only);

 rel_lnames := dedup(head_lessassoc, all);

deg2relDIDs := PROJECT(rel(isRelative AND depth>1), doxie.layout_references);
//TO DO: change most recent address logic to be based on AddressHierarchy ranking
head_roll := getMostRecentAddresses(old_shared, deg2relDIDs);

subject_recent_addrs := head_roll(did = subjectDID);

//get gong phones for subject and rels/assocs
// TO DO: replace this call with doxie.fn_progressivePhone.byDIDonly() and
// TO DO: add best address to progressive phones results (based on head_roll)
phoneaddr_gong_sra := getGongData(head_roll, SubjectDids+relassocdids, rel_lnames, mod_access);

subjectPhones := dedup(phoneaddr_gong_sra(contact.did = subjectDID and phone.phone <> '' and phone.listing_name <> ''), phone.phone, phone.listing_name, all);


nbr := getNeighbors(subject_recent_addrs, subjectDID, mod_access);

nbrAddrDIDs := 	dedup(sort(nbr, did,-dt_last_seen), did); // keep most recent address to report with PP+ for neighbors
nbrDIDs   	:= 	project(nbrAddrDIDs, doxie.layout_references);
allDIDs		  := 	dedup(sort(
                            allDIDs_noNeibhors +
                            project(nbrDIDs,
                                    transform(rec.pridid_rec,
                                              self.priority := con.priority_neighbor,
                                              self.relationship := con.str_Neighbor,
                                              self := left,
                                              self:=[])),
                            did, priority),
                        did);

// get gong phones for neighbors
phoneaddr_nei := getGongData(nbr, nbrDIDs, rel_lnames, mod_access);

//***** IF YOU ARE A NEIGHBOR, MAKE SURE YOU ARE NOT MATCHED UP WITH THE SUBJECT'S HOME PHONE (APT)
phoneaddr_gong_nei :=
          join(phoneaddr_nei, subjectPhones,
              left.contact.did in set(nbrDIDs, did) and
              left.phone.phone = right.phone.phone and
              left.phone.listing_name = right.phone.listing_name,
              transform(rec.contact_phone_addr_rec_ext,
                        self.phone.phone 					:= if(right.phone.phone <> '', '', 		left.phone.phone),
                        self.phone.listing_name 		:= if(right.phone.phone <> '', '', 		left.phone.listing_name),
                        self.phone.apartmentoffice := if(right.phone.phone <> '', false, left.phone.apartmentoffice),
                        self := left),
              left outer);

//TO DO: keep only neighbors gong phones here
phoneaddr_cln := phoneaddr_gong_sra + phoneaddr_gong_nei;

//***** KEEP ONE ADDRESS FOR EACH DID/PHONE COMBO	(HAS ADDED BENEFIT OF ALLOWING ONLY ONE PHONELESS ADDRESS PER PERSON)
pa_gong_ddp := ungroup(dedup(sort(group(sort(phoneaddr_cln, contact.did, phone.phone),
                                  contact.did, phone.phone),
                            if(length(trim(phone.phone)) = 10, 0, 1), doxie.tnt_score(addr.tnt), -addr.dt_last_seen
                            // add criteria to pick listing name matching contact and also to make sort deterministic
                          //  ,rank_apt(phone.apartmentoffice,phone.listing_name), ut.StringSimilar100(phone.listing_name, contact.lname), ut.StringSimilar100(phone.listing_name, contact.fname), record
                       ), true));

// these are our all gong phones (for subject/rels/assoc/neighbors)
// TO DO: combine neighbors gong phones here with new progressive phones for subject/rels/assoc
pa_srt := dedup(sort(pa_gong_ddp, contact.did, if(length(trim(phone.phone)) = 10, 0, 1), doxie.tnt_score(addr.tnt), -addr.dt_last_seen, rank_apt(phone.apartmentoffice,phone.listing_name), ut.StringSimilar100(phone.listing_name, contact.lname), ut.StringSimilar100(phone.listing_name, contact.fname)),
                contact.did, keep(storeds.PhonesPerPerson));


boolean NoVerifiedHomeAddresses := not exists(pa_srt(addr.verified and contact.did = subjectDID));

//***** RELO PHONES
rph := if(con.IncludeRelocation and NoVerifiedHomeAddresses and not SubjectIsDeceased,
          getRelocation(subjectDID));

//***** WORK PHONES
wph := IF(not SubjectIsDeceased, getWorkPhones(dids, spouseDIDs, old_shared, mod_access));

checkRNA := header.constants.checkRNA;

//***** PHONES +
ipp := Include_PhonesPlus_val;
ipprna := storeds.IncludePhonesPlus_for_RNA;

// this PP is rels/assoc/neigb
//TO DO: eliminate rels/assoc from this call, keep neighbors only
rna_lexids := relassocdids + nbrDIDs;
oph_rna := IF(ipprna, getPhonesPlusRNA(rna_lexids, nbrAddrDIDs, mod_access));

// this PP is only for subject
// TO DO: eliminate this call  (phones for subject/rels/assoc will come from doxie.fn_progressivePhone.byDIDonly())
oph := if(ipp, getSubjectPhonesPlus(dids, mod_access));

// TO DO:  possibly treat ipp and ipprna options to filter progressive phones based on phone type - landline vs wireless?

//***** POPULATE PRIORITY AND REACHME
// per new req.1.2.6 PPlus data for rels/asoc/neigb need to be combined within each section with gong phones(pa_srt):
pa_pp := pa_srt + if(ipprna,oph_rna);

pa_r := join(pa_pp, allDIDs,								//ALLDIDS MAY LOSE SOME OF THE RELATIVES HERE, BUT I BELEIVE THEY ARE BETTER LEFT OUT
            left.contact.did = right.did,
                transform(rec.rollup_rec2,
                          self.priority := right.priority,
                          self.reachme := con.str_ReachMe(right.priority),
                          self.relationship := if(right.did = 0, con.str_Subject, right.relationship),
                          self.relationship_type := right.type,
                          self.relationship_confidence := right.confidence,
                          self.relationship_last_seen :=  right.recent_cohabit,
                          self.depth := right.depth,
                          self := left,
                          self := []
                ));

//***** ADD BEST NAME AND THROW OUT ONE IF TWO ASSOCIATES WITH SAME NAME
rna_dppa_ok := mod_access.isValidDPPA(checkRNA);
rna_glb_ok :=mod_access.isValidGLB(checkRNA);
_glb_ok  := mod_access.isValidGLB ();
_dppa_ok := mod_access.isValidDPPA ();

rna_dids := alldids(did != subjectDID);
doxie.mac_best_records(rna_dids, did, rnabest, rna_dppa_ok, rna_glb_ok, false, mod_access.DataRestrictionMask)
doxie.mac_best_records(SubjectDids, did, sbest, _dppa_ok, _glb_ok, false, mod_access.DataRestrictionMask)
fbest := rnabest + sbest;

//TO DO: remove oph from here when progressive phones are added
wb2 := join(pa_r + oph + wph + rph, fbest,
          left.contact.did = right.did,
          transform(rec.rollup_rec2,
                          self.contact.fname := if(right.did > 0 and right.fname <> '', right.fname, left.contact.fname),
                          self.contact.mname := if(right.did > 0, 											 right.mname, left.contact.mname),
                          self.contact.lname := if(right.did > 0 and right.lname <> '', right.lname, left.contact.lname),
                          self := left),
          left outer);
wb1 := dedup(wb2, relationship, contact.fname, contact.lname, contact.company_name, phone.phone, addr.prim_name, addr.prim_Range, addr.zip, all);

//***** IF SUBJECT LOST (E.G. ONLY HAS POBOX ADDRESS), THEN ADD BACK WITH BEST
wb := if(exists(join(wb1, dids, left.contact.did = right.did)),
        wb1,
        wb1 +
        join(dids, fbest,
              left.did = right.did,
              transform(rec.rollup_rec2,
                        self.priority := con.priority_subject,
                        self.reachme := con.str_ReachMe(con.priority_subject),
                        self.relationship := con.str_subject,
                        self.contact := right,
                        self.addr := right,
                        self := [])));

ut.getTimeZone(wb,phone.phone,phone.timezone,wb_w_tzone)
ut.getTimeZone(wb_w_tzone,addr.phone,addr.timezone,wb_w_tzone2)
ut.getTimeZone(wb_w_tzone2,addr.listed_phone,addr.listed_timezone,wb_w_tzones)

//***** SORT AND ROLLUP
fr_srt_w_tzone := sort(wb_w_tzones(priority <= con.priority_subject or priority = con.priority_WorkPhone or phone.phone <> '' or storeds.IncludeNonSubjectPhonelessAddresses),
              addr.prim_range, addr.prim_name, addr.zip,
              -if(priority in con.set_restricted_for_rollup, 10 + priority, priority), //push them to the bottom, so "thru family" may merge into "at home", etc.
              contact.did,
              if(length(trim(phone.phone)) = 10, 0, 1), if(phone.phonetype='',0,1), doxie.tnt_score(addr.tnt), -addr.dt_last_seen, rank_apt(phone.apartmentoffice,phone.listing_name), ut.StringSimilar100(phone.listing_name, contact.lname), ut.StringSimilar100(phone.listing_name, contact.fname)
              );

fr_pop := project(fr_srt_w_tzone,
      transform(rec.rollup_rec_ext,
      self.try := project(left,
      transform(rec.addr_phones_contacts_rec_ext,
        self.whotoaskfor := project(left,
          transform(rec.contact_relat_rec,
          self.dt_last_seen := left.addr.dt_last_seen,
          self := left)),
          self.addr_phones := project(left,
            transform(rec.addr_phones_rec_ext,
              self.addr := left.addr,
              self.phones := project(left,
              transform(rec.phone_rec_ext,
                self := left.phone
                )))))),
                  self := left));


//****** FIRST GET ALL THE ADDRESSES TOGETHER
rec.rollup_rec_ext rollem2(rec.rollup_rec_ext l, rec.rollup_rec_ext r) := transform
  self.try := choosen(l.try &  r.try, con.max_try);
  self := r;
end;

rlld2 := rollup(fr_pop,
                left.addr.prim_range = right.addr.prim_range and
                left.addr.prim_name = right.addr.prim_name and
                left.addr.zip = right.addr.zip and
                if(left.priority in con.set_restricted_for_rollup or right.priority in con.set_restricted_for_rollup, //if one is a neighbor, then both must be
                  left.priority = right.priority,
                  true),
                rollem2(left, right));

//****** THEN ROLLUP THE PHONES AND NAMES UNDER THE ADDRESS
PhonesPerAddr := if (ipprna,con.max_TotalPhonesPerAddr,con.max_PhonesPerAddr); // PhonesPlus are in addition to gong phones, so we need to increase the total number of phones per address
rec.rollup_rec_ext FOR_rollem3(rec.rollup_rec_ext l) := transform
  self.try := rollup(l.try,
                      transform(rec.addr_phones_contacts_rec_ext,
                                self.addr_phones.addr.dt_last_seen := if(right.addr_phones.addr.dt_last_seen > left.addr_phones.addr.dt_last_seen, right.addr_phones.addr.dt_last_seen, left.addr_phones.addr.dt_last_seen),
                                self.addr_phones.addr.dt_first_seen := if(right.addr_phones.addr.dt_first_seen < left.addr_phones.addr.dt_first_seen and right.addr_phones.addr.dt_first_seen != 0, right.addr_phones.addr.dt_first_seen, left.addr_phones.addr.dt_first_seen),
                                self.addr_phones.addr := left.addr_phones.addr,
                                self.addr_phones.phones := choosen(sort(dedup(sort(left.addr_phones.phones + right.addr_phones.phones,phonetype,phone,-dt_last_seen),phonetype,phone)(phone <> ''),phonetype,-dt_last_seen), PhonesPerAddr),
                                self.whotoaskfor := choosen(sort(dedup(sort(left.whotoaskfor + right.whotoaskfor, contact.did, contact.company_name, -dt_last_seen), contact.did, contact.company_name),depth,contact.did, contact.company_name), con.max_WhoToAskFor)),
                    true);
  self := l;
end;

rlld3 := project(rlld2, FOR_rollem3(left));
//****** THEN ROLLUP INTO EACH PRIORITY
rlld4 := rollup(sort(rlld3, priority), rollem2(left, right), priority);

//****** THEN DO SOME LAST MINUTE SORTING
srtd_tmp := project(rlld4,
                transform(rec.rollup_rec2,
                          self.try := if (left.priority = con.priority_relative,
                                          sort(project(left.try,
                                                  transform(rec.addr_phones_contacts_rec,
                                                            self.whotoaskfor := sort(left.whotoaskfor, depth,-if(relationship = con.str_subject, 999999, dt_last_seen), Person_Models.title_rank(relationship)),
                                                            self.addr_phones.phones := project(sort(left.addr_phones.phones, phonetype,-dt_last_seen, rank_apt(apartmentOffice, listing_name)),rec.phone_rec),
                                                            self := left)),
                                          min(whotoaskfor,depth),-addr_phones.addr.dt_last_seen, max(whotoaskfor, Person_Models.title_rank(relationship)), record),

                                          sort(project(left.try,
                                                  transform(rec.addr_phones_contacts_rec,
                                                            self.whotoaskfor := sort(left.whotoaskfor, -if(relationship = con.str_subject, 999999, dt_last_seen), Person_Models.title_rank(relationship),depth),
                                                            self.addr_phones.phones := project(sort(left.addr_phones.phones, phonetype,-dt_last_seen, rank_apt(apartmentOffice, listing_name)),rec.phone_rec),
                                                            self := left)),
                                          -addr_phones.addr.dt_last_seen, max(whotoaskfor, Person_Models.title_rank(relationship)), record)),
                          self := left));


rec_tmp_layout:=record
rec.phone_rec,
unsigned6 DID,
end;
rec_tmp_layout Add_Feedback_ds (rec.phone_rec le):=transform
self:=le;
self.did:=subjectdid;
end;

rec.addr_phones_rec xform3 (rec.addr_phones_rec le) := transform

new_phoneRec:= project(le.phones,Add_Feedback_ds(LEFT));

PhonesFeedback_Services.Mac_Append_Feedback(new_phoneRec,DID,Phone,Phone_fb,mod_access);

rec.phone_rec Format_ds (Phone_fb le):=transform
  self:=le;
end;
new_phoneRec_fb:= project(Phone_fb,Format_ds(LEFT));
// self.PhoneRecs:=if(IncludePhonesFeedback,PhoneRecs_fb,new_phoneRec);

self.phones:=if(IncludePhonesFeedback,new_phoneRec_fb,le.phones);
self:=le;
end;

rec.addr_phones_contacts_rec xform2(rec.addr_phones_contacts_rec le):=transform
self.addr_phones:=project(le.addr_phones,xform3(LEFT));
self:=le;
end;

rec.rollup_rec2 xform1(srtd_tmp le):=transform
self.try:=if(le.ReachMe=Con.str_ReachMeSubject,project(le.try,xform2(LEFT)),le.try);
self:=le;
end;

srtd:=project(srtd_tmp,xform1(Left));

srtd2 := project(srtd, transform(rec.rollup_rec2,
  self.try := project(left.try, transform(rec.addr_phones_contacts_rec,
    self.whoToAskFor := project(left.whoToAskFor, transform(rec.contact_relat_rec,
      did := left.contact.did;
      self := left;
    ));
    self := left;
  ));
  self := left;
));


//****** DEBUG

// output(head, named('head'), all);
// output(head_lessassoc, named('head_lessassoc'), all);
// output(head_shared, named('head_shared'));
// output(head_roll_wnei, named('head_roll_wnei'));
// output(did_date, named('did_date'));
// output(deg2relDIDs, named('deg2relDIDs'));
// output(allDIDs_noNeibhors, named('allDIDs_noNeibhors'));
// output(allDIDs, named('allDIDs'));
// output(head_roll, named('head_roll'));
// output(targetRecs, named('TargetRecs'));
// output(nbr, named('nbr'));
// output(fgong, named('fgong'));
// output(wgong, named('wgong'));
// output(didgong, named('didgong'));
// output(phoneaddr, all, named('phoneaddr'));
// output(subjectPhones, all, named('subjectPhones'));
// output(phoneaddr_cln, all, named('phoneaddr_cln'));
// output(pa_gong_ddp, named('pa_gong_ddp'));
// output(pa_srt, named('pa_srt'));
// output(pa_p, named('pa_p'));
// output(pa_r, named('pa_r'));
// output(pa_r1, named('pa_r1'));
// output(pa_r2, named('pa_r2'));

// output(wb2, named('wb2'));
// output(wb1, named('wb1'));
// output(wb, named('wb'));
// output(fr_pop, named('fr_pop'));

// output(rel_lnames, named('rel_lnames'));
// output(rel_det, named('rel_det'));
// output(ophones_chsn, named('ophones_chsn'));
// output(wphones_chsn, named('wphones_chsn'));
// output(relo_chsn, named('relo_chsn'));
//output(oph, named('oph'));
// output(wph, named('wph'));
// output(rph, named('rph'));
// output(allrel, named('allrel'));
// output(rel, named('rel'));

// output(rlld2, named('rlld2'));
// output(rlld3, named('rlld3'));
// output(rlld4, named('rlld4'));
// output(srtd, named('srtd'));

// output(head_subject, named('head_subject'));


export results := srtd2;

END;
