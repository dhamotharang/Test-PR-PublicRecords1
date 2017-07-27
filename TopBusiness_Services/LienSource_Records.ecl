// ================================================================================
// ===== RETURNS LIENS&JUDGMENTS RECORD FOR A GIVEN TMSID IN ESP-COMPLIANT WAY ====
// ================================================================================

// This attribute was created by copying PersonReports.lienjudgment_records
// and revising it for use by TopBusiness_Services.SourceService_Records.
IMPORT iesp, LiensV2_Services, BIPV2, LiensV2, TopBusiness_Services, ut;

EXPORT LienSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	SHARED lien_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		Liensv2_services.layout_lien_rollup -acctno;
	END;

	// For in_docids records that don't have SourceDocIds (corp_keys) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get lien filing data
  ds_lienkeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly,
													                                inoptions.fetch_level
																											   ).ds_liens_linkidskey_recs,
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.tmsid,
																					SELF := LEFT,
																					SELF := []));
	
	// For records with an id value assigned and an Id type of liensrcrec, then get key parts via sourcerec key
	in_docs_SourceRec := in_docids(IdValue != '' and Idtype = constants.liensrcrec);
	ds_SrcRecLienkeys := JOIN(in_docs_SourceRec, LiensV2.key_liens_SourceRecId,
													    KEYED((INTEGER) LEFT.IdValue = RIGHT.persistent_record_id), 
													  TRANSFORM(Layouts.rec_input_ids_wSrc,
																		SELF.IdValue := RIGHT.tmsid,
																		SELF := LEFT,
																		SELF := []),
												    LIMIT(TopBusiness_Services.Constants.defaultJoinLimit,SKIP));
	
	// For records with an id value assigned and an Id type of lienkeys, then parse the idvalue to get the key parts
	ds_TmsidLienkeys := in_docids(IdValue != '' and (Idtype = constants.lienkeys or Idtype = constants.tmsid));
																		
	lien_keys_comb := ds_SrcRecLienkeys+ds_TmsidLienkeys+ds_lienkeys;

	lien_keys := PROJECT(lien_keys_comb(IdValue != ''),TRANSFORM(LiensV2_Services.layout_tmsid,SELF.tmsid := LEFT.IdValue));
  
	lien_keys_dedup := DEDUP(lien_keys,ALL);
	
	// Get report view via tmsid's  
	lien_sourceview := LiensV2_Services.liens_raw.report_view.by_tmsid (lien_keys_dedup, inoptions.ssn_mask, IsFCRA,,,,inoptions.app_type);

	SHARED lien_sourceview_wLinkIds := JOIN(lien_sourceview,lien_keys_comb,
																					LEFT.tmsid = RIGHT.IdValue,
																					TRANSFORM(lien_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids


  // iesp layout transforms
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
	
	iesp.lienjudgement.t_LienJudgmentParty setParties(Liensv2_Services.layout_lien_party_parsed L) := TRANSFORM
		SELF.Name := iesp.ECL2ESP.SetName (L.fname,L.mname,L.lname,L.name_suffix,L.title); 
		SELF.CompanyName := L.cname;
		SELF.UniqueId := L.did;
		SELF.BusinessId := L.bdid;
		SELF.SSN := L.ssn;
		SELF.TaxID := L.tax_id;
		SELF.FEIN := '';
		SELF.PersonFilterId := L.person_filter_id;
		SELF := [];
	END;
	
	iesp.share.t_Address setAddress(Liensv2_services.layout_lien_party_address L) := TRANSFORM
			self.StreetNumber := L.prim_range;
			self.StreetPreDirection := L.predir;
			self.StreetName := L.prim_name;
			self.StreetSuffix := L.addr_suffix;
			self.StreetPostDirection := L.postdir;
			self.UnitDesignation := L.unit_desig;
			self.UnitNumber := L.sec_range;
			self.StreetAddress1 := L.orig_address1;
			self.StreetAddress2 := L.orig_address2;
			self.City := L.p_city_name;
			self.State := L.st;
			self.Zip5 := L.zip;
			self.Zip4 := L.zip4;
			self.County := L.county_name;
			self.PostalCode := '';
			self.StateCityZip:= '';
	END;
	
	iesp.share.t_PhoneTimeZone getPartyPhones(DATASET(LiensV2_Services.layout_lien_party) L) := FUNCTION
		// The phone numbers are a child dataset of the Addresses, pull them all off and assign.
		addrRecs := NORMALIZE(L,LEFT.addresses,TRANSFORM(liensv2_services.layout_lien_party_address,SELF := RIGHT));
		phoneRecs := NORMALIZE(addrRecs,LEFT.phones,TRANSFORM(liensv2_services.layout_lien_party_phone,SELF := RIGHT));
		phoneClean := DEDUP(phoneRecs,ALL);
		phoneResults := PROJECT(phoneClean,TRANSFORM(iesp.share.t_PhoneTimeZone,SELF.phone10 := LEFT.phone, SELF := []));
		RETURN(phoneResults);
		
	END;
	
	iesp.lienjudgement.t_LienJudgmentDebtor setDebtors(LiensV2_Services.layout_lien_party L) := TRANSFORM
		SELF.OriginName := L.orig_name;
		SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES);
		SELF.Addresses := CHOOSEN(PROJECT(L.addresses,setAddress(LEFT)),iesp.Constants.Liens.MAX_ADDRESSES);
		SELF.Phones := CHOOSEN(getPartyPhones(DATASET(L)),iesp.Constants.Liens.MAX_PHONES);
		SELF := [];
	END;

	iesp.lienjudgement.t_LienJudgmentCreditor setCreditors(LiensV2_Services.layout_lien_party L) := TRANSFORM
		SELF.Name := L.orig_name;
		SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES);
		SELF.Addresses := CHOOSEN(PROJECT(L.addresses,setAddress(LEFT)),iesp.Constants.Liens.MAX_ADDRESSES);
		SELF.Phones := CHOOSEN(getPartyPhones(DATASET(L)),iesp.Constants.Liens.MAX_PHONES);
		SELF := [];
	END;

	iesp.lienjudgement.t_LienJudgmentDebtorAttorney setAttorneys(LiensV2_Services.layout_lien_party L) := TRANSFORM
		SELF.Name := L.orig_name;
		SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES);
		SELF.Addresses := CHOOSEN(PROJECT(L.addresses,setAddress(LEFT)),iesp.Constants.Liens.MAX_ADDRESSES);
		SELF.Phones := CHOOSEN(getPartyPhones(DATASET(L)),iesp.Constants.Liens.MAX_PHONES);
		SELF := [];
	END;
	
	iesp.lienjudgement.t_LienJudgmentThirdParty setThirdParties(LiensV2_Services.layout_lien_party L) := TRANSFORM
		SELF.OriginName := L.orig_name;
		SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES);
		SELF.Addresses := CHOOSEN(PROJECT(L.addresses,setAddress(LEFT)),iesp.Constants.Liens.MAX_ADDRESSES);
		SELF.Phones := CHOOSEN(getPartyPhones(DATASET(L)),iesp.Constants.Liens.MAX_PHONES);
		SELF := [];
	END;

	iesp.lienjudgement.t_LienJudgmentFiling setFilings(LiensV2_Services.layout_lien_history L) := TRANSFORM
		SELF.Number           := L.filing_number;
		SELF._Type            := L.filing_type_desc;
		SELF.Date             := iesp.ECL2ESP.toDate((INTEGER)L.filing_date);
		SELF.OriginFilingDate := iesp.ECL2ESP.toDate((INTEGER)L.orig_filing_date);
		SELF.FilingTime			 	:= L.filing_time;
		SELF.Book             := L.filing_book;
		SELF.Page             := L.filing_page;
		SELF.Agency           := L.agency;
		SELF.AgencyCity       := L.agency_city;
		SELF.AgencyState      := L.agency_state;
		SELF.AgencyCounty     := L.agency_county;
		SELF := [];
	END;

	SHARED iesp.lienjudgement.t_LienJudgmentReportRecord toOut(lien_layout_wLinkIds L) := TRANSFORM
		SELF.ExternalKey        := '';
		IDmacros.mac_IespTransferLinkids()
		SELF.TMSId              := L.TMSId;
		SELF.RMSId              := L.RMSId;
		SELF.MatchedParty       := PROJECT(L.matched_party,setMatchedParty(LEFT));
		SELF.IRSSerialNumber    := L.irs_serial_number;
		SELF.OriginFilingNumber := L.orig_filing_number;
		SELF.OriginFilingType   := L.orig_filing_type;
		SELF.OriginFilingDate   := iesp.ECL2ESP.toDate((INTEGER)L.orig_filing_date);
		SELF.OriginFilingTime		:= L.orig_filing_time;
		SELF.CaseNumber         := L.case_number;
		SELF.Eviction           := L.eviction;
		SELF.TaxCode						:= L.tax_code;
		SELF.Judge							:= L.judge;
		SELF.Amount             := L.amount;
		SELF.FilingJurisdiction     := L.filing_jurisdiction;
		SELF.FilingJurisdictionName := L.filing_jurisdiction_name;
		SELF.FilingState            := L.filing_state;
		SELF.FilingStatus           := L.filing_status[1].filing_status_desc;
		SELF.CertificateNumber  := L.certificate_number;
		SELF.JudgeSatisfiedDate := iesp.ECL2ESP.toDate((INTEGER)L.judg_satisfied_date);
		SELF.SuitDate           := [];
		SELF.JudgeVacatedDate   := iesp.ECL2ESP.toDate((INTEGER)L.judg_vacated_date);
		SELF.ReleaseDate        := iesp.ECL2ESP.toDate((INTEGER)L.release_date);
		SELF.LegalLot           := L.legal_lot;
		SELF.LegalBlock         := L.legal_block;
		SELF.MultipleDefendant  := (string) L.multiple_debtor;
		SELF.Debtors         		:= CHOOSEN(PROJECT(L.debtors,setDebtors(LEFT)),iesp.Constants.Liens.MAX_DEBTORS);
		SELF.Creditors       		:= CHOOSEN(PROJECT(L.creditors,setCreditors(LEFT)),iesp.Constants.Liens.MAX_CREDITORS);
		SELF.DebtorAttorneys 		:= CHOOSEN(PROJECT(L.attorneys,setAttorneys(LEFT)),iesp.Constants.Liens.MAX_ATTORNEYS);
		SELF.ThirdParties 			:= CHOOSEN(PROJECT(L.thds,setThirdParties(LEFT)),iesp.Constants.Liens.MAX_THIRD_PARTIES);
		SELF.Filings         		:= CHOOSEN(PROJECT(L.filings,setFilings(LEFT)),iesp.Constants.Liens.MAX_FILINGS);
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(lien_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'LIEN_V2';
			self.src_desc := 'Liens and Judgments';
			self.hasName 	:= exists(L.debtors(orig_name <>''));
			self.hasSSN  	:= exists(L.debtors(exists(parsed_parties(ssn <>''))));
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= exists(L.debtors(exists(addresses(st <>'' or zip <>''))));
		  self.hasPhone := exists(L.debtors(exists(addresses(exists(phones (phone != ''))))));
			dt_filing			:= ut.NormDate((unsigned)L.orig_filing_date);
			dt_rel				:= ut.NormDate((unsigned)L.release_date);
			dt_judsat			:= ut.NormDate((unsigned)L.judg_satisfied_date);
			dt_judvac			:= ut.NormDate((unsigned)L.judg_vacated_date);
			self.dt_first_seen	:= dt_filing;
			self.dt_last_seen		:= max(dt_filing, dt_rel, dt_judsat, dt_judvac);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(lien_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(lien_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(lien_sourceview_wLinkIds);

END;
