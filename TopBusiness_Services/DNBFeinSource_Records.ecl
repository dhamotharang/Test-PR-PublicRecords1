// ================================================================================
// ======    RETURNS DNB FEIN DATA FOR A GIVEN TMSID IN ESP-COMPLIANT WAY    ======
// ================================================================================
IMPORT BIPV2, Codes, DNB_FEINV2_Services, doxie_cbrs, iesp, TopBusiness_Services;

EXPORT DNBFeinSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
	
	
	SHARED dnbfein_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		DNB_FEINV2_services.layouts.layout_rollup;
	END;

	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get fbn tmsids from linkids
  ds_feinkeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly,inoptions.fetch_level
	                                                       ).ds_dnbfein_linkidskey_recs,
												 TRANSFORM(Layouts.rec_input_ids_wSrc,
													SELF.IdValue := LEFT.tmsid,
													SELF := LEFT,
													SELF := []));
	
	fein_keys_comb := in_docids+ds_feinkeys;

	fein_keys := PROJECT(fein_keys_comb(IdValue != ''),TRANSFORM(DNB_FEINV2_Services.layout_tmsid_ext,SELF.tmsid := LEFT.IdValue, SELF := []));
	
	fein_keys_dedup := DEDUP(fein_keys,ALL);
	
	 // Get the raw data from the appropriate view.
  fein_sourceview := DNB_FEINV2_Services.raw.source_view(dataset([],doxie_cbrs.layout_references),fein_keys_dedup,0,true); 
				
	SHARED fein_sourceview_wLinkIds := JOIN(fein_sourceview,fein_keys_comb,
																					LEFT.tmsid = RIGHT.IdValue,
																					TRANSFORM(dnbfein_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids;

  iesp.share.t_Address xform_address(DNB_FEINV2_Services.layouts.layout_address L) 
	  := transform
		self.StreetNumber        := ''; 
	  self.StreetPreDirection  := ''; 
	  self.StreetName          := ''; 
	  self.StreetSuffix        := ''; 
	  self.StreetPostDirection := ''; 
	  self.UnitDesignation     := ''; 
	  self.UnitNumber          := ''; 
	  self.StreetAddress1      := L.orig_address1;
	  self.StreetAddress2      := L.orig_address2;
	  self.City                := L.orig_city;
	  self.State               := L.orig_state;
	  self.Zip5                := L.orig_zip5;
	  self.Zip4                := L.orig_zip4;
	  self.County              := L.orig_county;
	  self.PostalCode          := '';
	  self.StateCityZip        := '';
  end;

  iesp.fein.t_FEINCompanyInfo xform_companyinfo(DNB_FEINV2_Services.layouts.layout_party L) 
	  := transform
	  self.CompanyName    := L.orig_company_name;
		self.SICCode 				:= L.sic_code;
		SELF.SicDescription	:= Codes.Key_SIC4(keyed(sic4_code = L.sic_code[1..4]))[1].sic4_description;
		self.TradeStyle			:= L.trade_style;
		self.Phone					:= L.telephone_number;
		self.AddressRecords := project(choosen(L.addresses,iesp.Constants.DNBFEIN.MAX_ADDRESSES),
		                               xform_address(left));
		ContactInfo := DATASET([ {L.top_contact_name,'','','','','',L.top_contact_title}],iesp.fein.t_FEINContactInfo);
		self.ContactRecords := ContactInfo;

  end;

  iesp.fein.t_FEINSearchRecord toOut(dnbfein_layout_wLinkIds L) 
	  := transform
		IDmacros.mac_IespTransferLinkids()
	  self.AlsoFound := false;
	  self.TMSId     := L.tmsid;
	  self.FEIN      := L.fein;
		self.FEINCompanyInfoRecords := project(choosen(L.parties,iesp.Constants.DNBFEIN.MAX_COMPANIES),
		                                       xform_companyinfo(left));
		self := [];
  end;

	EXPORT SourceView_Recs := project(fein_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(fein_sourceview_wLinkIds);

END;
