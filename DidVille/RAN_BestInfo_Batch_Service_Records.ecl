IMPORT didville, Doxie, Doxie_Raw, header, NID, STD, EmailV2_Services,ProfileBooster,DeathV2_Services;

EXPORT RAN_BestInfo_Batch_Service_Records(DATASET(DidVille.Layout_RAN_BestInfo_BatchIn) f_in_raw = DATASET([],DidVille.Layout_RAN_BestInfo_BatchIn),
                                          boolean CompareInputAddrWithRel = false,
                                          boolean CompareInputAddrNameWithRel = false,
                                          boolean UseBlankPhoneNumberRecords = false,
                                          unsigned4 PbRelativesCount = 0,
                                          unsigned4 PbAssociatesCount = 0,
                                          unsigned4 PbNeighborsCount = 0
                                           ) := FUNCTION

  //get input
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ());

  doxie.MAC_Selection_Declare()

  boolean exclude_relatives := false	: stored('ExcludeRelatives');
  boolean exclude_associates := false : stored('ExcludeAssociates');
  boolean exclude_input_nbrs := false : stored('ExcludeInputAddrNeighbors');
  boolean exclude_update_nbrs := false : stored('ExcludeUpdateAddrNeighbors');
  boolean suppress_same_address := false : stored('SuppressSameAddress');
  boolean suppress_same_phone := false : stored('SuppressSamePhone');
  boolean dedup_with_same_phone := false : stored('DedupRelativesAssociatesOnPhone');
  unsigned relatives_depth := 2 : stored('RelativesDepth');
  boolean IncludeProfileBooster := false : stored('IncludeProfileBooster'); // profilebooster option - to populate profile booster fields or not
  boolean DirectMarketingUser := mod_access.isDirectMarketing();
  checkRNA := header.constants.checkRNA;
  death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
  //convert to standard input layout


  Didville.Layouts.in_seq_rec get_seq(f_in_raw l, unsigned cnt) := transform
    self.seq := cnt;
    self.ssn := STD.Str.FilterOut(l.ssn, '-');
    self.phone10 := l.phoneno;
    self.title := '';
    self.fname := l.name_first;
    self.mname := l.name_middle;
    self.lname := l.name_last;
    self.suffix := l.name_suffix;
    self.addr_suffix := l.suffix;
    self.zip4 := l.z4;
    self := l;
  end;

  f_in_seq := project(f_in_raw, get_seq(left, counter));
  f_in_ready := project(f_in_seq(did=0), didville.Layout_Did_OutBatch);

  /* Split the input count restriction for profile booster attributes for neighbors among the two neighbors datasets - nbr_in and nbr_best.
     1) if profile booster count for neighbors less than 3 - count restriction only for nbr_best
     2) if profile booster count for neighbors more than 3 and even - split equally between datasets
     3) if profile booster count for neighbors more than 3 and odd - nbr_best gets higher weightage in split */

  unsigned4 PB_nbr_in_cnt := if(PbNeighborsCount > 3, if(PbNeighborsCount % 2 = 0, PbNeighborsCount / 2,
                                                                PbNeighborsCount - 3), 0);
  unsigned4 PB_nbr_best_cnt := PbNeighborsCount - PB_nbr_in_cnt;

  /* Use the data provided by the customer to first find a DID for each record. Exclude any dids
     whose score is less than 75.
  */
  //append did to the input subjs
  didville.MAC_DidAppend(f_in_ready, f_with_did_raw, true, 'true');

  f_with_did := project(f_with_did_raw, transform({f_with_did_raw}, self.did:=if(left.score>=75, left.did, 0), self:=left))+
    project(f_in_seq(did>0),transform({f_with_did_raw},self.score:=100, self:=left, self:=[]));

  /* Get the subject Best Address by did. Join against Watchdog GLB and non-GLB keys. If the
     customer has sufficient GLB permissions, retain the records from the Watchdog GLB key. If
     not, retain those from the non-GLB key.
  */
  //find nbrs - get subj best address
  subj_best_rec := record
    unsigned4 seq;
    doxie.layout_best;
  end;

  dppaOk := mod_access.isValidDPPA(checkRNA);
  glbOk := mod_access.isValidGLB(checkRNA);
  fixed_DRM := mod_access.DataRestrictionMask;



  doxie.mac_best_records(f_with_did,
                         did,
                         outfile,
                         dppaOk,
                         glbOk,
                         ,
                         fixed_DRM,
                         marketing := DirectMarketingUser,
                         include_dod := true);

  subj_best_rec get_subj_best(f_with_did l, outfile r) := transform
    self.seq := l.seq;
    self.did := l.did;
    self := r;
    self := [];
  end;

  f_subj_best := join(f_with_did, outfile,
                      left.did = right.did,
                    get_subj_best(left, right), left outer, keep(1));

  /* Find Neighbors for the search subject based on the input address (not on the Best address
     information!). Return the top 3 Neighbors, i.e. closest addresses by distance.
  */
  //find nbrs - for input address, init
  doxie.layout_nbr_targets  get_nbr_in_init(f_with_did l) := transform
    self.seqTarget := l.seq;
    self.zip := l.z5;
    self.suffix := l.addr_suffix;
    self := l;
    self := [];
  end;

  f_in_nbr_init := group(project(f_with_did, get_nbr_in_init(left)));

  //find nbrs - for input address, pick top 3
  f_in_nbrs_raw := doxie.nbr_records(f_in_nbr_init,
                'C',
                Max_Neighborhoods,
                Neighbors_PerAddress,
                Neighbors_Per_NA,
                Neighbor_Recency,
                false, false,,,
                mod_access);


  Didville.Layouts.nbr_with_rank_rec get_nbr_in_rank(f_in_nbrs_raw l, unsigned cnt) := transform
    self.nbr_rank := cnt;
    self := l;
    self := [];
  end;

  f_in_nbrs_rank := project(f_in_nbrs_raw, get_nbr_in_rank(left, counter));

  /* Append phone numbers to each Neighbor.
  */
  didville.Mac_RAN_phone_append(f_in_nbrs_rank, f_in_nbrs_app, checkRNA ,mod_access);

  f_in_nbrs_dep := dedup(sort(f_in_nbrs_app(phone<>''),
                              seqTarget, prim_name, prim_range, zip, sec_range, nbr_rank),
             seqTarget, prim_name, prim_range, zip, sec_range);

  f_in_nbrs_ready := group(sort(f_in_nbrs_dep, seqTarget, nbr_rank),seqTarget);

  f_in_nbrs_wo_death := TopN(f_in_nbrs_ready, 3, nbr_rank);

  f_in_nbrs_death := dx_death_master.Append.byDid(f_in_nbrs_wo_death,did,death_params);

   Didville.Layouts.nbr_with_rank_rec get_nbr_in_dod(f_in_nbrs_death l) := transform
    self.dod := l.death.dod8;
    self := l;
    self := [];
  end;

  f_in_nbrs_PB_in := TopN(f_in_nbrs_wo_death, PB_nbr_in_cnt, nbr_rank); // profile booster input restriction for nbrs_in


  /* Find Neighbors for the search subject based on the Best address information. Return
     the top 3 Neighbors, i.e. closest addresses by distance.
  */
  //find nbrs - for best address, init
  doxie.layout_nbr_targets  get_nbr_best_init(f_subj_best l) := transform
    self.seqTarget := l.seq;
    self.dt_last_seen := l.addr_dt_last_seen;
    self := l;
    self := [];
  end;

  f_best_nbr_init := group(project(f_subj_best, get_nbr_best_init(left)));

  //find nbrs - for best address, pick top 3
  f_best_nbrs_raw := doxie.nbr_records(f_best_nbr_init,
                'C',
                Max_Neighborhoods,
                Neighbors_PerAddress,
                Neighbors_Per_NA,
                Neighbor_Recency,
                false, false,,,
                mod_access);

  Didville.Layouts.nbr_with_rank_rec get_nbr_best_rank(f_best_nbrs_raw l, unsigned cnt) := transform
    self.nbr_rank := cnt;
    self := l;
    self := [];
  end;

  f_best_nbrs_rank := project(f_best_nbrs_raw, get_nbr_best_rank(left, counter));

  /* Append phone numbers to each Neighbor.
  */
  didville.Mac_RAN_phone_append(f_best_nbrs_rank, f_best_nbrs_app, checkRNA, mod_access);

  f_best_nbrs_dep := dedup(sort(f_best_nbrs_app(phone<>''),
                                seqTarget, prim_name, prim_range, zip, sec_range, nbr_rank),
               seqTarget, prim_name, prim_range, zip, sec_range);

  f_best_nbrs_ready := group(sort(f_best_nbrs_dep, seqTarget, nbr_rank),seqTarget);

  f_best_nbrs_wo_death := TopN(f_best_nbrs_ready, 3, nbr_rank);

  f_best_nbrs_death := dx_death_master.Append.byDid(f_best_nbrs_wo_death,did,death_params);

  f_best_nbrs := project(f_best_nbrs_death, get_nbr_in_dod(left));

  f_best_nbrs_PB_in := TopN(f_best_nbrs_wo_death, PB_nbr_best_cnt, nbr_rank); // profile booster input restriction for nbrs_best

  // Remove duplicate entries from input neighbors and best record neighbors
  f_in_nbrs_w_dup := project(f_in_nbrs_death, get_nbr_in_dod(left));

  f_in_nbrs := join(f_in_nbrs_w_dup,f_best_nbrs,
                    left.seqTarget = right.seqTarget AND left.did = right.did,
                    Transform(LEFT), LEFT ONLY);

  /* Get Relatives and Roommates (Associates). That is, get the identities of everyone who
     lives in the same dwelling as the search subject. A Roommate differs from a Relative
     only in that a Relative is related in some way to the search subject. Describe a
     Relative's relationship to the search subject by his/her relationship title.
  */
  //get relatives and roomies - init
  doxie_Raw.Layout_RelativeRawBatchInput get_rel(f_with_did l, unsigned cnt) := transform
    self.input.seq := l.seq;
    self.input.did := l.did;
    self.seq := cnt;
    self := [];
  end;

  f_rel_ready := group(project(f_with_did, get_rel(left, counter)),seq);

  incl_relatives := true;
  incl_associates := true;
  // we'd need just up to 10 relatives and associates each, but it's safer to pre-fetch some more
  // to allow choosing the "best" ten later. 100 is arbitrary number; almost always it will cover
  // all 1st degree relatives (assuming 1st degree is "better" than other degrees by definition)
  f_rel_raw := doxie_raw.relative_raw_batch(f_rel_ready, mod_access, relatives_depth, incl_relatives,incl_associates,100,200);

  f_rel_out_init := sort(ungroup(f_rel_raw),
												 input.seq, depth, p2_sort, p3_sort, p4_sort);

  //get relatives and roomies - rank as well as translate titleNo to text


  Didville.Layouts.rel_with_rank_rec get_rel_rank(doxie_Raw.Layout_RelativeRawBatchInput l, unsigned cnt) := transform
    self.rel_rank := cnt;
    self.relationship :=
          IF( l.titleNo <> 0, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(l.TitleNo)
                                                  + IF(l.TitleNo = Header.relative_titles.num_associate,' '+Header.translateRelativePrimrange(l.rel_prim_range),'')),
                              IF(l.isRelative = FALSE, STD.Str.CleanSpaces(Header.relative_titles.fn_get_str_title(Header.relative_titles.num_associate) + ' ' + Header.translateRelativePrimrange(l.rel_prim_range)),
                                                      Header.relative_titles.fn_get_str_title(Header.relative_titles.num_relative))
          );
    self := l;
    self := [];
  end;

  f_rel_out := project(f_rel_out_init, get_rel_rank(left, counter)); // *** HAS REL_PRIM_RANGE ***

  /* Although we do a better job of identifying relationships among household members--by
     specifying whether they are a spouse, child, sibling, parent or grandparent
     --at this point we still use a very
     simple rule that requires someone to have the same last name to be considered a Relative.
  */
  IsRel := f_rel_out.isRelative and f_rel_out.rel_prim_range  <> -1;	//keep out rels by ssn
  IsRoommie := not f_rel_out.isRelative;

  f_rel_for_best := (f_rel_out(IsRel))(person2<>0);

  Didville.Layouts.rel_with_rank_rec get_non_rel(Didville.Layouts.rel_with_rank_rec l) := transform
    self := l;
  end;

  f_roommie_for_best := join(f_rel_out(IsRoommie), f_rel_for_best,
                             left.person2 = right.person2, get_non_rel(left), left only)(person2<>0);

  /* Pick top ten Relatives. Retrieve Best Address and Phones information for each of them.
  */
  //get relatives - pick top 10
  doxie.mac_best_records(f_rel_for_best,
                          person2,
                          f_rel_best,
                          dppaOk,
                          glbOk,
                          ,
                          mod_access.DataRestrictionMask,
                          marketing := DirectMarketingUser,
                          include_dod :=true);

  f_rel_best_valid := f_rel_best(prim_name <> '' or phone<>'');
  f_rel_best_valid_to_use := if(UseBlankPhoneNumberRecords, f_rel_best(prim_name <> ''), f_rel_best_valid);
  f_rel_best_dep := dedup(sort(f_rel_best_valid_to_use, NID.PreferredFirstNew(fname), lname, prim_name, -sec_range, zip, phone),
                               NID.PreferredFirstNew(fname), lname, prim_name, zip, phone);

  Didville.Layouts.best_with_rank_rec get_back_rel_rank(Didville.Layouts.rel_with_rank_rec l, f_rel_best_dep r) := transform
    self.rel_rank := l.rel_rank;
    self.seqTarget := l.input.seq;
    self.depth := l.depth;
    self.relationship := l.relationship;
    self.relationship_type := l.type;
    self.relationship_confidence := l.confidence;
    self := r;
  end;

  f_rel_best_final_ready := join(f_rel_for_best, f_rel_best_dep,
                                 left.person2 = right.did,
                                 get_back_rel_rank(left, right), left outer, keep(1))(lname<>'' and prim_name<>'');

  didville.Mac_RAN_phone_append(f_rel_best_final_ready, f_rel_best_final_app_raw, checkRNA, mod_access);
  f_rel_best_final_app_flted := f_rel_best_final_app_raw(phone<>'');
  f_rel_best_final_app_to_use := if(UseBlankPhoneNumberRecords, f_rel_best_final_app_raw, f_rel_best_final_app_flted);
  f_rel_best_final_app := if(dedup_with_same_phone,
                             dedup(sort(f_rel_best_final_app_to_use, seqTarget, phone, rel_rank), seqTarget, phone),
                             f_rel_best_final_app_to_use);

  //check against input address, phones
  Didville.Layouts.best_with_rank_rec check_input(f_rel_best_final_app l) := transform
    self := l;
  end;

  f_rel_best_final_addr_ckd := if(suppress_same_address,
                                  join(f_rel_best_final_app, f_in_seq,
                                      left.seqTarget = right.seq and
                    left.prim_name = right.prim_name and
                    left.prim_range = right.prim_range and
                    left.zip = right.z5,
                    check_input(left), left only),
                f_rel_best_final_app);

  f_rel_best_final_phone_ckd := if(suppress_same_phone,
                                   join(f_rel_best_final_addr_ckd, f_in_seq,
                                        left.seqTarget = right.seq and
                      left.phone in [right.phone10,  right.phoneno_1,
                                  right.phoneno_2, right.phoneno_3,
                         right.phoneno_4, right.phoneno_5,
                         right.phoneno_6, right.phoneno_7,
                         right.phoneno_8, right.phoneno_9,
                         right.phoneno_10, right.phoneno_11],
                   check_input(left), left only),
                 f_rel_best_final_addr_ckd);

  f_rel_best_final_phone_ckd_toUse := if(UseBlankPhoneNumberRecords, f_rel_best_final_phone_ckd, f_rel_best_final_phone_ckd(phone<>''));
  f_rel_best_final_grp := group(sort(f_rel_best_final_phone_ckd_toUse, seqTarget, rel_rank), seqTarget);

  f_rel_best_final :=	topN(f_rel_best_final_grp, 10, rel_rank);

  f_rel_PB_in := topN(f_rel_best_final, PbRelativesCount, rel_rank); // profile booster input restriction for relatives

  /* Pick top ten Roommates. Retrieve Best Address and Phones information for each of them.
  */
  //get roomies - pick top 10

  doxie.mac_best_records(f_roommie_for_best,
                          person2,
                          f_roommie_best,
                          dppaOk,
                          glbOk,
                          ,
                          fixed_DRM,
                          marketing := DirectMarketingUser,
                          include_dod := true);

  f_roommie_best_valid := f_roommie_best(prim_name <> '' or phone<>'');
  f_roommie_best_dep := dedup(sort(f_roommie_best_valid, NID.PreferredFirstNew(fname), lname, prim_name, -sec_range, zip, phone),
                              NID.PreferredFirstNew(fname), lname, prim_name, zip, phone);

  f_roomie_best_final_ready := join(f_roommie_for_best, f_roommie_best_dep,
                                    left.person2 = right.did,
                                    get_back_rel_rank(left, right), left outer, keep(1))(lname<>'' and prim_name<>'');

  didville.Mac_RAN_phone_append(f_roomie_best_final_ready, f_roomie_best_final_app_raw, checkRNA, mod_access);
  f_roomie_best_final_app_flted := f_roomie_best_final_app_raw(phone<>'');
  f_roomie_best_final_app := if(dedup_with_same_phone,
                                dedup(sort(f_roomie_best_final_app_flted, seqTarget, phone, rel_rank), seqTarget, phone),
                                f_roomie_best_final_app_flted);

  //check against input address, phones
  f_roomie_best_final_addr_ckd := if(suppress_same_address,
                                     join(f_roomie_best_final_app, f_in_seq,
                                          left.seqTarget = right.seq and
                        left.prim_name = right.prim_name and
                        left.prim_range = right.prim_range and
                        left.zip = right.z5,
                        check_input(left), left only),
                   f_roomie_best_final_app);

  f_roomie_best_final_phone_ckd := if(suppress_same_phone,
                                      join(f_roomie_best_final_addr_ckd, f_in_seq,
                                           left.seqTarget = right.seq and
                         left.phone in [right.phone10,  right.phoneno_1,
                                     right.phoneno_2, right.phoneno_3,
                            right.phoneno_4, right.phoneno_5,
                            right.phoneno_6, right.phoneno_7,
                            right.phoneno_8, right.phoneno_9,
                            right.phoneno_10, right.phoneno_11],
                   check_input(left), left only),
                    f_roomie_best_final_addr_ckd);

  f_roomie_best_final_grp := group(sort(f_roomie_best_final_phone_ckd(phone<>''), seqTarget, rel_rank), seqTarget);

  f_roomie_best_final :=	topN(f_roomie_best_final_grp, 10, rel_rank);

  f_roomie_PB_in := topN(f_roomie_best_final, PbAssociatesCount, rel_rank); // profile booster input restriction for associates

  //generate output - initialize

  Didville.Layouts.out_with_seq_rec init_out(f_in_seq l) := transform
    self.phoneno := l.phone10;
    self.name_first := l.fname;
    self.name_middle := l.mname;
    self.name_last := l.lname;
    self.name_suffix := l.suffix;
    self.suffix := l.addr_suffix;
    self.z4 := l.zip4;
    self.RelAssocNeigh_Flag :='N';
    self := l;
    self := [];
  end;

  f_out_init := project(f_in_seq, init_out(left));

  // Input options for email address append service
  email_inmod := MODULE(Project(mod_access,EmailV2_Services.IParams.EmailParams, OPT))
    Export CheckEmailDeliverable := False;
    Export MaxResultsPerAcct := 1;
    Export IncludeAdditionalInfo := False;
    Export RequireLexidMatch := True;
    Export RestrictedUseCase := EmailV2_Services.Constants.RestrictedUseCase.NoRoyaltySources;
  END;

  // call EmailAddressAppendSearch to get email address for relatives
  rel_email_in := Project(Ungroup(f_rel_best_final),Transform(EmailV2_Services.Layouts.batch_in_rec,SELF.Did := LEFT.did, SELF :=[]));
  roomie_email_in := Project(Ungroup(f_roomie_best_final),Transform(EmailV2_Services.Layouts.batch_in_rec,SELF.Did := LEFT.did, SELF :=[]));
	nbr_in_email_in := Project(Ungroup(f_in_nbrs),Transform(EmailV2_Services.Layouts.batch_in_rec,SELF.Did := LEFT.did, SELF :=[]));
	nbr_best_email_in := Project(Ungroup(f_best_nbrs),Transform(EmailV2_Services.Layouts.batch_in_rec,SELF.Did := LEFT.did, SELF :=[]));

	email_in := rel_email_in + roomie_email_in + nbr_in_email_in + nbr_best_email_in;
	dedup_email_in := Dedup(email_in,Did);
	dedup_email_wseq := Project(dedup_email_in,Transform(EmailV2_Services.Layouts.batch_in_rec, SELF.acctno := (String) COUNTER, SELF := LEFT, SELF :=[]));
	email_out := EmailV2_Services.EmailAddressAppendSearch(dedup_email_wseq,email_inmod);

  Didville.Layouts.best_with_email_profile_rec get_out_rel_w_email(f_rel_best_final l,EmailV2_Services.Layouts.email_final_rec r) := TRANSFORM
      self.email :=  R.cleaned.clean_email;
      self := l;
      self := [];
  END;

  f_rel_best_w_email := Join(f_rel_best_final,
                                  email_out.records,
                                  left.did = right.did,
                                  get_out_rel_w_email(Left,Right), LEFT OUTER, Keep(1), Limit(0));


	PB_in_rec:= ProfileBooster.Layouts.Layout_PB_In;

  rel_profile_in := If(Exists(f_rel_PB_in),Didville.Transforms.FMac_profile_input(ungroup(f_rel_PB_in)),Dataset([],PB_in_rec));
	roomie_profile_in := If(Exists(f_roomie_PB_in),Didville.Transforms.FMac_profile_input(ungroup(f_roomie_PB_in)),Dataset([],PB_in_rec));
	nbr_in_profile_in := If(Exists(f_in_nbrs_PB_in),Didville.Transforms.FMac_profile_input(ungroup(f_in_nbrs_PB_in)),Dataset([],PB_in_rec));
	nbr_best_profile_in := If(Exists(f_best_nbrs_PB_in),Didville.Transforms.FMac_profile_input(ungroup(f_best_nbrs_PB_in)),Dataset([],PB_in_rec));

  // check on IncludeProfileBooster to create final input PII or else pass empty dataset to avoid performance hit from profile booster
  profile_in := IF(IncludeProfileBooster,rel_profile_in + roomie_profile_in  + nbr_in_profile_in + nbr_best_profile_in,Dataset([],PB_in_rec));
  dedup_profile_in := dedup(profile_in,Record);
  //add hash of fields to account number in the input dataset
  dedup_profile_wacct := Project(dedup_profile_in,DidVille.Transforms.Profile_acct(LEFT,COUNTER));

  profile_out := IF(IncludeProfileBooster,ProfileBooster.Search_Function(dedup_profile_wacct,mod_access.DataRestrictionMask,
                                                    mod_access.DataPermissionMask,'PBATTRV1'));

  ProfileBooster.Layouts.Layout_PB_BatchOut get_final_profile(PB_in_rec l, ProfileBooster.Layouts.Layout_PB_BatchOut r):= TRANSFORM
    SELF.Acctno := l.acctno;
    SELF := R;
  END;

  final_profile_out := Join(dedup_profile_wacct, profile_out, Left.seq = right.seq,get_final_profile(LEFT,RIGHT));

  // add profile booster attributes to relatives and associates
  Didville.Layouts.best_with_email_profile_rec get_out_rel_w_profile(Didville.Layouts.best_with_email_profile_rec l,ProfileBooster.Layouts.Layout_PB_BatchOut r) := TRANSFORM
    SELF.donotmail := R.attributes.version1.donotmail;
    SELF.ProspectAge := R.attributes.version1.ProspectAge;
    SELF.ProspectGender := R.attributes.version1.ProspectGender;
    SELF.ProspectMaritalStatus := R.attributes.version1.ProspectMaritalStatus;
    SELF.ProspectEstimatedIncomeRange := R.attributes.version1.ProspectEstimatedIncomeRange;
    SELF.ProspectCollegeAttended := R.attributes.version1.ProspectCollegeAttended;
    SELF.CrtRecCnt := R.attributes.version1.CrtRecCnt;
    SELF.CrtRecLienJudgCnt := R.attributes.version1.CrtRecLienJudgCnt;
    SELF.CrtRecBkrptCnt := R.attributes.version1.CrtRecBkrptCnt;
    SELF.OccProfLicense := R.attributes.version1.OccProfLicense;
    SELF.OccProfLicenseCategory := R.attributes.version1.OccProfLicenseCategory;
    SELF.OccBusinessAssociation := R.attributes.version1.OccBusinessAssociation;
    SELF.OccBusinessTitleLeadership := R.attributes.version1.OccBusinessTitleLeadership;
    SELF.HHEstimatedIncomeRange := R.attributes.version1.HHEstimatedIncomeRange;
    SELF.RaAMmbrCnt := R.attributes.version1.RaAMmbrCnt;
    SELF.RaAMedIncomeRange := R.attributes.version1.RaAMedIncomeRange;
    SELF.RaACollegeAttendedMmbrCnt := R.attributes.version1.RaACollegeAttendedMmbrCnt;
    SELF.RaACrtRecMmbrCnt := R.attributes.version1.RaACrtRecMmbrCnt;
    SELF.RaAOccBusinessAssocMmbrCnt := R.attributes.version1.RaAOccBusinessAssocMmbrCnt;
    self := l;
    self := [];
  END;

  //Final dataset with email and profile booster fields appended to top 10 relatives
  f_rel_best_w_email_profile := if(IncludeProfileBooster,Sort(Join(f_rel_best_w_email,final_profile_out,
                                                                    (String30)Hash64(left.did,left.fname,left.mname,left.lname,left.name_suffix,
                                                                    left.ssn,(String)left.dob,left.prim_range,left.predir,left.prim_name,left.suffix,
                                                                    left.postdir,left.unit_desig,left.city_name,left.st,left.zip) = right.Acctno,
                                                                    get_out_rel_w_profile(LEFT,RIGHT), LEFT OUTER),
                                                                    seqTarget,rel_rank),
                                  Sort(f_rel_best_w_email,seqTarget,rel_rank));



  f_out_with_rel := if(exclude_relatives, f_out_init,
                       denormalize(f_out_init, f_rel_best_w_email_profile,
                                left.seq = right.seqTarget,
                                Didville.Transforms.get_out_rel(left, right,CompareInputAddrWithRel,CompareInputAddrNameWithRel,counter)));

  // call EmailAddressAppendSearch to get email address for associates
  f_roomie_best_w_email := Join(f_roomie_best_final,
                                  email_out.records,
                                  left.did = right.did,
                                  get_out_rel_w_email(Left,Right), LEFT OUTER, Keep(1),Limit(0));



  //Final dataset with email and profile booster fields appended to top 10 associates
  f_roomie_best_w_email_profile := if(IncludeProfileBooster,Sort(Join(f_roomie_best_w_email,final_profile_out,
                                                                    (String30)Hash64(left.did,left.fname,left.mname,left.lname,left.name_suffix,
                                                                    left.ssn,(String)left.dob,left.prim_range,left.predir,left.prim_name,left.suffix,
                                                                    left.postdir,left.unit_desig,left.city_name,left.st,left.zip) = right.Acctno,
                                                                    get_out_rel_w_profile(LEFT,RIGHT), LEFT OUTER),
                                                                    seqTarget,rel_rank),
                                      Sort(f_roomie_best_w_email,seqTarget,rel_rank));


  f_out_with_roomie := if(exclude_associates, f_out_with_rel,
                          denormalize(f_out_with_rel, f_roomie_best_w_email_profile,
                                      left.seq = right.seqTarget,
                                      Didville.Transforms.get_out_roomie(left, right,counter)));

  // Email Address Append search input for neighbors

  Didville.Layouts.nbr_with_email_profile_rec get_out_nbr_w_email(Didville.Layouts.nbr_with_rank_rec l,EmailV2_Services.Layouts.email_final_rec r) := TRANSFORM
      self.email := R.cleaned.clean_email;
      self := l;
      self := [];
  END;

  f_nbr_in_w_email := Join(f_in_nbrs,
                                  email_out.records,
                                  left.did = right.did,
                                  get_out_nbr_w_email(Left,Right), LEFT OUTER, Keep(1),Limit(0));


  // add profile booster attributes to relatives and associates
  Didville.Layouts.nbr_with_email_profile_rec get_out_nbr_w_profile(Didville.Layouts.nbr_with_email_profile_rec l,ProfileBooster.Layouts.Layout_PB_BatchOut r) := TRANSFORM
    SELF.donotmail := R.attributes.version1.donotmail;
    SELF.ProspectAge := R.attributes.version1.ProspectAge;
    SELF.ProspectGender := R.attributes.version1.ProspectGender;
    SELF.ProspectMaritalStatus := R.attributes.version1.ProspectMaritalStatus;
    SELF.ProspectEstimatedIncomeRange := R.attributes.version1.ProspectEstimatedIncomeRange;
    SELF.ProspectCollegeAttended := R.attributes.version1.ProspectCollegeAttended;
    SELF.CrtRecCnt := R.attributes.version1.CrtRecCnt;
    SELF.CrtRecLienJudgCnt := R.attributes.version1.CrtRecLienJudgCnt;
    SELF.CrtRecBkrptCnt := R.attributes.version1.CrtRecBkrptCnt;
    SELF.OccProfLicense := R.attributes.version1.OccProfLicense;
    SELF.OccProfLicenseCategory := R.attributes.version1.OccProfLicenseCategory;
    SELF.OccBusinessAssociation := R.attributes.version1.OccBusinessAssociation;
    SELF.OccBusinessTitleLeadership := R.attributes.version1.OccBusinessTitleLeadership;
    SELF.HHEstimatedIncomeRange := R.attributes.version1.HHEstimatedIncomeRange;
    SELF.RaAMmbrCnt := R.attributes.version1.RaAMmbrCnt;
    SELF.RaAMedIncomeRange := R.attributes.version1.RaAMedIncomeRange;
    SELF.RaACollegeAttendedMmbrCnt := R.attributes.version1.RaACollegeAttendedMmbrCnt;
    SELF.RaACrtRecMmbrCnt := R.attributes.version1.RaACrtRecMmbrCnt;
    SELF.RaAOccBusinessAssocMmbrCnt := R.attributes.version1.RaAOccBusinessAssocMmbrCnt;
    self := l;
    self := [];
  END;

  //Final dataset with email and profile booster fields appended to top 3 neighbors
  f_nbr_in_w_email_profile := if(IncludeProfileBooster,Sort(Join(f_nbr_in_w_email,final_profile_out,
                                                                    (String30)Hash64(left.did,left.fname,left.mname,left.lname,left.name_suffix,
                                                                    left.ssn,(String)left.dob,left.prim_range,left.predir,left.prim_name,left.suffix,
                                                                    left.postdir,left.unit_desig,left.city_name,left.st,left.zip) = right.Acctno,
                                                                    get_out_nbr_w_profile(LEFT,RIGHT), LEFT OUTER),
                                                                    seqTarget,nbr_rank),
                                      Sort(f_nbr_in_w_email,seqTarget,nbr_rank));


  f_out_with_nbr_in := if(exclude_input_nbrs,f_out_with_roomie,
                          denormalize(f_out_with_roomie, f_nbr_in_w_email_profile,
                                      left.seq = right.seqTarget,
                                      Didville.Transforms.get_out_nbr_in(left, right,counter)));


  f_nbr_best_w_email := Join(f_best_nbrs,
                                  email_out.records,
                                  left.did = right.did,
                                  get_out_nbr_w_email(Left,Right), LEFT OUTER,Keep(1),Limit(0));


  //Final dataset with email and profile booster fields appended to top 3 neighbors-best
  f_nbr_best_w_email_profile := if(IncludeProfileBooster,Sort(Join(f_nbr_best_w_email,final_profile_out,
                                                                    (String30)Hash64(left.did,left.fname,left.mname,left.lname,left.name_suffix,
                                                                    left.ssn,(String)left.dob,left.prim_range,left.predir,left.prim_name,left.suffix,
                                                                    left.postdir,left.unit_desig,left.city_name,left.st,left.zip) = right.Acctno,
                                                                    get_out_nbr_w_profile(LEFT,RIGHT), LEFT OUTER),
                                                                    seqTarget,nbr_rank),
                                      Sort(f_nbr_best_w_email,seqTarget,nbr_rank));


  f_out_final := if(exclude_update_nbrs,f_out_with_nbr_in,
                    denormalize(f_out_with_nbr_in, f_nbr_best_w_email_profile,
                                left.seq = right.seqTarget,
                                Didville.Transforms.get_out_nbr_best(left, right,counter)));


  RETURN f_out_final;

END;