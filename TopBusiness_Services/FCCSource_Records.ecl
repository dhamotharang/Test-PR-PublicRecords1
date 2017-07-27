// ================================================================================
// ======   RETURNS FCC DATA FOR A GIVEN FCC_SEQ IN ESP-COMPLIANT WAY  =====
// ================================================================================
IMPORT FCC_Services, FCC, iesp, BIPV2;

EXPORT FCCSource_Records( 
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions,
	boolean IsFCRA = false) 
 := MODULE
	
	SHARED fcc_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		FCC_Services.layouts.SourceOutput;
	END;
	
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get fcc_seq id's from linkids
  ds_fcckeys := PROJECT(FCC.Key_FCC_Linkids.kFetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := (STRING) LEFT.fcc_seq,
																					SELF := LEFT,
																					SELF := []));
	
	fcc_keys_comb := in_docids+ds_fcckeys;

	fcc_keys := PROJECT(fcc_keys_comb(IdValue != ''),TRANSFORM(FCC_Services.layouts.id,SELF.fcc_seq := (INTEGER) LEFT.IdValue, SELF := []));
	
	fcc_keys_dedup := DEDUP(fcc_keys,ALL);
	
  // Get the raw data from the appropriate view
	fcc_sourceview := FCC_Services.raw.SOURCE_VIEW.by_id(fcc_keys_dedup,inoptions.app_type);

	SHARED fcc_sourceview_wLinkIds := JOIN(fcc_sourceview,fcc_keys_comb,
																					(STRING) LEFT.FCC_seq = RIGHT.IdValue,
																					TRANSFORM(fcc_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
																							
  // Transform for the iesp output layout
  iesp.fcclicense.t_FCCLicenseReportRecord toOut (fcc_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
	  self.FCCIdNumber        := (string)L.FCC_seq; //is this the right base file (L) field ???
    self.LicenseeInfo.Name  := L.clean_licensees_name;
	  self.LicenseeInfo.Phone := L.licensees_phone;
		self.LicenseeInfo.Address.StreetNumber        := L.address.prim_range;
	  self.LicenseeInfo.Address.StreetPreDirection  := L.address.predir;
	  self.LicenseeInfo.Address.StreetName          := L.address.prim_name;
	  self.LicenseeInfo.Address.StreetSuffix        := L.address.addr_suffix;
	  self.LicenseeInfo.Address.StreetPostDirection := L.address.postdir;
	  self.LicenseeInfo.Address.UnitDesignation     := L.address.unit_desig;
	  self.LicenseeInfo.Address.UnitNumber          := L.address.sec_range;
	  self.LicenseeInfo.Address.StreetAddress1      := '';
	  self.LicenseeInfo.Address.StreetAddress2      := '';
	  self.LicenseeInfo.Address.City                := L.address.v_city_name;
	  self.LicenseeInfo.Address.State               := L.address.st;
	  self.LicenseeInfo.Address.Zip5                := L.address.zip5;
	  self.LicenseeInfo.Address.Zip4                := L.address.zip4;
	  self.LicenseeInfo.Address.County              := if(L.address.st<>'' and L.address.fips_county<>'',
			                                                  Functions_Source.get_county_name(L.address.st, L.address.fips_county),'');
	  self.LicenseeInfo.Address.PostalCode          := '';
	  self.LicenseeInfo.Address.StateCityZip        := '';
		self.LicenseeInfo.ContactFirmAddress.StreetNumber        := L.addr_firm.prim_range;
	  self.LicenseeInfo.ContactFirmAddress.StreetPreDirection  := L.addr_firm.predir;
	  self.LicenseeInfo.ContactFirmAddress.StreetName          := L.addr_firm.prim_name;
	  self.LicenseeInfo.ContactFirmAddress.StreetSuffix        := L.addr_firm.addr_suffix;
	  self.LicenseeInfo.ContactFirmAddress.StreetPostDirection := L.addr_firm.postdir;
	  self.LicenseeInfo.ContactFirmAddress.UnitDesignation     := L.addr_firm.unit_desig;
	  self.LicenseeInfo.ContactFirmAddress.UnitNumber          := L.addr_firm.sec_range;
	  self.LicenseeInfo.ContactFirmAddress.StreetAddress1      := '';
	  self.LicenseeInfo.ContactFirmAddress.StreetAddress2      := '';
	  self.LicenseeInfo.ContactFirmAddress.City                := L.addr_firm.v_city_name;
	  self.LicenseeInfo.ContactFirmAddress.State               := L.addr_firm.st;
	  self.LicenseeInfo.ContactFirmAddress.Zip5                := L.addr_firm.zip5;
	  self.LicenseeInfo.ContactFirmAddress.Zip4                := L.addr_firm.zip4;
	  self.LicenseeInfo.ContactFirmAddress.County              := if(L.addr_firm.st<>'' and L.addr_firm.fips_county<>'',
		             	                                                 Functions_Source.get_county_name(L.addr_firm.st, L.addr_firm.fips_county),'');
	  self.LicenseeInfo.ContactFirmAddress.PostalCode          := '';
	  self.LicenseeInfo.ContactFirmAddress.StateCityZip        := '';
	  self.LicenseeInfo.ContactFirmPhone     := L.contact_firms_phone_number;
	  self.LicenseeInfo.ContactFirmFax       := L.contact_firms_fax_number;
		self.LicenseeInfo.AttentionName.Full   := ''; 
		self.LicenseeInfo.AttentionName.First  := L.name_attention.fname; 
		self.LicenseeInfo.AttentionName.Middle := L.name_attention.mname;
		self.LicenseeInfo.AttentionName.Last   := L.name_attention.lname;
		self.LicenseeInfo.AttentionName.Suffix := L.name_attention.name_suffix;
		self.LicenseeInfo.AttentionName.Prefix := L.name_attention.title;
	  self.LicenseeInfo.AttentionLine        := L.licensees_attention_line;
	  self.LicenseeInfo.FirmPreparingApplication := L.firm_preparing_application;

	  self.LicenseInfo.CallsignOfLicense       := L.callsign_of_license;
	  self.LicenseInfo.LicenseType             := L.license_type_desc;
	  self.LicenseInfo.FileNumber              := L.file_number;
	  self.LicenseInfo._Service                := L.service_code_desc;
	  self.LicenseInfo.FCCLicenseReviedAppDate := iesp.ECL2ESP.toDate ((integer4) L.date_application_received_at_FCC);
	  self.LicenseInfo.LicenseIssuedDate       := iesp.ECL2ESP.toDate ((integer4) L.date_license_issued);
	  self.LicenseInfo.LicenseExpiredDate      := iesp.ECL2ESP.toDate ((integer4) L.date_license_expires);
	  self.LicenseInfo.LastChangeDate          := iesp.ECL2ESP.toDate ((integer4) L.date_of_last_change);
	  self.LicenseInfo.LastChangeType          := L.last_change_desc;
	  self.LicenseInfo.PendingOrGranted        := L.pending_granted_desc;
	  self.LicenseInfo.PagingLicenseStatus     := L.paging_license_status;

		self.AntenaSiteInfo.Address.StreetNumber          := '';
	  self.AntenaSiteInfo.Address.StreetPreDirection    := '';
	  self.AntenaSiteInfo.Address.StreetName            := '';
	  self.AntenaSiteInfo.Address.StreetSuffix          := '';
	  self.AntenaSiteInfo.Address.StreetPostDirection   := '';
	  self.AntenaSiteInfo.Address.UnitDesignation       := '';
	  self.AntenaSiteInfo.Address.UnitNumber            := '';
	  self.AntenaSiteInfo.Address.StreetAddress1        := L.transmitters_street;
	  self.AntenaSiteInfo.Address.StreetAddress2        := '';
	  self.AntenaSiteInfo.Address.City                  := L.transmitters_city;
	  self.AntenaSiteInfo.Address.State                 := L.transmitters_state;
	  self.AntenaSiteInfo.Address.Zip5                  := '';
	  self.AntenaSiteInfo.Address.Zip4                  := '';
	  self.AntenaSiteInfo.Address.County                := L.transmitters_county;
	  self.AntenaSiteInfo.Address.PostalCode            := '';
	  self.AntenaSiteInfo.Address.StateCityZip          := '';
	  self.AntenaSiteInfo.TransmitrsAntenna_height      := L.transmitters_antenna_height;
	  self.AntenaSiteInfo.TransmitrsHeightAbvAvgTerrain := L.transmitters_height_above_avg_terra;
	  self.AntenaSiteInfo.TransmitrsheightAbvGrndLvl    := L.transmitters_height_above_ground_le;
	  self.AntenaSiteInfo.ControlPointForTheSystem      := L.control_point_for_the_system;
	  self.AntenaSiteInfo.Latitude                      := L.latitude;
	  self.AntenaSiteInfo.Longitude                     := L.longitude;

	  self.FrequencyInfo.FrequencyMhz                := L.frequency_Mhz;
	  self.FrequencyInfo.ClassOfStation              := L.class_of_station;
	  self.FrequencyInfo.PowerOfFrequency            := L.power_of_this_frequency;
	  self.FrequencyInfo.EmissionsCodes              := L.emissions_codes;
	  self.FrequencyInfo.NmbrOfUnitsAuthorizedOnFreq := L.number_of_units_authorized_on_freq;
	  self.FrequencyInfo.EffectiveRadiatedPower      := L.effective_radiated_power;
	  self.FrequencyInfo.FrequencyCoordinationNumber := L.frequency_coordination_number;

  end;
	 
	EXPORT SourceView_Recs := project(fcc_sourceview_wLinkIds, toOut(left));
	EXPORT SourceView_RecCount := COUNT(fcc_sourceview_wLinkIds);
END;
