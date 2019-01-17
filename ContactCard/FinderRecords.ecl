import person_models,moxie_phonesplus_server,doxie_raw,header,Relocations,doxie,address,PhonesFeedback_Services,
       PhonesFeedback,AutoStandardI,DeathV2_Services,suppress, ContactCard, std;

deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());

doxie.MAC_Header_Field_Declare(); // dial_contactprecision_value, score_threshold_value, glb_ok, dppa_ok
mod_access := doxie.compliance.GetGlobalDataAccessModule ();

doxie.MAC_Selection_Declare();

con := ContactCard.constants;
rec := ContactCard.layouts;
storeds := ContactCard.storeds;

export FinderRecords( 
	dataset(doxie.layout_references) dids
	):= 
MODULE

shared subjectDIDs 	:= 	dids;
shared subjectDID 		:= 	max(subjectDIDs, did);

shared newEnough(unsigned2 yr) := yr + con.max_AgeOfData >= (unsigned2)(((STRING)Std.Date.Today())[1..4]);

//***** GET THE RELATIVES 
//	depth is input to service and defaults to 1 by #stored('RelativeDepth',con.default_RelativeDepth) in ContactCard.ReportService,
//	so we can have depth beyond 1 in allrel
shared allrel := Doxie_Raw.relative_raw(dids, mod_access,
                                              true, true,
                                              Relative_Depth, max_relatives);

// rel is the group that i will actually consider relatives in the final output
// there are some refs to allrel because we use them to figure out some of the relationships						
// note that depth>1 is allowed if newEnough 
shared rel := allrel(depth=1 or newEnough((unsigned2)(((STRING)recent_cohabit)[1..4])));

// this just removes the deceased
shared relassocdids := join(rel, doxie.key_death_masterv2_ssa_did,
														keyed(left.person2 = right.l_did)
														and not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
														transform(doxie.layout_references, self.did := left.person2),
														left only);


//***** GET ALL THE HEADER RECORDS

shared csa := doxie.Comp_Subject_Addresses(dids + relassocdids, , dial_contactprecision_value, , mod_access);

