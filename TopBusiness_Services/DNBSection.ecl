/* TBD:
     1. Research/resolve open issues (search for '???') and removed commented out coding.
*/
IMPORT BIPV2, Codes, DNB_DMI, iesp, MDR, Doxie;

EXPORT DNBSection := MODULE;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
 	dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
	,Layouts.rec_input_options  in_options
	,doxie.IDataAccess mod_access
	                 ):= function

  FETCH_LEVEL := in_options.BusinessReportFetchLevel;											

  // Sort/dedup input dataset by ids to reduce # of lookups against the source key files
	// MAY NOT BE NEEDED SINCE DONE IN BIPV2.IDmacros.mac_mac_IndexFetch MACRO???
  //ds_in_ids_deduped := dedup(sort(ds_in_ids, %all_linkid_fields%),
	//                           %all_linkid_fields%);

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_ids_only := project(ds_in_ids_wacctno,
	                                 transform(BIPV2.IDlayouts.l_xlink_ids,
	                                             self := left,
																							 self := []));
  

  // *** Key fetch to get DNB DMI data.
  ds_dnb_keyrecs := DNB_DMI.Key_Linkids.kFetch(
	                          ds_in_ids_only, mod_access, // input file to join key with
	      										FETCH_LEVEL); // level of ids to join with
														// 3rd parm is ScoreThreshold, take default of 0
														
  // Sort/dedup to only keep the 1 most recent record for each combo of unique linkids.
	// See what is done in doxie_cbrs.DNB_records, lines 68-74, but it does not account  
	// for multiple recs with same date_last_seen; so added additional date below. 
  ds_dnbrecs_deduped := dedup(sort(ds_dnb_keyrecs,
	                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
                                   -date_last_seen, 
                                  //-record_type, //5=current?, 4=active? ???
                                   -date_vendor_last_reported,
                                   record),
	                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
													   );
														 
  // Project DNB key recs onto a common layout with just fields needed for the section
	// output or for source viewing/linking???
  // Fill in the 3 extra "decoded" fields output in the current (before BIP2) Accurint only DNB section
	ds_dnbrecs_slimmed := project(ds_dnbrecs_deduped,
	   transform(DNBSection_Layouts.rec_ids_withdata_slimmed,
	     self.structure_type_decoded        := codes.keyCodes('DNB_COMPANIES','structure_type',,left.rawfields.structure_type);
	     self.type_of_establishment_decoded := codes.keyCodes('DNB_COMPANIES','type_of_establishment',,left.rawfields.type_of_establishment);
	     self.owns_rents_decoded            := codes.keyCodes('DNB_COMPANIES','owns_rents',,left.rawfields.owns_rents);
			 self := left // to preserve key fields being kept
     ));
  
  // Normalize to split out the sic info (up to 30) into an individual child dataset.
  ds_sics_normalized := normalize(ds_dnbrecs_slimmed,
												          30, // 30 sets of sic* & sic*desc fields
			transform(DNBSection_Layouts.rec_DnbChild_SIC,
				self.sic_code := choose(counter,
					left.rawfields.sic1,left.rawfields.sic1a,left.rawfields.sic1b,left.rawfields.sic1c,left.rawfields.sic1d,
					left.rawfields.sic2,left.rawfields.sic2a,left.rawfields.sic2b,left.rawfields.sic2c,left.rawfields.sic2d,
					left.rawfields.sic3,left.rawfields.sic3a,left.rawfields.sic3b,left.rawfields.sic3c,left.rawfields.sic3d,
					left.rawfields.sic4,left.rawfields.sic4a,left.rawfields.sic4b,left.rawfields.sic4c,left.rawfields.sic4d,
					left.rawfields.sic5,left.rawfields.sic5a,left.rawfields.sic5b,left.rawfields.sic5c,left.rawfields.sic5d,
					left.rawfields.sic6,left.rawfields.sic6a,left.rawfields.sic6b,left.rawfields.sic6c,left.rawfields.sic6d),
				self.sic_desc := choose(counter,
					left.rawfields.sic1desc,left.rawfields.sic1adesc,left.rawfields.sic1bdesc,left.rawfields.sic1cdesc,left.rawfields.sic1ddesc,
					left.rawfields.sic2desc,left.rawfields.sic2adesc,left.rawfields.sic2bdesc,left.rawfields.sic2cdesc,left.rawfields.sic2ddesc,
					left.rawfields.sic3desc,left.rawfields.sic3adesc,left.rawfields.sic3bdesc,left.rawfields.sic3cdesc,left.rawfields.sic3ddesc,
					left.rawfields.sic4desc,left.rawfields.sic4adesc,left.rawfields.sic4bdesc,left.rawfields.sic4cdesc,left.rawfields.sic4ddesc,
					left.rawfields.sic5desc,left.rawfields.sic5adesc,left.rawfields.sic5bdesc,left.rawfields.sic5cdesc,left.rawfields.sic5ddesc,
					left.rawfields.sic6desc,left.rawfields.sic6adesc,left.rawfields.sic6bdesc,left.rawfields.sic6cdesc,left.rawfields.sic6ddesc),
				self := left, // to preserve all linkids
			));

  // Filter to remove records with a blank sic_code
  ds_sics_norm_filtered := ds_sics_normalized(sic_code !='');


  // Transforms for the iesp DNB Section related layouts
	//
  // Transform to handle the iesp SIC info child dataset layout
	iesp.TopBusinessReport.t_TopbusinessIndustrySIC 
	  tf_rpt_sic(DNBSection_Layouts.rec_DnbChild_SIC l) := transform 
      self.SICCode            := l.sic_code,
			// v--- may need to expand length in iesp... from string40 to string60???
      self.SICCodeDescription := l.sic_desc,
	end;

  // Transform for the iesp main DNB Record layout
	DNBSection_Layouts.rec_ids_plus_DnbDetail
	  tf_rptdetail(DNBSection_Layouts.rec_ids_withdata_slimmed l) := transform
     //assign raw data fields to their corresponding iesp fields
		 self.DateFirstSeen := iesp.ECL2ESP.toDate(l.date_first_seen),
		 self.DateLastSeen  := iesp.ECL2ESP.toDate(l.date_last_seen),
	   self.DunsNumber    := l.rawfields.duns_number,
	   self.BusinessName  := l.rawfields.business_name,
	   self.TradeStyle    := l.rawfields.trade_style,
	   self.OrigAddress.StreetAddress1 := l.rawfields.street,
	   self.OrigAddress.City           := l.rawfields.city,
	   self.OrigAddress.State          := l.rawfields.state,
	   self.OrigAddress.County         := l.rawfields.county_name,
	   self.OrigAddress.PostalCode     := l.rawfields.zip_code,
		 self.OrigAddress                := [], //null out rest of OrigAddress fields
	   self.OrigMailingAddress.StreetAddress1 := l.rawfields.mail_address,
	   self.OrigMailingAddress.City           := l.rawfields.mail_city,
	   self.OrigMailingAddress.State          := l.rawfields.mail_state,
	   self.OrigMailingAddress.PostalCode     := l.rawfields.mail_zip_code,
		 self.OrigMailingAddress                := [], //null out rest of OrigMailingAddress fields
	   self.Phone10       := l.rawfields.telephone_number,
	   self.MsaCode       := l.rawfields.msa_code,
     self.MsaName       := l.rawfields.msa_name,
	   self.LineOfBusinessDescription := l.rawfields.line_of_business_description,
		 self.SICs          := //use a join of l & sics_filtered to create the SIC iesp child dataset
												   join(dataset(l),
												        ds_sics_norm_filtered,
												           BIPV2.IDmacros.mac_JoinTop3Linkids(),
                                tf_rpt_sic(right),
														    inner); // only right recs that match to left
	   self.IndustryGroup            := l.rawfields.industry_group,
     self.YearStarted              := l.rawfields.year_started,
		 self.DateOfIncorporation      := iesp.ECL2ESP.toDate((integer) l.rawfields.date_of_incorporation),
		 self.StateOfIncorporation     := l.rawfields.state_of_incorporation_abbr,
	   self.AnnualSalesVolumeSign    := l.rawfields.annual_sales_volume_sign,
	   self.AnnualSalesVolume        := l.rawfields.annual_sales_volume,
	   self.AnnualSalesCode          := l.rawfields.annual_sales_code,
	   self.EmployeesHereSign        := l.rawfields.employees_here_sign,
	   self.EmployeesHere            := l.rawfields.employees_here,
	   self.EmployeesTotalSign       := l.rawfields.employees_total_sign,
	   self.EmployeesTotal           := l.rawfields.employees_total,
	   self.EmployeesHereCode        := l.rawfields.employees_here_code,
		 self.AnnualSalesRevisionDate  := iesp.ECL2ESP.toDate((integer) l.rawfields.annual_sales_revision_date),
	   self.NetWorthSign             := l.rawfields.net_worth_sign,
	   self.NetWorth                 := l.rawfields.net_worth,
	   self.TrendSalesSign           := l.rawfields.trend_sales_sign,
	   self.TrendSales               := l.rawfields.trend_sales,
	   self.TrendEmploymentTotalSign := l.rawfields.trend_employment_total_sign,
	   self.TrendEmploymentTotal     := l.rawfields.trend_employment_total,
	   self.BaseSalesSign            := l.rawfields.base_sales_sign,
	   self.BaseSales                := l.rawfields.base_sales,
	   self.BaseEmploymentTotalSign  := l.rawfields.base_employment_total_sign,
	   self.BaseEmploymentTotal      := l.rawfields.base_employment_total,
		 self.PercentageSalesGrowthSign      := l.rawfields.percentage_sales_growth_sign,
     self.PercentageSalesGrowth          := l.rawfields.percentage_sales_growth,
     self.PercentageEmploymentGrowthSign := l.rawfields.percentage_employment_growth_sign,
     self.PercentageEmploymentGrowth     := l.rawfields.percentage_employment_growth,
	   self.SquareFootage          := l.rawfields.square_footage,
	   self.SalesTerritory         := l.rawfields.sals_territory,
	   self.OwnsRents              := l.rawfields.owns_rents,
	   self.NumberOfAccounts       := l.rawfields.number_of_accounts,
     self.BankDunsNumber         := l.rawfields.bank_duns_number,
     self.BankName               := l.rawfields.bank_name,
     self.AccountingFirmName     := l.rawfields.accounting_firm_name,
	   self.SmallBusinessIndicator := l.rawfields.small_business_indicator,
	   self.MinorityOwned          := l.rawfields.minority_owned,
	   self.CottageIndicator       := l.rawfields.cottage_indicator,
	   self.ForeignOwned           := l.rawfields.foreign_owned,
	   self.ManufacturingHereIndicator := l.rawfields.manufacturing_here_indicator,
	   self.PublicIndicator            := l.rawfields.public_indicator,
	   self.ImporterExporterIndicator  := l.rawfields.importer_exporter_indicator,
	   self.StructureType          := l.rawfields.structure_type,
	   self.TypeOfEstablishment    := l.rawfields.type_of_establishment,
     self.ParentDunsNumber       := l.rawfields.parent_duns_number,
     self.UltimateDunsNumber     := l.rawfields.ultimate_duns_number,
     self.HeadquartersDunsNumber := l.rawfields.headquarters_duns_number,
     self.ParentCompanyName      := l.rawfields.parent_company_name,
     self.UltimateCompanyName    := l.rawfields.ultimate_company_name,
     self.DiasCode               := l.rawfields.dias_code,
     self.HierarchyCode          := l.rawfields.hierarchy_code,
     self.UltimateIndicator      := l.rawfields.ultimate_indicator,
     self.HotList.NewIndicator             := l.rawfields.hot_list_new_indicator,
     self.HotList.OwnershipChangeIndicator := l.rawfields.hot_list_ownership_change_indicator,
     self.HotList.CeoChangeIndicator       := l.rawfields.hot_list_ceo_change_indicator,
     self.HotList.CompanyNameChangeInd     := l.rawfields.hot_list_company_name_change_ind,
     self.HotList.AddressChangeIndicator   := l.rawfields.hot_list_address_change_indicator,
     self.HotList.TelephoneChangeIndicator := l.rawfields.hot_list_telephone_change_indicator,
     //v--- these next 6 are all string6 (yyyymm) not string8, so put '00' in the dd portion
     self.HotList.NewChangeDate       := iesp.ECL2ESP.toDate((integer) (l.rawfields.hot_list_new_change_date + '00')),
     self.HotList.OwnershipChangeDate := iesp.ECL2ESP.toDate((integer) (l.rawfields.hot_list_ownership_change_date + '00')),
     self.HotList.CeoChangeDate       := iesp.ECL2ESP.toDate((integer) (l.rawfields.hot_list_ceo_change_date + '00')),
     self.HotList.CompanyNameChgDate  := iesp.ECL2ESP.toDate((integer) (l.rawfields.hot_list_company_name_chg_date + '00')),
     self.HotList.AddressChangeDate   := iesp.ECL2ESP.toDate((integer) (l.rawfields.hot_list_address_change_date + '00')),
     self.HotList.TelephoneChangeDate := iesp.ECL2ESP.toDate((integer) (l.rawfields.hot_list_telephone_change_date + '00')),
     self.ReportDate            := iesp.ECL2ESP.toDate((integer) l.rawfields.report_date),
     self.DeleteRecordIndicator := l.rawfields.delete_record_indicator,
	   self.MailingAddress.StreetNumber        := l.clean_mail_address.prim_range,
	   self.MailingAddress.StreetPreDirection  := l.clean_mail_address.predir,
	   self.MailingAddress.StreetName          := l.clean_mail_address.prim_name,
	   self.MailingAddress.StreetSuffix        := l.clean_mail_address.addr_suffix,
	   self.MailingAddress.StreetPostDirection := l.clean_mail_address.postdir,
	   self.MailingAddress.UnitDesignation     := l.clean_mail_address.unit_desig,
	   self.MailingAddress.UnitNumber          := l.clean_mail_address.sec_range,
	   self.MailingAddress.City                := if(l.clean_mail_address.v_city_name !='', 
		                                               l.clean_mail_address.v_city_name,
																									 l.clean_mail_address.p_city_name),
	   self.MailingAddress.State               := l.clean_mail_address.st,
	   self.MailingAddress.Zip5                := l.clean_mail_address.zip,
	   self.MailingAddress.Zip4                := l.clean_mail_address.zip4,
		 self.MailingAddress                     := [], //null out rest of MailingAddress fields
	   self.Address.StreetNumber        := l.clean_address.prim_range,
	   self.Address.StreetPreDirection  := l.clean_address.predir,
	   self.Address.StreetName          := l.clean_address.prim_name,
	   self.Address.StreetSuffix        := l.clean_address.addr_suffix,
	   self.Address.StreetPostDirection := l.clean_address.postdir,
	   self.Address.UnitDesignation     := l.clean_address.unit_desig,
	   self.Address.UnitNumber          := l.clean_address.sec_range,
	   self.Address.City                := if(l.clean_address.v_city_name !='', 
		                                        l.clean_address.v_city_name,l.clean_address.p_city_name),
	   self.Address.State               := l.clean_address.st,
	   self.Address.Zip5                := l.clean_address.zip,
	   self.Address.Zip4                := l.clean_address.zip4,
		 self.Address                     := [], //null out rest of Address fields
		 // For RecordType, convert unsigned1 to string1 to be compatable with what the old 
		 // doxie_cbrs.DNB_records outputs from the old DNB.Layout_DNB_Base layout versus what is 
		 // stored in the new BIP2 DNB linkids key which uses DNB_DMI.Layouts.Base.CompaniesForBIP2.
		 // From examining some data on the new thor_data400::key::dnb::qa::linkids file, 
		 // it appears that 4=H(Historical) & 5=C(Current)  Are there other values???
     self.RecordType                 := if(l.record_type=4,'H',
		                                       if(l.record_type=5,'C','')),
     self.ActiveDunsNumber           := l.active_duns_number,
	   self.StructureTypeDecoded       := l.structure_type_decoded,
	   self.TypeOfEstablishmentDecoded := l.type_of_establishment_decoded,
	   self.OwnsRentsDecoded           := l.owns_rents_decoded,
		 self := l, // to preserve all ids
	end;

  ds_recs_rptdetail := project(//ds_dnbrecs_deduped,
                              ds_dnbrecs_slimmed, 
															   tf_rptdetail(left));


  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_ids_wacctno,//ds_all_rptdetail_rolled,
	                              ds_recs_rptdetail,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(DNBSection_Layouts.rec_ids_plus_DnbSecRec,
														      self.acctno         := left.acctno,
																	self.DnbRecordCount := count(ds_recs_rptdetail),
																	self.Dnb            := right, 
															    self                := right),
														    left outer); // 1 out rec for every left (input ds) rec

	// Roll up all recs for the acctno
	ds_final_results := rollup(group(sort(ds_all_wacctno_joined,acctno),acctno),
	                           group,
		                         transform(DNBSection_Layouts.rec_Final,
			                         self := left));

  // Uncomment for debugging
  //output(ds_in_ids_wacctno,           named('ds_in_ids_wacctno'));
	//output(ds_in_ids_only,              named('ds_in_ids_only'));
	//output(ds_dnb_keyrecs,              named('ds_dnb_keyrecs'));
	//output(ds_dnbrecs_slimmed,          named('ds_dnbrecs_slimmed'));
	//output(ds_dnbrecs_deduped,          named('ds_dnbrecs_deduped'));
  //output(ds_sics_normalized,          named('ds_sics_normalized'));
  //output(ds_sics_norm_filtered,       named('ds_sics_norm_filtered'));
  //output(ds_recs_rptdetail,           named('ds_recs_rptdetail'));
  //output(ds_all_wacctno_joined,       named('ds_all_wacctno_joined'));
	//output(ds_final_results,            named('ds_final_results'));

	return ds_final_results;

 end; //end of FullView function

END; //end of module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

  // Input options for all report sections (except UCCs, see UCC section testing below)
	// Just 2 booleans & 1 char for now: lnbranded , internal_testing and fetch_level
  ds_options := dataset([{false, false, 'P'} //3rd parm=BusinessReportFetchLevel, default='P' ???
                        ],topbusiness_services.Layouts.rec_input_options);

// input dataset layout= acctno,DotID,EmpID,POWID,ProxID,SeleID,OrgID,UltID

  // Report section input params.  
	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '000' : stored('DataRestrictionMask'); //pos 3=0 to use EBR
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

dnb_sec := TopBusiness_Services.DNBSection.fn_FullView(
             dataset([{
                       //{'dnb1p', 0, 0, 0, 129079444, 129079444, 129079444, 129079444} // Schreier Electrix
											 //{'dnb2p', 0, 0, 0, 119199661, 119199661, 119199661, 119199661} // Radon X
                     ],topbusiness_services.Layouts.rec_input_ids)
 						,ds_options[1]
					  ,tempmod
           );
output(dnb_sec);
*/
