IMPORT eMerges, iesp,DriversV2_Services,ut,
				LiensV2_Services,LN_PropertyV2_Services, AutoStandardI,
				CriminalRecords_Services, SexOffender_Services,hunting_fishing_services,
				CCW_Services, doxie,VehicleV2_Services,doxie_cbrs, LN_PropertyV2,
				Gateway, BatchServices, Address, Doxie_Raw, std;
				
EXPORT Functions := MODULE
/////////////////////////////////////////////////
	
	shared ms(string70 a, string70 b, string70 c) :=
			map(a = '' => b,
					b = '' => a,
					ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b); 
					
	shared fullNameValue(string fn, string mn, string lna, string name)  :=
	       if (fn = '' AND mn = '' AND lna = '', name, '');
				 
	shared streetAddress1Value(string prim_name, string prim_range, string predir, string addr_suffix, string postdir) :=
	            if (prim_name != '', '',
													trim(prim_range,left,right) + ' ' + trim(predir,left,right) + ' ' +
			                    trim(prim_name,left,right) + ' ' + trim(addr_suffix) + ' ' + 
													trim(postdir,left,right));
  
  shared streetAddress2Value(string p_city_name, string v_city_name, string param_city, string st, string zip) := 					
							if (trim(ms(p_city_name, v_city_name, param_city),left,right) != '', '',
																			trim(ms(p_city_name, v_city_name, param_city),left,right) + ' ' +
																			trim(st,left,right) + ' ' + trim(zip,left,right));
																			
  shared stateCityZipValue(string p_city_name, string v_city_name, string param_city, string st, string zip) :=
							 if (trim(ms(p_city_name, v_city_name, param_city),left,right) != '' OR zip != '', '',
													trim(st) + ' ' + trim(ms(p_city_name,v_city_name,param_city),left,right) + ' ' + trim(zip));
													
	shared string FormatCurrency (string currency_value, boolean contains_fractions = false, string1 currency_symbol = '$') := FUNCTION
		//limitations:
		// no check for alpha-characters is done (responsibility of a caller)
		// returns input string unchanged if empty or longer than 12 chars (more than 999 billions)
		// caller should check the length of the result returned
		in_value := TRIM (currency_value, Left, Right);
		unsigned1 len := LENGTH (in_value);

		// string length without fractions (negative means no whole-amount is specified)
		integer1 len_wholes := IF (contains_fractions, len-2, len); //

		rem := len_wholes % 3;
		start := IF (rem = 0, 3, rem);
		whole_value := MAP (
			len_wholes > 9  => in_value[1..start] + ',' + in_value[start+1..start+3] + ',' + 
												 in_value[start+4..start+6] + ',' + in_value[start+7..start+9],
			len_wholes > 6  => in_value[1..start] + ',' + in_value[start+1..start+3] + ',' +  in_value[start+4..start+6],
			len_wholes > 3  => in_value[1..start] + ',' + in_value[start+1..start+3],
			len_wholes > 0  => in_value[1..start],
			'');

		fraction_value := IF (len = 1, '0' + in_value, in_value[len-1..]);
		res := currency_symbol + whole_value + IF (contains_fractions, '.' + fraction_value, '');
		return IF (len_wholes > 12 OR len =0, currency_value, res);
  END;
  shared entity_rec := LN_PropertyV2_Services.layouts.parties.entity;
	shared string FormatName (entity_rec L) := function
    return
      if (trim (L.title) != '', trim (L.title), '') +
      if (trim (L.fname) != '', ' ' + trim (L.fname), '') +
      if (trim (L.mname) != '', ' ' + trim (L.mname), '') + 
      if (trim (L.lname) != '', ' ' + trim (L.lname), '') +
      if (trim (L.name_suffix) != '', ' ' + trim (L.name_suffix), '');
  end;
	//****************************************************//
	// Census Data Transform Function			 	 							//
	//****************************************************//
  EXPORT iesp.bpsreport.t_BpsReportCensusData ProjectCensus (layouts.census_layout cens) := FUNCTION
    iesp.bpsreport.t_BpsReportCensusData SetCensus (layouts.census_layout cens) := TRANSFORM
      Self.Age := (integer) cens.age;
      Self.Income := cens.income; 
      Self.HomeValue := cens.home_value;
      Self.Education := cens.education;
    END;
    RETURN PROJECT (cens, SetCensus (Left));
  END;
	
	//****************************************************//
	// Phone Information Transform Function			 	 				//
	//****************************************************//
  EXPORT iesp.share.t_PhoneInfo ProjectPhones (dataset(layouts.phone_out_layout) phones) := FUNCTION
    iesp.share.t_PhoneInfo SetPhones (layouts.phone_out_layout l) := TRANSFORM
     	self.Phone10:=l.phone;
     	self.PubNonpub:=l.publish_code;
			self.ListingPhone10:='';
			self.ListingName:=l.listing_name;
			self.TimeZone:=l.timezone;
			self.ListingTimeZone:='';
    END;
    RETURN PROJECT (phones, SetPhones (Left));
  END;
	//****************************************************//
	// Drivers License Transform Function 	 							//
	//****************************************************//	
	

  EXPORT iesp.bps_share.t_BpsReportDriverLicense ProjectDL (dataset(DriversV2_Services.layouts.result_wide_tmp) dls) := FUNCTION
    dl_narrow := project (dls, DriversV2_Services.layouts.result_wide);
    RETURN project (PROJECT (dl_narrow, iesp.transform_dl_bps (Left)), iesp.bps_share.t_BpsReportDriverLicense);
  END;
	
	//****************************************************//
	// LeinsandJudgement Transform Function 							//
	//****************************************************//	
  
  EXPORT iesp.bizreport.t_BizLienJudgment ProjectLiens (dataset(LiensV2_Services.layout_lien_rollup) ljdata) := FUNCTION
		iesp.bizreport.t_BizLienJudgment projectLiensJudgments (ljdata ds):=transform
			Self.FilingType:=ds.filings[1].filing_type_desc;//ds.orig_filing_type;
			Self.CourtLocation :=ds.filings[1].agency_county;//ds.filing_jurisdiction_name;
			Self.CourtState :=ds.filings[1].agency_state;//ds.filing_state;
			Self.CourtDescription :=ds.filings[1].agency;
			Self.CaseNumber := ds.filings[1].filing_number;//ds.case_number;
			Self.Amount := ds.amount;
			Self.DateFiled := iesp.ECL2ESP.toDatestring8(ds.orig_filing_date);
			Self.DateDisposed := iesp.ECL2ESP.toDatestring8(ds.release_date);
			Self.Plaintiff :=ds.creditors[1].orig_name;
      party := ds.debtors[1].parsed_parties[1];
			Self.Defendant.name := iesp.ECL2ESP.SetName (party.fname, party.mname, party.lname, party.name_suffix, party.title);
			Self.Defendant.SSN :=ds.debtors[1].parsed_parties[1].ssn;
			addr := ds.debtors[1].Addresses[1];
			Self.Defendant.Address := iesp.ECL2ESP.SetAddress (
						addr.prim_name, addr.prim_range, addr.predir, addr.postdir,
						addr.addr_suffix, addr.unit_desig, addr.sec_range,
						trim(ms(addr.p_city_name, addr.v_city_name, ''),left,right), addr.st, addr.zip, addr.zip4,
						'', '',
						streetAddress1Value(addr.prim_name, addr.prim_range, addr.predir, addr.addr_suffix, addr.postdir),
						streetAddress2Value(addr.p_city_name, addr.v_city_name, '', addr.st, addr.zip),
						stateCityZipValue(addr.p_city_name, addr.v_city_name, '', addr.st, addr.zip));

			Self.Defendant.CompanyName :=ds.debtors[1].parsed_parties[1].cname;//ds.filings[1].agency;
			Self.Defendant.Book :=ds.filings[1].filing_book;
			Self.Defendant.Page :=ds.filings[1].filing_page;
			Self.Defendant.OtherCaseNumber :='';
		end;
	
    RETURN PROJECT (ljdata, projectLiensJudgments (Left));
  END;
		


	//****************************************************//
	// Residents Data Transform Function 				 					//
	//****************************************************//
  EXPORT iesp.addressreport.t_AddrReportPresentResident ProjectPresentResidents (dataset(AddressReport_Services.Layouts.residents_final_out) res,
																																								 boolean isLocationReport) := FUNCTION
    iesp.addressreport.t_AddrReportPresentResident SetCurrent (res l) := TRANSFORM
			self.identity			:= l.identity;
			self.AKAs 				:= choosen(l.akas,iesp.constants.AR.MaxAkas);
			self.Phones 			:= if(isLocationReport, l.CurrentPhone, dataset([], iesp.addressreport.t_AddrReportRealTimePhone));
			hris							:= project(L.hri_address, transform(iesp.share.t_RiskIndicator, 
																																					self.RiskCode := left.hri, 
																																					self.Description := left.desc));
			addr							:= iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
																										L.suffix, L.unit_desig, L.sec_range, L.city_name, 
																										L.st, L.zip, L.zip4, '');
			dt_last_seen			:= iesp.ECL2ESP.toDateYM(L.addr_dt_last_seen);
			dt_first_seen			:= iesp.ECL2ESP.toDateYM(L.addr_dt_first_seen);
			self.Address.HighRiskIndicators := if(isLocationReport, hris, dataset([], iesp.share.t_RiskIndicator));
			Self.Address 			:= if(isLocationReport, addr, row([], iesp.share.t_Address));
			self.DateLastSeen := if(isLocationReport, dt_last_seen, row([], iesp.share.t_Date));
			self.DateFirstSeen:= if(isLocationReport, dt_first_seen, row([], iesp.share.t_Date));
			self.Height				:= if(isLocationReport, L.height, '');
			self.Weight				:= if(isLocationReport, L.weight, '');
			self.HairColor		:= if(isLocationReport, L.hair_color, '');
			self.EyeColor			:= if(isLocationReport, L.eye_color, '');
    END;

    RETURN PROJECT (res, SetCurrent (Left));
  END;

  EXPORT iesp.addressreport.t_AddrReportPriorResident ProjectPriorResidents (dataset(layouts.residents_final_out) res) := FUNCTION
		iesp.addressreport.t_AddrReportPriorResident SetPrior (res l) := TRANSFORM
			self.identity:=l.identity;
			Self.currentaddress := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
						L.suffix, L.unit_desig, L.sec_range, L.city_name, L.st, L.zip, L.zip4, '');
			self.AKAs :=choosen(l.akas,iesp.constants.AR.MaxAkas);
			self.CurrentPhone := project(l.CurrentPhone, iesp.share.t_PhoneInfo)[1]; //Prior Residents only has one CurrentPhone record
    END;
    RETURN PROJECT (res, SetPrior (Left));
  END;	
	//****************************************************//
	// Business Data Transform Function		 	 							//
	//****************************************************//

	EXPORT iesp.addressreport.t_AddrReportBusiness ProjectBusiness (dataset(layouts.layout_Business_out) bus) := FUNCTION
		
		iesp.addressreport.t_AddrReportBusIdentity SetIdentity (bus l) := TRANSFORM
			self.Name								:=l.company_name;
			self.phone10						:=(string) l.phone;
			self.fein								:=(string) l.fein;
			self.uniqueid						:=(string) l.bdid;
			self.BusinessIds.DotID 	:= l.dotid;
			self.BusinessIds.EmpID 	:= l.empid;
			self.BusinessIds.PowID 	:= l.powid;
			self.BusinessIds.UltID 	:= l.ultid;
			self.BusinessIds.SeleID	:= l.seleid;
			self.BusinessIds.ProxID	:= l.proxid;
			self.BusinessIds.OrgID 	:= l.orgid;
    END;
    identity_recs:=PROJECT (bus, SetIdentity (Left));
		
		iesp.addressreport.t_AddrReportBusiness SetBus (bus l) := TRANSFORM
			Self.address := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
						L.addr_suffix, L.unit_desig, L.sec_range, L.city, L.state, L.zip, L.zip4, '');
			self.identities:=identity_recs;
    END;

    RETURN PROJECT (choosen(bus,1), SetBus (Left));
		
		
  END;
	
	//****************************************************//
	// Property Transform Function				 								//
	//****************************************************//
