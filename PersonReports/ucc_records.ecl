import $, iesp, doxie, UCCv2_Services;

EXPORT ucc_records (
  dataset (doxie.layout_references) dids,
  $.IParam.ucc in_params = module ($.IParam.ucc) end,
  boolean IsFCRA = false
) := MODULE

  export uccr2 := UCCv2_Services.UCCRaw.source_view.by_did (dids, in_params.ssn_mask, in_params.ucc_party_type, in_params.application_type);
  //returns: uccv2_services.layout_ucc_rollup_src:

  iesp.ucc.t_UCCParsedParty FormatParties (uccv2_services.layout_ucc_party_parsed L, string120 Orig_name) := TRANSFORM
    Self.BusinessId := intformat(L.bdid, 12, 1);
		self.BusinessIDs.proxid := l.proxid;
		self.businessIDs.ultid := l.ultid;
		self.businessIDs.orgid := l.orgid;
		self.businessIDs.seleid := l.seleid;
		self.businessIDs.dotid := l.dotid;
		self.BusinessIDs.empid := l.empid;
		self.BusinessIDs.powid := l.powid;
    Self.UniqueId := (string) L.did;
	  Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    Self.SSN := L.ssn;
    Self.FEIN := L.fein;
    Self.IncorporatedState := L.Incorp_state;
    Self.CorporateNumber := L.corp_number;
    Self.CorporateType := L.corp_type;
		self.companyName := if (L.bdid != 0, orig_name, '');
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
		Self.OrigStreetAddress1:=L.orig_address1;
		Self.OrigStreetAddress2:=L.address2; 
  END;

  iesp.ucc.t_UCCReport2Person SetParties (uccv2_services.layout_ucc_party_src L) := TRANSFORM
    Self.OriginName := L.orig_name;
    Self.Addresses := choosen (project (L.addresses, FormatAddress (Left)), iesp.Constants.UCCF.MaxPersonAddresses);
    Self.ParsedParties := choosen (project (L.parsed_parties, FormatParties (Left, L.orig_name)), iesp.Constants.UCCF.MaxPersonParsedParties);
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
    Self.VendorUpdateDate.Year := (integer4) L.vendor_upd_date;
    Self.VendorUpdateDate.Month := 0;
    Self.VendorUpdateDate.Day := 0;
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

  iesp.ucc.t_UCCReport2Record toOut (uccv2_services.layout_ucc_rollup_src L) := transform
    Self.TMSId := L.tmsid;
    Self.FilingJurisdiction := L.filing_jurisdiction; //? state
    Self.FilingJurisdictionName := L.filing_jurisdiction_name;
    Self.OriginFilingNumber := L.orig_filing_number;
    Self.OriginFilingType := L.orig_filing_type;
	  Self.OriginFilingDate := iesp.ECL2ESP.toDate ((integer4) L.orig_filing_date);
    Self.OriginFilingTime := L.orig_filing_time;
		filingsCount := count(l.filings);
		Self.FilingStatus := L.filings[filingsCount].filing_status;//choosen (L.filing_status, 10); // hardcoded in ucc raw...
    Self.Comment := L.description;
    Self.CommentEffectiveDate := iesp.ECL2ESP.toDate ((integer4) L.cmnt_effective_date);

    // child datasets are shared between v1 - v2
    debtors := choosen (project (L.debtors, SetParties (Left)), iesp.Constants.UCCF.MaxDebtors);
	  Self.Debtors2 := project (debtors, iesp.ucc.t_UCCPerson);    

    creditors := choosen (project (L.creditors, SetParties (Left)), iesp.Constants.UCCF.MaxCreditors);
	  Self.Creditors := project (creditors, iesp.ucc.t_UCCPerson);
    Self.Creditors2 := creditors;

    secureds := choosen (project (L.secureds,  SetParties (Left)), iesp.Constants.UCCF.MaxSecureds);
	  Self.Secureds  := project (secureds, iesp.ucc.t_UCCPerson);
    Self.Secureds2 := secureds;

    assignees := choosen (project (L.assignees, SetParties (Left)), iesp.Constants.UCCF.MaxAssignees);
	  Self.Assignees  := project (assignees, iesp.ucc.t_UCCPerson);
	  Self.Assignees2 := assignees;

    collaterals := choosen (project (L.collateral, SetCollateral (Left)), iesp.Constants.UCCF.MaxCollaterals);
	  Self.Collaterals  := project (collaterals, iesp.ucc.t_UCCCollateral);
	  Self.Collaterals2 := collaterals;

    Self.Signers := choosen (project (L.signers, SetSigners (Left)), iesp.Constants.UCCF.MaxSigners);

    filings := choosen (project (L.filings, SetFilings (Left)), iesp.Constants.UCCF.MaxFilings);
	  Self.Filings := project (filings, iesp.ucc.t_UCCFiling);
	  Self.Filings2 := filings;

    Self.FilingOffices := choosen (project (L.filing_offices, SetFilingOffices (Left)), iesp.Constants.UCCF.MaxFilingOffices);
		Self := [];
	END;

  export ucc_v2 := if (~IsFCRA, project(uccr2, toOut(left))); //UCCFilingsNew2 in CRS

  export ucc := dataset ([], iesp.bpsreport.t_BpsUCCRecord); //UCCFilings in CRS

  export ucc_v1 := dataset ([], iesp.ucc.t_UCCReportRecord); //UCCFilingsNew in CRS

END;
