import Property,Foreclosure_Services,Census_data;

export transform_NOD (dataset(Foreclosure_Services.Layouts.Layout_Foreclosure_out) nodi) := function

	get_county_name(string2 st_in, string3 county_in) := 
		Census_data.Key_Fips2County(keyed(st_in=state_code AND county_in=county_fips))[1].county_name;

	iesp.foreclosure.t_ForeclosureReportRecord toOut(Foreclosure_Services.Layouts.Layout_Foreclosure_out l) := transform
		self.ForeclosureId := l.foreclosure_id;
		self.CaseNumber := l.court_case_nbr;
		self.DeedType := l.deed_desc;
		self.SiteAddress := iesp.ECL2ESP.SetAddressFields(
			l.situs1_prim_name,l.situs1_prim_range,l.situs1_predir,l.situs1_postdir,l.situs1_addr_suffix,l.situs1_unit_desig,
			l.situs1_sec_range,l.situs1_p_city_name,l.situs1_v_city_name,'',l.situs1_st,l.situs1_zip,l.situs1_zip4,
			if(l.situs1_st<>'' and l.situs1_fipscounty<>'',get_county_name(l.situs1_st,l.situs1_fipscounty),''),'');
		self.Site2Address := iesp.ECL2ESP.SetAddressFields(
			l.situs2_prim_name,l.situs2_prim_range,l.situs2_predir,l.situs2_postdir,l.situs2_addr_suffix,l.situs2_unit_desig,
			l.situs2_sec_range,l.situs2_p_city_name,l.situs2_v_city_name,'',l.situs2_st,l.situs2_zip,l.situs2_zip4,
			if(l.situs2_st<>'' and l.situs2_fipscounty<>'',get_county_name(l.situs2_st,l.situs2_fipscounty),''),'');
		self.FilingDate := iesp.ECL2ESP.todatestring8(l.filing_date);
		self.RecordingDate := iesp.ECL2ESP.toDatestring8(l.recording_date);
		self.DocumentYear := (integer)l.document_year;
		self.DocumentNumber := l.document_nbr;
		self.DocumentBook := l.document_book;
		self.DocumentPages := l.document_pages;
		self.DocumentType := l.document_type;
		self.DateOfLoanDefault := iesp.ECL2ESP.toDatestring8(l.date_of_default[1..8]);
		self.AmountOfLoanDefault := l.amount_of_default;
		self.AuctionDate := iesp.ECL2ESP.toDatestring8(l.auction_date[1..8]);
		self.AuctionTime := l.auction_time;
		self.AuctionLocation := [];
		self.OpeningBid := l.opening_bid;
		self.FinalJudgmentAmount := l.final_judgment_amount;
		self.Lender.Name :=iesp.ecl2esp.SetNameFields(l.lender_beneficiary_first_name,'',l.lender_beneficiary_last_name,'','','');
		self.Lender.CompanyName :=l.lender_beneficiary_company_name;
		self.Trustee :=l.trustee_name;
		self.TitleCompany :=l.title_company_name;
		self.Attorney :=l.attorney_name;
		self.AttorneyPhoneNumber :=l.attorney_phone_nbr;
		self.AttorneyTimeZone :='';
		self.SubdivisionName :=l.tract_subdivision_name;
		self.LandUsage :=l.property_desc;
		self.ParcelNumber :=l.parcel_number_parcel_id;
		self.YearBuilt :=(unsigned) l.year_built;
		self.CurrentLandValue :=l.current_land_value;
		self.CurrentImprovementValue :=l.current_improvement_value;
		self.LandSize :=l.lot_size;
		self.LivingSize :=l.living_area_square_feet;
		self.LegalDescription :=l.expanded_legal;
		self.Plaintiffs := choosen(dedup(dataset([{l.plaintiff_1},{l.plaintiff_2}],share.t_StringArrayItem),record),iesp.constants.MAX_COUNT_PLAINTIFF);
		self.Defendants := choosen(dedup(sort(dataset([
			{'','',l.first_defendant_borrower_owner_first_name,'',l.first_defendant_borrower_owner_last_name,'','','',l.first_defendant_borrower_company_name},
			{'','',l.second_defendant_borrower_owner_first_name,'',l.second_defendant_borrower_owner_last_name,'','','',l.second_defendant_borrower_company_name},
			{'','',l.third_defendant_borrower_owner_first_name,'',l.third_defendant_borrower_owner_last_name,'','','',l.third_defendant_borrower_company_name},
			{'','',l.fourth_defendant_borrower_owner_first_name,'',l.fourth_defendant_borrower_owner_last_name,'','','',l.fourth_defendant_borrower_company_name}
			],iesp.foreclosure.t_ForeclosureReportDefendant)((Name.Last<>'' and Name.First<>'') or CompanyName<>'')
			,Name.Last,Name.First,CompanyName),Name.Last,Name.First,CompanyName),iesp.constants.MAX_COUNT_DEFENDANT);
		self := [];
	end;

	return project(nodi,toOut(Left));

end;