shared head_nopull := csa.raw;


	
//***** PULL IDS
Suppress.MAC_Suppress(head_nopull,head_pull1,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
Suppress.MAC_Suppress(head_pull1,head_pull2,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,ssn);

rna_IN := head_pull2(did<>subjectDID);
header.MAC_GLB_DPPA_Clean_RNA(rna_in,head_pull2_rna,mod_access);

export head := head_pull2_rna + head_pull2(did = subjectDID);

//***** DETAILED RELS
// this join removes associates and also relatives beyond depth of 1
shared head_lessassoc := join(head, rel(~isRelative or depth > 1), 
											 left.did = right.person2, 
											 transform(doxie_raw.Layout_HeaderRawOutput, self := left),
											 left only);

export rel_det := choosen(project(rel(isRelative and depth = 1),
                                 transform({doxie_Raw.Layout_RelativeRawOutput,doxie.layout_references,string20 title},
																            self.did:=left.person2,
																						self.title:=Header.relative_titles.fn_get_str_title(left.titleNo),
																						self:=left)), 
																	con.max_relatives);
shared rel_lnames := dedup(project(head_lessassoc, {head_lessassoc.lname}), all);

shared alldids_rec := record
doxie.layout_references;
rel.rel_prim_range;
rel.recent_cohabit;
rel.depth;
rel.titleno;
rel.type;
rel.confidence;
end;

//***** DID SETS
shared AssocDIDs 		:= 	choosen(sort(dedup(project(rel(~isRelative, number_cohabits >= con.min_number_cohabits), transform(alldids_rec, self.did := left.person2, self := left)), all),-recent_cohabit), con.max_associates);
shared deg2relDIDs 	:= 	choosen(sort(dedup(project(rel(depth > 1, isRelative, number_cohabits >= con.min_number_cohabits), transform(alldids_rec, self.did := left.person2, self := left)), all),depth,-recent_cohabit), con.max_relatives);
shared relDIDs   		:= 	dedup(project(rel_det, alldids_rec), all);
shared spouseDIDs 		:=  project(rel_det(titleNo in Header.relative_titles.set_Spouse), doxie.layout_references);
shared allDIDs_noNeibhors	:= 	dedup(sort(project(subjectDIDs, transform(rec.pridid_rec, self.priority := con.priority_subject, 		self := left)) +
																 project(AssocDIDs, 	transform(rec.pridid_rec, self.priority := con.priority_associate, 	self := left)) +
																 project(deg2relDIDs, transform(rec.pridid_rec, self.priority := con.priority_relative, 	self := left)) +
																 project(relDIDs, 		transform(rec.pridid_rec, self.priority := con.priority_relative, 	self := left)),
																 did, priority), 
														did);

//***** SEE IF DECEASED
export SubjectDeathRecords := sort(choosen(doxie.key_death_masterv2_ssa_did(keyed(l_did = subjectDID) and not DeathV2_Services.Functions.Restricted(src, glb_flag, glb_ok, deathparams)),con.max_subject),-dod8);
shared boolean SubjectIsDeceased := 
	exists(SubjectDeathRecords) or
	exists(head(did = subjectDID and address.isDeathRecord(prim_name)));
	

//***** PREPARE HEADER FOR GONG APPEND
shared head_slim := sort(join(head, 
											 allDIDs_noNeibhors,
											 left.did = right.did, 
											 transform({rec.contact_rec, rec.addr_rec}, 
																 self.subject_dt_last_seen := if(right.priority = con.priority_subject, left.dt_last_seen, 0),  //mark subject recs so i can use them to populate subject_dt_last_seen in next join
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

shared old_shared := join(head_roll1, dedup(shared_addrs, prim_name, prim_range, zip, all),
													 left.prim_name=right.prim_name and
													 left.prim_range = right.prim_range and
													 left.zip = right.zip,
													 transform({head_roll1}, 
																			self.shared_address := if(right.zip <> '', 'S',''),
																			self := left),
													 left outer);

export head_subject := old_shared(did = subjectDID);
head_shared := old_shared(newEnough(dt_last_seen div 100) and not ut.isPOBox(prim_name));
							 
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

head_roll := 
						 join(head_roll2, did_date,
									left.did = right.did and
									left.dt_last_seen = right.dt_last_seen,
									transform({head_shared}, self := left));


//***** NEIGHBORS FOR SUBJECT AT MOST RECENT ADDRESS(ES)
targetRecs := project(head_roll(did = subjectDID),				
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

nbrAddrDIDs := 	dedup(sort(nbr, did,-dt_last_seen), did);
nbrDIDs   	:= 	project(nbrAddrDIDs, doxie.layout_references);
allDIDs		  := 	dedup(sort(
														 allDIDs_noNeibhors +
														 project(nbrDIDs, 		transform(rec.pridid_rec, self.priority := con.priority_neighbor, 	self := left)),
														 did, priority), 
											  did);

head_roll_wnei := 
	head_roll + 
	project(nbr, transform({head_shared},
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
												 
//***** FIND GONG BY ADDRESS
fgong := dedup(project(head_roll_wnei, transform(doxie.layout_AppendGongByAddr_input,
																	self.listing_name := '',
																	self.phone := '',
																	self := left)),
							  all);
											
wgong := dedup(doxie.fn_AppendGongByAddr(fgong)(phone <> ''), all);

//***** FIND GONG BY DID
didgong := doxie.mod_gong_records(project(allDIDs, doxie.layout_references));

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

phoneaddr := join(head_roll_wnei, wgong,
									left.prim_Range = right.prim_range and
									left.prim_name = right.prim_name and
									left.zip = right.zip and
									(left.sec_range = right.sec_range or
									 (right.sec_range = '' and right.fname = '' and right.lname = '')	or //could be the building and looks like its listed to a business
										ut.NameMatch(left.fname, left.mname, left.lname, right.fname, right.mname, right.lname) <= 2 or
										// length(trim(left.lname)) > 1 and stringlib.stringfind(right.listing_name,left.lname,1) > 0
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

//***** IF YOU ARE A NEIGHBOR, MAKE SURE YOU ARE NOT MATCHED UP WITH THE SUBJECT'S HOME PHONE (APT)
subjectPhones := dedup(phoneaddr(contact.did = subjectDID and phone.phone <> '' and phone.listing_name <> ''), phone.phone, phone.listing_name, all);

phoneaddr_cln := 
					join(phoneaddr, subjectPhones,
							 left.contact.did in set(nbrDIDs, did) and
							 left.phone.phone = right.phone.phone and 
							 left.phone.listing_name = right.phone.listing_name,
							 transform(rec.contact_phone_addr_rec_ext,
												 self.phone.phone 					:= if(right.phone.phone <> '', '', 		left.phone.phone),
												 self.phone.listing_name 		:= if(right.phone.phone <> '', '', 		left.phone.listing_name),
												 self.phone.apartmentoffice := if(right.phone.phone <> '', false, left.phone.apartmentoffice),
												 self := left),
							 left outer);


//***** KEEP ONE ADDRESS FOR EACH DID/PHONE COMBO	(HAS ADDED BENEFIT OF ALLOWING ONLY ONE PHONELESS ADDRESS PER PERSON)				
pa_ddp := ungroup(dedup(sort(group(sort(phoneaddr_cln, contact.did, phone.phone), 
													         contact.did, phone.phone),
														 if(length(trim(phone.phone)) = 10, 0, 1), doxie.tnt_score(addr.tnt), -addr.dt_last_seen),
												true));

//***** KEEP storeds.PHONESPERPERSON PHONES PER PERSON	
rank_apt(boolean aptOff,typeof(wgong.listing_name) listing_name) :=
	map(not aptOff => 0,
			aptOff     => map(exists(con.ds_AptWords(stringlib.StringFind(listing_name, trim(word), 1) > 0)) => 1,
												2),
			0);

pa_srt := dedup(sort(pa_ddp, contact.did, if(length(trim(phone.phone)) = 10, 0, 1), doxie.tnt_score(addr.tnt), -addr.dt_last_seen, rank_apt(phone.apartmentoffice,phone.listing_name), ut.StringSimilar100(phone.listing_name, contact.lname), ut.StringSimilar100(phone.listing_name, contact.fname)),
								 contact.did, keep(storeds.PhonesPerPerson));


boolean NoVerifiedHomeAddresses := not exists(pa_srt(addr.verified and contact.did = subjectDID));

//***** PHONES + 
checkRNA := header.constants.checkRNA;
ipp := Include_PhonesPlus_val;
ipprna := storeds.IncludePhonesPlus_for_RNA;

//get PP data for input subject only:
ophones := if(ipp, moxie_phonesplus_server.phonesplus_did_records(dids(ipp),
                       con.max_phonesplus, score_threshold_value, mod_access.glb, mod_access.dppa, con.min_PhonesPlusConfidencescore, true).w_timezoneSeenDt);

ophones_chsn := choosen(sort(dedup(sort(ophones,phoneno,-last_seen),phoneno),-last_seen),con.max_phonesplus);

//get Phones+ for RNA separately since GLB restrictions are different for RNA vs. subject 
// and we need to skip calculating penalties for relatives,associates,neighbors' dids as they are based on global module input:
ophones_rna := if(ipprna, moxie_phonesplus_server.phonesplus_did_records(project(allDIDs(did<>subjectDID),doxie.layout_references)(ipprna),
                               con.max_phonesplus, score_threshold_value, mod_access.glb, mod_access.dppa, con.min_PhonesPlusConfidencescore, false, false, checkRNA).w_timezoneSeenDt);

// we will keep only one record per phone/did combination similar to pa_ddp above and upto 10 Phones+ per did
ophones_rna_grpd := group(dedup(sort(ophones_rna,did,phoneno,-last_seen,-first_seen),did,phoneno),did);
ophones_rna_chsn := topn(ophones_rna_grpd,con.max_phonesplus,did,-last_seen,record);

// for neighbors we pull addresses from header, for others from Phones+
// Instead of populating the cell phone address in the neighbors address results, populate the address used to identify person as a neighbor of the subject (based on up to 3-month-old addresses from header).
oph_rna := join(ungroup(ophones_rna_chsn),nbrAddrDIDs, (unsigned6)left.did=right.did, transform(rec.contact_phone_addr_rec_ext, 
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

// per new req.1.2.6 PPlus data for rels/asoc/neigb need to be combined within each section with gong phones(pa_srt):
pa_pp := pa_srt + if(ipprna,oph_rna);

//***** WORK PHONES
wphones_chsn1 := choosen(sort(doxie.Fn_PhonesAtWork((dids+spouseDIDs)(not SubjectIsDeceased),
                                  mod_access.date_threshold, mod_access.dppa, mod_access.glb, con.min_PAWRecencyInDays,con.min_PAWConfidencescore), 
															ut.StringSimilar100(contact.lname, phone.listing_name)),
												con.max_workphones);

wphones_chsn := join(wphones_chsn1,head_roll2, 
										 left.contact.did = right.did and
										 left.addr.prim_range = right.prim_range and
										 left.addr.prim_name = right.prim_name and
										 left.addr.zip = right.zip,
										 transform({wphones_chsn1, head_roll2.shared_address, head_roll2.verified, head_roll.tnt},
															 self.shared_address := right.shared_address,
															 self.verified := right.verified,
															 self.tnt := right.tnt,
															 self := left),
										 left outer,
										 keep(1));

//***** RELO PHONES
relo_chsn := if(con.IncludeRelocation and NoVerifiedHomeAddresses and not SubjectIsDeceased, 
							  choosen(Relocations.wdtg.get_gong_by_did(subjectDID,,storeds.targetRadius,storeds.maxDaysBefore,storeds.maxDaysAfter), con.max_Relocation));


//***** POPULATE PRIORITY AND REACHME	
pa_p := join(pa_pp, allDIDs,								//ALLDIDS MAY LOSE SOME OF THE RELATIVES HERE, BUT I BELEIVE THEY ARE BETTER LEFT OUT
						 left.contact.did = right.did,
								transform(rec.rollup_rec2,
													self.priority := right.priority,
													self.reachme := con.str_ReachMe(right.priority),
													self := left,
													self := []
								));

//***** POPULATE RELATIONSHIP FOR RELS AND ASSOCIATES

pa_r2 := join(pa_P, AssocDIDs,
						 left.contact.did = right.did,
								transform(rec.rollup_rec2,
													self.relationship := if(right.did = 0, if(left.relationship <> '', left.relationship, con.str_Subject), con.str_Associate +
														if(right.titleno=Header.relative_titles.num_transactionalAssociate,'',' ' + header.translateRelativePrimrange(right.rel_prim_range))),
													self.relationship_type := right.type,
													self.relationship_confidence := right.confidence,
													self.relationship_last_seen := if(right.did = 0, left.relationship_last_seen, right.recent_cohabit),
													self.depth := if(right.did = 0, left.depth,right.depth),
													self := left
								), left outer);

pa_r3 := join(pa_r2, rel(isRelative),
						 left.contact.did = right.person2,
								transform(rec.rollup_rec2,
													self.relationship := if(right.person2 = 0, left.relationship, if(right.titleNo <> 0, Header.relative_titles.fn_get_str_title(right.titleNo), con.str_Relative)),
													self.relationship_type := if(right.person2 = 0, left.relationship_type, right.type),
													self.relationship_confidence := if(right.person2 = 0, left.relationship_confidence, right.confidence),
													self.relationship_last_seen := if(right.person2 = 0, left.relationship_last_seen, right.recent_cohabit),
													self.depth := if(right.person2 = 0, left.depth,right.depth),
													self := left
								), left outer);

pa_r := join(pa_r3, nbrDIDs,
						 left.contact.did = right.did,
								transform(rec.rollup_rec2,
													self.relationship := if(right.did = 0, left.relationship, con.str_Neighbor),
													self := left
								), left outer);

// this PP is only for subject
oph := project(ophones_chsn, transform(rec.rollup_rec2, 
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
						 
wph := join(wphones_chsn, dedup(rel_det, did, all),
						(unsigned6)left.contact.did = right.did,
							 transform(rec.rollup_rec2, 
												 self.relationship := if(right.did = 0, con.str_Subject, Header.relative_titles.fn_get_str_title(right.titleNo));
												 self.relationship_last_seen := right.recent_cohabit,
												 self.priority := con.priority_WorkPhone,
												 self.ReachMe := con.str_ReachMe(con.priority_WorkPhone);
												 self.addr.shared_address := left.shared_address,
												 self.addr.verified := left.verified,
												 self := left,
												 self := []), left outer);

rph := project(relo_chsn, 
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
//***** ADD BEST NAME AND THROW OUT ONE IF TWO ASSOCIATES WITH SAME NAME
rna_dppa_ok := mod_access.isValidDPPA(checkRNA);
rna_glb_ok :=mod_access.isValidGLB(checkRNA);
rna_dids := alldids(did != subjectDID);
doxie.mac_best_records(rna_dids, did, rnabest, rna_dppa_ok, rna_glb_ok, false, doxie.DataRestriction.fixed_DRM)
doxie.mac_best_records(SubjectDids, did, sbest, dppa_ok, glb_ok, false, doxie.DataRestriction.fixed_DRM)
fbest := rnabest + sbest;
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

PhonesFeedback_Services.Mac_Append_Feedback(new_phoneRec
																						,DID
																						,Phone
																						,Phone_fb
																						);

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
// output(pa_ddp, named('pa_ddp'));
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


