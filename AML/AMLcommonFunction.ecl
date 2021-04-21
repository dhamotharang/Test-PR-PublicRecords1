import AML, risk_indicators, doxie;

export AMLcommonFunction(grouped DATASET(risk_indicators.Layout_Output) with_did,
              AML.IParam.IAml mod_aml,
              boolean suppressNearDups=false,
              boolean isFCRA=false,
              boolean runSSNCodes=true, boolean runBestAddrCheck=true,
              string10 ExactMatchLevel=risk_indicators.iid_constants.default_ExactMatchLevel,
              string10 CustomDataFilter='',
              dataset(risk_indicators.layouts.Layout_DOB_Match_Options) DOBMatchOptions,
              unsigned2 EverOccupant_PastMonths,
              unsigned4 EverOccupant_StartDate,
              unsigned3 LastSeenThreshold = risk_indicators.iid_constants.oneyear
              ) :=  FUNCTION

mod_access := PROJECT(mod_aml, doxie.IDataAccess);

// returns the full list of raw header records for that did
with_header := risk_indicators.iid_getHeader(with_did, mod_access.dppa, mod_access.glb, isFCRA, mod_access.ln_branded, ExactMatchLevel, mod_access.datarestrictionMask, CustomDataFilter, mod_aml.bs_version, DOBMatchOptions, EverOccupant_PastMonths, EverOccupant_StartDate, LastSeenThreshold,
                                        LexIdSourceOptout := mod_access.lexid_source_optout,
                                        TransactionID := mod_access.transaction_id,
                                        BatchUID := '', //not needed
                                        GlobalCompanyID := mod_access.global_company_id);


// append address hierarchy seq # to the addresses from the header
with_hierarchy := Risk_Indicators.iid_append_address_hierarchy(with_header, isFCRA, mod_aml.bs_version);


//  call to get miltary flags if shell version 5.0 or higher
header_with_Military_addresses   := risk_indicators.iid_GetMilitaryAddr(with_hierarchy);

with_ssn_addr_velocity := risk_indicators.getVelocityHist(header_with_Military_addresses, isFCRA, mod_access.dppa, mod_access.datarestrictionMask, mod_aml.bs_version, mod_access := mod_access);//  history BocaShell stuff


with_addr_history := risk_indicators.Boca_Shell_Address_History(with_ssn_addr_velocity, isFCRA, mod_access.datarestrictionMask);


just_layout_output := PROJECT (with_addr_history,TRANSFORM(risk_indicators.layout_output, SELF := LEFT));

experian_batch_feed := false;  // this is always false in this function when calling roll_header
// add BSOptions to iid_roll_header
rolled_header_normal := risk_indicators.iid_roll_header(just_layout_output, suppressNearDups, mod_aml.bs_version, experian_batch_feed, isfcra, mod_aml.bs_options);

Movers := rolled_header_normal(addrs_last36 >=3);

MoverDIDs := join(with_hierarchy, Movers,
                  left.seq = right.seq and
                  left.did = right.did,
                  transform(risk_indicators.iid_constants.layout_outx,
                              self := left));

GetZipDist := AML.GetMoveDist(MoverDIDs);

// iid_getSSNFlags was located prior to rolled_header. When entering a 4 byte ssn, flags were being set before the ssn was fixed.
with_ssn_flags := risk_indicators.iid_getSSNFlags(rolled_header_normal, mod_access,
                                                  isFCRA, runSSNCodes, ExactMatchLevel, mod_aml.bs_version,
                                                  mod_aml.bs_options);

Indivslim := record

  unsigned4 historydate;
  unsigned4 seq;
  unsigned6 did;
  STRING20  fname;
  STRING20  lname;
  string10  prim_range;
  string2   predir;
  string28  prim_name;
  string4   addr_suffix;
  string2   postdir;
  string5   unit_desig;
  string8   sec_range;
  STRING2   state;
  STRING5   zip5;
  string3   county ;
  string7   geo_blk ;
  unsigned4 addr_dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_first_seen;
  string50  src;
  boolean   IsVoter;
  qstring9  ssn;
  boolean   isITIN;
  Boolean   isNON_US_SSN;
  unsigned4 socllowissue;


