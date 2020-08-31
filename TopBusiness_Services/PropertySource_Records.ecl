//=================================================================================
// ====== RETURNS PROPERTY DATA FOR A GIVEN LN_FARES_ID IN ESP-COMPLIANT WAY. =====
// ================================================================================
//
import iesp, LN_PropertyV2, LN_PropertyV2_Services, BIPV2, Suppress, address, fcra, ut, TopBusiness_Services, std;

EXPORT PropertySource_Records(
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions,
	integer nonSS = suppress.Constants.NonSubjectSuppression.doNothing,
	boolean IsFCRA = false) 
 := MODULE
  
	SHARED prop_layout_wLinkIds := RECORD
		TopBusiness_Services.Layouts.rec_input_ids_wSrc;
		LN_PropertyV2_Services.layouts.combined.widest;
		string8 recording_date;
	END;
	
	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get ln_fares_id's from linkids
  ds_propkeys := PROJECT(LN_PropertyV2.Key_LinkIds.kFetch(in_docs_linkonly,inoptions.fetch_level,,,TopBusiness_Services.Constants.PropertyKfetchMaxLimit),
																TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.ln_fares_id,
																					SELF := LEFT,
																					SELF := []));
	
	// For records with an id value assigned and an Id type of vl_id, we need to strip the first 
	// 3 characters (2 char source code and 1 char source flag) of the idvalue to get the fares id 
	in_docs_vlIDRecs := in_docids(IdValue != '' and Idtype = TopBusiness_Services.constants.busvlid);
	ds_vlIdKeys := PROJECT(in_docs_vlIDRecs,TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.IdValue[4..],
																					SELF := LEFT,
																					SELF := []));
	
	// For records with an id value assigned and not a idtype of vl_id, assumes idvalue is fares_id
	ds_faresKeys := in_docids(IdValue != '' and Idtype != TopBusiness_Services.constants.busvlid);
																		
	prop_keys_comb := ds_propkeys+ds_vlIdKeys+ds_faresKeys;
	
	prop_keys := PROJECT(prop_keys_comb(IdValue != ''),TRANSFORM(LN_PropertyV2_Services.layouts.search_fid,SELF.ln_fares_id := LEFT.IdValue, SELF := []));
	
      prop_keys_dedup := DEDUP(SORT(prop_keys, ln_fares_id), ln_fares_id);
	
	// Get the raw data from the appropriate view.
  prop_sourceview := LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(prop_keys_dedup,,,nonSS,IsFCRA);
	
	prop_sourceview_date := PROJECT(prop_sourceview,TRANSFORM(prop_layout_wLinkIds,
																					SELF.recording_date := IF(LEFT.fid_type='D',LEFT.deeds[1].recording_date,LEFT.assessments[1].recording_date),
																					SELF := LEFT,
																					SELF := []));
			
	SHARED prop_sourceview_wLinkIds := JOIN(prop_sourceview_date,prop_keys_comb,
																					LEFT.ln_fares_id = RIGHT.IdValue,
																					TRANSFORM(prop_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT,
																							SELF := []),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids;);
	
	SHARED prop_sourceview_sorted := sort(prop_sourceview_wLinkIds,-recording_date);
	
  // Uses an exsiting transform onto iesp.property.t_PropertyReport2Record layout 
	// found within PersonReports\Property_Records.
	// NOTE: had to make the FormatReport2Records transform within 
	// PersonReports\Property_Records "exported", so could use it here.
	iesp.property.t_OriginalName xform_orig_names2(LN_PropertyV2_Services.layouts.parties.orig L) := transform
		Self.NameSeq := (string) L.name_seq;
		Self.Name := L.orig_name;
		Self.IdDescription := L.id_desc;
	end;

	iesp.property.t_Property2Name xform_names(LN_PropertyV2_Services.layouts.parties.entity L) := transform
		self.BusinessIds.DotID 		:= L.DotID;
		self.BusinessIds.EmpID 		:= L.EmpID;
		self.BusinessIds.POWID 		:= L.POWID;
		self.BusinessIds.ProxID 	:= L.ProxID;
		self.BusinessIds.SELEID 	:= L.SELEID;  
		self.BusinessIds.OrgID 		:= L.OrgID;
		self.BusinessIds.UltID 		:= L.UltID;
		Self.CompanyName :=  L.cname;
		Self.UniqueId := if(L.did <> '', intformat((unsigned)L.did,12,1), '');
		Self.BusinessId := if(L.bdid <> '', intformat((unsigned)L.bdid,12,1), '');
		Self.AppendedSSN := L.app_ssn;
		Self.Full := if(l.lname!='' and l.lname <> fcra.constants.FCRA_Restricted,std.str.CleanSpaces(l.lname + ' , ' + l.fname + ' ' + l.mname + ' ' +  l.name_suffix),'');;
		Self.First := L.fname;
		Self.Middle := L.mname;
		Self.Last := L.lname;
		Self.Suffix := L.name_suffix;
		Self.Prefix := L.title;
		self.IdValue := '';
	end;

	iesp.share.t_Address SetPartyAddress (LN_PropertyV2_Services.layouts.parties.pparty P) := iesp.ECL2ESP.SetAddress (
																				P.prim_name, P.prim_range, P.predir, P.postdir, P.suffix, P.unit_desig, P.sec_range,
																				P.v_city_name,P.st, P.zip, P.zip4, P.county_name);
	
	iesp.share.t_StringArrayItem xform_orig_names(LN_PropertyV2_Services.layouts.parties.orig L) := transform
		Self.value := L.orig_name;
	end;
	
	iesp.property.t_Property2Entity xform_entities(LN_PropertyV2_Services.layouts.parties.pparty L) := transform
		Self.Address := SetPartyAddress (L);
		Self.Phone := ROW({L.phone_number,'','','','',''}, iesp.share.t_PhoneInfo);
		Self.EntityTypeCode := L.party_type;
		Self.EntityType := L.party_type_name;
		Self.OriginalAddress.StreetAddress1 := L.orig_addr;
		Self.OriginalAddress.UnitNumber := L.orig_unit;
		Self.OriginalAddress.StateCityZip := L.orig_csz;
		Self.OriginalAddress := [];
		Self.Lot := L.lot;
		Self.LotOrder := L.lot_order;
		
		ds_names := project(L.entity, xform_names(left));
		Self.Names := ds_names; 
		
		ds_orig_names := project(L.orig_names, xform_orig_names(left));
		Self.OriginalNames := choosen(ds_orig_names,iesp.constants.prop.MaxOriginalNames);
		
		ds_orig_names2 := project(L.orig_names, xform_orig_names2(left));
		Self.OriginalNames2 := choosen(ds_orig_names2,iesp.constants.prop.MaxOriginalNames2);
		
		
	end;
	
	SHARED iesp.property.t_PropertyReport2Record toOut (prop_layout_wLinkIds L) := TRANSFORM
		TopBusiness_Services.IDmacros.mac_IespTransferLinkids()
		assess := L.assessments[1];	
		deed := L.deeds[1];
		
		Self.DataSource := L.vendor_source_flag;
		Self.FaresId := L.ln_fares_id;
		Self.SourcePropertyRecordId := L.ln_fares_id;
		Self.RecordType := L.fid_type; 
		Self.RecordTypeDesc := L.fid_type_desc; 
		Self.OutputSeqNo := '';
		Self.ParcelNumber := map(L.fid_type='A' => assess.apna_or_pin_number,
															L.fid_type='D' => deed.apnt_or_pin_number ,
															'');
		Self.Assessment.StateCode := assess.state_code;
		Self.Assessment.County  := assess.county_name;
		Self.Assessment.ParcelId  := assess.apna_or_pin_number;
		Self.Assessment.FipsCode  := assess.fips_code;
		Self.Assessment.DuplicateApnMultipleAddressId  := assess.duplicate_apn_multiple_address_id;
		Self.Assessment.TapeCutDate.year :=(unsigned2) assess.tape_cut_date[1..4]; 
		Self.Assessment.TapeCutDate.month :=(unsigned1) assess.tape_cut_date[5..6];
		Self.Assessment.TapeCutDate.day :=0 ; // TapCutDate format from vendor is YYYYMM only.
		Self.Assessment.EditionNumber  := assess.edition_number;
		Self.Assessment.CertificationDate  := iesp.ECL2ESP.toDate ((unsigned4) assess.certification_date);
		Self.Assessment.AssesseeOwnershipRights  := assess.assessee_ownership_rights_desc;
		Self.Assessment.AssesseeRelationship  := assess.assessee_relationship_desc;
		Self.Assessment.AssesseePhoneNumber  := assess.assessee_phone_number;
		Self.Assessment.TaxAccountNumber  := assess.tax_account_number;
		Self.Assessment.ContractOwner  := assess.contract_owner;
		Self.Assessment.AssesseeNameType  := assess.assessee_name_type_desc;
		Self.Assessment.SecondAssesseeNameType  := assess.assessee_name_type_desc;
		Self.Assessment.MailCareOfNameType  := assess.mail_care_of_name_type_desc;
		Self.Assessment.MailingCareOf  := assess.mailing_care_of_name;
		Self.Assessment.PropertyAddress  := assess.property_address_desc;
		Self.Assessment.OwnerOccupied  := assess.owner_occupied;
		Self.Assessment.RecordingDate  := iesp.ECL2ESP.toDate ((unsigned4) assess.recording_date);
		Self.Assessment.PriorRecordingDate  := iesp.ECL2ESP.toDate ((unsigned4) assess.prior_recording_date);
		Self.Assessment.RecordType  := assess.record_type_desc;
		Self.Assessment.LandUseCode  := assess.standardized_land_use_code;
		Self.Assessment.LandUse  := assess.standardized_land_use_desc;
		Self.Assessment.RecorderBookNumber  := assess.recorder_book_number;
		Self.Assessment.RecorderPageNumber  := assess.recorder_page_number;
		Self.Assessment.LegalLotNumber  := assess.legal_lot_number;
		Self.Assessment.LegalSubdivision  := assess.legal_subdivision_name;
		Self.Assessment.LegalBriefDescription  := assess.legal_brief_description;
		Self.Assessment.LegalLot  := assess.legal_lot_desc;
		Self.Assessment.LegalLandLot  := assess.legal_land_lot;
		Self.Assessment.LegalBlock  := assess.legal_block;
		Self.Assessment.LegalSection  := assess.legal_section;
		Self.Assessment.LegalDistrict  := assess.legal_district;
		Self.Assessment.LegalUnit  := assess.legal_unit;
		Self.Assessment.LegalCityMunicipalityTownship  := assess.legal_city_municipality_township;
		Self.Assessment.LegalPhaseNumber  := assess.legal_phase_number;
		Self.Assessment.LegalTractNumber  := assess.legal_tract_number;
		Self.Assessment.LegalSecTwnRngMer  := assess.legal_sec_twn_rng_mer;
		Self.Assessment.LegalAssessorMapRef  := assess.legal_assessor_map_ref;
		Self.Assessment.LegalInfo.BriefDescription := assess.legal_brief_description;
		Self.Assessment.LegalInfo.LotCode := assess.legal_lot_code;
		Self.Assessment.LegalInfo.LotDesc := assess.legal_lot_desc;
		Self.Assessment.LegalInfo.LotNumber := assess.legal_lot_number;
		Self.Assessment.LegalInfo.Block := assess.legal_block;
		Self.Assessment.LegalInfo.Section := assess.legal_section;
		Self.Assessment.LegalInfo.District := assess.legal_district;
		Self.Assessment.LegalInfo.LandLot := assess.legal_land_lot;
		Self.Assessment.LegalInfo.Unit := assess.legal_unit;
		Self.Assessment.LegalInfo.CityMunicipalityTownship := assess.legal_city_municipality_township;
		Self.Assessment.LegalInfo.Subdivision := assess.legal_subdivision_name;
		Self.Assessment.LegalInfo.PhaseNumber := assess.legal_phase_number;
		Self.Assessment.LegalInfo.TractNumber := assess.legal_tract_number;
		Self.Assessment.LegalInfo.SecTwnRngMer := assess.legal_sec_twn_rng_mer;
		Self.Assessment.LegalInfo.AssessorMapRef := assess.legal_assessor_map_ref;
		Self.Assessment.CensusTract  := assess.census_tract;
		Self.Assessment.OwnershipType  := assess.ownership_type_desc;
		Self.Assessment.NewRecordType  := assess.new_record_type_desc;
		Self.Assessment.TimeshareCode  := assess.timeshare_code;
		Self.Assessment.Zoning  := assess.zoning;
		Self.Assessment.RecorderDocumentNumber  := assess.recorder_document_number;
		Self.Assessment.TransferDate  := iesp.ECL2ESP.toDate ((unsigned4) assess.transfer_date);
		Self.Assessment.DocumentTypeDesc  := IF(assess.document_type_desc != '',assess.document_type_desc,assess.document_type);
		Self.Assessment.PriorTransferDate  := iesp.ECL2ESP.toDate ((unsigned4) assess.prior_transfer_date);
		Self.Assessment.DocumentType  := assess.document_type;
		Self.Assessment.SaleDate  := iesp.ECL2ESP.toDate ((unsigned4)  assess.sale_date);
		Self.Assessment.SalesPrice  := assess.sales_price;
		Self.Assessment.SalesPriceDescription  := assess.sales_price_desc;
		Self.Assessment.PriorSalesPrice  := assess.prior_sales_price;
		Self.Assessment.PriorSalesPriceDescription  := assess.prior_sales_price_desc;
		Self.Assessment.MortgageLoanAmount  := assess.mortgage_loan_amount;
		Self.Assessment.MortgageLoanType  := assess.mortgage_loan_type_desc;
		Self.Assessment.MortgageLender  := assess.mortgage_lender_name;
		Self.Assessment.MortgageLenderType  := assess.mortgage_lender_type_desc;
		Self.Assessment.AssessedTotalValue  := assess.assessed_total_value;
		Self.Assessment.HomesteadHomeownerExemption  := assess.homestead_homeowner_exemption;
		Self.Assessment.AssessedImprovementValue  := assess.assessed_improvement_value;
		Self.Assessment.MarketLandValue  := assess.market_land_value;
		Self.Assessment.MarketImprovementValue  := assess.market_improvement_value;
		Self.Assessment.MarketTotalValue  := assess.market_total_value;
		Self.Assessment.MarketValueYear  := assess.market_value_year;
		Self.Assessment.AssessedLandValue  := assess.assessed_land_value;
		Self.Assessment.AssessedValueYear  := assess.assessed_value_year;
		Self.Assessment.TaxYear  := assess.tax_year;
		Self.Assessment.TaxAmount  := assess.tax_amount;
		Self.Assessment.TaxRateCodeArea  := assess.tax_rate_code_area;
		Self.Assessment.TaxDelinquentYear  := assess.tax_delinquent_year;
		Self.Assessment.LandSquareFootage  := assess.land_square_footage;
		Self.Assessment.YearBuilt  := assess.year_built;
		Self.Assessment.NoOfStories  := assess.no_of_stories;
		Self.Assessment.NoOfStoriesDesc  := assess.no_of_stories_desc;
		Self.Assessment.NoOfBedrooms  := assess.no_of_bedrooms;
		Self.Assessment.NoOfBaths  := assess.no_of_baths;
		Self.Assessment.NoOfPartialBaths  := assess.no_of_partial_baths;
		Self.Assessment.GarageType  := assess.garage_type_desc;
		Self.Assessment.Pool  := assess.pool_desc;
		Self.Assessment.ExteriorWalls  := assess.exterior_walls_desc;
		Self.Assessment.RoofType  := assess.roof_type_desc;
		Self.Assessment.Heating  := assess.heating_desc;
		Self.Assessment.HeatingFuelTypeDesc  := assess.heating_fuel_type_desc;
		Self.Assessment.AirConditioning  := assess.air_conditioning_desc;
		Self.Assessment.AirConditioningType  := assess.air_conditioning_type_desc;
		Self.Assessment.HeatingFuelTypeCode  := assess.heating_fuel_type_code;
		Self.Assessment.LandAcres  := assess.land_acres;
		Self.Assessment.LandDimensions  := assess.land_dimensions;
		Self.Assessment.BuildingArea  := assess.building_area;
		Self.Assessment.EffectiveYearBuilt  := assess.effective_year_built;
		Self.Assessment.NoOfBuildings  := assess.no_of_buildings;
		Self.Assessment.NoOfUnits  := assess.no_of_units;
		Self.Assessment.NoOfRooms  := assess.no_of_rooms;
		Self.Assessment.ParkingNoOfCars  := assess.parking_no_of_cars;
		Self.Assessment.TypeConstructionDesc  := assess.type_construction_desc;
		Self.Assessment.Foundation  := assess.foundation_desc;
		Self.Assessment.RoofCoverDesc  := assess.roof_cover_desc;
		Self.Assessment.Elevator  := assess.elevator;
		Self.Assessment.FireplaceIndicator  := assess.fireplace_indicator;
		Self.Assessment.FireplaceNumber  := assess.fireplace_number;
		Self.Assessment.Basement  := assess.basement_desc;
		Self.Assessment.BuildingClassDesc  := assess.building_class_desc;
		Self.Assessment.CondoProject  := assess.condo_project_name;
		Self.Assessment.Building  := assess.building_name;
		Self.Assessment.Comments  := assess.comments;
		Self.Assessment.StyleCode  := assess.style_code;
		Self.Assessment.StyleDesc  := assess.style_desc;
		Self.Assessment.TypeConstructionCode  := assess.type_construction_code;
		Self.Assessment.RoofCoverCode  := assess.roof_cover_code;
		Self.Assessment.BuildingClassCode  := assess.building_class_code;
		Self.Assessment.NeighborhoodCode  := assess.neighborhood_code;
		Self.Assessment.AddlLegal  := assess.addl_legal;
		Self.Assessment.SourcePropertyRecord.LivingSquareFeet := assess.fares_living_square_feet;
		Self.Assessment.SourcePropertyRecord.IrisApn := assess.fares_iris_apn;
		Self.Assessment.SourcePropertyRecord.CalculatedLandValue := assess.fares_calculated_land_value;
		Self.Assessment.SourcePropertyRecord.CalculatedImprovementValue := assess.fares_calculated_improvement_value;
		Self.Assessment.SourcePropertyRecord.CalculatedTotalValue := assess.fares_calculated_total_value;
		Self.Assessment.SourcePropertyRecord.AdjustedGrossSquareFeet := assess.fares_adjusted_gross_square_feet;
		Self.Assessment.SourcePropertyRecord.NoOfFullBaths := assess.fares_no_of_full_baths;
		Self.Assessment.SourcePropertyRecord.NoOfHalfBaths := assess.fares_no_of_half_baths;
		Self.Assessment.SourcePropertyRecord.PoolIndicator := assess.fares_pool_indicator ;
		Self.Assessment.SourcePropertyRecord.Frame := assess.fares_frame ;
		Self.Assessment.SourcePropertyRecord.FrameDesc := assess.fares_frame_desc;
		Self.Assessment.SourcePropertyRecord.ElectricEnergy := assess.fares_electric_energy;
		Self.Assessment.SourcePropertyRecord.ElectricEnergyDesc := assess.fares_electric_energy_desc;
		Self.Assessment.SourcePropertyRecord.Sewer := assess.fares_sewer;
		Self.Assessment.SourcePropertyRecord.SewerDesc := assess.fares_sewer_desc;
		Self.Assessment.SourcePropertyRecord.Water := assess.fares_water;
		Self.Assessment.SourcePropertyRecord.WaterDesc := assess.fares_water_desc;
		Self.Assessment.SourcePropertyRecord.Condition := assess.fares_condition;
		Self.Assessment.SourcePropertyRecord.ConditionDesc := assess.fares_condition_desc;
		ds :=  dataset([{assess.school_tax_district1},{assess.school_tax_district2},{assess.school_tax_district3}], {string15 school_tax_district});
		Self.Assessment.SchoolTaxDistricts :=  project(ds,transform(iesp.share.t_StringArrayItem,self.value:= left.school_tax_district));
		
		ds1 := dataset([{assess.tax_exemption1_desc},
						{ assess.tax_exemption2_desc},
						{ assess.tax_exemption3_desc},
						{ assess.tax_exemption4_desc}], {string21 description});
		Self.Assessment.TaxExemptions := project(ds1,transform(iesp.share.t_StringArrayItem,self.value:= left.description));								
		

		ds2 := dataset([{assess.other_buildings1_desc},
					{ assess.other_buildings2_desc},
					{ assess.other_buildings3_desc},
					{ assess.other_buildings4_desc},
					{assess.other_buildings5_desc}], {string28 description});
		Self.Assessment.OtherBuildings := project(ds2,transform(iesp.share.t_StringArrayItem,self.value:= left.description));								
		
		ds3 := dataset([{assess.site_influence1_desc},
					{ assess.site_influence2_desc},
					{ assess.site_influence3_desc},
					{ assess.site_influence4_desc},
					{ assess.site_influence5_desc}], {string29 description});
		Self.Assessment.SiteInfluences := project(ds3,transform(iesp.share.t_StringArrayItem,self.value:= left.description));								
		
		ds4 := dataset([{assess.amenities1_desc},
						{ assess.amenities2_desc},
						{ assess.amenities3_desc},
						{ assess.amenities4_desc},
						{assess.amenities5_desc}], {string17 description});
		Self.Assessment.Amenities := project(ds4,transform(iesp.share.t_StringArrayItem,self.value:= left.description));								
		
		ds5 :=  dataset([{assess.building_area, assess.building_area_indicator,assess.building_area_desc},
						{assess.building_area1, assess.building_area1_indicator, assess.building_area1_desc},
						{assess.building_area2, assess.building_area2_indicator, assess.building_area2_desc},
						{assess.building_area3, assess.building_area3_indicator, assess.building_area3_desc},
						{assess.building_area4, assess.building_area4_indicator, assess.building_area4_desc},
						{assess.building_area5, assess.building_area5_indicator, assess.building_area5_desc},
						{assess.building_area6, assess.building_area6_indicator, assess.building_area6_desc},
						{assess.building_area7, assess.building_area7_indicator, assess.building_area7_desc}], {string9 area, string2 indicator, string30 description});
		Self.Assessment.BuildingAreas := project(ds5,transform(iesp.share.t_StringArrayItem,self.value:= left.description));								
		Self.Assessment.BuildingAreas2 := project(ds5, transform(iesp.property.t_BuildingAreaInfo, self:=left));
		
		Self.Deed.County := deed.county_name;	
		Self.Deed.ParcelId  := deed.apnt_or_pin_number;
		Self.Deed.FipsCode  := deed.fips_code;
		Self.Deed.DeedType  := deed.record_type;
		Self.Deed.DeedTypeDesc  := deed.record_type_desc;
		Self.Deed.MultiApnFlag  := deed.multi_apn_flag;
		Self.Deed.TaxIdNumber  := deed.tax_id_number;
		Self.Deed.PhoneNumber  := deed.phone_number;
		Self.Deed.PropertyAddressCode  := deed.property_address_code;
		Self.Deed.PropertyAddressDesc  := deed.property_address_desc;
		Self.Deed.Buyer1IdCode := deed.buyer1_id_code ;
		Self.Deed.Buyer2IdCode := deed.buyer2_id_code ;
		Self.Deed.BuyerVestingCode  := deed.buyer_vesting_code;
		Self.Deed.BuyerAddendumFlag  := deed.buyer_addendum_flag;
		Self.Deed.Buyer1IdDesc := deed.buyer1_id_desc ;
		Self.Deed.Buyer2IdDesc := deed.buyer2_id_desc ;
		Self.Deed.BuyerVestingDesc  := deed.buyer_vesting_desc;
		
		Self.Deed.BuyersInfo.Id1Code := deed.buyer1_id_code ;
		Self.Deed.BuyersInfo.Id1Description := deed.buyer1_id_desc ;
		Self.Deed.BuyersInfo.Id2Code := deed.buyer2_id_code;
		Self.Deed.BuyersInfo.Id2Description := deed.buyer2_id_desc;
		Self.Deed.BuyersInfo.VestingCode := deed.buyer_vesting_code;
		Self.Deed.BuyersInfo.VestingDescription := deed.buyer_vesting_desc;
		Self.Deed.BuyersInfo.AddendumFlag := deed.buyer_addendum_flag;
		
		Self.Deed.Borrower1IdCode := deed.borrower1_id_code;
		Self.Deed.Borrower2IdCode := deed.borrower2_id_code;
		Self.Deed.BorrowerVestingCode  := deed.borrower_vesting_code;
		Self.Deed.Borrower1IdDesc := deed.borrower1_id_desc;
		Self.Deed.Borrower2IdDesc := deed.borrower2_id_desc;
		Self.Deed.BorrowerVestingDesc  := deed.borrower_vesting_desc;
		
		Self.Deed.BorrowersInfo.Id1Code := deed.borrower1_id_code ;
		Self.Deed.BorrowersInfo.Id1Description := deed.borrower1_id_desc ;
		Self.Deed.BorrowersInfo.Id2Code := deed.borrower2_id_code;
		Self.Deed.BorrowersInfo.Id2Description := deed.borrower2_id_desc;
		Self.Deed.BorrowersInfo.VestingCode := deed.borrower_vesting_code;
		Self.Deed.BorrowersInfo.VestingDescription := deed.borrower_vesting_desc;
		Self.Deed.BorrowersInfo.AddendumFlag := ''; //Borrower addendumflag doesn't exist.
		
		Self.Deed.Seller1IdCode := deed.seller1_id_code;
		Self.Deed.Seller2IdCode := deed.seller2_id_code;
		Self.Deed.SellerAddendumFlag  := deed.seller_addendum_flag;
		Self.Deed.Seller1IdDesc := deed.seller1_id_desc ;
		Self.Deed.Seller2IdDesc := deed.seller2_id_desc;
		
		Self.Deed.SellersInfo.Id1Code := deed.Seller1_id_code ;
		Self.Deed.SellersInfo.Id1Description := deed.Seller1_id_desc ;
		Self.Deed.SellersInfo.Id2Code := deed.Seller2_id_code;
		Self.Deed.SellersInfo.Id2Description := deed.Seller2_id_desc;
		Self.Deed.SellersInfo.VestingCode := '';//field doesn't exist.
		Self.Deed.SellersInfo.VestingDescription := '';//field doesn't exist.
		Self.Deed.SellersInfo.AddendumFlag := deed.Seller_addendum_flag;
		
		Self.Deed.Lender  := deed.lender_name;
		Self.Deed.LenderNameId  := deed.lender_name_id;
		Self.Deed.LenderDbaAka  := deed.lender_dba_aka_name;
		Self.Deed.LenderFullStreetAddress  := deed.lender_full_street_address;
		Self.Deed.LenderAddressUnitNumber  := deed.lender_address_unit_number;
		Self.Deed.LenderAddressCitystatezip  := deed.lender_address_citystatezip;
		
		Self.Deed.LenderInfo.Name := deed.lender_name ;
		Self.Deed.LenderInfo.NameId := deed.lender_name_id ;
		Self.Deed.LenderInfo.DbaAka :=  deed.lender_dba_aka_name;
		Self.Deed.LenderInfo.FullStreetAddress :=  deed.lender_full_street_address;
		Self.Deed.LenderInfo.AddressUnitNumber := deed.lender_address_unit_number;
		Self.Deed.LenderInfo.AddressCitystatezip := deed.lender_address_citystatezip;
		
		Self.Deed.ContractDate  := iesp.ECL2ESP.toDate ((unsigned6) deed.contract_date);
		Self.Deed.RecordingDate  := iesp.ECL2ESP.toDate ((unsigned6) deed.recording_date);
		Self.Deed.DocumentTypeCode  := deed.document_type_code;
		Self.Deed.DocumentTypeDesc  := deed.document_type_desc;
		Self.Deed.ArmResetDate  := iesp.ECL2ESP.toDate ((unsigned6) deed.arm_reset_date);
		Self.Deed.DocumentNumber  := deed.document_number;
		Self.Deed.RecorderBookNumber  := deed.recorder_book_number;
		Self.Deed.RecorderPageNumber  := deed.recorder_page_number;
		Self.Deed.LandLotSize  := deed.land_lot_size;
		Self.Deed.LegalBriefDescription  := deed.legal_brief_description;
		Self.Deed.LegalLotCode  := deed.legal_lot_code;
		Self.Deed.LegalLotDesc  := deed.legal_lot_desc;
		Self.Deed.LegalLotNumber  := deed.legal_lot_number;
		Self.Deed.LegalBlock  := deed.legal_block;
		Self.Deed.LegalSection  := deed.legal_section;
		Self.Deed.LegalDistrict  := deed.legal_district;
		Self.Deed.LegalLandLot  := deed.legal_land_lot;
		Self.Deed.LegalUnit  := deed.legal_unit;
		Self.Deed.LegalCityMunicipalityTownship  := deed.legal_city_municipality_township;
		Self.Deed.LegalSubdivision  := deed.legal_subdivision_name;
		Self.Deed.LegalPhaseNumber  := deed.legal_phase_number;
		Self.Deed.LegalTractNumber  := deed.legal_tract_number;
		Self.Deed.LegalSecTwnRngMer  := deed.legal_sec_twn_rng_mer;
		Self.Deed.RecorderMapReference  := deed.recorder_map_reference;
		
		Self.Deed.LegalInfo.BriefDescription := deed.legal_brief_description;
		Self.Deed.LegalInfo.LotCode  := deed.legal_lot_code;
		Self.Deed.LegalInfo.LotDesc  := deed.legal_lot_desc ;
		Self.Deed.LegalInfo.LotNumber  := deed.legal_lot_number ;
		Self.Deed.LegalInfo.Block  := deed.legal_block ;
		Self.Deed.LegalInfo.Section  := deed.legal_section ;
		Self.Deed.LegalInfo.District  := deed.legal_district ;
		Self.Deed.LegalInfo.LandLot  := deed.legal_land_lot ;
		Self.Deed.LegalInfo.Unit  := deed.legal_unit ;
		Self.Deed.LegalInfo.CityMunicipalityTownship  := deed.legal_city_municipality_township ;
		Self.Deed.LegalInfo.Subdivision  := deed.legal_subdivision_name ;
		Self.Deed.LegalInfo.PhaseNumber  := deed.legal_phase_number ;
		Self.Deed.LegalInfo.TractNumber  := deed.legal_tract_number ;
		Self.Deed.LegalInfo.SecTwnRngMer  := deed.legal_sec_twn_rng_mer ;
		Self.Deed.LegalInfo.AssessorMapRef  := deed.recorder_map_reference ;
		
		
		Self.Deed.CompleteLegalDescriptionCode  := deed.complete_legal_description_code;
		Self.Deed.LoanNumber  := deed.loan_number;
		Self.Deed.ConcurrentMortgageBookPageDocumentNumber  := deed.concurrent_mortgage_book_page_document_number;
		Self.Deed.HawaiiTct  := deed.hawaii_tct;
		Self.Deed.HawaiiCondoCprCode  := deed.hawaii_condo_cpr_code;
		Self.Deed.HawaiiCondo  := deed.hawaii_condo_name;
		Self.Deed.FillerExceptHawaii  := deed.filler_except_hawaii;
		Self.Deed.SalesPrice  := deed.sales_price;
		Self.Deed.CityTransferTax  := deed.city_transfer_tax;
		Self.Deed.CountyTransferTax  := deed.county_transfer_tax;
		Self.Deed.TotalTransferTax  := deed.total_transfer_tax;
		Self.Deed.SalesPriceCode  := deed.sales_price_code;
		Self.Deed.SalesPriceDesc  := deed.sales_price_desc;
		Self.Deed.ExciseTaxNumber  := deed.excise_tax_number;
		Self.Deed.PropertyUseCode  := deed.property_use_code;
		Self.Deed.PropertyUseDesc  := deed.property_use_desc;
		Self.Deed.AssessmentMatchLandUseCode  := deed.assessment_match_land_use_code;
		Self.Deed.AssessmentMatchLandUseDesc  := deed.assessment_match_land_use_desc;
		Self.Deed.CondoCode  := deed.condo_code;
		Self.Deed.CondoDesc  := deed.condo_desc;
		Self.Deed.TimeshareFlag  := deed.timeshare_flag;
		Self.Deed.FirstTdLoanAmount  := deed.first_td_loan_amount;
		Self.Deed.FirstTdLoanType  := deed.first_td_loan_type_desc;
		Self.Deed.TypeFinancing  := deed.type_financing;
		Self.Deed.TypeFinancingDesc  := deed.type_financing_desc;
		Self.Deed.FirstTdInterestRate  := deed.first_td_interest_rate;
		Self.Deed.FirstTdDueDate  := iesp.ECL2ESP.toDate ((unsigned6) deed.first_td_due_date);
		Self.Deed.TitleCompany  := deed.title_company_name ;
		Self.Deed.RateChangeFrequency  := deed.rate_change_frequency;
		Self.Deed.RateChangeFrequencyDesc  := deed.rate_change_frequency_desc;
		Self.Deed.ChangeIndex  := deed.change_index;
		Self.Deed.AdjustableRateIndex  := deed.adjustable_rate_index;
		Self.Deed.AdjustableRateIndexDesc  := deed.adjustable_rate_index_desc;
		Self.Deed.AdjustableRateRider  := deed.adjustable_rate_rider;
		Self.Deed.GraduatedPaymentRider  := deed.graduated_payment_rider;
		Self.Deed.BalloonRider  := deed.balloon_rider;
		Self.Deed.FixedStepRateRider  := deed.fixed_step_rate_rider;
		Self.Deed.CondominiumRider  := deed.condominium_rider;
		Self.Deed.PlannedUnitDevelopmentRider  := deed.planned_unit_development_rider;
		Self.Deed.RateImprovementRider  := deed.rate_improvement_rider;
		Self.Deed.AssumabilityRider  := deed.assumability_rider;
		Self.Deed.PrepaymentRider  := deed.prepayment_rider;
		Self.Deed.OneFourFamilyRider  := deed.one_four_family_rider;
		Self.Deed.BiweeklyPaymentRider  := deed.biweekly_payment_rider;
		Self.Deed.SecondHomeRider  := deed.second_home_rider;
		Self.Deed.SecondTdLoanAmount  := deed.second_td_loan_amount;
		Self.Deed.FirstTdLenderTypeCode  := deed.first_td_lender_type_code;
		Self.Deed.FirstTdLenderTypeDesc  := deed.first_td_lender_type_desc;
		Self.Deed.SecondTdLenderTypeCode  := deed.second_td_lender_type_code;
		Self.Deed.SecondTdLenderTypeDesc  := deed.second_td_lender_type_desc;
		Self.Deed.PartialInterestTransferred  := deed.partial_interest_transferred;
		Self.Deed.LoanTermMonths  := deed.loan_term_months;
		Self.Deed.LoanTermYears  := deed.loan_term_years;
		Self.Deed.FaresMortgageDate  := iesp.ECL2ESP.toDate ((unsigned6) deed.fares_mortgage_date);
		Self.Deed.FaresBuildingSquareFeet  := deed.fares_building_square_feet;
		Self.Deed.FaresForeclosure  := deed.fares_foreclosure;
		Self.Deed.FaresForeclosureDesc  := deed.fares_foreclosure_desc;
		Self.Deed.FaresRefiFlag  := deed.fares_refi_flag;
		Self.Deed.FaresRefiFlagDesc  := deed.fares_refi_flag_desc;
		Self.Deed.FaresEquityFlag  := deed.fares_equity_flag;
		Self.Deed.FaresEquityFlagDesc  := deed.fares_equity_flag_desc;
		Self.Deed.FaresTransactionType  := deed.fares_transaction_type;
		Self.Deed.FaresTransactionTypeDesc  := deed.fares_transaction_type_desc;
		Self.Deed.FaresMortgageDeedType  := deed.fares_mortgage_deed_type;
		Self.Deed.FaresMortgageDeedTypeDesc  := deed.fares_mortgage_deed_type_desc;
		Self.Deed.FaresMortgageTermCode  := deed.fares_mortgage_term_code;
		Self.Deed.FaresMortgageTermCodeDesc  := deed.fares_mortgage_term_code_desc;
		Self.Deed.FaresMortgageTerm  := deed.fares_mortgage_term;
		Self.Deed.FaresIrisApn  := deed.fares_iris_apn;
		Self.Deed.FaresLenderAddress  := deed.fares_lender_address;
		Self.Deed.MortgageDeedSubtype  := '';
		
		Self.Deed.DeedSourcePropertyRecord.TransactionType  := deed.fares_transaction_type;
		Self.Deed.DeedSourcePropertyRecord.TransactionTypeDesc  := deed.fares_transaction_type ;
		Self.Deed.DeedSourcePropertyRecord.MortgageDeedType  := deed.fares_mortgage_deed_type;
		Self.Deed.DeedSourcePropertyRecord.MortgageDeedTypeDesc  := deed.fares_mortgage_deed_type_desc;
		Self.Deed.DeedSourcePropertyRecord.MortgageTermCode  := deed.fares_mortgage_term_code;
		Self.Deed.DeedSourcePropertyRecord.MortgageTermCodeDesc  := deed.fares_mortgage_term_code_desc;
		Self.Deed.DeedSourcePropertyRecord.MortgageTerm  := deed.fares_mortgage_term;
		Self.Deed.DeedSourcePropertyRecord.IrisApn  := deed.fares_iris_apn;
		Self.Deed.DeedSourcePropertyRecord.LenderAddress  := deed.fares_lender_address ;
		Self.Deed.DeedSourcePropertyRecord.MortgageDate  := iesp.ECL2ESP.toDate ((unsigned6) deed.fares_mortgage_date);;
		Self.Deed.DeedSourcePropertyRecord.BuildingSquareFeet  := deed.fares_building_square_feet;
		Self.Deed.DeedSourcePropertyRecord.Foreclosure  :=  deed.fares_foreclosure;
		Self.Deed.DeedSourcePropertyRecord.ForeclosureDesc  := deed.fares_foreclosure_desc;
		Self.Deed.DeedSourcePropertyRecord.RefiFlag  := deed.fares_refi_flag;
		Self.Deed.DeedSourcePropertyRecord.RefiFlagDesc  := deed.fares_refi_flag_desc;
		Self.Deed.DeedSourcePropertyRecord.EquityFlag  := deed.fares_equity_flag;
		Self.Deed.DeedSourcePropertyRecord.EquityFlagDesc  := deed.fares_equity_flag_desc;
		
		//Entities
		ds_entities := project(L.parties, xform_entities(left));
		Self.Entities := ds_entities;
		
  END;

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Assessor_Details(prop_layout_wLinkIds L) := TRANSFORM
			mac_dt_first_str(ds, field) := macro
				ut.NormDate(min(ds(field<>''), (unsigned)field))
			endmacro;
			mac_dt_last(ds, field) := macro
				ut.NormDate(max(ds, field))
			endmacro;
			mac_dt_last_str(ds, field) := macro
				ut.NormDate(max(ds, (unsigned)field))
			endmacro;
		
			self.src			:= 'ASSESSMENT_V2';
			self.src_desc := 'Tax Assessor Records';
			self.hasName 	:= exists(L.parties(exists(orig_names(orig_name<>''))));
			self.hasSSN  	:= exists(L.parties(exists(entity(app_ssn<>''))));
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= exists(L.parties(orig_csz<>''));
		  self.hasPhone := exists(L.parties(phone_number<>''));
			// Find min & max of 3 dates from all the assessments child dataset records
			rc_dt_first	  := mac_dt_first_str(L.assessments, recording_date);
			rc_dt_last	  := mac_dt_last_str(L.assessments, recording_date);
			av_dt_first   := mac_dt_first_str(L.assessments, assessed_value_year);
			av_dt_last    := mac_dt_last_str(L.assessments, assessed_value_year);
			mv_dt_first   := mac_dt_first_str(L.assessments, market_value_year);
			mv_dt_last    := mac_dt_last_str(L.assessments, market_value_year);
			// Then use the recording_date if not zero or assessed_value_year if not zero, 
			// otherwise use the market_value_year
		  self.dt_first_seen  := if(rc_dt_first<>0,rc_dt_first, 
			                          if(av_dt_first<>0,av_dt_first, mv_dt_first));
		  // don't use rc_dt for last seen unless other 2 are empty
			self.dt_last_seen	  := if(av_dt_last<>0, av_dt_last,  
			                          if(mv_dt_last<>0, mv_dt_last, rc_dt_last));
			self := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Deed_Details(prop_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'DEED_V2';
			self.src_desc := 'Deed Transfers';
			self.hasName 	:= exists(L.parties(exists(orig_names(orig_name<>''))));
			self.hasSSN  	:= exists(L.parties(exists(entity(app_ssn<>''))));
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= exists(L.parties(orig_csz<>''));
		  self.hasPhone := exists(L.parties(phone_number<>''));
			self.dt_first_seen := ut.NormDate((unsigned)(L.deeds[1].recording_date));
			self.dt_last_seen := ut.NormDate((unsigned)(L.deeds[1].recording_date));
			self := [];
	END;
	
	EXPORT AssessorSourceDetailInfo := project(prop_sourceview_sorted(fid_type='A'),xform_Assessor_Details(LEFT));
	EXPORT DeedSourceDetailInfo := project(prop_sourceview_sorted(fid_type='D'),xform_Deed_Details(LEFT));
	EXPORT SourceDetailInfo := AssessorSourceDetailInfo+DeedSourceDetailInfo;
	EXPORT SourceView_Recs := project(prop_sourceview_sorted, toOut(left));
  EXPORT SourceView_RecCount := COUNT(prop_sourceview_sorted);

end;
