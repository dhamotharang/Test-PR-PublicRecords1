import ut, STD;

EXPORT fn_flatten(dataset(Nac_v2.Layouts.base) base1) := FUNCTION
	b0 := PROJECT(Distribute(base1,HASH32(case_state_abbreviation, case_benefit_type, case_identifier)),
						TRANSFORM(Nac_v2.Layouts.baseHistorical, 
						self.StartDate := fn_FirstDayOfMonth(left.case_benefit_month);
						self.EndDate := fn_LastDayOfMonth(left.case_benefit_month);
						self.Phys_addr1    := StandardizeName(left.Case_Physical_Address_Street_1 + ' ' + left.Case_Physical_Address_Street_2);
						SELF.Phys_addr2    := StandardizeName(TRIM(left.Case_Physical_Address_City) + if(left.Case_Physical_Address_City = '' OR Std.Str.EndsWith(TRIM(left.Case_Physical_Address_City),','),'',',') 
																			+ ' ' + left.Case_Physical_Address_State + ' ' + left.Case_Physical_Address_Zip[1..5]);
						self.Mail_addr1    := StandardizeName(left.Case_Mailing_Address_Street_1 + ' ' + left.Case_Mailing_Address_Street_2);
						SELF.Mail_addr2    := StandardizeName(TRIM(left.Case_Mailing_Address_City) + if(left.Case_Mailing_Address_City = '' OR Std.Str.EndsWith(TRIM(left.Case_Mailing_Address_City),','),'',',') 
																			+ ' ' + left.Case_Mailing_Address_State + ' ' + left.Case_Mailing_Address_Zip[1..5]);
																			
						self.GroupId := left.Case_State_Abbreviation + '01';
						self.filename := IF(Std.Str.StartsWith(left.filename, 'nac::in::'), left.filename[10..], left.filename);
						self := LEFT;));
	
	b0a := DISTRIBUTE(b0, HASH32(case_state_abbreviation, case_benefit_type, case_identifier));
	b1 := SORT(b0a, 
						case_state_abbreviation, case_benefit_type, case_identifier, client_identifier, Client_Eligible_Status_Indicator,
						Client_Last_Name,
						Phys_addr1, Phys_addr2,
						Mail_addr1, Mail_addr2,
						//Case_Physical_Address_Street_1, Case_Physical_Address_Street_2, Case_Physical_Address_City, Case_Physical_Address_State,Case_Physical_Address_Zip,
						//Case_Mailing_Address_Street_1, Case_Mailing_Address_Street_2, Case_Mailing_Address_City, Case_Mailing_Address_State,Case_Mailing_Address_Zip,
						-case_benefit_month, LOCAL);
				
	b2 := ROLLUP(b1, 
									left.case_state_abbreviation=right.case_state_abbreviation AND left.case_benefit_type=right.case_benefit_type AND
											left.case_identifier=right.case_identifier AND left.client_identifier=right.client_identifier AND
									left.Client_Eligible_Status_Indicator=right.Client_Eligible_Status_Indicator AND 
									left.Client_Last_Name=right.Client_Last_Name and
									left.Phys_addr1=right.Phys_addr1 and left.Phys_addr2=right.Phys_addr2 and
									left.Mail_addr1=right.Mail_addr1 and left.Mail_addr2=right.Mail_addr2 and
									/*left.Case_Physical_Address_Street_1=right.Case_Physical_Address_Street_1 AND left.Case_Physical_Address_Street_2=right.Case_Physical_Address_Street_2 AND
											left.Case_Physical_Address_City=right.Case_Physical_Address_City AND left.Case_Physical_Address_State=right.Case_Physical_Address_State AND
											left.Case_Physical_Address_Zip[1..5]=right.Case_Physical_Address_Zip[1..5] AND
									left.Case_Mailing_Address_Street_1=right.Case_Mailing_Address_Street_1 AND left.Case_Mailing_Address_Street_2=right.Case_Mailing_Address_Street_2 AND
											left.Case_Mailing_Address_City=right.Case_Mailing_Address_City AND left.Case_Mailing_Address_State=right.Case_Mailing_Address_State AND
											left.Case_Mailing_Address_Zip[1..5]=right.Case_Mailing_Address_Zip[1..5] AND*/
										ut.MonthsApart(TRIM(left.case_benefit_month),TRIM(right.case_benefit_month)) = 1,
								TRANSFORM(Nac_v2.Layouts.baseHistorical,
											self.StartDate := right.StartDate;
											self.EndDate := max(left.EndDate,right.EndDate);
											self.case_benefit_month := right.case_benefit_month;
											self.Client_Eligible_Status_Date := min(left.Client_Eligible_Status_Date, right.Client_Eligible_Status_Date);
											self := left;), LOCAL);
											
		return b2;
          

END;