EXPORT iesp.bpsreport.t_BpsReportProperty ProjectProp (dataset(LN_PropertyV2_Services.layouts.combined.widest) prop_in) := FUNCTION

	iesp.bpsreport.t_BpsReportProperty set_prop (prop_in L) := TRANSFORM
		SELF.DataSource := L.vendor_source_flag;//l.fid_type;//l.ln_fares_id[2];//l.source_code;

		deed := L.deeds[1];
		Assess:=L.assessments[1];
		prop := L.parties (party_type = 'P')[1];
		buyer := L.parties (party_type = 'O')[1];  // "Buyer"
		seller :=  L.parties (party_type = 'S')[1];

		SELF.SellerAddress := iesp.ECL2ESP.SetAddress (
					seller.prim_name, seller.prim_range, seller.predir, seller.postdir, seller.suffix, 
					seller.unit_desig, seller.sec_range, seller.v_city_name, seller.st, seller.zip,
					seller.zip4, seller.county_name);
		SELF.ParcelNumber := if(l.fid_type='D',deed.fares_iris_apn,Assess.fares_iris_apn);//L.fapn;
		SELF.ParcelId := if(l.fid_type='D',deed.apnt_or_pin_number,Assess.apna_or_pin_number);//L.uapn;
		SELF._Type := l.fid_type_desc;//l.record_type;
		SELF.FaresId := l.ln_fares_id;
		SELF.LotNumber := assess.legal_lot_number;
		SELF.NameOwner1 := FormatName(buyer.entity[1]);//l.Name_Owner_1;
		SELF.NameOwner2 := FormatName(buyer.entity[2]);//l.Name_Owner_2;
		SELF.Address := iesp.ECL2ESP.SetAddress (
					prop.prim_name, prop.prim_range, prop.predir, prop.postdir, prop.suffix, 
					prop.unit_desig, prop.sec_range, prop.v_city_name, prop.st, prop.zip,
					prop.zip4, prop.county_name);
		SELF.OwnerAddress := iesp.ECL2ESP.SetAddress (
					buyer.prim_name, buyer.prim_range, buyer.predir, buyer.postdir, buyer.suffix, 
					buyer.unit_desig, buyer.sec_range, buyer.v_city_name, buyer.st, buyer.zip,
					buyer.zip4, buyer.county_name);

		SELF.LandUse := if(l.fid_type='D',deed.property_use_desc,assess.standardized_land_use_desc);
		SELF.LandValue := assess.market_land_value;//l.Land_Value;
		SELF.SubdivisionName := assess.legal_subdivision_name;//l.Subdivision_Name;
		SELF.TotalValue := iesp.ECL2ESP.FormatDollarAmount (assess.market_total_value);//l.Total_Value;
		SELF.ImprovementValue := iesp.ECL2ESP.FormatDollarAmount (assess.market_improvement_value);//l.Improvement_Value;
		SELF.LandSize := assess.land_square_footage;//l.Land_Size;
		SELF.BuildingSize := '';//l.Building_Size;
		SELF.BuildingSquareFeet := deed.fares_building_square_feet;//l.building_square_feet;
		SELF.YearBuilt := (integer) assess.year_built;//(integer) l.Year_Built;
		SELF.TaxYear := (integer) assess.tax_year;//(integer) L.tax_year;
		SELF.SaleDate := iesp.ECL2ESP.toDate (
																			if(l.fid_type='D',
																				(unsigned4) deed.contract_date,
																				(unsigned4) assess.sale_date));
		SELF.RecordingDate := if(l.fid_type='D',iesp.ECL2ESP.toDate ((unsigned4) deed.recording_date),iesp.ECL2ESP.toDate ((unsigned4) assess.recording_date));
		SELF.LoanDueDate := [];//iesp.ECL2ESP.toDate ((unsigned4) l.Loan_Due_Date);
		SELF.SalePrice := if(l.fid_type='D',iesp.ECL2ESP.FormatDollarAmount (deed.sales_price),iesp.ECL2ESP.FormatDollarAmount (assess.sales_price));//l.Sale_Price;
		SELF.NameSeller := FormatName (seller.entity[1]);//l.name_of_seller;
		SELF.LenderName := if(l.fid_type='D',deed.lender_name,assess.mortgage_lender_name);
		SELF.LegalDescription := if(l.fid_type='D',deed.legal_brief_description,assess.legal_brief_description);
		SELF.MortgageAmount := iesp.ECL2ESP.FormatDollarAmount (deed.first_td_loan_amount);
		// SELF.MortgageTermCode := '';//l.MortgageTermCode;
		SELF.MortgageTerm := deed.fares_mortgage_term + if (deed.fares_mortgage_term_code_desc != '', 
																												' ' + deed.fares_mortgage_term_code_desc, '');
		SELF.DocumentType := deed.document_type_desc;
		SELF.DocumentNumber := deed.document_number;
		SELF.TransactionType := deed.fares_transaction_type_desc;;
		SELF.MortgageLoanType := if(l.fid_type='D',deed.first_td_loan_type_desc,assess.mortgage_loan_type_desc);//codes.FARES_1080.mortgage_loan_type_code(L.loan_amount);//l.Loan_Type;
		// SELF.LeaderName := '';//l.LeaderName; - ?????????
		SELF.TitleCompanyName := deed.title_company_name;
		Self.MortgageDeedType := deed.fares_mortgage_deed_type_desc;
		Self.MortgageDeedSubtype := '';
		Self.AssessedValue := iesp.ECL2ESP.FormatDollarAmount (assess.assessed_total_value);
		Self.TaxAmount := iesp.ECL2ESP.FormatDollarAmount (assess.tax_amount);
		// SELF.MarketLandValue := L.mkt_land_val;
		// SELF.MarketImprovementValue := L.mkt_improvement_val;
		// SELF.TotalMarketValue := L.mkt_total_val;
		// SELF.LivingSize := stringlib.stringfilter (L.building_square_feet, _Validate.Strings.digit);
		SELF.Foundation := assess.foundation_desc;
		Self.NumberStories   := (string) assess.no_of_stories;
		Self.NumberBedrooms  := (string) assess.no_of_bedrooms;
		Self.NumberFullBaths := (string) assess.no_of_baths;
		Self.NumberHalfBaths := (string) assess.no_of_partial_baths;

		int_book_d := (integer) deed.recorder_book_number;
		int_book_a := (integer) assess.recorder_book_number;
		int_book:=if(l.fid_type='D',int_book_d,int_book_a);
		int_page_d := (integer) deed.recorder_page_number;
		int_page_a := (integer) assess.recorder_page_number;
		int_page	:= if(l.fid_type='D',int_page_d,int_page_a);
		Self.Book := if (int_book = 0, '', (string) int_book);
		Self.Page := if (int_page = 0, '', (string) int_page);
		SELF.InterestRate := deed.first_td_interest_rate;
		SELF.InterestRateType := deed.type_financing_desc;
		SELF.HomesteadExemption := if (assess.homestead_homeowner_exemption = 'Y', 'YES', '');
		SELF.LoanAmount := iesp.ECL2ESP.FormatDollarAmount (assess.mortgage_loan_amount);
		// SELF.LoanType := l.Loan_Type;
		// SELF.Basement := l.Basement;
		// SELF.ExteriorWalls := l.ExteriorWalls;
		// SELF.RoofType := l.Roof_Type;
		// SELF.AirConditioning := l.AirConditioning;
		SELF.Heating := assess.heating_desc;
		// SELF.Fireplace := l.Fireplace;
		// SELF.Pool := l.Pool;
		// SELF.Garage := l.Garage;

		Self.Sellers := choosen (project (seller.orig_names, transform (iesp.share.t_StringArrayItem, Self.value := Left.orig_name)),
														 iesp.Constants.PROP.MaxSellers);
		Self.Owners  := choosen (project (buyer.orig_names, transform (iesp.share.t_StringArrayItem, Self.value := Left.orig_name)),
														 iesp.Constants.PROP.MaxOwners);
		// SELF.OtherBuyers := choosen (project (L.other_buyers, transform (iesp.share.t_StringArrayItem, Self.value := Left.buyer)),
														 // iesp.Constants.PROP.MaxBuyers);
		// SELF.OtherSellers := choosen (project (L.other_sellers, transform (iesp.share.t_StringArrayItem, Self.value := Left.seller)),
														 // iesp.Constants.PROP.MaxSellers);
		// SELF.OtherBuildings := dataset([{l.OtherBuildings1},
										// {l.OtherBuildings2},
										// {l.OtherBuildings3},
										// {l.OtherBuildings4},
										// {l.OtherBuildings5}],iesp.share.t_StringArrayItem)(value<>'');
		// SELF.OtherCharacteristics := dataset([{l.OtherCharacteristics1},
										// {l.OtherCharacteristics2},
										// {l.OtherCharacteristics3},
										// {l.OtherCharacteristics4},
										// {l.OtherCharacteristics5}],iesp.share.t_StringArrayItem)(value<>'');
		self:=[];
	END;
	return project(prop_in,set_prop(LEFT));
