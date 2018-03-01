import iesp, doxie, Suppress, UCCv2, UCCv2_Services, BIPV2, ut;

EXPORT UCCSource_Records (
	dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false,
	boolean keepAll = false) 
 := MODULE

	SHARED ucc_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		UCCv2_Services.layout_ucc_rollup_src;
	END;	
	
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get ucc tmsids from linkids
	ds_ucclink := UCCv2.Key_LinkIds.KeyFetch(in_docs_linkonly,inoptions.fetch_level,,TopBusiness_Services.Constants.UCCKfetchMaxLimit);
	
	// For records matched on linkids only, only keep debtor and secured party records, unless stated to keep all.
	ds_ucckeys := PROJECT(ds_ucclink(party_type = Constants.DEBTOR OR party_type = Constants.SECUREDPARTY OR KeepAll),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.tmsid,
																					SELF := LEFT,
																					SELF := []));
																					
	ucc_keys_comb := in_docids+ds_ucckeys;

	ucc_keys := PROJECT(ucc_keys_comb(IdValue != ''),TRANSFORM(UCCv2_services.layout_tmsid,SELF.tmsid := LEFT.IdValue, SELF := []));
	
	ucc_keys_dedup := DEDUP(ucc_keys,ALL);
	
	// Get the raw data from the appropriate view.
  ucc_sourceview := UCCv2_Services.UCCRaw.source_view.by_tmsid (ucc_keys_dedup, inoptions.ssn_mask,,inoptions.app_type);

	SHARED ucc_sourceview_wLinkIds := JOIN(ucc_sourceview,ucc_keys_comb,
																					LEFT.tmsid = RIGHT.IdValue,
																					TRANSFORM(ucc_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
																							
  iesp.ucc.t_UCCParsedParty FormatParties (uccv2_services.layout_ucc_party_parsed L, String Orig_Name) := TRANSFORM
		self.BusinessIds.DotID 		:= L.DotID;
		self.BusinessIds.EmpID 		:= L.EmpID;
		self.BusinessIds.POWID 		:= L.POWID;
		self.BusinessIds.ProxID 	:= L.ProxID;
		self.BusinessIds.SELEID 	:= L.SELEID;  
		self.BusinessIds.OrgID 		:= L.OrgID;
		self.BusinessIds.UltID 		:= L.UltID;
    Self.BusinessId := (string) L.bdid;
    Self.UniqueId := (string) L.did;
	  Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    Self.SSN := L.ssn;
    Self.FEIN := L.fein;
    Self.IncorporatedState := L.Incorp_state;
    Self.CorporateNumber := L.corp_number;
    Self.CorporateType := L.corp_type;
		// If no last name, then company is the party, assign company name from passed orig_name
		Self.CompanyName := IF(L.lname = '',Orig_Name,'');  
		self.IdValue := '';
  END;

  iesp.share.t_UniversalAndRawAddress FormatAddress (uccv2_services.layout_ucc_party_address_src L) := TRANSFORM
    Self.StreetName := L.prim_name;
    Self.StreetNumber := L.prim_range;
    Self.StreetPreDirection := L.predir;
    Self.StreetPostDirection := L.postdir;
    Self.StreetSuffix := L.addr_suffix;
    Self.UnitDesignation := L.unit_desig;
    Self.UnitNumber := L.sec_range;
    Self.StreetAddress1 := L.address1;
    Self.StreetAddress2 := L.address2;
    Self.State := L.st;
    Self.City := L.v_city_name;
    Self.Zip5 := L.zip5;
    Self.Zip4 := L.zip4;
    Self.County := '';
    Self.PostalCode := L.orig_postal_code;
    Self.StateCityZip := '';
    Self.Country := L.orig_country;
    Self.Province := L.orig_province;
    Self.IsForeign := L.foreign_indc = 'Y';
		Self.OrigStreetAddress1 := L.orig_address1;
		Self.OrigStreetAddress2 := L.orig_address2;
  END;

  iesp.ucc.t_UCCReport2Person SetParties (uccv2_services.layout_ucc_party_src L) := TRANSFORM
    Self.OriginName := L.orig_name;
    Self.Addresses := choosen (project (L.addresses, FormatAddress (Left)), iesp.Constants.UCCF.MaxPersonAddresses);
    Self.ParsedParties := choosen (project (L.parsed_parties, FormatParties (Left,L.orig_name)), iesp.Constants.UCCF.MaxPersonParsedParties);
  END; 

  iesp.ucc.t_UCCReport2Collateral SetCollateral (uccv2_services.layout_ucc_coll_src L) := TRANSFORM
    Self.Description := L.collateral_desc;
    Self.Count := L.collateral_count;
    Self.PropertyDescription := L.property_desc;
    Self.Address := L.collateral_address;
    Self.SerialNumber := L.serial_number;

    // v2:
    Self.PrimaryMachine := L.prim_machine;
    Self.SecondMachine := L.sec_machine;
    Self.ManufacturerCode := L.manufacturer_code;
    Self.Manufacturer := L.manufacturer_name;
    Self.ModelYear := (integer) L.model_year;
    Self.Model := L.model;
    Self.ModelDesc := L.model_desc;
    Self.ManufacturedYear:= (integer) L.manufactured_year;
    Self.Borough := L.borough;
    Self.Block := L.block;
    Self.Lot:= L.lot;
    Self.AirRights := L.air_rights_indc;
    Self.SubterraneanRights := L.subterranean_rights_indc;
    Self.Easement := L.easment_indc;
    Self.NewUsed := L.new_used;
  END; 


  iesp.ucc.t_UCCReport2Filing SetFilings (uccv2_services.layout_ucc_hist_src L) := TRANSFORM
    Self.FilingStatus := L.filing_status;
    Self.Number := L.filing_number;
    Self._Type := L.filing_type;
    Self.Date := iesp.ECL2ESP.toDate ((integer4) L.filing_date);
    Self.Time := L.filing_time;
    Self.Pages := L.page;
    Self.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.expiration_date);
    Self.Amount := L.amount;
    Self.ContractType := L.contract_type;
    Self.EffectiveDate := iesp.ECL2ESP.toDate ((integer4) L.effective_date);
    Self.SerialNumber := L.irs_serial_number;

    // v2:
    Self.FilingNumberIndicator := L.filing_number_indc;
    Self.VendorEntryDate  := iesp.ECL2ESP.toDate ((integer4) L.vendor_entry_date);
    Self.VendorUpdateDate := iesp.ECL2ESP.toDate ((integer4) L.vendor_upd_date);
    Self.ContinuousExpiration := L.continuious_expiration;
    Self.StatementsFiled := L.statements_filed;
    Self.MicrofilmNumber := L.microfilm_number;
  END; 

  iesp.ucc.t_UCCFilingOffice SetFilingOffices (uccv2_services.layout_ucc_filofc L) := TRANSFORM
    Self.FilingAgency := L.filing_agency;
    Self.Address := iesp.ECL2ESP.SetAddress ('','','','','','','', L.city, L.state, L.zip,'',L.county,'',L.address);
    Self.Address2 := iesp.ECL2ESP.SetUniversalAddress ('','','','','','','', L.city, L.state, L.zip, '', L.county, '', L.address);
  END; 

  iesp.ucc.t_UCCSigner SetSigners (uccv2_services.layout_ucc_signer L) := TRANSFORM
    Self.Name := L.signer_name;
    Self.Title := L.title;
  END; 

  SHARED iesp.ucc.t_UCCReport2Record toOut (ucc_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
    Self.TMSId := L.tmsid;
    Self.FilingJurisdiction := L.filing_jurisdiction; //? state
    Self.FilingJurisdictionName := L.filing_jurisdiction_name;
    Self.OriginFilingNumber := L.orig_filing_number;
    Self.OriginFilingType := L.orig_filing_type;
	  Self.OriginFilingDate := iesp.ECL2ESP.toDate ((integer4) L.orig_filing_date);
    Self.OriginFilingTime := L.orig_filing_time;
    Self.FilingStatus := '';//choosen (L.filing_status, 10); // hardcoded in ucc raw...
    Self.Comment := L.description;
    Self.CommentEffectiveDate := iesp.ECL2ESP.toDate ((integer4) L.cmnt_effective_date);

    Self.Debtors2 := choosen (project (L.debtors, SetParties (Left)), iesp.Constants.UCCF.MaxDebtors);
		Self.Creditors2 := choosen (project (L.creditors, SetParties (Left)), iesp.Constants.UCCF.MaxCreditors);
		Self.Secureds2 := choosen (project (L.secureds,  SetParties (Left)), iesp.Constants.UCCF.MaxSecureds);
		Self.Assignees2 := choosen (project (L.assignees, SetParties (Left)), iesp.Constants.UCCF.MaxAssignees);
		Self.Collaterals2 := choosen (project (L.collateral, SetCollateral (Left)), iesp.Constants.UCCF.MaxCollaterals);
		Self.Signers := choosen (project (L.signers, SetSigners (Left)), iesp.Constants.UCCF.MaxSigners);
		Self.Filings2 := choosen (project (L.filings, SetFilings (Left)), iesp.Constants.UCCF.MaxFilings);
    Self.FilingOffices := choosen (project (L.filing_offices, SetFilingOffices (Left)), iesp.Constants.UCCF.MaxFilingOffices);
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(ucc_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'UCC_V2';
			self.src_desc := 'UCC Lien Filings';
			self.hasName 	:= exists(L.debtors(orig_name <>'')) or exists(L.secureds(orig_name <>''));
			self.hasSSN  	:= exists(L.debtors(exists(parsed_parties(ssn<>'')))) or
											 exists(L.secureds(exists(parsed_parties(ssn<>''))));
			self.hasDOB  	:= false; 
		  self.hasFEIN 	:= exists(L.debtors(exists(parsed_parties(fein<>'')))) or
											 exists(L.secureds(exists(parsed_parties(fein<>''))));		
			self.hasAddr 	:= exists(L.debtors(exists(addresses(orig_address1<>'' or orig_address2 <>'')))) or
											 exists(L.secureds(exists(addresses(orig_address1<>'' or orig_address2 <>''))));
		  self.hasPhone := false;
			self.dt_first_seen := ut.NormDate((unsigned)L.orig_filing_date);
			self.dt_last_seen := max(ut.NormDate((unsigned)L.orig_filing_date),ut.NormDate((unsigned)L.cmnt_effective_date));
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(ucc_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(ucc_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(ucc_sourceview_wLinkIds);

END;
