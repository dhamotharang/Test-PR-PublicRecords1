import paw, riskwise, risk_indicators, Business_Header, doxie, Suppress, AML, STD;

export AMLEmployment(GROUPED DATASET(risk_indicators.layout_bocashell_neutral) AMLEmploy, doxie.IDataAccess mod_access) := FUNCTION


patw := record
  AMLEmploy.seq;
  AMLEmploy.did;
  AMLEmploy.historydate;

  unsigned6 contact_id := 0;
  unsigned8 fp;
  string12 bid := '';
  string10 company_status := '';
  string2 source := '';
  string100 sources := '';  // for use in counting sources
  qstring100 company_title;  // most recent company title
  unsigned4 First_seen_date := 0;  //(non-dead businesses)
  unsigned2 Business_ct := 0;  // number of different BDIDs worked for
  unsigned2 Dead_business_ct := 0;  // number of different BDIDs worked for that are dead
  unsigned2 Business_active_phone_ct := 0; // number of active business phones
  unsigned2 Source_ct  := 0;  // number of different PAW sources appeared on
  unsigned4 Last_seen_date := 0;
  AML.Layouts.LayoutAMLShell;

end;



//SIC codes
BusContactFP :=  JOIN(sort(AMLEmploy,seq,did), Business_Header.Key_Business_Contacts_DID,
                            keyed(LEFT.did = RIGHT.did),
                            transform(patw, self.fp:=right.fp,self := left, self := []),
                            atmost(riskwise.max_atmost), keep(1000));

BusContactBID := JOIN(BusContactFP, Business_Header.Key_Business_Contacts_FP,
                            keyed(LEFT.fp = RIGHT.fp) and (RIGHT.bdid>0),
                            transform(patw, self.bid:=(string)right.bdid,self := left),
                            atmost(riskwise.max_atmost), keep(1000));

BusContBIDSD  :=  dedup(sort(BusContactBID, seq, did, bid), seq, did, bid);



SicCodes := JOIN(BusContBIDSD,Business_header.key_sic_code,
                KEYED(left.bid = (string)right.bdid) and
                (right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or
                right.sic_code in AML.AMLConstants.setHRBusFullSicCds),
                transform(patw,
                          self.did := left.did,
                          self.seq := left.seq,
                          self.AMLHRBusiness := if(right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or right.sic_code in AML.AMLConstants.setHRBusFullSicCds, 1, 0);
                          self.AMLHRBusinessCount :=   if(right.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or right.sic_code in AML.AMLConstants.setHRBusFullSicCds, 1, 0);
                          self:= left),
                atmost(riskwise.max_atmost),
                left outer, keep(1));


SICCodesDS  := rollup(SicCodes ,left.seq=right.seq and left.did=right.did,
                      transform(patw,
                      self.AMLHRBusiness := If(left.AMLHRBusiness, left.AMLHRBusiness, right.AMLHRBusiness);
                      self.AMLHRBusinessCount :=  left.AMLHRBusinessCount + right.AMLHRBusinessCount;
                      self := right));

// rollup hrbusncont

with_paw_did := join(SICCodesDS, paw.Key_Did,
            left.did<>0 and
            keyed(left.did=right.did),
            transform(patw,
                      self.seq := left.seq;
                      self.did := left.did;
                      self.historydate := left.historydate;
                      self.contact_id := right.contact_id;
                      self.AMLHRBusiness := left.AMLHRBusiness;
                      self.AMLHRBusinessCount := left.AMLHRBusinessCount;
                      self := []),
            left outer, atmost(riskwise.max_atmost), keep(100));