END;

	//****************************************************//
	// Relative and Associate Transform Function					//
	//****************************************************//
export projectRelativeAssociate(dataset(AddressReport_Services.Layouts.rel_asst_layout) in_ds) := function
	iesp.addressreport.t_AddrReportRelativeAssociate set_rel_assoc(in_ds L) := transform
		self.ResidentUniqueId := (string)L.person1;
		self.UniqueId					:= (string)L.person2;
		self.Name							:= iesp.ECL2ESP.SetName(L.fname, L.mname, L.lname, L.name_suffix, L.title, ''); 
		self.DOB							:= iesp.ECL2ESP.toDate(L.dob);
		self.Address					:= iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
																											L.suffix, L.unit_desig, L.sec_range, L.city_name,
																											L.st, L.zip, L.zip4, '');
		self.Phone10					:= L.phone;
		self.RelationshipType := L.type;
		self.RelationshipConfidence:= L.confidence;
	end;
	return project(in_ds,set_rel_assoc(left));
end;

	//****************************************************//
	// Vehicles Transform Function												//
	//****************************************************//
export projectVehicles(dataset(VehicleV2_Services.Layout_Report) in_ds,
											 AddressReport_Services.Layouts.in_address in_addr) := function
	AddressReport_Services.Layouts.iesp_addrpt_possveh_plusdid_layout set_vehicles(in_ds L) := transform
		reg										 := L.registrants(prim_range = in_addr.prim_range and 
																						prim_name = in_addr.prim_name and 
																						addr_suffix = in_addr.suffix and
																						(v_city_name = in_addr.v_city_name or v_city_name = in_addr.p_city_name) and 
																						st = in_addr.st and 
																						zip5 = in_addr.zip);
		// Set boolean if the Vehicle registrant address is the same as the reported on address 
		boolean regaddr_sameas_rptaddr := exists(reg);
		reg_to_use 							:= if(regaddr_sameas_rptaddr, reg[1], L.registrants[1]);
		self.YearMake 					:= (integer4) L.model_year;
		self.Make 							:= L.make_desc;
		self.Model 							:= L.model_desc;
		self.MajorColor 				:= L.major_color_desc;
		self.MinorColor 				:= L.minor_color_desc;
		self.BodyStyle 					:= L.body_style_desc;
		self.RegistrantName 		:= iesp.ECL2ESP.SetName(reg_to_use.fname, reg_to_use.mname, reg_to_use.lname, reg_to_use.name_suffix, '', ''); 
		self.RegistrantAddress 	:= iesp.ECL2ESP.SetAddress (reg_to_use.prim_name, reg_to_use.prim_range, reg_to_use.predir, reg_to_use.postdir,
																											reg_to_use.addr_suffix, reg_to_use.unit_desig, reg_to_use.sec_range, reg_to_use.v_city_name,
																											reg_to_use.st, reg_to_use.zip5, reg_to_use.zip4, '');
		self.VIN 								:= L.vin;
		self.PlateNumber				:= reg_to_use.reg_license_plate;
		self.ResidentUniqueId          := ''; // null for now, will be filled in by the calling function
		self.AssociatedToReportAddress := regaddr_sameas_rptaddr;
		self.registrant_did            := (unsigned6) reg_to_use.append_did;
	end;
	return project(in_ds, set_vehicles(left));	
