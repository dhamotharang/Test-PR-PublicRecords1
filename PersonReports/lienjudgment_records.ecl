IMPORT iesp, doxie, liensv2_services, doxie_crs, fcra, suppress, FFD;

EXPORT lienjudgment_records (
  dataset (doxie.layout_references) dids,
  PersonReports.IParam.liens in_params = module (PersonReports.IParam.liens) end,
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
  dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
  boolean rollup_by_case_link = false
) := MODULE

  liens_raw := doxie.Liens_Judgments_records (dids, in_params.liens_party_type);
  // returns v2 data mapped to doxie_crs.layout_Liens_Judgments_records

  iesp.bpsreport.t_BpsReportLienJudgment toOut (doxie_crs.layout_Liens_Judgments_records L) := transform

    Self.FilingType       := L.filingtype_desc;
    Self.CourtLocation     := '';//L.state_mapped; //this is probably anachronism
    Self.CourtState       := L.filing_state;
    Self.CourtDescription := L.court_desc;
    Self.CaseNumber       := L.casenumber;
    Self.Amount           := iesp.ECL2ESP.FormatDollarAmount (L.amount);
    Self.DateFiled         := iesp.ECL2ESP.toDatestring8 (L.filing_date);
    Self.DateDisposed     := iesp.ECL2ESP.toDatestring8 (L.release_date);

    Self.Debtor.Name := iesp.ECL2ESP.SetName (L.def_fname, L.def_mname, L.def_lname, L.def_name_suffix, L.def_title);
    Self.Debtor.SSN := L.orig_ssn; // ssn_appended is explicitely blanked in doxie.Fn_LienBackwards
    Self.Debtor.Address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix,
                                                    L.unit_desig, L.sec_range, L.v_city_name, L.state, L.zip, L.zip4, '');
    Self.Creditor := L.plaintiff;
    Self.Book := L.book;
    Self.Page := L.page;
  end;

  EXPORT liensjudgment :=  if(~IsFCRA, project (liens_raw, toOut (Left)));

  iesp.lienjudgement_fcra.t_FcraLienJudgmentParty setParties(liensv2_services.layout_lien_party_parsed L) := TRANSFORM
    SELF.Name := iesp.ECL2ESP.SetName (L.fname,L.mname,L.lname,L.name_suffix,L.title); 
    SELF.CompanyName := L.cname;
    SELF.UniqueId := L.did;
    SELF.BusinessId := L.bdid;
		self.BusinessIDs.proxid := l.proxid;
		self.businessIDs.ultid := l.ultid;
		self.businessIDs.orgid := l.orgid;
		self.businessIDs.seleid := l.seleid;
		self.businessIDs.dotid := l.dotid;
		self.BusinessIDs.empid := l.empid;
		self.BusinessIDs.powid := l.powid;
    SELF.SSN := L.ssn;
    SELF.FEIN := L.tax_id;
    SELF.personFilterId := L.person_filter_id;
		SELF.Statementids := L.StatementIds;
		SELF.isDisputed := L.isDisputed;
		SELF := [];
  END;

  iesp.lienjudgement_fcra.t_FcraLienJudgmentFiling setFilings(LiensV2_Services.layout_lien_history L) := TRANSFORM
    SELF.Number := L.filing_number;
    SELF._Type := L.filing_type_desc;
    SELF.Date := iesp.ECL2ESP.toDate((INTEGER)L.filing_date);
    SELF.OriginFilingDate := iesp.ECL2ESP.toDate((INTEGER)L.orig_filing_date);
    SELF.Book := L.filing_book;
    SELF.Page := L.filing_page;
    SELF.Agency := L.agency;
    SELF.AgencyCity := L.agency_city;
    SELF.AgencyState := L.agency_state;
    SELF.AgencyCounty := L.agency_county;
		SELF.Statementids := L.StatementIds;
		SELF.isDisputed := L.isDisputed;
		SELF := [];
  END;

  iesp.lienjudgement_fcra.t_FcraLienJudgmentDebtorAttorney setAttorneys(LiensV2_Services.layout_lien_party L) := TRANSFORM
    SELF.Name := L.orig_name;
    A := L.addresses[1];
    SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES); 
    SELF.Address := iesp.ECL2ESP.SetAddress (
      A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range, 
      A.p_city_name, A.st, A.zip, A.zip4, A.county_name, '', A.orig_address1, A.orig_address2);
    SELF.Phone := stringlib.stringfilter(A.phones[1].phone,'0123456789');
    SELF.TimeZone := '';
		SELF := [];
  END;

  iesp.lienjudgement_fcra.t_FcraLienJudgmentCreditor setCreditors(LiensV2_Services.layout_lien_party L) := TRANSFORM
    SELF.Name := L.orig_name;
    A := L.addresses[1];
    SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES); 
    SELF.Address := iesp.ECL2ESP.SetAddress (
      A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range, 
      A.p_city_name, A.st, A.zip, A.zip4, A.county_name, '', A.orig_address1, A.orig_address2);
		SELF := [];
	END;
  iesp.share.t_Address LoadAddrs(liensv2_services.layout_lien_party_address a) := TRANSFORM
      SELF :=  iesp.ECL2ESP.SetAddress (
      a.prim_name, a.prim_range, a.predir, a.postdir, a.addr_suffix, a.unit_desig, a.sec_range, 
      a.p_city_name, a.st, a.zip, a.zip4, a.county_name, '', a.orig_address1,a.orig_address2);
    END;
  
  iesp.lienjudgement_fcra.t_FcraLienJudgmentDebtor setDebtors(LiensV2_Services.layout_lien_party L) := TRANSFORM
    SELF.OriginName := L.orig_name;
    SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES); 
    SELF.ADDRESSES := PROJECT(L.ADDRESSES, LoadAddrs(LEFT));
    A := L.addresses[1];
    SELF.Address := iesp.ECL2ESP.SetAddress (
      A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range, 
      A.p_city_name, A.st, A.zip, A.zip4, A.county_name, '', A.orig_address1,A.orig_address2);
    SELF.TaxId := L.parsed_parties[1].tax_id;
    SELF.SSN := L.parsed_parties[1].ssn;
		SELF := [];
  END;

  iesp.share.t_MatchedParty setMatchedParty(LiensV2_Services.assorted_layouts.matched_party_rec L) := TRANSFORM
    SELF.PartyType := L.party_type; 
    SELF.OriginName := '';
    P := L.parsed_party;
    SELF.ParsedParty := iesp.ECL2ESP.SetName (P.fname,P.mname,P.lname,P.name_suffix,P.title); 
    SELF.ParsedParty2 := iesp.ECL2ESP.SetNameAndCompany ('','','','','','',P.cname); 
    A := L.address;
    SELF.Address := iesp.ECL2ESP.SetAddress (
      A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range,
      A.p_city_name, A.st, A.zip, A.zip4, '', '', A.orig_address1, A.orig_address2);
  END;

  iesp.lienjudgement_fcra.t_FcraLienJudgmentReportRecord toRpt(LiensV2_Services.layout_lien_rollup L) := TRANSFORM
    SELF.ExternalKey := '';
    SELF.TMSId := L.TMSId;
    SELF.MatchedParty := PROJECT(L.matched_party,setMatchedParty(LEFT));
    SELF.IRSSerialNumber := L.irs_serial_number;
    SELF.OriginFilingNumber := L.orig_filing_number;
    SELF.OriginFilingType := L.orig_filing_type;
    SELF.OriginFilingDate := iesp.ECL2ESP.toDate((INTEGER)L.orig_filing_date);
    SELF.CaseNumber := L.case_number;
    SELF.Eviction := L.eviction;
    SELF.Amount := L.amount;
    SELF.FilingJurisdiction := L.filing_jurisdiction;
    SELF.FilingJurisdictionName := L.filing_jurisdiction_name;
    SELF.FilingState := L.filing_state;
    SELF.FilingStatus := L.filing_status[1].filing_status_desc;
    SELF.CertificateNumber := L.certificate_number;
    SELF.JudgeSatisfiedDate := iesp.ECL2ESP.toDate((INTEGER)L.judg_satisfied_date);
    SELF.SuitDate := [];
    SELF.JudgeVacatedDate := iesp.ECL2ESP.toDate((INTEGER)L.judg_vacated_date);
    SELF.ReleaseDate := iesp.ECL2ESP.toDate((INTEGER)L.release_date);
    SELF.LegalLot := L.legal_lot;
    SELF.LegalBlock := L.legal_block;
    SELF.MultipleDefendant := (string) L.multiple_debtor;
    SELF.Debtors := CHOOSEN(PROJECT(L.debtors,setDebtors(LEFT)),iesp.Constants.Liens.MAX_DEBTORS);
    SELF.Creditors := CHOOSEN(PROJECT(L.creditors,setCreditors(LEFT)),iesp.Constants.Liens.MAX_CREDITORS);
    SELF.DebtorAttorneys := CHOOSEN(PROJECT(L.attorneys,setAttorneys(LEFT)),iesp.Constants.Liens.MAX_ATTORNEYS);
    SELF.Filings := CHOOSEN(PROJECT(L.filings,setFilings(LEFT)),iesp.Constants.Liens.MAX_FILINGS);
		SELF.Statementids := L.StatementIds;
		SELF.isDisputed := L.isDisputed;
		SELF  := L;
		SELF := [];
	END;

  // same as in Compreport (Doxie/liens_v2_records)
  rptRecs := LiensV2_Services.liens_raw.report_view.by_did (dids, in_params.ssn_mask, IsFCRA, in_params.liens_party_type,in_params.application_type, ,slim_pc_recs, in_params.FFDOptionsMask,, rollup_by_case_link);
  rptRecs_fcra := LiensV2_Services.fn_applyFcraOverrides (rptRecs, flagfile, in_params.ssn_mask, false, slim_pc_recs, in_params.FFDOptionsMask);

  raw_recs := if (IsFCRA, rptRecs_fcra, rptRecs);

  // non-subject suppression, if requested
  subject_recs := project (raw_recs, transform (LiensV2_Services.layout_ids, 
                                                self.did := dids[1].did, // for the purpose of person reports: atmost one subject
                                                self.tmsid := left.tmsid,
                                                self.acctno := left.acctno));

  res_rcs := if (in_params.non_subject_suppression <> Suppress.Constants.NonSubjectSuppression.doNothing, 
                 LiensV2_Services.fn_applyNonSubjectSuppression (raw_recs, subject_recs, in_params.non_subject_suppression),
                 raw_recs);

  EXPORT liensjudgment_v2 :=  CHOOSEN (PROJECT(res_rcs, toRpt(LEFT)), iesp.Constants.Liens.MAX_LIENS_JUDGEMENTS);

END;
