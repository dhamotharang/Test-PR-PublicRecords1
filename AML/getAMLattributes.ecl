import Risk_Indicators, iesp, doxie, Gateway;

EXPORT getAMLattributes(DATASET(Risk_Indicators.Layout_Input) iid_prep,
                                            $.IParam.IAml mod_aml,
                                            DATASET(Gateway.Layouts.Config) gateways,
                                            boolean NegNewsInd
                                           ) := FUNCTION

  // define synonyms for convenience -- until we're able to pass mod_aml all the way.
  string DataRestrictionMask := mod_aml.DataRestrictionMask;
  unsigned1 dppa := mod_aml.dppa;
  unsigned1 glba := mod_aml.glb;
  boolean   isUtility           := false; //TODO: mod_aml.isUtility(); ?
  boolean   isLn                := false; //TODO: mod_aml.ln_branded; ?

  boolean   isFCRA              := false;
  boolean   require2ele         := false;
  boolean   includeRelativeInfo := true;
  boolean   doDL                := false;
  boolean   doVehicle           := false;
  boolean   doDerogs            := true;
  boolean   ofacOnly            := false;
  boolean   suppressNearDups    := false;
  boolean   fromBIID            := false;
  boolean   excludeWatchlists   := false;
  boolean   fromIT1O            := false;
  unsigned1 OFACVersion         := 0;
  real      watchlist_threshold := 0.84;
  boolean   usedobFilter        := false;
  integer2  dob_radius          := -1;
  boolean   includeOfac         := false;
  boolean   includeAddWatchlists:= false;
  boolean   nugen               := true;
  boolean   doScore             := false;
  boolean   runSSNCodes         := true;
  boolean   runBestAddr         := true;
  boolean   runChronoPhone      := false;
  boolean   runAreaCodeSplit    := false;
  boolean   allowCellPhones     := false;
  string10  ExactMatchLevel     := Risk_Indicators.iid_constants.default_ExactMatchLevel;
  string10  CustomDataFilter    := '';
  boolean   IncludeDLverification := false;
  DOBMatchOptions               := dataset([], risk_indicators.layouts.layout_dob_match_options);
  unsigned2 EverOccupant_PastMonths := 0;
  unsigned4 EverOccupant_StartDate  := 99999999;
  unsigned1 AppendBest          := 1;  // search the best file
  watchlists_request            := dataset([], iesp.share.t_StringArrayItem);
  boolean   RemoveFares         := if(DataRestrictionMask[1]='1', true, false);

  unique_dids := dedup(sort(project(iid_prep,transform(doxie.layout_references,self:=left)), did), did);

  // get best info from same function we use in the collection shell
  bestData := risk_indicators.collection_shell_mod.getBestCleaned(unique_dids,
                                                                    DataRestrictionMask,
                                                                    GLBA,
                                                                    clean_address:=true); //  clean address,

  bestappended := join(iid_prep, bestData, left.did<>0 and left.did=right.did,
                            TRANSFORM(Risk_Indicators.Layout_Input,

                                      self.fname              := If(trim(left.fname) = '' ,  right.fname,left.fname),
                                      self.mname              := If(trim(left.mname) = '',   right.mname, left.mname),
                                      self.lname              := If(trim(left.lname) = '',  right.lname, left.lname),
                                      self.suffix             := If(trim(left.suffix) = '',   right.name_suffix, left.suffix),

                                      self.in_streetAddress   := If(trim(left.in_streetaddress) = '', right.street_addr, left.in_streetaddress),
                                      self.in_city            := if(trim(left.in_city) = '', right.city_name, left.in_city),
                                      self.in_state           := if(trim(left.in_state) = '',  right.st, left.in_state);
                                      self.in_zipCode         := if(trim(left.in_zipCode) = '',  right.zip, left.in_zipCode);

                                      self.prim_range         := if(trim(left.prim_range) = '', right.prim_range, left.prim_range);
                                      self.predir             := if(trim(left.predir) = '',  right.predir, left.predir),
                                      self.prim_name          := if(trim(left.prim_name) = '',  right.prim_name, left.prim_name),
                                      self.addr_suffix        := if(trim(left.addr_suffix) = '', right.suffix, left.addr_suffix),
                                      self.postdir            := if(trim(left.postdir) = '',  right.postdir, left.postdir),
                                      self.unit_desig         := if(trim(left.unit_desig) = '',   right.unit_desig, left.unit_desig),
                                      self.sec_range          := if(trim(left.sec_range) = '',  right.sec_range, left.sec_range),
                                      self.p_city_name        := if(trim(left.p_city_name) = '',   right.city_name, left.p_city_name),
                                      self.st                 := if(trim(left.st) = '',  right.st, left.st),
                                      self.z5                 := if(trim(left.z5) = '',   right.zip, left.z5),
                                      self.zip4               := if(trim(left.zip4) = '',   right.zip4, left.zip4),
                                      self.county             := if(trim(left.county) = '',  right.county, left.county ),
                                      self.geo_blk            := if(trim(left.geo_blk) = '',  right.geo_blk,left.geo_blk),

                                      self.addr_type          := if(trim(left.addr_type) = '',  right.addr_type,left.addr_type),
                                      self.addr_status        := if(trim(left.addr_status) = '',   right.addr_status, left.addr_status),

                                      self.ssn                := if(trim(left.ssn) = '',   right.ssn, left.ssn),
                                      self.phone10            := if(trim(left.phone10) = '',   right.phone, left.phone10),
                                      self       := left,
                                      self       := []),
                                      left outer, keep(1));

  // for batch queries, dedup the input to reduce searching