end;

	//**************************************************** //
	// Hunting and Fishing Lics Transform Function  			 //
	//**************************************************** //
export projectHuntFish(dataset(iesp.huntingfishing.t_HuntFishRecord) in_ds,
											         AddressReport_Services.Layouts.in_address in_addr) := function
	AddressReport_Services.Layouts.iesp_addrpt_posshf_plusdid_layout tf_hunt_fish(in_ds L) := transform
		// Set boolean if the HF address is the same as the reported on address 
		hfaddr_sameas_rptaddr := (L.Address.StreetNumber = in_addr.prim_range   and 
		                          L.Address.StreetName   = in_addr.prim_name    and 
		                          L.Address.StreetSuffix = in_addr.suffix       and 
		                          (L.Address.City = in_addr.v_city_name or
															 L.Address.City = in_addr.p_city_name)        and 
		                          L.Address.State        = in_addr.st           and 
		                          L.Address.Zip5         = in_addr.zip);
		self.Name 							:= L.Name;
		self.SSN                := L.SSN;
		self.Address 						:= L.Address;
		self.LicenseType				:= L.LicenseType;
		self.HomeState				  := L.HomeState;
		self.LicenseState				:= L.LicenseState;
		self.IssueDate          := L.LicenseDate;
		self.ResidentUniqueId          := ''; // null for now, will be filled in by the calling function
		self.AssociatedToReportAddress := hfaddr_sameas_rptaddr;
		self.licensee_did              := (unsigned6) L.UniqueId;
	end;
	return project(in_ds, tf_hunt_fish(left));
