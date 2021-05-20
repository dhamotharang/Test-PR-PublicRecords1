import Std, ut;

r1 := RECORD
	nac_v2.Layout_Payload;
	Std.Date.Date_t	StartDate;
END;

// year 2099 is treated as open ended
//	dats and months returned will be 0
integer GetDaysBetween(unsigned4 StartDate, unsigned4 EndDate) := FUNCTION
		EndYear := Std.Date.Year(EndDate);
		return IF(EndYear = 2099, 0,
							STD.Date.DaysBetween(StartDate, EndDate) + 1
						);
END;

integer GetMonthsBetween(unsigned4 StartDate, unsigned4 EndDate) := FUNCTION
		EndYear := Std.Date.Year(EndDate);
		return IF(EndYear = 2099, 0,
							STD.Date.MonthsBetween(StartDate, EndDate) + 1
						);
END;

EXPORT To_Payload(dataset(nac_v2.Layout_Base2) base1) := FUNCTION

	base := base1(eligibility_status_indicator<>'N');

	b0 := DEDUP(		
					SORT(DISTRIBUTE(base, HASH32(ProgramState, ProgramCode, CaseID, ClientId)),
									ProgramState, ProgramCode, CaseID, ClientId, 
									eligibility_status_indicator, 
									Physical_Street1, Physical_Street2, Physical_City, Physical_State, Physical_Zip,
									Mailing_Street1, Mailing_Street2, Mailing_City, Mailing_State, Mailing_Zip,
									prim_range,prim_name,sec_range,zip,st,
									-StartDate, EndDate, 
									LOCAL),
									ProgramState, ProgramCode, CaseID, ClientId, 
									eligibility_status_indicator, 
									Physical_Street1, Physical_Street2, Physical_City, Physical_State, Physical_Zip,
									Mailing_Street1, Mailing_Street2, Mailing_City, Mailing_State, Mailing_Zip,
									prim_range,prim_name,sec_range,zip,st,
									StartDate, EndDate,
									LOCAL);
									
	b00 := ROLLUP(b0, 
									left.ProgramState=right.ProgramState AND left.ProgramCode=right.ProgramCode AND
											left.CaseID=right.CaseID AND left.ClientId=right.ClientID AND
									left.eligibility_status_indicator=right.eligibility_status_indicator AND 
									left.Physical_Street1=right.Physical_Street1 AND left.Physical_Street2=right.Physical_Street2 AND
											left.Physical_City=right.Physical_City AND left.Physical_State=right.Physical_State AND
											left.Physical_Zip[1..5]=right.Physical_Zip[1..5] AND
									left.Mailing_Street1=right.Mailing_Street1 AND left.Mailing_Street2=right.Mailing_Street2 AND
											left.Mailing_City=right.Mailing_City AND left.Mailing_State=right.Mailing_State AND
											left.Mailing_Zip[1..5]=right.Mailing_Zip[1..5] AND
											left.prim_range=right.prim_range AND left.prim_name=right.prim_name AND left.sec_range=right.sec_range AND
											left.zip=right.zip AND left.st=right.st AND
										ut.MonthsApart(left.StartDate_Raw[1..6],right.StartDate_Raw[1..6]) = 1,
								TRANSFORM(nac_v2.Layout_Base2,
											self.StartDate := right.StartDate;
											self.EndDate := left.EndDate;
											self.StartDate_Raw := right.StartDate_Raw;
											self.EndDate_Raw := left.EndDate_Raw;
											self.eligibility_status_date := (string8)min((unsigned)left.eligibility_status_date, (unsigned)right.eligibility_status_date),
											self := left;), LOCAL);

	b1 := PROJECT(base,
						TRANSFORM(nac_v2.Layout_Payload,
									// case fields
										self.case_Program_State := left.ProgramState;
										self.case_Program_Code := left.ProgramCode;
										self.nac_GroupId := left.GroupId;
										self.Case_Identifier :=  Std.Str.ToUpperCase(left.CaseId);
										self.case_Monthly_Allotment := left.case_Monthly_Allotment;
										self.case_Last_Name := left.case_Last_Name;
										self.case_First_Name := left.case_First_Name;
										self.case_Middle_Name := left.case_Middle_Name;
										self.case_Suffix_Name := left.case_Name_Suffix;
										self.case_Region_Code := left.RegionCode;
										self.case_county_parish_code := left.CountyCode;
										self.case_county_parish_name := left.CountyName;
										self.case_Phone_1 := left.case_Phone1;
										self.case_Phone_2 := left.case_Phone2;
										self.case_Email := left.case_Email;
								// case addresses
									self.case_Physical_Address_Category := left.Physical_AddressCategory;	
									self.case_Physical_Address_Street_1 := left.Physical_Street1;
									self.case_Physical_Address_Street_2 := left.Physical_Street2;
									self.case_Physical_Address_City := left.Physical_City;
									self.case_Physical_Address_State := left.Physical_State;
									self.case_Physical_Address_Zip := left.Physical_Zip;
									self.case_Mailing_Address_Category := left.Mailing_AddressCategory;	
									self.case_Mailing_Address_Street_1 := left.Mailing_Street1;
									self.case_Mailing_Address_Street_2 := left.Mailing_Street2;
									self.case_Mailing_Address_City := left.Mailing_City;
									self.case_Mailing_Address_State := left.Mailing_State;
									self.case_Mailing_Address_Zip := left.Mailing_Zip;
								// client data
									self.Client_Identifier := Std.Str.ToUpperCase(left.ClientId);
									self.Client_Last_Name := left.LastName;
									self.Client_First_Name := left.FirstName;
									self.Client_Middle_Name := left.MiddleName;
									self.Client_Suffix_Name := left.Name_Suffix;
									self.Client_HoH_Indicator := left.HoH_Indicator;
									self.Client_ABAWD_Indicator := left.ABAWDIndicator;
									self.Client_Relationship_Indicator := left.Relationship;
									
									self.Client_Gender := left.Gender;
									self.Client_Race := left.Race;
									self.Client_Ethnicity := left.Ethnicity;
									self.Client_ssn := left.ssn;
									self.Client_ssn_Type_Indicator := left.ssn_Type_indicator;					// A=Actual; P=Pseudo; D=Default
									self.Client_dob := left.dob;							// CCYYMMDD
									self.Client_dob_Type_Indicator := left.dob_Type_indicator;					// A=Actual; P=Pseudo; D=Default
									self.Client_Certificate_id_type := left.Certificate_id_type;
									self.Client_Monthly_Allotment := left.MonthlyAllotment;	
	
									self.Client_Period_Type := left.PeriodType;				// M=Month, D=Date
									self.Client_Historical_Benefit_Count := left.HistoricalBenefitCount;
									self.client_Phone := left.client_phone;
									self.client_Email := left.client_Email;
								// contact information
									self.state_Contact_Name := left.ContactName;
									self.state_Contact_Phone := left.ContactPhone;
									self.state_Contact_Phone_Extension := left.ContactExt;
									self.state_Contact_Email := left.ContactEmail;
								// eligibility data 
									self.eligibility_status_indicator := IF(left.eligibility_status_indicator in NAC_V2.Mod_Sets.Eligible_Status, left.eligibility_status_indicator, 'E');
									self.eligibility_status_date := left.eligibility_status_date;
									self.eligibility_period_start_raw := left.StartDate_Raw;
									self.eligibility_period_end_raw := left.EndDate_Raw;
									self.eligibility_period_start := left.StartDate;
									self.eligibility_period_end := left.EndDate;
									self.eligible_period_count_days := IF(left.eligibility_status_indicator='E',
																									GetDaysBetween(
																										left.StartDate,
																										left.EndDate),
																										0);
									self.eligible_period_count_months := IF(left.eligibility_status_indicator='E',
																									GetMonthsBetween(
																										left.StartDate,
																										left.EndDate),
																										0);
									self := left;
								));
		
			b2 := DEDUP(SORT(DISTRIBUTE(b1, HASH32(case_Program_State, case_Program_Code, Client_Identifier)),
									case_Program_State, case_Program_Code, Client_Identifier,
									eligibility_period_start_raw, eligibility_period_end_raw,
									LOCAL),
									case_Program_State, case_Program_Code, Client_Identifier,
									eligibility_period_start_raw, eligibility_period_end_raw,
									LOCAL)(eligibility_status_indicator='E');

		rAggregate := RECORD
			b2.case_Program_State;
			b2.case_Program_Code;
			b2.Client_Identifier;
					RecordCount := COUNT(GROUP);
					earliestStart := Min(GROUP, b2.eligibility_period_start_raw);
					latestEnd := Max(GROUP, b2.eligibility_period_end_raw);
					TotalMonths := SUM(GROUP, b2.eligible_period_count_months);
					TotalDays := SUM(GROUP, b2.eligible_period_count_days);
		END;	
		
	aggregates := table(b2, rAggregate, 
						case_Program_State, case_Program_Code, Client_Identifier);
		

	payload := JOIN(b1, aggregates, left.case_Program_State=right.case_Program_State
						AND	left.case_Program_Code=right.case_Program_Code
						AND left.Client_Identifier=right.Client_Identifier,
						TRANSFORM(nac_v2.Layout_Payload,
							self.RecordCount := right.RecordCount;
							self.earliestStart := right.earliestStart;
							self.latestEnd := right.latestEnd;
							self.TotalMonths := right.TotalMonths;
							self.TotalDays := right.TotalDays;
							self := left;),
							LEFT OUTER, KEEP(1));

	return payload;

END;