import iesp,doxie,LiensV2_Services,LiensV2_Services,AutoStandardI,PersonReports;
export Liens_Records(dataset(doxie.layout_references) dsDids, dataset(doxie.layout_ref_bdid) dsBdids) := module
	shared getBusLiens(dataset(doxie.layout_ref_bdid) dsBdids, string ssnMaskValue, string32 appType) := function
			//Below code taken from TopBusiness_Services.LienSource_Records
			rptRecs := LiensV2_Services.liens_raw.report_view.by_bdid(dsBdids,,ssnMaskValue,,appType);

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
				SELF.FEIN := L.tax_id;
				SELF.PersonFilterId := '';
				SELF := [];
			END;
	    iesp.share.t_Address LoadAddrs(liensv2_services.layout_lien_party_address a) := TRANSFORM
		     SELF :=  iesp.ECL2ESP.SetAddress (
		      	a.prim_name, a.prim_range, a.predir, a.postdir, a.addr_suffix, a.unit_desig, a.sec_range, 
		  	   a.p_city_name, a.st, a.zip, a.zip4, a.county_name, '', a.orig_address1,a.orig_address2);
		  END;
			iesp.lienjudgement.t_LienJudgmentDebtor setDebtors(LiensV2_Services.layout_lien_party L) := TRANSFORM
				SELF.OriginName := L.orig_name;
				SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES); 
			 	SELF.ADDRESSES := PROJECT(L.ADDRESSES, LoadAddrs(LEFT));
				A := L.addresses[1];
				SELF.Address := iesp.ECL2ESP.SetAddress (
					A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range, 
					A.p_city_name, A.st, A.zip, A.zip4, '', '', A.orig_address1,A.orig_address2);
				SELF.TaxId := L.parsed_parties[1].tax_id;
				SELF.SSN := L.parsed_parties[1].ssn;
				SELF := [];
			END;

			iesp.lienjudgement.t_LienJudgmentCreditor setCreditors(LiensV2_Services.layout_lien_party L) := TRANSFORM
				SELF.Name          := L.orig_name;
				A := L.addresses[1];
				SELF.ParsedParties := CHOOSEN(PROJECT(L.parsed_parties,setParties(LEFT)),iesp.Constants.Liens.MAX_PARTIES); 
				SELF.Address       := iesp.ECL2ESP.SetAddress (
					A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range, 
					A.p_city_name, A.st, A.zip, A.zip4, '', '', A.orig_address1, A.orig_address2);
				SELF := [];
			END;

			iesp.lienjudgement.t_LienJudgmentDebtorAttorney setAttorneys(LiensV2_Services.layout_lien_party L) := TRANSFORM
				SELF.Name     := L.orig_name;
				A := L.addresses[1];
				SELF.Address  := iesp.ECL2ESP.SetAddress (
					A.prim_name, A.prim_range, A.predir, A.postdir, A.addr_suffix, A.unit_desig, A.sec_range, 
					A.p_city_name, A.st, A.zip, A.zip4, '', '', A.orig_address1, A.orig_address2);
				SELF.Phone    := A.phones[1].phone;
				SELF.TimeZone := '';
				SELF.ParsedParties := [];
				SELF := [];
			END;

			iesp.lienjudgement.t_LienJudgmentFiling setFilings(LiensV2_Services.layout_lien_history L) := TRANSFORM
				SELF.Number           := L.filing_number;
				SELF._Type            := L.filing_type_desc;
				SELF.Date             := iesp.ECL2ESP.toDate((INTEGER)L.filing_date);
				SELF.OriginFilingDate := iesp.ECL2ESP.toDate((INTEGER)L.orig_filing_date);
				SELF.Book             := L.filing_book;
				SELF.Page             := L.filing_page;
				SELF.Agency           := L.agency;
				SELF.AgencyCity       := L.agency_city;
				SELF.AgencyState      := L.agency_state;
				SELF.AgencyCounty     := L.agency_county;
				SELF := [];
			END;

			iesp.lienjudgement.t_LienJudgmentReportRecord toRpt(LiensV2_Services.layout_lien_rollup L) := TRANSFORM
				SELF.ExternalKey        := '';
				SELF.TMSId              := L.TMSId;
				SELF.MatchedParty       := PROJECT(L.matched_party,setMatchedParty(LEFT));
				SELF.IRSSerialNumber    := L.irs_serial_number;
				SELF.OriginFilingNumber := L.orig_filing_number;
				SELF.OriginFilingType   := L.orig_filing_type;
				SELF.OriginFilingDate   := iesp.ECL2ESP.toDate((INTEGER)L.orig_filing_date);
				SELF.CaseNumber         := L.case_number;
				SELF.Eviction           := L.eviction;
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
				SELF.Debtors         := CHOOSEN(PROJECT(L.debtors,setDebtors(LEFT)),iesp.Constants.Liens.MAX_DEBTORS);
				SELF.Creditors       := CHOOSEN(PROJECT(L.creditors,setCreditors(LEFT)),iesp.Constants.Liens.MAX_CREDITORS);
				SELF.DebtorAttorneys := CHOOSEN(PROJECT(L.attorneys,setAttorneys(LEFT)),iesp.Constants.Liens.MAX_ATTORNEYS);
				SELF.Filings         := CHOOSEN(PROJECT(L.filings,setFilings(LEFT)),iesp.Constants.Liens.MAX_FILINGS);
				SELF := [];
			END;

			return PROJECT(rptRecs,toRpt(LEFT));
	end;

	export dsLiensJudgmentsInd := choosen(project(PersonReports.lienjudgment_records(dsDids).liensjudgment_v2,iesp.lienjudgement.t_LienJudgmentReportRecord),iesp.Constants.BR.MaxLiensJudgments);
	
	export dsLiensJudgmentsBus := choosen(getBusLiens(dsBdids,AutoStandardI.GlobalModule().ssnmask,AutoStandardI.GlobalModule().ApplicationType),iesp.Constants.BR.MaxLiensJudgments);
end;