end;

	//****************************************************//
	// Criminals Transform Function												//
	//****************************************************//
export projectCrim(dataset(iesp.criminal.t_CrimReportRecord) in_ds) := function
	iesp.addressreport.t_AddrReportPossibleCriminal set_criminal_records(in_ds L) := transform
		self.OffenderId 	:= L.OffenderId;
		self.Name 				:= L.Name;
		self.Address 			:= L.Address;
		self.DOB 					:= L.DOB;
		self.OffenseState	:= L.StateOfOrigin;
		self.DataSource 	:= L.DataSource;
		self.CaseNumber		:= L.CaseNumber;
	end;
	return project(in_ds, set_criminal_records(left));
end;

	//****************************************************//
	// Sex Offenders Transform Function										//
	//****************************************************//
export projectSexOffenders(dataset(SexOffender_Services.Layouts.t_OffenderRecord_plus) in_ds) := function
	iesp.addressreport.t_AddrReportPossibleSexOffense set_sex_off(in_ds L) := transform
		self.Name 							:= L.Name;
		self.Address 						:= L.Address;
		self.DOB 								:= L.DOB;
		self.Height 						:= L.PhysicalCharacteristics.Height;
		self.Weight 						:= L.PhysicalCharacteristics.Weight;
		self.Race 							:= L.PhysicalCharacteristics.Race;
		self.Convictions 				:= choosen(L.Convictions, iesp.Constants.SEXOFF_MAX_COUNT_CONVICTIONS);
		self.OffenderStatus 		:= L.OffenderStatus;
		self.ScarsMarksTattoos	:= if(L.ScarsMarksTattoos <> '', L.ScarsMarksTattoos, L.PhysicalCharacteristics.ScarsMarksTattoos);
		self.ImageLink					:= L.ImageLink;
	end;
	return project(in_ds, set_sex_off(left));