bestappended_deduped := dedup(sort(ungroup(bestappended),
  historydate, fname, mname, lname, suffix, ssn, dob, phone10,  in_streetAddress, in_city, in_state, in_zipcode,  seq),
  historydate, fname, mname, lname, suffix, ssn, dob, phone10,  in_streetAddress, in_city, in_state, in_zipcode);

seq_map := join( bestappended, bestappended_deduped,
  left.historydate=right.historydate
    and left.fname=right.fname
    and left.mname=right.mname
    and left.lname=right.lname
    and left.suffix=right.suffix
    and left.ssn=right.ssn
    and left.dob=right.dob
    and left.phone10=right.phone10
    and left.in_streetAddress=right.in_streetAddress
    and left.in_city=right.in_city
    and left.in_state=right.in_state
    and left.in_zipcode=right.in_zipcode,
  transform( {unsigned input_seq, unsigned deduped_seq}, self.input_seq := left.seq, self.deduped_seq := right.seq ), keep(1) );

  preIID := group(bestappended_deduped, seq);

  iid := risk_indicators.InstantID_Function(bestappended_deduped,
                                            gateways,
                                            dppa,
                                            glba,
                                            isUtility,
                                            isLN,
                                            ofacOnly,
                                            suppressNearDups,
                                            require2ele,
                                            isFCRA,
                                            fromBIID,
                                            ExcludeWatchLists,
                                            fromIT1O,
                                            OFACVersion,
                                            includeOfac,
                                            includeAddWatchlists,
                                            watchlist_threshold,
                                            dob_radius,
                                            mod_aml.bs_version,
                                            runSSNCodes,
                                            runBestAddr,
                                            runChronoPhone,
                                            runAreaCodeSplit,
                                            allowCellPhones,
                                            ExactMatchLevel,
                                            DataRestrictionMask,
                                            CustomDataFilter,
                                            IncludeDLverification,
                                            watchlists_request,
                                            DOBMatchOptions,
                                            EverOccupant_PastMonths,
                                            EverOccupant_StartDate,
                                            AppendBest,
                                            mod_aml.bs_options,
                                            in_DataPermission := mod_aml.DataPermissionMask,
                                            LexIdSourceOptout := mod_aml.lexid_source_optout,
                                            TransactionID := mod_aml.transaction_id,
                                            BatchUID := '',
                                            GlobalCompanyID := mod_aml.global_company_id
                                            );



  clam := risk_indicators.Boca_Shell_Function_AML(iid,
                                                gateways,
                                                mod_aml,
                                                includeRelativeInfo,
                                                doDL,
                                                doVehicle,
                                                doDerogs,
                                                doScore,
                                                nugen,
                                                RemoveFares
                                                );

Layouts.RelativeInLayout  NewNewsNames(clam le) := TRANSFORM
  self.seq            := le.seq;
  self.historydate    := le.historyDate;
  self.DID            := le.did;
  self.fname          := le.Shell_Input.fname;
  self.mname          := le.Shell_input.mname;
  self.lname          := le.Shell_Input.lname;
  self                := [];
END;

NNNames := project(clam, NewNewsNames(left));

NNIndex  := AMLIndvNegNews(NNNames, NegNewsInd);

Risk_Indicators.Layout_Boca_Shell  AddNNCounts(clam le, NNIndex ri)  := TRANSFORM
  self.AMLAttributes.IndAMLNegativeNews90    :=  map(
                                                    le.AMLAttributes.IndAgeRange = '-1' and NegNewsInd    => '-1',
                                                    le.AMLAttributes.IndAgeRange = '-1' and ~NegNewsInd   => '',
                                                    ri.n_status <> 0                                      => '',
                                                    ri.days90count > 999                                  => '999',
                                                    NegNewsInd                                            => (string)ri.days90count,
                                                    '');

  self.AMLAttributes.IndAMLNegativeNews24   :=   map(
                                                    le.AMLAttributes.IndAgeRange = '-1' and NegNewsInd    => '-1',
                                                    le.AMLAttributes.IndAgeRange = '-1' and ~NegNewsInd   => '',
                                                    ri.n_status <> 0                                      =>  '',
                                                    ri.months24count > 999                                => '999',
                                                    NegNewsInd                                            => (string)ri.months24count,
                                                    '');
  self := le;
END;

IndNNCounts := join(clam, NNIndex,
                      left.seq = right.seq and
                      left.did = right.did,
                      AddNNCounts(left, right),
                      left outer);



// join the results back to the original input so that every record on input has a response populated
full_response := join( seq_map, IndNNCounts, left.deduped_seq=right.seq, transform( Risk_indicators.Layout_Boca_Shell, self.seq := left.input_seq, self := right ), keep(1) );

  return full_response;
END;
