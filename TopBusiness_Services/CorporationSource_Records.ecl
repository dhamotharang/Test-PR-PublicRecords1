//=================================================================================
// ====== RETURNS CORPORATION DATA FOR A GIVEN CORP_KEY IN ESP-COMPLIANT WAY. =====
// ================================================================================
IMPORT Corp2_Services, Corp2, BIPV2, iesp, ut;
	
EXPORT CorporationSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,  
	boolean IsFCRA = false  
  ):= MODULE
	
	
	SHARED corp_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		corp2_services.layout_corp2_rollup;
	END;
	
	// For in_docids records that don't have SourceDocIds (corp_keys) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get incorporation filing data
  ds_corpkeys := PROJECT(Corp2.Key_Linkids.Corp.kFetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.corp_key,
																					SELF := LEFT,
																					SELF := []));
	
	corp_keys_comb :=in_docids+ds_corpkeys;
	
	corp_keys := PROJECT(corp_keys_comb(IdValue != ''),TRANSFORM(Corp2_Services.layout_Search_IDs,SELF.corp_key := LEFT.IdValue));
	
	corp_keys_dedup := DEDUP(corp_keys,ALL);
	
  corp_sourceview := Corp2_Services.corp2_raw.source_view.by_corpkey(corp_keys_dedup);
		
	SHARED corp_sourcetview_wLinkIds := JOIN(corp_sourceview,corp_keys_comb,
																					LEFT.corp_key = RIGHT.IdValue,
																					TRANSFORM(corp_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids;

  // transforms for the various iesp.corporate child dataset layouts
  iesp.corporate.t_CorpReportHistory xform_hist(Corp2_Services.layout_corps_out L) := TRANSFORM
	  self.SupplementalNumber     := L.corp_supp_nbr;
	  self.Vendor                 := L.corp_vendor;
	  self.VendorCounty           := L.corp_vendor_county;
	  self.VendorSubcode          := L.corp_vendor_subcode;
	  self.AdditionalInfo         := L.corp_addl_info;
	  self.RecordType             := L.record_type;
		self.RecordTypeDesc         := L.record_date;
	  self.DateLastSeen           := iesp.ECL2ESP.toDate ((integer4) L.dt_last_seen);
	  self.CompanyName            := L.corp_legal_name;
	  self.CompanyNameComment     := L.corp_name_comment;
	  self.FederalTaxId           := L.corp_fed_tax_id;
	  self.StateTaxId             := L.corp_state_tax_id;
		self.Address.StreetNumber        := L.corp_addr1_prim_range;
	  self.Address.StreetPreDirection  := L.corp_addr1_predir;
	  self.Address.StreetName          := L.corp_addr1_prim_name;
	  self.Address.StreetSuffix        := L.corp_addr1_addr_suffix;
	  self.Address.StreetPostDirection := L.corp_addr1_postdir;
	  self.Address.UnitDesignation     := L.corp_addr1_unit_desig;
	  self.Address.UnitNumber          := L.corp_addr1_sec_range;
	  self.Address.StreetAddress1      := '';
	  self.Address.StreetAddress2      := '';
	  self.Address.City                := L.corp_addr1_p_city_name;
	  self.Address.State               := L.corp_addr1_state;
	  self.Address.Zip5                := L.corp_addr1_zip5;
	  self.Address.Zip4                := L.corp_addr1_zip4;
	  self.Address.County              := ''; 
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
		self.Address._Type               := L.corp_address1_type_desc;
	  self.AddressEffectiveDate        := iesp.ECL2ESP.toDate ((integer4) L.corp_address1_effective_date);
		self.Address2.StreetNumber        := L.corp_addr2_prim_range;
	  self.Address2.StreetPreDirection  := L.corp_addr2_predir;
	  self.Address2.StreetName          := L.corp_addr2_prim_name;
	  self.Address2.StreetSuffix        := L.corp_addr2_addr_suffix;
	  self.Address2.StreetPostDirection := L.corp_addr2_postdir;
	  self.Address2.UnitDesignation     := L.corp_addr2_unit_desig;
	  self.Address2.UnitNumber          := L.corp_addr2_sec_range;
	  self.Address2.StreetAddress1      := '';
	  self.Address2.StreetAddress2      := '';
	  self.Address2.City                := L.corp_addr2_p_city_name;
	  self.Address2.State               := L.corp_addr2_state;
	  self.Address2.Zip5                := L.corp_addr2_zip5;
	  self.Address2.Zip4                := L.corp_addr2_zip4;
	  self.Address2.County              := ''; // ???
	  self.Address2.PostalCode          := '';
	  self.Address2.StateCityZip        := '';
		self.Address2._Type               := L.corp_address2_type_desc;
	  self.Address2EffectiveDate        := iesp.ECL2ESP.toDate ((integer4) L.corp_address2_effective_date);
	  self.LegalContact.PhoneNumber     := L.corp_phone10;
	  self.LegalContact.PhoneNumberType := L.corp_phone_number_type_desc;
	  self.LegalContact.Fax             := L.corp_fax_nbr;
	  self.LegalContact.EMail           := L.corp_email_address;
	  self.LegalContact.WebAddress      := L.corp_web_address;
	  self.Status           						:= L.corp_status_desc;
	  self.StatusDate       						:= iesp.ECL2ESP.toDate ((integer4) L.corp_status_date);
	  self.StatusComment    						:= L.corp_status_comment;
	  self.IncorporateState 						:= L.corp_inc_state;
	  self.IncorporateDate  						:= iesp.ECL2ESP.toDate ((integer4) L.corp_inc_date);
		self.RegisteredAgent.Address.StreetNumber        := L.corp_ra_prim_range;
	  self.RegisteredAgent.Address.StreetPreDirection  := L.corp_ra_predir;
	  self.RegisteredAgent.Address.StreetName          := L.corp_ra_prim_name;
	  self.RegisteredAgent.Address.StreetSuffix        := L.corp_ra_addr_suffix;
	  self.RegisteredAgent.Address.StreetPostDirection := L.corp_ra_postdir;
	  self.RegisteredAgent.Address.UnitDesignation     := L.corp_ra_unit_desig;
	  self.RegisteredAgent.Address.UnitNumber          := L.corp_ra_sec_range;
	  self.RegisteredAgent.Address.StreetAddress1      := '';
	  self.RegisteredAgent.Address.StreetAddress2      := '';
	  self.RegisteredAgent.Address.City                := L.corp_ra_p_city_name;
	  self.RegisteredAgent.Address.State               := L.corp_ra_state;
	  self.RegisteredAgent.Address.Zip5                := L.corp_ra_zip5;
	  self.RegisteredAgent.Address.Zip4                := L.corp_ra_zip4;
	  self.RegisteredAgent.Address.County              := '';
	  self.RegisteredAgent.Address.PostalCode          := '';
	  self.RegisteredAgent.Address.StateCityZip        := '';
		self.RegisteredAgent.Address._Type               := L.corp_ra_address_type_desc;
		self.RegisteredAgent.Name.Full                   := L.corp_ra_name;
		self.RegisteredAgent.Name.First                  := L.corp_ra_fname1;
		self.RegisteredAgent.Name.Middle                 := L.corp_ra_mname1;
		self.RegisteredAgent.Name.Last                   := L.corp_ra_lname1;
		self.RegisteredAgent.Name.Suffix                 := '';
		self.RegisteredAgent.Name.Prefix                 := '';
		self.RegisteredAgent.LegalContact.PhoneNumber     := L.corp_ra_phone10;
	  self.RegisteredAgent.LegalContact.PhoneNumberType := L.corp_ra_phone_number_type_desc;
	  self.RegisteredAgent.LegalContact.Fax             := L.corp_ra_fax_nbr;
	  self.RegisteredAgent.LegalContact.EMail           := L.corp_ra_email_address;
	  self.RegisteredAgent.LegalContact.WebAddress      := L.corp_ra_web_address;
	  self.RegisteredAgent.Title       									:= L.corp_ra_title_desc;
	  self.RegisteredAgent.SSN         									:= L.corp_ra_ssn;
	  self.RegisteredAgent.FEIN        									:= L.corp_ra_fein;
	  self.RegisteredAgent.ResignDate  									:= iesp.ECL2ESP.toDate ((integer4) L.corp_ra_resign_date);
	  self.RegisteredAgent.AsAgentDate 									:= iesp.ECL2ESP.toDate ((integer4) L.corp_ra_effective_date);
 	 
		self.ForeignInfo.IncorporationState    := L.corp_forgn_state_desc; //OR corp_forgn_state_desc???
	  self.ForeignInfo.CharterNumber         := L.corp_forgn_sos_charter_nbr;
	  self.ForeignInfo.IncorporateDate       := iesp.ECL2ESP.toDate ((integer4) L.corp_forgn_date);
	  self.ForeignInfo.FederalTaxId          := L.corp_forgn_fed_tax_id;
	  self.ForeignInfo.StateTaxId            := L.corp_forgn_state_tax_id;
		self.ForeignInfo.ForeignDomesticInd    := L.corp_foreign_domestic_ind;
	  self.ForeignInfo.TermOfExistence.Code  := L.corp_forgn_term_exist_cd;
	  self.ForeignInfo.TermOfExistence._Type := L.corp_forgn_term_exist_desc;
	  self.ForeignInfo.TermOfExistence.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.corp_forgn_term_exist_exp);
	  self.ForeignInfo.TermOfExistence.Years := 0; 
	  self.NameType              					:= L.corp_ln_name_type_desc;
	  self.FilingReferenceNumber 					:= L.corp_filing_reference_nbr;
	  self.FilingDate            					:= iesp.ECL2ESP.toDate ((integer4) L.corp_filing_date);
	  self.FilingType            					:= L.corp_filing_desc;
	  self.IsGoodStanding        					:= if(stringlib.StringCleanSpaces(L.corp_standing)='Y',true,false); //???
	  self.TickerSymbol          					:= L.corp_ticker_symbol;
	  self.StockExchange         					:= L.corp_stock_exchange;
	  self.IncorporateCounty     					:= L.corp_inc_county;
	  self.AnniversaryMonth      					:= (integer) L.corp_anniversary_month;
	  self.TermOfExistence.Code           := L.corp_term_exist_cd;
	  self.TermOfExistence._Type          := L.corp_term_exist_desc;
	  self.TermOfExistence.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.corp_term_exist_exp);
	  self.TermOfExistence.Years          := 0;
	  self.TaxInfo.TaxesOwnedToState 			:= 0; 
	  self.TaxInfo.TaxesOwedToState 		 	:= (integer) stringlib.StringFilterOut(L.corp_taxes,',');
	  self.TaxInfo.FranchiseTaxes    			:= L.corp_franchise_taxes;
	  self.TaxInfo.TaxProgram        			:= L.corp_tax_program_desc;
	  self.CompanyType.OrganizeStructure 	:= L.corp_orig_org_structure_desc;
		self.CompanyType.IsForProfit       	:= if(stringlib.StringCleanSpaces(L.corp_for_profit_ind)='Y',true,false);
	  self.CompanyType.IsForProfit2				:= stringlib.StringCleanSpaces(L.corp_for_profit_ind);
	  self.CompanyType.IsPublic          	:= if(stringlib.StringCleanSpaces(L.corp_public_or_private_ind)='Y',true,false);
		self.CompanyType.IsPublic2					:= stringlib.StringCleanSpaces(L.corp_public_or_private_ind);
		self.CompanyType.PublicOrPrivate   	:= L.corp_public_or_private_ind_decoded;
	  self.CompanyType.SICCode           	:= L.corp_sic_code;
	  self.CompanyType.SubCode          	:= L.corp_naic_code;
	  self.CompanyType.BusinessType      	:= L.corp_orig_bus_type_desc;
	  self.CompanyType.EntityType        	:= L.corp_entity_desc;
	  self.CompanyType.CertificateNumber 	:= L.corp_certificate_nbr;
	  self.CompanyType.MicrofilmNumber2   := L.corp_microfilm_nbr;
	  self.CompanyType.AmendmentsFiled2   := L.corp_amendments_filed;
	  self.CompanyType.LegislativeActs   	:= L.corp_acts;
	  self.CompanyType.Partnerable       	:= if(stringlib.StringCleanSpaces(L.corp_partnership_ind)='Y',true,false); //???
	  self.CompanyType.Manufacturerable  	:= if(stringlib.StringCleanSpaces(L.corp_mfg_ind)='Y',true,false); //???
	  self.CompanyType.AdditionalInfo    	:= L.corp_addl_info;

	  self.RawAddress  := DATASET([L.corp_address1_line1,L.corp_address1_line2,
																 L.corp_address1_line3,L.corp_address1_line4,
																 L.corp_address1_line5,L.corp_address1_line6],iesp.share.t_StringArrayItem);
		
		self.RawAddress2 := DATASET([L.corp_address2_line1,L.corp_address2_line2,
																 L.corp_address2_line3,L.corp_address2_line4,
																 L.corp_address2_line5,L.corp_address2_line6],iesp.share.t_StringArrayItem);
	  
		self.RegisteredAgent.RawAddress	:= DATASET([L.corp_ra_address_line1,L.corp_ra_address_line2,
																										 L.corp_ra_address_line3,L.corp_ra_address_line4,
																										 L.corp_ra_address_line5,L.corp_ra_address_line6],iesp.share.t_StringArrayItem);
		self := [];
  end;

  iesp.corporate.t_CorpReportContactType xform_cont_title(Corp2_Services.layout_titles L) := TRANSFORM
	  self._Type := L.cont_type_desc;
	  self.Title := L.cont_title_desc;
  END;
	
 iesp.share.t_NameAndCompany xform_cont_name(Corp2_Services.layout_search_names L) := TRANSFORM
	  SELF.Full 	 			:= L.cont_name;
		SELF.CompanyName 	:= L.cont_cname;
	  SELF.First   			:= L.cont_fname;
		SELF.Middle				:= L.cont_mname;
		SELF.Last					:= L.cont_lname;
		SELF.Suffix				:= L.cont_name_suffix;
		SELF.Prefix				:= '';
  END;

	iesp.share.t_AddressWithType xform_cont_addr(Corp2_Services.layout_addresses L) := TRANSFORM
		SELF.StreetNumber        := L.cont_prim_range;
	  SELF.StreetPreDirection  := L.cont_predir;
	  SELF.StreetName          := L.cont_prim_name;
	  SELF.StreetSuffix        := L.cont_addr_suffix;
	  SELF.StreetPostDirection := L.cont_postdir;
	  SELF.UnitDesignation     := L.cont_unit_desig;
	  SELF.UnitNumber          := L.cont_sec_range;
	  SELF.StreetAddress1      := '';
	  SELF.StreetAddress2      := '';
	  SELF.City                := L.cont_p_city_name; 
	  SELF.State               := L.cont_state;
	  SELF.Zip5                := L.cont_zip5;
	  SELF.Zip4                := L.cont_zip4;
	  SELF.County              := L.cont_address_county;
	  SELF.PostalCode          := '';
	  SELF.StateCityZip        := '';
		SELF._Type               := L.cont_address_type_desc;
	END;
	
	iesp.corporate.t_CorpReportContact xform_contacts(Corp2_Services.layout_contact_out L) := TRANSFORM
		self.RecordType            := L.record_type;
		self.RecordTypeDesc        := L.record_date;
		self.Status                := L.cont_status_desc;
	  self.AsOfDate              := [];
	  self.FilingDate            := iesp.ECL2ESP.toDate ((integer4) L.cont_filing_date);
	  self.FilingType            := L.cont_filing_desc;
	  self.FilingReferenceNumber := L.cont_filing_reference_nbr;
	  self.CompanyName           := L.corp_legal_name;
	  self.UniqueId              := L.did;
	  self.CharterNumber         := L.cont_sos_charter_nbr;
	  self.SSN                      := L.cont_ssn;
	  self.FEIN                     := L.cont_fein;
	  self.DOB                      := iesp.ECL2ESP.toDate ((integer4) L.cont_dob);
	  self.AsAgentDate              := []; 
	  self.ResignDate               := []; 
	  self.CompaniesRepresented     := 0; 
	  self.GoodStandingsRepresented := 0;
	  self.AdditionalInfo           := L.cont_addl_info;
	  self.EffectiveDate            := iesp.ECL2ESP.toDate ((integer4) L.cont_effective_date);
	  self.EffectiveDescription     := L.cont_effective_desc;
	  self.LegalContact.PhoneNumber     := L.addresses[1].cont_phone10;
	  self.LegalContact.PhoneNumberType := L.addresses[1].cont_phone_number_type_desc;
	  self.LegalContact.Fax             := L.addresses[1].cont_fax_nbr;
	  self.LegalContact.EMail           := L.addresses[1].cont_email_address;
	  self.LegalContact.WebAddress      := L.addresses[1].cont_web_address;
		self.RawAddress  := DATASET([L.addresses[1].cont_address_line1,L.addresses[1].cont_address_line2,
																 L.addresses[1].cont_address_line3,L.addresses[1].cont_address_line4,
																 L.addresses[1].cont_address_line5,L.addresses[1].cont_address_line6],iesp.share.t_StringArrayItem);
		self.Names := project(choosen(L.names,iesp.Constants.CORP.MAX_CONTACT_NAMES),xform_cont_name(left));
		self.Addresses := project(choosen(L.addresses,iesp.Constants.CORP.MAX_CONTACT_ADDR),xform_cont_addr(left));
    self.ContactTypes := project(choosen(L.title_descriptions,iesp.Constants.CORP.MAX_CONTACT_TYPES),xform_cont_title(left)); 
		self := [];
  end;

	iesp.corporate.t_CorpReportEvent xform_events(Corp2_Services.layout_events_out L) 
	  := transform
	  self.ReferenceNumber     := L.event_filing_reference_nbr;
	  self.AmendmentNumber     := L.event_amendment_nbr;
	  self.FilingDate          := iesp.ECL2ESP.toDate ((integer4) L.event_filing_date);
	  self.DateType            := L.event_date_type_desc;
	  self.DateTypeCode        := L.event_date_type_cd;
	  self.FilingType          := L.event_filing_desc;
	  self.FilingTypeCode      := L.event_filing_cd;
	  self.CorporateNumber     := L.event_corp_nbr;
	  self.CorporateNumberCode := L.event_corp_nbr_cd;
	  self.CorporateNumberType := L.event_corp_nbr_desc;
	  self.MicrofilmRoll2      := L.event_roll;
	  self.MicrofilmNumber2    := L.event_microfilm_nbr;
		self.MircofilmFrame			 := L.event_frame;
		self.MircofilmStart			 := L.event_start;
		self.MircofilmEnd				 := L.event_end;
	  self.StartDate           := iesp.ECL2ESP.toDate ((integer4) L.event_start);
	  self.EndDate             := iesp.ECL2ESP.toDate ((integer4) L.event_end);
	  self.EventDescription    := L.event_desc;
		self := [];
  end;

	iesp.corporate.t_CorpReportStock xform_stocks(Corp2_Services.layout_stocks_out L) := TRANSFORM
	  self.TickerSymbol      := L.stock_ticker_symbol;
	  self.Exchange          := L.stock_exchange;
	  self._Type             := L.stock_type;
	  self.Class             := L.stock_class;
	  self.SharesIssued3     := stringlib.StringFilterOut(L.stock_shares_issued,',');
	  self.SharesAuthorized3 := stringlib.StringFilterOut(L.stock_authorized_nbr,',');
	  self.ParValue2         := stringlib.StringFilterOut(L.stock_par_value,',');
	  self.NoParShares2      := stringlib.StringFilterOut(L.stock_nbr_par_shares,',');
	  self.IsChanged         := if(stringlib.StringCleanSpaces(L.stock_change_ind)='Y',true, false); 
	  self.ChangeDate        := iesp.ECL2ESP.toDate ((integer4) L.stock_change_date);
	  self.HasVotingRights   := if(stringlib.StringCleanSpaces(L.stock_voting_rights_ind)='Y',true, false); 
	  self.IsConverted       := if(stringlib.StringCleanSpaces(L.stock_convert_ind)='Y',true, false); 
	  self.ConvertDate       := iesp.ECL2ESP.toDate ((integer4) L.stock_convert_date);
	  self.CapitalChangeDate := iesp.ECL2ESP.toDate ((integer4) L.stock_change_in_cap);
	  self.TaxCapital2       := stringlib.StringFilterOut(L.stock_tax_capital,',');
	  self.TotalCapital2     := stringlib.StringFilterOut(L.stock_total_capital,',');
	  self.AdditionalInfo    := L.stock_addl_info;
		self := [];
  end;

	iesp.corporate.t_CorpReportAnnualReport xform_annrpts(Corp2_Services.layout_ar_out L) := TRANSFORM
	  self.FilingYear           := (integer) L.ar_year;
	  self.DateLastSeen         := iesp.ECL2ESP.toDate ((integer4) L.dt_last_seen);
	  self.CorpProcessDate      := iesp.ECL2ESP.toDate ((integer4) L.corp_process_date);
	  self.MailedDate           := iesp.ECL2ESP.toDate ((integer4) L.ar_mailed_dt);
	  self.DueDate              := iesp.ECL2ESP.toDate ((integer4) L.ar_due_dt);
	  self.FiledDate            := iesp.ECL2ESP.toDate ((integer4) L.ar_filed_dt);
	  self.ReportDate           := iesp.ECL2ESP.toDate ((integer4) L.ar_report_dt);
	  self.ReportNumber         := L.ar_report_nbr;
	  self.FranchiseTaxPaidDate := iesp.ECL2ESP.toDate ((integer4) L.ar_franchise_tax_paid_dt);
	  self.DelinquentDate       := iesp.ECL2ESP.toDate ((integer4) L.ar_delinquent_dt);
	  self.TaxFactor2           := L.ar_tax_factor;
	  self.TaxPaid2             := stringlib.StringFilterOut(L.ar_tax_amount_paid,',');
	  self.CapitalReported2     := stringlib.StringFilterOut(L.ar_annual_report_cap,',');
	  self.IllinoisCapital2     := stringlib.StringFilterOut(L.ar_illinois_capital,',');
	  self.MicrofilmRoll2       := L.ar_roll;
	  self.MicrofilmFrame2      := L.ar_frame;
	  self.ReportExtensions2    := L.ar_extension;
	  self.MicrofilmNumber2     := L.ar_microfilm_nbr;
	  self.Comment              := L.ar_comment;
	  self.ReportType           := L.ar_type;
		self := [];
  end;

	iesp.corporate.t_CorpReportTradeBrand xform_trades(Corp2_Services.layout_trades_out L) := TRANSFORM
	  self.RecordType            := L.record_type;
		self.RecordTypeDesc        := L.record_date;
	  self.CertificateNumber     := L.corp_certificate_nbr;
	  self.SupplementalKey       := L.corp_supp_key;
	  self.BusinessType          := L.corp_orig_bus_type_desc; 
	  self.Status                := L.corp_status_desc;
	  self.CompanyName           := L.corp_legal_name;
	  self.NameType              := L.corp_ln_name_type_desc;
	  self.Vendor                := L.corp_vendor;
	  self.VendorCounty          := L.corp_vendor_county;
	  self.VendorSubcode         := L.corp_vendor_subcode;
	  self.DateLastSeen          := iesp.ECL2ESP.toDate ((integer4) L.dt_last_seen);
	  self.SupplementalNumber    := L.corp_supp_nbr;
	  self.CompanyNameComment    := L.corp_name_comment;
	  self.FilingReferenceNumber := L.corp_filing_reference_nbr;
	  self.FilingDate            := iesp.ECL2ESP.toDate ((integer4) L.corp_filing_date);
	  self.FilingDescription     := L.corp_filing_desc;
		self.Address.StreetNumber        := L.corp_addr1_prim_range;
	  self.Address.StreetPreDirection  := L.corp_addr1_predir;
	  self.Address.StreetName          := L.corp_addr1_prim_name;
	  self.Address.StreetSuffix        := L.corp_addr1_addr_suffix;
	  self.Address.StreetPostDirection := L.corp_addr1_postdir;
	  self.Address.UnitDesignation     := L.corp_addr1_unit_desig;
	  self.Address.UnitNumber          := L.corp_addr1_sec_range;
	  self.Address.StreetAddress1      := '';
	  self.Address.StreetAddress2      := '';
	  self.Address.City                := L.corp_addr1_p_city_name; 
	  self.Address.State               := L.corp_addr1_state;
	  self.Address.Zip5                := L.corp_addr1_zip5;
	  self.Address.Zip4                := L.corp_addr1_zip4;
	  self.Address.County              := ''; 
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
		self.Address._Type               := L.corp_address1_type_desc;
	  self.AddressEffectiveDate        := iesp.ECL2ESP.toDate ((integer4) L.corp_address1_effective_date);
		self.Address2.StreetNumber        := L.corp_addr2_prim_range;
	  self.Address2.StreetPreDirection  := L.corp_addr2_predir;
	  self.Address2.StreetName          := L.corp_addr2_prim_name;
	  self.Address2.StreetSuffix        := L.corp_addr2_addr_suffix;
	  self.Address2.StreetPostDirection := L.corp_addr2_postdir;
	  self.Address2.UnitDesignation     := L.corp_addr2_unit_desig;
	  self.Address2.UnitNumber          := L.corp_addr2_sec_range;
	  self.Address2.StreetAddress1      := '';
	  self.Address2.StreetAddress2      := '';
	  self.Address2.City                := L.corp_addr2_p_city_name; 
	  self.Address2.State               := L.corp_addr2_state;
	  self.Address2.Zip5                := L.corp_addr2_zip5;
	  self.Address2.Zip4                := L.corp_addr2_zip4;
	  self.Address2.County              := ''; 
	  self.Address2.PostalCode          := '';
	  self.Address2.StateCityZip        := '';
		self.Address2._Type               := L.corp_address2_type_desc;
	  self.Address2EffectiveDate        := iesp.ECL2ESP.toDate ((integer4) L.corp_address2_effective_date);
	  self.TermOfExistence.Code           := L.corp_term_exist_cd;
	  self.TermOfExistence._Type          := L.corp_term_exist_desc;
	  self.TermOfExistence.ExpirationDate := iesp.ECL2ESP.toDate ((integer4) L.corp_term_exist_exp);
	  self.TermOfExistence.Years          := 0; 
   
		self.RawAddress  := DATASET([L.corp_address1_line1,L.corp_address1_line2,
																 L.corp_address1_line3,L.corp_address1_line4,
																 L.corp_address1_line5,L.corp_address1_line6],iesp.share.t_StringArrayItem);
	  self.Events     := project(choosen(L.events,iesp.Constants.CORP.MAX_EVENTS),xform_events(left));
		self := [];
	end;

  // transform for iesp corp report output main layout
  SHARED iesp.corporate.t_CorporateReport2Record toOut(corp_layout_wLinkIds L) := TRANSFORM
	  self.BusinessId         := ''; 
		IDmacros.mac_IespTransferLinkids()
	  self.StateOrigin        := L.corp_state_origin;
	  self.StateOriginName    := L.corp_state_origin_decoded;
	  self.CharterNumber      := L.corp_sos_charter_nbr; // OR corp_orig_sos_charter_nbr???
	  self.CorporateKey       := L.corp_key;
	  self.CorporateHistories := project(choosen(L.corp_hist,iesp.Constants.CORP.MAX_HISTORIES),xform_hist(left)); 
	  self.Contacts           := project(choosen(L.contacts,iesp.Constants.CORP.MAX_CONTACTS),xform_contacts(left)); 
	  self.Events             := project(choosen(L.events,iesp.Constants.CORP.MAX_EVENTS),xform_events(left)); 
	  self.Stocks             := project(choosen(L.stocks,iesp.Constants.CORP.MAX_STOCKS),xform_stocks(left)); 
	  self.AnnualReports      := project(choosen(sort(dedup(L.annual_reports, record, all, except dt_last_seen, corp_process_date, ar_type),-ar_filed_dt, -ar_due_dt, -corp_process_date, -dt_last_seen),iesp.Constants.CORP.MAX_ANNUAL_RPTS),xform_annrpts(left)); 
	  self.Trademarks         := project(choosen(L.trademarks,iesp.Constants.CORP.MAX_TRADEMARKS),xform_trades(left));
	  self.Tradenames         := project(choosen(L.tradenames,iesp.Constants.CORP.MAX_TRADENAMES),xform_trades(left));
  end;

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(corp_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'CORP_V2';
			self.src_desc := 'Corporate Filings';
			self.hasName 	:= exists(L.corp_hist(corp_legal_name <>''));
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= exists(L.corp_hist(corp_fed_tax_id <>''));	
			self.hasAddr 	:= exists(L.corp_hist(corp_addr1_state <>'' or corp_addr1_zip5 <>''));
		  self.hasPhone := exists(L.corp_hist(corp_phone10 <>''));
			self.dt_first_seen := ut.NormDate((unsigned)(L.corp_hist[1].corp_filing_date));
			self.dt_last_seen := ut.NormDate((unsigned)(L.corp_hist[1].dt_last_seen));
			self := [];
	END;

	EXPORT SourceDetailInfo := project(corp_sourcetview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(corp_sourcetview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(corp_sourcetview_wLinkIds);

END;