end;

	//****************************************************//
	// Possible Other Occupants Transform Function				//
	//****************************************************//
export projectOtherOccupants(dataset(iesp.bpsreport.t_NeighborAddressSlim) in_ds) := function
	iesp.addressreport.t_AddrReportPossibleOccupants set_other_occupants(in_ds L) := transform
		self.Address					:= L.Address;
		self.Occupants				:= project(L.Residents, iesp.addressreport.t_AddrReportIdentitySlim);
		self.Phones						:= L.Phones;
	end;
	return project(in_ds, set_other_occupants(left));
end;

	//****************************************************//
	// Possible Owner Transform Function									//
	//****************************************************//
export projectPossibleOwner(dataset(AddressReport_Services.Layouts.possible_owner_layout) in_ds) := function
	iesp.addressreport.t_AddrReportPossibleOwner set_owner(in_ds L) := transform
		self.Name							:= iesp.ECL2ESP.SetNameAndCompany(L.fname, L.mname, L.lname, L.name_suffix, L.title, '', L.company_name); 
		self.Address					:= iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
																											L.suffix, L.unit_desig, L.sec_range, L.city_name,
																											L.st, L.zip, L.zip4, '');
		self.Phone10					:= L.phone;
	end;
	return project(in_ds, set_owner(left));
end;	

shared inputParams:= AutoStandardI.GlobalModule();

shared fCriminalRecords(dataset(CriminalRecords_Services.layouts.l_search) in_recs) := function
	crim_mod := module(project(inputParams,CriminalRecords_Services.IParam.report,  opt))
		export boolean 	IncludeAllCriminalRecords := true;
		export boolean 	IncludeSexualOffenses := true; //shouldn't this be set to false...
		export string25		doc_number:='';
		export string60		offender_key:='';
	end;
	crim_recs 	:= CriminalRecords_Services.Raw.getOffenderraw(in_recs);
	f_crim_recs	:= CriminalRecords_Services.ReportService_Records.applyRulesAndFormatCrimRecs(crim_recs,crim_mod);
	/* Note: the above call gets the Non-FCRA results in the FCRA layout. 
	So transform to Non-FCRA layout is needed. */
	result			:= project(f_crim_recs.CriminalRecords,iesp.criminal.t_CrimReportRecord);
	return result;
end;	
												
export fCrimes():= function
	crim_module := module(project (inputParams,CriminalRecords_Services.IParam.ak_params,  opt))
		export boolean workHard := true;
		export boolean noFail := false;
		export boolean isdeepDive := false;
	end;
	crim_ids	:= CriminalRecords_Services.Autokey_ids.val(crim_module);
	result 		:= fCriminalRecords(crim_ids);
	return result;
end;

export fCrimesRecords(dataset(doxie.layout_references) in_dids) := function
	crim_ids	:= CriminalRecords_Services.Raw.getOffenderKeys.byDIDs(in_dids);
	result 		:= fCriminalRecords(crim_ids);
	return result;
end;

export fSexOffendors():=FUNCTION 	
	OffenderTempmod := module(project(inputParams,SexOffender_Services.IParam.search,opt));
	   export boolean include_regaddrs   := false; 
		 export boolean include_unregaddrs := false;
		 export boolean include_histaddrs  := false;
		 export boolean include_assocaddrs := false;
		 export boolean include_offenses := true;
		 export boolean include_bestaddress := true;
  end;
	SexOffendorRawRecords:=sexOffender_Services.search_Records.val(OffenderTempmod);
		// set the maxresults_val that is used in Alerts.mac_ProcessAlerts
	unsigned8 maxresults_val := Constants.MaxSexualOffenses;
		RESULT:=project(SexOffendorRawRecords, 
	TRANSFORM(iesp.sexualoffender.t_OffenderRecord, 
			SELF:=LEFT;
			SELF:=[];));
	RETURN RESULT;
END;		

export fSexOffenderRecords(dataset(doxie.layout_references) in_dids, 
													 string32 ApplicationType) := function
	so_dids			:= project(in_dids, SexOffender_Services.layouts.search_did);
	so_id_recs	:= SexOffender_Services.Raw.byDIDs(so_dids);
	so_mod := module(project(inputParams,SexOffender_Services.IParam.search,opt));
	   export boolean include_regaddrs   := false; 
		 export boolean include_unregaddrs := false;
		 export boolean include_histaddrs  := false;
		 export boolean include_assocaddrs := false;
		 export boolean include_offenses := true;
		 export boolean include_bestaddress := true;
  end;
	results 		:= sexOffender_Services.search_Records.getRecordsAndApplyRules(so_id_recs, so_mod); //gives same results as sexOffender_Services/search_records.val, but gets so ids using DID
	return results;
end;