// pawfile_full_nonfcra := join(PawSicCodes, paw.Key_contactid,
pawfile_full_nonfcra_unsuppressed := join(with_paw_did, paw.Key_contactid,
            left.contact_id<>0 and
            keyed(left.contact_id=right.contact_id)
            and (unsigned)right.dt_first_seen[1..6] < left.historydate,
            transform({patw, unsigned4 global_sid},
                      self.global_sid := right.global_sid;
                      self.seq := left.seq;
                      self.did := left.did;
                      self.historydate := left.historydate;
                      self.contact_id := right.contact_id;
                      self.bid := if(right.contact_id<>0 and right.company_name<>'' and right.bdid=0, 'xyz', (string)right.bdid);  // throw in a fake BDID for counting later if the BDID wasn't on the record
                      self.company_status := right.company_status;
                      self.source := right.source;
                      self.company_title := right.company_title;  // most recent company title
                      dead_company := trim(right.company_status)='DEAD';
                      self.First_seen_date := if(dead_company, 0, (unsigned)right.dt_first_seen);  //(non-dead businesses)
                      self.Last_seen_date := if(dead_company, 0, (unsigned)right.dt_last_seen); // (non-dead businesses)
                      self.Business_ct := if(right.contact_id<>0, 1, 0);  // number of different BDIDs worked for
                      self.Dead_business_ct := if(right.contact_id<>0 and dead_company, 1, 0);  // number of different BDIDs worked for that are dead
                      self.Source_ct  := if(right.contact_id<>0, 1, 0);  // number of different PAW sources appeared on
                      self.sources := '';
                      self.AMLOfficerPosition := AML.AMLTitleRank(right.company_title);
                      self.AMLOfficePositionsCount := 0;
                      self.AMLHRBusiness := left.AMLHRBusiness;
                      self.AMLHRBusinessCount := left.AMLHRBusinessCount;
                      self := left;
                      ),
                      left outer,
            atmost(riskwise.max_atmost), keep(100));

pawfile_full_nonfcra_flagged := Suppress.MAC_FlagSuppressedSource(pawfile_full_nonfcra_unsuppressed, mod_access);

pawfile_full_nonfcra := PROJECT(pawfile_full_nonfcra_flagged, TRANSFORM(patw,
  self.contact_id := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.contact_id);
  self.bid := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.bid);
  self.company_status := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.company_status);
  self.source := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.source);
  self.company_title := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.company_title);
  self.First_seen_date := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.First_seen_date);
  self.Last_seen_date := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Last_seen_date);
  self.Business_ct := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Business_ct);
  self.Dead_business_ct := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Dead_business_ct);
  self.Source_ct  := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.Source_ct);
  self.AMLOfficerPosition := IF(left.is_suppressed, (INTEGER)Suppress.OptOutMessage('INTEGER'), left.AMLOfficerPosition);
    SELF := LEFT;
));

patw roll_paw(patw le, patw ri) := transform
  self.company_title := if(le.company_title='', ri.company_title, if(le.last_seen_date>ri.last_seen_date,le.company_title,ri.company_title));
  self.first_seen_date := if(ri.first_seen_date<le.first_seen_date and ri.first_seen_date<>0, ri.first_seen_date, le.first_seen_date);
  self.last_seen_date := if(ri.last_seen_date>le.last_seen_date, ri.last_seen_date, le.last_seen_date);
  source_seen := STD.Str.find(le.sources, le.source, 1)>0;
  self.sources := if(source_seen, le.sources, trim(le.sources) + ',' + le.source);
  self.source_ct := if(source_seen or le.sources='', le.source_ct, le.source_ct + ri.source_ct);
  self.business_ct := if(le.bid=ri.bid, le.business_ct, le.business_ct + ri.business_ct);
  self.dead_business_ct := if(le.bid=ri.bid, le.dead_business_ct, le.dead_business_ct + ri.dead_business_ct);
  self.AMLOfficerPosition := if(ri.AMLOfficerPosition <= 3 and ri.Dead_business_ct = 0 , ri.AMLOfficerPosition, le.AMLOfficerPosition);
  self.AMLOfficePositionsCount := if(le.bid=ri.bid, le.AMLOfficePositionsCount, if(ri.AMLOfficerPosition <= 3, le.AMLOfficePositionsCount + 1, le.AMLOfficePositionsCount));
  self.AMLHRBusiness := le.AMLHRBusiness;
  self.AMLHRBusinessCount :=  le.AMLHRBusinessCount;
  self := ri;
end;

grouped_pawfile_full := sort(pawfile_full_nonfcra, seq, did, -(unsigned)bid, -last_seen_date, -first_seen_date);

rolled_paw := rollup(grouped_pawfile_full, left.seq=right.seq and left.did=right.did, roll_paw(left, right));

withPaw := group(join(AMLEmploy, rolled_paw,
                  left.seq=right.seq and left.did=right.did,
                  transform(risk_indicators.layout_bocashell_neutral,
                  self.AMLOfficerPosition := right.AMLOfficerPosition,
                  self.AMLOfficePositionsCount := right.AMLOfficePositionsCount,
                  self.AMLHRBusiness := right.AMLHRBusiness,
                  self.AMLHRBusinessCount  := right.AMLHRBusinessCount,
                  self := left),
                  left outer, keep(1)), seq,did);



return withPaw;

end;
