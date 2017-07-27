import ClickData, iesp;

out_rec := iesp.directmarketingsearch.t_DirectMarketingSearchRecord;

export out_rec transform_dmxml(dataset(ClickData.Layout_ClickData_Out_Ext) recs) := function

	iesp.share.t_Address SetBestAddress (ClickData.Layout_ClickData_Out_Ext L) := transform
    Self.StreetName := '';
    Self.StreetNumber := '';
    Self.StreetPreDirection := '';
    Self.StreetPostDirection := '';
    Self.StreetSuffix := '';
    Self.UnitDesignation := '';
    Self.UnitNumber := '';
    Self.StreetAddress1 := L.Best_Addr1;
    Self.StreetAddress2 := '';
    Self.State := L.Best_State;
    Self.City := L.Best_City; 
    Self.Zip5 := L.Best_Zip[1..5];
    Self.Zip4 := L.Best_Zip[7..10];
    Self.County := ''; 
    Self.PostalCode := '';
    Self.StateCityZip := '';
  end;
	
	iesp.share.t_name SetBestName(ClickData.Layout_ClickData_Out_Ext L) := transform
		self.full := '';
		self.First := L.Best_Fname;
		self.Middle := L.Best_Mname;		
		self.Last := L.Best_Lname,
		self.suffix := L.Best_Suffix,
		self.prefix := ''
	end;

	iesp.directmarketingsearch.t_BestInfo SetBestInfo (ClickData.Layout_ClickData_Out_Ext L) := transform	
		self.AddressScore := (integer)L.Best_Address_Score;
		self.Address := row(L,SetBestAddress(L));
		self.NameScore := (integer) L.Best_Name_Score;
		Self.Name := row(L,SetBestName(L));
		self.PhoneScore := (integer) L.Best_Phone_score;
		self.Phone := L.Best_Phone;
		self.AddrDate := iesp.ECL2ESP.toDatestring8(L.Best_Addr_Date);		
		self.AddrDateFirstSeen := iesp.ECL2ESP.toDatestring8(L.Best_Addr_Date_first_seen);		
  end;
	
	iesp.directmarketingsearch.t_ScoreInfo SetScoreInfo (ClickData.Layout_ClickData_Out_Ext L) := transform	
		self.Score := (integer)L.score;
		self.AnySSN := (integer)L.score_any_ssn;
		self.AnyAddress := (integer)L.score_any_addr;
		self.AnyDOB := (integer)L.score_any_dob;
		self.AnyPhone := (integer)L.score_any_phn;
		self.AnyFuzzy := (integer)L.score_any_fzzy;
  end;
	
	iesp.directmarketingsearch.t_DimensionHousehold SetDimensionHousehold(ClickData.Layout_ClickData_Out_Ext L) := transform
		self.Outdoors := L.outdoors_dimension_household;
		self.Athletic := L.athletic_dimension_household;
		self.Fitness := L.fitness_dimension_household;
		self.Domestic := L.domestic_dimension_household;
		self.GoodLife := L.good_life_dimension_household;
		self.Cultural := L.cultural_dimension_household;
		self.BlueChip := L.blue_chip_dimension_household;
		self.DoItYourself := L.do_it_yourself_dimension_household;
		self.Technology := L.technology_dimension_household;
	end;

	iesp.directmarketingsearch.t_CreditCardUsage SetCreditCardUsage(ClickData.Layout_ClickData_Out_Ext L) := transform		
		self.Miscellaneous := L.credit_card_usage_miscellaneous;	
		self.StandardRetail := L.credit_card_usage_standard_retail;
		self.StandardSpecialtyCard := L.credit_card_usage_standard_specialty_card;
		self.UpscaleRetail := L.credit_card_usage_upscale_retail;
		self.UpscaleSpecRetail := L.credit_card_usage_upscale_spec_retail;
		self.BankCard := L.credit_card_usage_bank_card;
		self.OilGasCard := L.credit_card_usage_oil_gas_card;
		self.FinanceCoCard := L.credit_card_usage_Finance_Co_Card;
		self.TravelEntertainment := L.credit_card_usage_Travel_Entertainment;
	end;

	out_rec toOut(ClickData.Layout_ClickData_Out_Ext L) := transform		
		self.Source := L.source;
		self.UniqueID := L.ADL;
		self.HouseholdID := L.HHID;		
		Self.BestInfo := row(L,SetBestInfo(L));													 	
		self.NumHeaderRecs := (integer) L.Num_Header_Recs;
		self.EDAConnect := iesp.ECL2ESP.toDatestring8(L.EDA_Connect);
		self.EDADisconnect := iesp.ECL2ESP.toDatestring8(L.EDA_Disconnect);
		self.ScoreInfo := row(L,SetScoreInfo(L));
		self.Age := (integer) L.age;
		self.Gender := L.gender;
		self.MaritalStatus := L.marital_status; 
		self.NumOfAdultsInHousehold := (integer) L.number_of_adults_in_household;
		self.NumOfChildrenInHousehold := (integer) L.number_of_children_in_household;
		self.DwellingType := L.dwelling_type;
		self.HomeOwnerRenterCode := L.home_ownerrenter_code; 
		self.HouseholdIncomeIdentifier := L.household_income_identifier;
		self.HouseholdOccupation := L.household_occupation;
		self.LengthOfResidence := L.length_of_residence;
		self.MailResponsiveDonorIndicator := L.mail_responsive_donor_indicator;
		self.MailResponsiveBuyerIndicator := L.mail_responsive_buyer_indicator;
		self.Telephone := L.telephone;			
		self.DimensionHousehold := row(L, SetDimensionHousehold(L));
		self.CreditCardUsage := row(L, SetCreditCardUsage(L));		
	end;
	return project(recs,toOut(left));
end;