export fHuntingAndFishing():=function 
		hunting_ID_params	:= module(project(inputParams, hunting_fishing_services.AutoKey_IDs.params,opt));
													end;
		hunting_Rids      := hunting_fishing_services.AutoKey_IDs.val(hunting_ID_params); 
		hunting_Raw_recs  := join(hunting_Rids,eMerges.Key_HuntFish_Rid(),
															(keyed(left.rid= right.rid)),
															 transform(hunting_fishing_services.Layouts.raw_rec,
																self:=left,
																self:=right), 
															limit(0), keep(1));
	  in_mod						:= module(project(inputParams,hunting_fishing_Services.Search_Records.params,  opt))end;
    hfSearch					:= hunting_fishing_Services.Search_Records;
	  result      			:= hfSearch.formatandFilterRawRecords(hunting_Raw_recs,in_mod);		
		return result;
end;

shared fConcealedWeaponsPermits(dataset(ccw_services.Layouts.search_rid) in_recs) := function
	cw_mod 			:= module(project(inputParams,CCW_services.SearchService_Records.params,  opt))end;
	cw_rid_recs := CCW_services.Raw.byRids(in_recs);
	result			:= ccw_services.SearchService_Records.getFormatedRecords(cw_rid_recs,cw_mod);
	return result;																
end;
																
export fWeaponsPermits():=Function
	Weapons_ID_params	:= module(project(inputParams,CCW_services.AutoKey_IDs.params,opt));
												end;
	Weapons_IDs				:= CCW_services.AutoKey_IDs.val(Weapons_ID_params); 
	result						:= fConcealedWeaponsPermits(Weapons_IDs);
	return result;
end;

export fWeaponsPermitsRecords(dataset(doxie.layout_references) in_dids) := function
	cw_id_recs := CCW_Services.Raw.byDIDs(project(in_dids, CCW_services.Layouts.search_did));
	result 		 := fConcealedWeaponsPermits(cw_id_recs);
	return result;
end;

export fAddDriverInfo(dataset(AddressReport_Services.Layouts.residents_final_out) m_Resident,
											dataset(DriversV2_Services.layouts.result_wide_tmp) m_DriverInfo) := function
	ds_driver := dedup(sort(m_DriverInfo, did, -dt_last_seen), did);
	m_Resident xformDriverInfo(m_Resident L, ds_driver R) := transform
		self.height 		:= R.height;
		self.weight 		:= R.weight;
		self.eye_color 	:= R.eye_color;
		self.hair_color	:= R.hair_color;
		self						:= L;
	end;
	result 		:= join(m_Resident, ds_driver,
										left.did = right.did,
										xformDriverInfo(left, right), 
										left outer, limit(0), keep(1));
	return result;
end;

export fPossibleOwners(dataset(AddressReport_Services.Layouts.in_address) in_recs,
											AddressReport_Services.input.params in_param) := function

  mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
    EXPORT unsigned1 glb := in_param.glbPurpose;
    EXPORT unsigned1 dppa := in_param.dppaPurpose;
    EXPORT string DataPermissionMask := in_param.DataPermissionMask;
    EXPORT string DataRestrictionMask := in_param.DataRestrictionMask;
    EXPORT boolean ln_branded := in_param.lnbranded;
    EXPORT string5 industry_class := in_param.industryclass;
    EXPORT string32 application_type := in_param.applicationType;
    EXPORT boolean no_scrub := in_param.raw;
		EXPORT boolean show_minors := in_param.IncludeMinors OR (in_param.glbPurpose = 2);
  END;

	owner_key := LN_PropertyV2.key_ownership.addr();
	id_rec1 := join(in_recs, owner_key,
									keyed(left.prim_range = right.prim_range) and 
									keyed(left.predir = right.predir) and
									keyed(left.prim_name = right.prim_name) and
									keyed(left.suffix = right.addr_suffix) and
									keyed(left.postdir = right.postdir) and
									keyed(left.sec_range = right.sec_range) and
									keyed(left.zip = right.zip5),
									transform(right),
									limit(ut.limits.DEFAULT));
	
	// ...and when we don't get exact hits, try omitting the sec_range
	// narrow inputs to those not successfully handled in previous block
	in_recs2 := join(in_recs(sec_range<>''), id_rec1,
									left.prim_range = right.prim_range and 
									left.predir = right.predir and
									left.prim_name = right.prim_name and
									left.suffix = right.addr_suffix and
									left.postdir = right.postdir and
									left.sec_range = right.sec_range and
									left.zip = right.zip5,
									transform(recordof(in_recs), self.sec_range := '', self := left),
									left only);
	id_rec2 := if(exists(in_recs2), join(in_recs2, owner_key,
																				keyed(left.prim_range = right.prim_range) and 
																				keyed(left.predir = right.predir) and
																				keyed(left.prim_name = right.prim_name) and
																				keyed(left.suffix = right.addr_suffix) and
																				keyed(left.postdir = right.postdir) and
																				keyed(left.sec_range = right.sec_range) and
																				keyed(left.zip = right.zip5),
																				transform(right),
																				limit(ut.limits.DEFAULT)));
	id_rec := (id_rec1 + id_rec2).hist;
	id_layout := record
		unsigned6 id;
		boolean isBDID;
		unsigned4 dt_seen;
	end;

	id_layout xNorm(id_rec L, recordof(id_rec.owners) R) := transform
		self.id := R.did;
		self.isBDID := R.isBDID;
		self.dt_seen := L.dt_seen;
	end;
	own_norm := normalize(id_rec, left.owners, xNorm(left, right));
	own_sort := sort(own_norm, -dt_seen);
	//Only keep the latest records based on dt_seen
	latest_dt_seen := own_norm[1].dt_seen;
	own_filt := dedup(sort(own_sort(dt_seen = latest_dt_seen), id), id);
	bdid_rec := project(own_filt(isBDID), transform(doxie_cbrs.layout_references, self.bdid := left.id));
	did_rec := project(own_filt(~isBDID), transform(doxie.layout_references, self.did := left.id));

	bus_rec := project(doxie_cbrs.best_records_bdids(bdid_rec), 
											transform(AddressReport_Services.Layouts.possible_owner_layout,
																self := left,
																self.addr_dt_last_seen := (integer)left.dt_last_seen,
																self := []));

	ppl_rec	:= project(doxie.best_records(did_rec, false, , , true, checkRNA:=true, includeDOD:=true, modAccess := mod_access),
											transform(AddressReport_Services.Layouts.possible_owner_layout,
																self := left,
																self := []));
	results := if(exists(did_rec), ppl_rec) +	if(exists(bdid_rec), bus_rec);

	return results;
