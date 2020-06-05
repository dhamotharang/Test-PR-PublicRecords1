IMPORT doxie, iesp, ut, dx_Gong, CriminalRecords_Services, Suppress;

export transform_neighbors(dataset(doxie.layout_nbr_records) neighbors,
  Doxie.IDataAccess mod_access,
  boolean phone_filter=false,
  boolean includeCriminalIndicators=false,
  boolean location_report=false
):= FUNCTION

  doxie.MAC_Header_Field_Declare(); //only score_threshold_value!

  integer max_nbr_phones := if(location_report, iesp.Constants.BR.MaxAddress_Phones, 1);
  nbr_phone_layout:=record
    doxie.layout_nbr_records;
    iesp.share.t_PhoneInfo;
    unsigned4 ph_dt_last_seen;
    unsigned seq_order;
    string listed_phone;
    boolean hasCriminalConviction;
    boolean isSexualOffender;
  end;

  nbr_phone_layout_optout := RECORD
    nbr_phone_layout;
    unsigned6 key_did;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;
  // Set neighbors' addresses in appropriate format
  iesp.bpsreport.t_BpsReportIdentitySlim UnfoldResidents (nbr_phone_layout L) := transform
    // EXPORT iesp.share.t_SSNInfo SetSSNInfo (string ssn, string valid, string location,
                                            // iesp.share.t_Date issuedStart, iesp.share.t_Date issuedEnd) := function

    self.uniqueid:=intformat (L.did, 12, 1);
    self.Name:=iesp.ECL2ESP.SetName (l.fname,l.mname,l.lname,l.name_suffix,'');
    self.Gender:='';
    blank_date := row ({'', '', ''}, iesp.share.t_Date);
    Self.SSNInfo := iesp.ECL2ESP.SetSSNInfo (L.ssn, if (l.valid_ssn='G', 'YES', 'NO'), '',
                         blank_date, blank_date);
    Self.SSNInfoEx := iesp.ECL2ESP.SetSSNInfoEx (L.ssn, if (l.valid_ssn='G', 'YES', 'NO'), '',
                         blank_date, blank_date);
    Self.DOB := iesp.ECL2ESP.toDate (L.dob);
    // Self.Age := 0;
    // self.dod := [];
    // self.AgeAtDeath := 0;
    // self.DeathCounty := '';
    // self.DeathState := '';
    // self.DeathVerificationCode := '';
    self.hasCriminalConviction:=l.hasCriminalConviction;
    self.isSexualOffender:=l.isSexualOffender;
    self:=[];

  end;

  iesp.share.t_PhoneInfoEx GetPhone (nbr_phone_layout L):=transform
    self.Phone10 :=l.phone10;
    self.PubNonpub:=l.PubNonpub;
    self.ListingPhone10:=l.ListingPhone10;
    self.ListingName:=l.ListingName;
    self.TimeZone :=l.TimeZone;
    self.ListingTimeZone:=l.ListingTimeZone;
    self:=[];
  END;


  iesp.bpsreport.t_NeighborAddressSlim SetNeighborsAddresses (nbr_phone_layout L, dataset (nbr_phone_layout) R) := transform

    Self.Address := project (l, transform (iesp.share.t_AddressEx,
                    self.StreetName := Left.prim_name,
                    self.StreetNumber := LEFT.prim_range ,
                    self.StreetPreDirection := LEFT.predir ,
                    self.StreetPostDirection := LEFT.postdir ,
                    self.StreetSuffix := LEFT.suffix ,
                    self.UnitDesignation := LEFT.unit_desig ,
                    self.UnitNumber := LEFT.sec_range ,
                    self.StreetAddress1 := '' ,
                    self.StreetAddress2 := '' ,
                    self.State := LEFT.st ,
                    self.City := LEFT.city_name ,
                    self.Zip5 := LEFT.zip ,
                    self.Zip4 := LEFT.zip4 ,
                    self.County := LEFT.county_name ,
                    self.PostalCode := '' ,
                    self.StateCityZip:= '' ,
                    self.HighRiskIndicators := []));
    phones0 := sort(r, seq_order, -ph_dt_last_seen);
    phones_loc := sort(r((integer)phone10<>0), -ph_dt_last_seen, seq_order); //for LocationReport we care more about the dt_last_seen of phones
    phones := if(location_report, phones_loc, phones0);
    Self.Phones := dedup(sort(project(choosen(phones,max_nbr_phones),GetPhone(LEFT)),phone10),phone10);
    Self.LocationID := '';
    self.Verified := if(l.tnt='V',true,false);
    self.DateLastSeen:= iesp.ECL2ESP.toDateYM(max(r,dt_last_seen));//[];
    self.DateFirstSeen:=iesp.ECL2ESP.toDateYM(min(r,dt_first_seen));//[];
    residents0 := sort(r,if(ut.isNamePart (ListingName, trim (lname),false), if(ut.isNamePart (ListingName, trim (fname),false),0,1),2),-dt_last_seen);
    residents_loc := dedup(sort(r, did, -dt_last_seen), did); //for LocationReport we need to dedup by did as there are name repeats due to returning multiple phones
    residents := if(location_report, residents_loc, residents0);
    Self.Residents := choosen(project (residents, UnfoldResidents (Left)),iesp.Constants.BR.Neigbors_Residents);
    self._Shared:=false;
    Self := l;
  end;

  tmp_nbr_layout:=record
    doxie.layout_nbr_records;
    string listed_phone;
    boolean hasCriminalConviction := false;
    boolean isSexualOffender := false;
    string12 UniqueId;
  end;
  nbr_addr:=project(neighbors, transform(doxie.Layout_Comp_Addresses,self.address_seq_no := left.seqnpa,self:=left,self:=[]));
  nbr_addr_ver_nofil:=Doxie.fn_addLVV(nbr_addr).records_wListedPhone;

  nbr_addr_ver_fil:=nbr_addr_ver_nofil((unsigned)listed_phone<>0);

  nbr_addr_ver:=if(phone_filter,nbr_addr_ver_fil,nbr_addr_ver_nofil);

  // add crim indicators
  recsIn := PROJECT(neighbors,TRANSFORM(tmp_nbr_layout,SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[]));
  CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
  neighbors_crim_ind := IF(includeCriminalIndicators,recsOut,recsIn);

  p_neighbors:=join(neighbors_crim_ind,nbr_addr_ver,
                    left.seqnpa=right.address_seq_no,
                    transform(tmp_nbr_layout,
                    self.tnt:=right.tnt,
                    self.listed_phone:=right.listed_phone,
                    self:=left));

  nbr:=project(p_neighbors,transform(nbr_phone_layout,self:=left,self:=[]));

  gong_key:=dx_Gong.key_history_phone();

  nbr_phone_layout_optout addgong (nbr l, gong_key r):=transform
    self.Phone10 := r.phone10;
    self.PubNonpub := r.publish_code;
    self.ListingPhone10 :='';
    self.ListingName := r.listed_name;
    self.TimeZone :='';
    self.ListingTimeZone:='';
    self.ph_dt_last_seen:=(unsigned) r.dt_last_seen;
    self.seq_order := if(l.lname=r.name_last,1,2);
    self.key_did := r.did;
    self.record_sid := r.record_sid;
    self.global_sid := r.global_sid;
    self:=l;
  end;

  pre_nbr_Phone_tmp0:=join(nbr, gong_key,
                      keyed(left.listed_phone[4..10] = right.p7) and
                      keyed(left.listed_phone[1..3] = right.p3) and
                      keyed(left.st = right.st) and
                      right.current_flag,
                      addgong(left, right),
                      limit(ut.limits.DEFAULT),keep(iesp.Constants.BR.MaxAddress_Phones),left outer);

  nbr_Phone_tmp0_optout := Suppress.MAC_FlagSuppressedSource(pre_nbr_Phone_tmp0, mod_access, key_did);

  nbr_Phone_tmp0 := PROJECT(nbr_Phone_tmp0_optout, TRANSFORM(nbr_phone_layout,
    self.Phone10 :=IF(LEFT.is_suppressed, '', LEFT.phone10);
    self.PubNonpub := IF(LEFT.is_suppressed, '', LEFT.PubNonpub);
    self.ListingName := IF(LEFT.is_suppressed, '', LEFT.ListingName);
    self.ph_dt_last_seen:= IF(LEFT.is_suppressed, 0, LEFT.ph_dt_last_seen);
    self.seq_order :=if(LEFT.is_suppressed, 2, LEFT.seq_order);
    self := LEFT;
  ));

  //If didn't find Phones by EDA, use Phones Plus to retrieve neighbors phones for Location Report
  nbr_pp_in := join(neighbors_crim_ind, nbr_Phone_tmp0((integer)Phone10<>0), left.did = right.did, transform(left), left only);
  nbr_pp_out := doxie.MAC_Get_GLB_DPPA_PhonesPlus(nbr_pp_in, mod_access, true,,
                                    if(location_report,0,11),
                                    '',,false, false, true);
  srt_pp_out := sort(nbr_pp_out, did, -confidencescore, -dt_last_seen);

  nbr_phone_layout addphonesplus(nbr_pp_in L, srt_pp_out R) := transform
    self.phone10 := R.phone,
    self.PubNonpub := '',
    self.ListingPhone10 := '',
    self.ListingName := R.listed_name,
    self.TimeZone := '',
    self.ph_dt_last_seen := (unsigned)R.dt_last_seen,
    self.seq_order := if(L.lname = R.lname, 1, 2),
    self := L,
    self := []
  end;

  pp_out := join(nbr_pp_in, srt_pp_out,
                 left.did = right.did,
                 addphonesplus(left, right),
                 left outer, limit(0), keep(iesp.Constants.BR.MaxAddress_Phones));

  //For location report use Phones Plus as a backup to get phones
  nbr_Phone_tmp_loc := dedup(sort(pp_out + nbr_Phone_tmp0, seqnpa, did, phone10, -ph_dt_last_seen), seqnpa, did, phone10);
  nbr_Phone_tmp := if(location_report, nbr_Phone_tmp_loc, nbr_Phone_tmp0);

  ut.getTimeZone(nbr_Phone_tmp,phone10,TimeZone,nbr_Phone);
  nb_addr_grp_1 := group (sort (nbr_Phone, seqnpa, seqTarget, seqNbr), seqnpa);
  nb_addr_grp := rollup (nb_addr_grp_1, group, SetNeighborsAddresses (left, rows (left)));

  iesp.bpsreport.t_NeighborSlim SetNeighbors () := transform
    Self.SubjectAddress := [];
    Self.NeighborAddresses := choosen(nb_addr_grp,iesp.Constants.BR.NeigborsInNeighborhood);
  END;

  ds_neighbors := dataset([SetNeighbors()]);
  return ds_neighbors;

END;
