// ================================================================================
// ======       RETURNS FBN DATA FOR A GIVEN TMSID IN ESP-COMPLIANT WAY      ======
// ================================================================================
IMPORT BIPV2, FBNV2_services, iesp, TopBusiness_Services;

EXPORT FBNSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
  
	SHARED fbn_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		FBNV2_services.Layout_FBN_Report;
	END;

	// For in_docids records that don't have SourceDocIds (file_number) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get fbn tmsids from linkids
  ds_fbnkeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly,inoptions.fetch_level
	                                                      ).ds_fbn_linkidskey_recs,
												TRANSFORM(Layouts.rec_input_ids_wSrc,
													SELF.IdValue := LEFT.tmsid,
													SELF := LEFT,
													SELF := []));
	
	fbn_keys_comb := in_docids+ds_fbnkeys;

	fbn_keys := PROJECT(fbn_keys_comb(IdValue != ''),TRANSFORM(FBNV2_Services.Layout_search_IDs,SELF.tmsid := LEFT.IdValue, SELF := []));
	
	fbn_keys_dedup := DEDUP(fbn_keys,ALL);
	
  // Get the raw data from the appropriate view.
  fbn_sourceview := FBNV2_services.FBN_raw.report_view.by_rmsid (fbn_keys_dedup, false,false);
		
	SHARED fbn_sourceview_wLinkIds := JOIN(fbn_sourceview,fbn_keys_comb,
																					LEFT.tmsid = TRIM(RIGHT.IdValue),
																					TRANSFORM(fbn_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
																							
  // Ownerinfo child dataset transform
  iesp.fictitiousbusinesssearch.t_OwnerInformation xform_Contact(
                                     FBNV2_services.Layout_Contact L) := transform
	  self.UniqueId                    := (string) L.did;
		self.Name                        := L.CONTACT_NAME;
	  self.Phone                       := L.CONTACT_PHONE;
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
	  self.Address.Zip5                := L.zip5;
	  self.Address.Zip4                := L.zip4;
	  self.Address.County              := L.county_name;
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
		self.Address.Country             := '';
	  self.Address.Province            := '';
	  self.Address.IsForeign           := false;
	  self.ContactType                 := L.Contact_Type_decoded;
	  self.Status                      := L.CONTACT_STATUS;
	  self.NameFormat                  := L.Contact_Name_Format_decoded;
	  self.FEIN                        := L.CONTACT_FEI_NUM;
	  self.CharterNumber               := L.CONTACT_CHARTER_NUM;
	  self.WithdrawlDate               := iesp.ECL2ESP.toDate (L.WITHDRAWAL_DATE);
  end;
	
	// Transform for the main fbn iesp output layout
  iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord toOut 
	                             (fbn_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
	  self.TMSId                  := L.tmsid;
	  self.RMSId                  := L.rmsid;
	  self.FilingJurisdiction     := L.Filing_Jurisdiction;
	  self.FilingNumber           := L.FILING_NUMBER;
	  self.OriginalFilingNumber   := L.ORIG_FILING_NUMBER;
	  self.FilingType             := L.FILING_TYPE;
	  self.FilingDate             := iesp.ECL2ESP.toDate ((integer4) L.Filing_date);
	  self.OriginalFilingDate     := iesp.ECL2ESP.toDate ((integer4) L.ORIG_FILING_DATE);
	  self.FilingExpirationDate   := iesp.ECL2ESP.toDate ((integer4) L.EXPIRATION_DATE);
	  self.FilingCancellationDate := iesp.ECL2ESP.toDate ((integer4) L.CANCELLATION_DATE);
	  self.Business.BusinessId             := (string) L.bdid;
	  self.Business.Name                   := L.BUS_NAME;
	  self.Business.SICCode                := L.SIC_CODE;
	  self.Business.TypeDescription        := L.BUS_TYPE_DESC;
	  self.Business.FEIN                   := L.orig_FEIN;
	  self.Business.Phone                  := L.BUS_PHONE_NUM;
	  self.Business.Status                 := L.bus_statUS;
	  self.Business.StartDate              := iesp.ECL2ESP.toDate ((integer4) L.bus_comm_dATE);
	  self.Business.OfficeAddress.StreetNumber         := L.prim_range;
	  self.Business.OfficeAddress.StreetPreDirection   := L.predir;
	  self.Business.OfficeAddress.StreetName           := L.prim_name;
	  self.Business.OfficeAddress.StreetSuffix         := L.addr_suffix;
	  self.Business.OfficeAddress.StreetPostDirection  := L.postdir;
	  self.Business.OfficeAddress.UnitDesignation      := L.unit_desig;
	  self.Business.OfficeAddress.UnitNumber           := L.sec_range;
	  self.Business.OfficeAddress.StreetAddress1       := '';
	  self.Business.OfficeAddress.StreetAddress2       := '';
	  self.Business.OfficeAddress.City                 := L.v_city_name;
	  self.Business.OfficeAddress.State                := L.st;
	  self.Business.OfficeAddress.Zip5                 := L.zip5;
	  self.Business.OfficeAddress.Zip4                 := L.zip4;
	  self.Business.OfficeAddress.County               := L.BUS_COUNTY;//??? or get_county_name(...???
	  self.Business.OfficeAddress.PostalCode           := '';
	  self.Business.OfficeAddress.StateCityZip         := '';
		self.Business.OfficeAddress.Country              := L.BUS_COUNTRY;
	  self.Business.OfficeAddress.Province             := '';
	  self.Business.OfficeAddress.IsForeign            := false;
	  self.Business.MailingAddress.StreetNumber        := L.mail_prim_range;
	  self.Business.MailingAddress.StreetPreDirection  := L.mail_predir;
	  self.Business.MailingAddress.StreetName          := L.mail_prim_name;
	  self.Business.MailingAddress.StreetSuffix        := L.mail_addr_suffix;
	  self.Business.MailingAddress.StreetPostDirection := L.mail_postdir;
	  self.Business.MailingAddress.UnitDesignation     := L.mail_unit_desig;
	  self.Business.MailingAddress.UnitNumber          := L.mail_sec_range;
	  self.Business.MailingAddress.StreetAddress1      := '';
	  self.Business.MailingAddress.StreetAddress2      := '';
	  self.Business.MailingAddress.City                := L.mail_v_city_name;
	  self.Business.MailingAddress.State               := L.mail_st;
	  self.Business.MailingAddress.Zip5                := L.mail_zip5;
	  self.Business.MailingAddress.Zip4                := L.mail_zip4;
		self.Business.MailingAddress.County              := if(L.mail_st<>'' and L.mail_fips_county<>'',
			                                                     Functions_Source.get_county_name(L.mail_st, L.mail_fips_county),'');
	  self.Business.MailingAddress.PostalCode          := '';
	  self.Business.MailingAddress.StateCityZip        := '';
		// v--- is this really just "Owners"(?) or should all "Contacts" be output???
		self.Owners := project(choosen(L.Contacts,iesp.Constants.FBN.MaxCountOwners),
		                       xform_Contact(left)); 
		self := [];
  end;

	EXPORT SourceView_Recs := project(fbn_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(fbn_sourceview_wLinkIds);

END;