end;

export getRTPhones(dataset(AddressReport_Services.layouts.residents_final_out) in_res,
									 boolean call_gateway = false) := function
	in_res addCounter(in_res L, integer C) := transform
		self.rec_no 	:= C;
		self.addr 		:= Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name,
																											 L.suffix, L.postdir, L.unit_desig, L.sec_range);
		self					:= L;
	end; 
	rtp_in := project(in_res, addCounter(left, counter));
	
	in_gateways := Gateway.Configuration.Get();
	
	rtp_mod := module(project(inputParams, BatchServices.RealTimePhones_Params.Params,opt));
		export boolean UseQSENTV2 := true;
		export boolean failOnError := false; 
		export string5 serviceType := ''; 
	end;
	
	gw_out_rec := record   //temporary structure to hold all resulting rows for each request (acct).
		unsigned6 rec_no;
		dataset(Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse) gw_results {maxcount(batchServices.constants.RealTime.REALTIME_PHONE_LIMIT)};	
	end;
	qsent_out_rec := record(Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse)  				//final gtw output layout = t_PhoneplusSearchResponse
	 unsigned6 rec_no;																															 				//with rec_no added
	end;	
	
	gw_out_rec  getGateway(rtp_in L) := TRANSFORM
		in_mod := MODULE(project(rtp_mod,BatchServices.RealTimePhones_Params.params,opt))
			export string15 phone     := '';
			export string30 firstname	:= L.fname;
			export string30 lastname  := L.lname;
			export string200 addr     := L.addr;
			export string25 city      := L.city_name;
			export string2 state      := L.st;
			export string6 zip        := L.zip;
		end;
		gw_results_res := choosen(doxie_raw.RealTimePhones_Raw(in_gateways, 30, 0, in_mod, call_gateway),	batchServices.constants.RealTime.REALTIME_PHONE_LIMIT);
		self.gw_results := gw_results_res;													 
		self.rec_no := l.rec_no;  
	end;
	gw_recs := project(rtp_in, getGateway(Left)) ;	

	qsent_out_rec flat_recs(gw_out_rec L, Doxie_Raw.PhonesPlus_Layouts.t_PhoneplusSearchResponse R) := transform
	 self.rec_no 						:= L.rec_no;
	 self.dt_first_seen 		:= iesp.ECL2ESP.t_DateToString8(R.RealTimePhone_Ext.ListingCreationDate);
	 self.dt_last_seen 			:= iesp.ECL2ESP.t_DateToString8(R.RealTimePhone_Ext.ListingTransactionDate);
	 self 									:= R; 
	end;
	//flatten results to filter and get hriPhone and timezone
	rtp_out 	:= NORMALIZE(gw_recs,LEFT.gw_results, flat_recs(LEFT, RIGHT));
	rtp_filt	:= sort(dedup(sort(rtp_out(ut.DaysApart(dt_last_seen, (STRING)Std.Date.Today()) < AddressReport_Services.Constants.DAYS_IN_YEAR), 
															 rec_no, phone, -dt_last_seen), 
													rec_no, phone), 
										rec_no, -dt_last_seen);
	maxHriPer_value	:= iesp.Constants.MaxCountHRI;
	doxie.mac_AddHRIPhone(rtp_filt,rtp_out_hri);
	ut.getTimeZone(rtp_out_hri,phone,timezone,rtp_out_hri_w_tzone);
	
	//Calculate Royalties and carry in separate dataset
	Royalty.MAC_RoyaltyQSENT(rtp_out, qsent_royalties, false, call_gateway);
	
	iesp.addressreport.t_AddrReportRealTimePhone xformPhones(qsent_out_rec R) := transform
		self.Phone10						:=r.phone;
		self.PubNonpub					:='';
		self.ListingPhone10			:='';
		self.ListingName				:=r.Listed_Name;
		self.TimeZone						:=r.timezone;
		self.ListingTimeZone		:='';
		hri_phones 							:= project(r.hri_phone, 
															transform(iesp.share.t_RiskIndicator, 
																				self.RiskCode := left.hri, 
																				self.Description := left.desc));
		self.HighRiskIndicators := choosen(hri_phones, iesp.Constants.MaxCountHRI);
		self.CarrierName				:= r.carrier_name;
		self := []; //Messages
	end;
	
	in_res add_phones(in_res L, dataset(qsent_out_rec) R):=transform
		self.CurrentPhone := project(R, xformPhones(left));
		self:=L;
	end;
		
	rtp_results := denormalize(rtp_in, rtp_out_hri_w_tzone, 
														left.rec_no = right.rec_no,
														group,
														add_phones(left, rows(right)));
	
	AddressReport_Services.Layouts.residents_final_out_w_royalties xformRTPhones() := transform
		self.Royalties	:= qsent_royalties;
		self.residents	:= rtp_results;
	end;
	results := dataset([xformRTPhones()]);
	return results;
end;

END;