// ================================================================================
// === RETURNS DEA DATA FOR A GIVEN DEA_REGISTRATION_NUMBER IN ESP-COMPLIANT WAY ==
// ================================================================================
IMPORT DeaV2_Services, DEA, BIPV2, iesp;

EXPORT DEASource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions,
	boolean IsFCRA = false) 
 := MODULE
 
	SHARED dea_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		DeaV2_Services.Assorted_Layouts.Layout_Output;
	END;
	
	
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get fcc_seq id's from linkids
  ds_deakeys := PROJECT(DEA.Key_dea_linkids.kFetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.dea_registration_number,
																					SELF := LEFT,
																					SELF := []));
	
	dea_keys_comb := in_docids+ds_deakeys;

	dea_keys := PROJECT(dea_keys_comb(IdValue != ''),TRANSFORM(DeaV2_Services.assorted_layouts.layout_search_IDs,SELF.Dea_Registration_Number := LEFT.IdValue, SELF := []));
	
	dea_keys_dedup := DEDUP(dea_keys,ALL);
	
  // Get the raw data from the appropriate view
  dea_sourceview := DeaV2_Services.DEA_raw.search_view.by_deakey(dea_keys_dedup,inoptions.ssn_mask,inoptions.app_type);
	
	SHARED dea_sourceview_wLinkIds := JOIN(dea_sourceview,dea_keys_comb,
																					(STRING) LEFT.Dea_Registration_Number = RIGHT.IdValue,
																					TRANSFORM(dea_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
																							
  iesp.deacontrolledsubstance.t_DEAControlledSubstanceRecord xform_contsub(DeaV2_Services.assorted_layouts.Layout_Output_Child L) := transform
    self.SSN              := L.best_ssn;
	  self.CompanyName      := L.Cname;
	  self.Name.Full        := '';
		self.Name.First       := L.fname;
		self.Name.Middle      := L.mname;
		self.Name.Last        := L.lname;
		self.Name.Suffix      := L.name_suffix;
		self.Name.Prefix      := L.title;
	  self.Address.StreetNumber        := L.prim_range;
	  self.Address.StreetPreDirection  := L.predir;
	  self.Address.StreetName          := L.prim_name;
	  self.Address.StreetSuffix        := L.addr_suffix;
	  self.Address.StreetPostDirection := L.postdir;
	  self.Address.UnitDesignation     := L.unit_desig;
	  self.Address.UnitNumber          := L.sec_range;
	  self.Address.StreetAddress1      := '';
	  self.Address.StreetAddress2      := '';
	  self.Address.City                := L.v_city_name;
	  self.Address.State               := L.st;
	  self.Address.Zip5                := L.zip;
	  self.Address.Zip4                := L.zip4;
	  self.Address.County              := ''; 
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
	  self.BusinessType                := L.Bussiness_Type;
	  self.DrugSchedules  := L.Drug_Schedules;
	  self.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.Expiration_Date);
    self.HasCriminalConviction :=L.hasCriminalConviction;
    self.IsSexualOffender := L.isSexualOffender;
    self.ExternalKey := '';
  end;

  iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record toOut (dea_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
		self.AlsoFound          := false; 
		self.RegistrationNumber := L.Dea_Registration_Number;
		self.ControlledSubstancesInfo := project(choosen(L.Children,iesp.constants.MAX_COUNT_DEA_REGISTRATION),
		                                         xform_contsub(left));
  end;

	EXPORT SourceView_Recs := project(dea_sourceview_wLinkIds, toOut(left));
	EXPORT SourceView_RecCount := COUNT(dea_sourceview_wLinkIds);

END;