end;
Indivslim  evalheader(with_header le, with_ssn_flags ri )  := TRANSFORM
  SELF.IsVoter   := IF(LE.h.src = 'VO', true, false);
  Self.isITIN :=   Risk_Indicators.rcSet.isCodeIT(le.h.ssn);
  self.isNON_US_SSN := Risk_Indicators.rcSet.isCode85(le.h.ssn, (string)ri.socllowissue);
  self.historydate := le.historydate;
  self.seq := le.seq;
  self.did := le.did;
  self.fname := le.fname;
  self.lname := le.lname;
  self.src := le.h.src;
  self.addr_dt_first_seen := if(le.h.prim_name <> '' and le.h.zip <> '' and le.h.dt_first_seen <> 0, le.h.dt_first_seen, 999999);
  self.socllowissue := (unsigned4)le.socllowissue;
  self.dt_first_seen := if(le.h.dt_first_seen = 0, 999999, le.h.dt_first_seen);
  self.dt_last_seen := le.h.dt_last_seen;
  self := le;
  self := [];
END;

getHDRSSNType :=  sort(join(with_header,with_ssn_flags,
                      left.seq = right.seq and
                      left.did = right.did,
                      evalheader(left, right)), seq, did);

Indivslim  rollHeader(getHDRSSNType le, getHDRSSNType ri)  := TRANSFORM
  self.isVoter :=  le.isVoter or ri.isVoter;
  self.isITIN :=   le.isITIN or ri.isITIN;
  self.isNON_US_SSN :=  le.isNON_US_SSN or ri.isNON_US_SSN;
  self.addr_dt_first_seen := min(le.addr_dt_first_seen, ri.addr_dt_first_seen);
  self.dt_last_seen := max(le.dt_last_seen, ri.dt_last_seen);
  self.dt_first_seen := min(le.dt_first_seen, ri.dt_first_seen);
  self.socllowissue := min(le.socllowissue, ri.socllowissue);
  self := le;
END;

rolledHdrdtls := rollup(getHDRSSNType, rollHeader(left, right), seq ,did);

with_best_addr := risk_indicators.iid_check_best(with_addr_history, with_ssn_flags, ExactMatchLevel, mod_aml.bs_version);

PrepBSlayout := AML.GetBSLayout(with_best_addr);

AddHdrdetails := join(PrepBSlayout, rolledHdrdtls,
                      left.seq = right.seq and
                      left.did = right.did,
                      transform(AML.Layouts.LayoutAMLShellV2,
                                  self.did := left.did,
                                  self.seq := left.seq,
                                  self.isVoter :=   right.isVoter,
                                  self.EverITIN :=   right.isITIN,
                                  self.EverNon_US_SSN :=   right.isNON_US_SSN,
                                  self.EarliestAddrFirstSeenDt := right.addr_dt_first_seen,
                                  self.HdrFirstSeenDate := right.dt_first_seen,
                                  self.HdrLastSeenDate := right.dt_last_seen,
                                  self := left), left outer);

AddMovers := join(AddHdrdetails,GetZipDist ,
                      left.seq = right.seq and
                      left.did = right.did,
                      transform(AML.Layouts.LayoutAMLShellV2,
                                  self.Move1_dist :=   if(right.did <> 0, right.Move1_dist, 9999),
                                  self.Move2_dist :=   if(right.did <> 0, right.Move2_dist, 9999),
                                  self.Move3_dist :=   if(right.did <> 0, right.Move3_dist, 9999),
                                  // self.Move4_dist :=   right.Move4_dist,
                                  self := left), left outer);


// output(with_header, named('with_header'));
// output(with_hierarchy, named('with_hierarchy'));

// output(header_with_Military_addresses, named('header_with_Military_addresses'));
// output(with_ssn_addr_velocity, named('with_ssn_addr_velocity'));
// output(with_addr_history, named('with_addr_history'));
// output(just_layout_output, named('just_layout_output'));
// output(rolled_header_normal, named('rolled_header_normal'));

// output(Movers, named('Movers'));
// output(GetZipDist, named('GetZipDist'));
// output(with_ssn_flags, named('with_ssn_flags'));
// output(getHDRSSNType, named('getHDRSSNType'));
// output(rolledHdrdtls, named('rolledHdrdtls'));
// output(with_best_addr, named('with_best_addr'));
// output(PrepBSlayout, named('PrepBSlayout'));

// output(AddHdrdetails, named('AddHdrdetails'));

RETURN AddMovers;

END;
