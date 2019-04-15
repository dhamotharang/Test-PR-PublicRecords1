import  IncomeRisk_Services,iesp,business_risk, ut, PersonReports, doxie, autoheaderi, Gateway;

export raw := module
	  
		export iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx
		                 ERIGateway_SoapCall_Function(dataset(iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest) Inf,		                                   
																									dataset(gateway.layouts.config) gateway_cfg
		                                     ) := function
		
		string gateway_url_param := gateway_cfg(servicename = Gateway.Constants.ServiceName.ERI)[1].url;
    gateway_url := if (gateway_url_param <> '', gateway_url_param,
		                      ''		              
		                      // maybe add in a failure cmd here
													// fail(dataset([],iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx),IncomeRisk_Services.Constants.GATEWAY_ERROR_CODE)
											); // return some kind of error code here.
												
		iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest into_in(inf L) := transform
			self.Options.Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
			self := L;
		end;

		iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx failX(inf L) := transform	
			self.response._header.Message := FAILMESSAGE('soapresponse');
			self:=l;
			self := [];
		end;

		iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx FormatFail(iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx L) := transform
			rec:=record  
				string Source :=XMLTEXT('Source');
				integer Code := (integer) XMLTEXT('faultcode');
				string Location := XMLTEXT('Location');
				string Message := XMLTEXT('faultstring');
			end;
		
			ds := dataset([L.response._header.Message],{string line});
			parsedSoapResponse := parse (ds,line, rec, xml('soap:Envelope/soap:Body/soap:Fault'));
			ds_e:=project(parsedSoapResponse,iesp.share.t_WsException);

			self.response._header.Exceptions:=ds_e;
			integer errorC := ds_e[1].code;
			//self.response.response.ErrorCode := IF (errorC = 0, '', (STRING)errorC);
			self.response._header.Message := ds_e[1].Message;
			self:=l;
		end;
																											
		outf := soapcall (inf, gateway_url, 'ERISalaryReport', iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest, 
                  into_in(LEFT), dataset(iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx),
                  XPATH('ERISalaryReportResponseEx'),
                  onfail(failx(LEFT)), RETRY(0), TIMEOUT(20), TRIM, LOG
                 );								 
		return project (outf, FormatFail (Left));
		// pass return fields into layout
	end; // function income_validation
	
	//
	// this function is used for testing only 
	// kept here for testing purposes
	// calls for this are within IncomeRisk_Services.ReportService and are currently commented out
	//
	export readGatewayInput(iesp.gateway_eri_salaryreport.t_ERISalaryReportBy xml_in) := function
	     string JobTitle_val := global(xml_in).JobTitle;
	    #stored('JobTitle', JobTitle_val);		
			 
		 string Employer_val := global(xml_in).Employer;
		#stored('Employer', Employer_val);		
		
		boolean EmployerMatch_val := global(xml_in).EmployerMatch;
	  #stored('EmployerMatch', EmployerMatch_val);		
		
		integer JobExperience_val := global(xml_in).JobExperience;
		#stored('JobExperience', JobExperience_val);		
		
		integer ProfessionalExperience_val := global(xml_in).ProfessionalExperience;
		#stored('ProfessionalExperience', ProfessionalExperience_val);				
		
		integer AnnualIncome_val := global(xml_in).AnnualIncome;
    #stored('AnnualIncome', AnnualIncome_val);		
		
		string BorrowerPostalCode_val := global(xml_in).BorrowerPostalCode;
		#stored('BorrowerPostalCode', BorrowerPostalCode_val);
	
	   return output(dataset([],{integer x}), named('__internal__'), extend);
		
	end;
	
  export setGatewayRequest(iesp.share.t_User xml_in_User,
	                         iesp.income_risk.t_IncomeRiskReportOption xml_in_option,
	                         iesp.income_risk.t_Employment xml_in_employment,
												   iesp.income_risk.t_EmployerIn xml_in_employer,
													 dataset(business_risk.Layout_Input_Moxie_2) df) := function													  													 
 
       string   glb_p             := xml_in_User.GLBPurpose;
			 string   dl_p              := xml_in_User.DLPurpose;
			 string   queryID           := xml_in_User.QueryId;
			 string   refCode           := xml_in_User.ReferenceCode;
			 string   billingCode       := xml_in_User.BillingCode;
       string   JobTitle          := xml_in_employment.JobTitle;
			 integer  AnnualIncome      := (integer) xml_in_employment.AnnualIncome;
			 integer  YearsInJob        := xml_in_employment.YearsInJob;
			 integer  YearsInProfession := xml_in_employment.YearsInProfession;
			 string   companyName       := xml_in_Employer.CompanyName;
			 string   dba               := xml_in_Employer.DBA;
			 address                    := xml_in_Employer.Address;
			 string10 PhoneNumber       := xml_in_Employer.PhoneNumber;
			 string11 TaxId             := xml_in_Employer.TaxId;			 
			 boolean  EmployerMatch     := xml_in_option.EmployerMatch;
	     string   SIC               := xml_in_option.SIC;
	     string   NAICS             := xml_in_option.NAICS;
	     string   SOC               := xml_in_option.SOC;						 
			 string5  z5_2 := df[1].z5_2; // person address (rep_zip) 
			 
			 
	iesp.gateway_eri_salaryReport.t_ERISalaryReportRequest prep_for_basic() := TRANSFORM

			SELF.RemoteLocations    :=[];
			SELF.ServiceLocations   :=[];
	
			SELF.user.GLBPurpose    := glb_p;
			SELF.user.DLPurpose     := dl_p;
			SELF.user.QueryID       := queryID;
			SELF.user.ReferenceCode := refCode;
			SELF.user.BillingCode   := billingCode;
			SELF.user               :=[]; // there are many fields not being set which seem to be
			                              // unneeded this takes care of them.
	
			SELF.Reportby.JobTitle               := JobTitle;
			SELF.Reportby.Employer               := if (dba <> '', dba, companyName); // business rule
			SELF.Reportby.EmployerMatch          := EmployerMatch;
			SELF.Reportby.JobExperience          := YearsInJob;
			SELF.ReportBy.Professionalexperience := YearsInProfession;
			SELF.ReportBy.AnnualIncome           := if (AnnualIncome < 0 OR AnnualIncome = 0, 1, AnnualIncome);
			SELF.ReportBy.SIC                    := SIC;
			SELF.ReportBy.NAICS                  := NAICS;	
			SELF.ReportBy.SOC                    := SOC;
			SELF.ReportBy.BorrowerPostalCode     := z5_2; //BorrowerZip;	
			SELF.options:=[];
	END;

		eri_in := DATASET ([prep_for_basic ()]);
			 
    return(eri_in);         												
	end;										
	
	export business_risk.Layout_Input_Moxie_2
	        SetReportInput(iesp.income_risk.t_IncomeRiskReportBy xml_in,	                    
	                      iesp.share.t_Name nme_info,
	                      iesp.share.t_Address Person_addr,
												iesp.share.t_Date xml_in_dob,
												iesp.income_risk.t_Employment xml_in_employment,
												iesp.income_risk.t_EmployerIn xml_in_employer,
												unsigned history_date=999999) := function
			 
			 string4  g_Year  := (string4) xml_in_dob.Year; 
			 string   g_Month :=  if (length((string) xml_in_dob.Month) = 1,
			                      '0' + (string) xml_in_dob.Month,
														      (string) xml_in_dob.Month); 
			 string   g_Day   := if (length((string) xml_in_dob.Day) = 1, '0' + (string) xml_in_dob.Day,
			                                (string) xml_in_dob.Day);
			 string8  g_dob := g_year + g_month + g_day;
			 
			 string9  g_ssn := xml_in.ssn;
			 string10 g_phone_2 := xml_in.PhoneNumber;
			 string20 g_name_f_in := nme_info.First;
			 string20 g_name_m_in := nme_info.Middle;
			 string20 g_name_l_in   := nme_info.Last;
			 
			  				
				// *_2 is person related address fields
			 string28 g_prim_name_2     := Person_Addr.StreetName;
	     string10 g_prim_range_2    := Person_Addr.StreetNumber;
	     string2 g_pre_dir_2        := Person_Addr.StreetPreDirection;
	     string2 g_post_dir_2       := Person_Addr.StreetPostDirection;
	     string4 g_addr_suffix_2    := Person_Addr.StreetSuffix;
	     string10 g_unit_desig_2    := Person_Addr.UnitDesignation;
	     string8 g_sec_range_2      := Person_Addr.UnitNumber;
	     string60 g_street_addr_2   := Person_Addr.StreetAddress1;
	     string60 g_StreetAddress2  := Person_Addr.StreetAddress2;
	     string2 g_st_2             := Person_Addr.State;
	     string25 g_p_city_name_2   := Person_Addr.City;
	     string5 g_z5_2             := Person_Addr.Zip5;
	     string4 g_Zip4_2           := Person_Addr.Zip4;
	     string18 g_County_2          := Person_Addr.County;
	     string9 g_PostalCode_2       := Person_Addr.PostalCode;
	     string50 g_StateCityZip_2    := Person_Addr.StateCityZip;
			 
			 string2  g_dl_state        := xml_in.DriverLicenseState;
			 string15 g_dl_number       := xml_in.DriverLicenseNumber;
			 			 
			 unsigned8 age :=  (unsigned8) ut.GetAgeI((integer) g_dob);
			 //1
			 //
	     #stored('RepresentativeSSN', g_ssn);
			 #stored('RepresentativeDOB', g_dob);  // yyyymmdd format
			 #stored('RepresentativeFirstName',g_name_f_in);
			 #stored('RepresentativeLastName', g_name_l_in);
			 #stored('RepresentativeMiddleName', g_name_m_in);
			
       #stored('RepresentativeAddr', g_Street_addr_2);
			 #stored('RepresentativeCity', g_p_city_name_2);
			 #stored('RepresentativeState', g_st_2);
			
       #stored('RepresentativeDLState', g_dl_state);
			 #stored('RepresentativeDLNumber', g_dl_number);
			 #stored('RepresentativeZip', g_z5_2);

			 #stored('RepresentativeAge', age);
			 #stored('RepresentativeHomePhone', g_Phone_2); 		
		
			 // these will be used to call the gateway.
			 string g_JobTitle       := xml_in_employment.JobTitle;
			 string g_AnnualIncome   := xml_in_employment.AnnualIncome;
			 integer g_YearsInJob    := xml_in_employment.YearsInJob;
			 integer g_YearsInProfession := xml_in_employment.YearsInProfession;
			 string g_name_company   := xml_in_Employer.CompanyName;
			 string g_dba            := xml_in_Employer.DBA;
			 g_address               := xml_in_Employer.Address;			
			 
			 string10 g_PhoneNumber  := xml_in_Employer.PhoneNumber;
			 string11 g_TaxId        := xml_in_Employer.TaxId;
			 // integer estRevenueThousands := xml_in_Employer.estRevenueThousands;
			 // integer estEmployees :=        xml_in_Employer.estEmployees;
					
			 
			 dummy_ds := dataset([{'TEST', 
						 g_PhoneNumber, g_name_company,g_address.StreetAddress1, g_address.StreetNumber, g_address.StreetPreDirection,g_address.StreetName,g_address.StreetSuffix,
						 g_address.StreetPostDirection,g_address.unitDesignation,g_address.UnitNumber,g_address.City,g_address.State,
             g_address.Zip5, g_address.Zip4,
				     g_ssn, g_name_f_in, g_name_m_in, g_name_l_in, g_Street_addr_2, g_prim_range_2, g_pre_dir_2, g_prim_name_2, g_addr_suffix_2, g_post_dir_2, g_unit_desig_2, g_sec_range_2, g_p_city_name_2, g_st_2, g_z5_2, g_zip4_2, 
						 g_dob,g_phone_2, age, g_dl_number, g_dl_state, g_TaxId}], IncomeRisk_Services.layouts.z_input_layout_rec);
			                    
		   bus_risk_ds := project(dummy_ds, transform(business_risk.Layout_Input_Moxie_2,			                        			                         
															 self.name_first  := left.name_fst_in,
															 self.name_last   := left.name_lst_in,
															 self.name_middle := left.name_md_in,
															 self.zip4_2      := left.zip44_2,		
															 self.phoneno     := left.phoneNo_company,
															 self.fein        := left.fein,
															 self.historydateYYYYMM := history_date,
															 self := left,
															 self := []
															 ));				
			
	     return bus_risk_ds;
			 // will return this type:  business_risk.Layout_Input_Moxie_2
			 
  end;
	
		export iesp.income_risk.t_IncomeRiskAssessmentReportResponse
		         setReportOutput(iesp.gateway_eri_salaryreport.t_ERISalaryReportResponse response,
		                       dataset(incomeRisk_Services.layouts.biid_output_layout) biid_out,
													 integer miles_in_param,
													 string11 taxId,
													 iesp.share.t_Address address_in,
													 integer borrowerIncome_in,
													 autoheaderI.LIBIN.FetchI_Hdr_Indv.full in_mod,
													 dataset(iesp.share.t_RiskIndicator) dob_riskCode_in
						 ) := function
        																																				 
      gtway_recs := response.records;						
			
			county       := address_in.county;
			postalCode   := address_in.postalCode;
			stateCityZip := address_in.stateCityZip;
			 
      integer miles_in := miles_in_param;							
			 
			Mileage_riskCode := incomeRisk_services.functions.checkMiles(miles_in);	
			 
      iesp.income_risk.t_IncomeRiskAssessmentReportResponse set_layout_gateway(
			              iesp.gateway_eri_salaryreport.t_ERIRecord l,
									  integer miles_param
										) := TRANSFORM		 
			SELF.LocalStats.PercentileLow       := l.LocalLow;
			SELF.LocalStats.Percentile10        := l.Local10Percentile;
			SELF.LocalStats.Percentile25        := l.Local25Percentile;
			SELF.LocalStats.Percentile75        := l.Local75Percentile;
			SELF.LocalStats.Percentile90        := l.Local90Percentile;
			SELF.LocalStats.PercentileHigh      := l.LocalHigh;
			SELF.LocalStats.Mean                := l.localMean;
			SELF.LocalStats.Median              := l.LocalMedian;
			SELF.LocalStats.TotalCompensation   := l.LocalTotalCompensation;
			SELF.LocalStats.StandardOfError     := l.LocalStandardError;
			SELF.LocalStats.BonusPercentage     := l.LocalBonusPercentage;
			SELF.LocalStats.BenefitsPercentage  := l.LocalBenefitsPercentage;
			SELF.LocalStats.JobFamilyMin        := l.JobFamilyLocalMin;
			SELF.LocalStats.JobFamilyMax        := l.JobFamilyLocalMax;
			
			SELF.NationalStats.PercentileLow      :=  l.NationalLow;
			SELF.NationalStats.Percentile10       :=  l.National10Percentile;
			SELF.NationalStats.Percentile25       :=  l.National25Percentile;
			SELF.NationalStats.Percentile75       :=  l.National75Percentile;
			SELF.NationalStats.Percentile90       :=  l.National90Percentile;
			SELF.NationalStats.PercentileHigh     :=  l.NationalHigh;
			SELF.NationalStats.Mean               :=  l.NationalMean;
			SELF.NationalStats.Median             :=  l.NationalMedian;
			SELF.NationalStats.TotalCompensation  :=  l.NationalTotalCompensation;
			SELF.NationalStats.StandardOfError    :=  l.NationalStandardError;
		
			SELF.NationalStats.JobFamilyMin       :=  l.JobFamilyNationalMin;
			SELF.NationalStats.JobFamilyMax       :=  l.JobFamilyNationalMax;
			SELF.Employer.EstEmployees            :=  (integer) l.EmployerEsTempCount; // l.EstEmployees;  
			SELF.Employer.EstRevenueThousands     :=  (integer) l.EmployerEstrev; //l.EstRevenueThousands; 
			     // return empty datset (i.e. no risk code if gateway information is not filled in) i.e
					 // if both the *percentile* information is not populated report is not able to determine if this risk
					 // code should be output so shortcut before going to the function to determine this and return empty DS
			SELF.HighRiskIndicators               :=  if ( (integer)l.Local25Percentile = 0 and (integer)l.National25Percentile = 0,
																										dataset([{'',''}], iesp.share.t_riskIndicator),
																	                   IncomeRisk_Services.functions.checkSalary(borrowerIncome_in,
																												if ((integer)l.Local25Percentile <> 0, l.Local25Percentile, l.National25Percentile),
																												if ((integer)l.Local75Percentile <> 0, l.Local75Percentile, l.National75Percentile)
																										));
			SELF.PositionPercentile               := (real4) l.PositionPercentile;
			SELF.JobTitle                         := l.JobTitle;
			SELF.JobFamily                        := l.JobFamily;
			SELF.StdIndustryClass                 := l.SicDescription; // unsure here?
			SELF.EmploymentMiles                  :=  miles_param; 	
			SELF.CompanySizeSensitiveIncome       := l.SizeSensitive = 'Yes';							
			self := []
	    END;
 
     out_rec_gateway := project(gtway_recs, set_layout_gateway(left, miles_in)); // populate all the		 
		 
		 did_sample_ds := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(in_mod);
		 
		 iesp.income_risk.t_EmployerWatchList 
		            xform_WatchList(incomeRisk_Services.layouts.biid_output_layout l,
								              integer C) := transform						
        self.tableName           := (string) choose(C,l.watchlist_table,l.watchlist_table_2,l.watchlist_table_3,
					                               l.watchlist_table_4, l.watchlist_table_5, l.watchlist_table_6,l.watchlist_table_7);
        self.RecordNumber        := (string) choose(C,l.watchlist_Record_Number,l.watchlist_Record_Number_2,l.watchlist_Record_Number_3,
					                               l.watchlist_Record_Number_4, l.watchlist_Record_Number_5, 
																				 l.watchlist_Record_Number_6,l.watchlist_Record_Number_7);																						       
        self.Name.First				 	 := choose(C, (string)l.repwatchlist_fname,(string)l.watchlist_fname_2, 
						                                       (string)l.watchlist_fname_3, (string)l.watchlist_fname_4, (string)l.watchlist_fname_5,
																									  (string)l.watchlist_fname_6, (string)l.watchlist_fname_7); 
				self.Name.Last           := choose(C, (string)l.repwatchlist_lname,(string)l.watchlist_lname_2, (string)l.watchlist_lname_3,
						                                       (string)l.watchlist_lname_4, (string)l.watchlist_lname_5,
																									 (string)l.watchlist_lname_6, (string)l.watchlist_lname_7);						                            													           																	 										  
				self.Address.StreetAddress1 := choose(C, l.watchlist_address, l.watchlist_address_2,l.watchlist_address_3, l.watchlist_address_4, 
						                                     l.watchlist_address_5, l.watchlist_address_6, l.watchlist_address_7);												           
				self.Address.City        := choose(C, l.watchlist_city, l.watchlist_city_2,l.watchlist_city_3, l.watchlist_city_4, 
						                                  l.watchlist_city_5, l.watchlist_city_6, l.watchlist_city_7);
        self.Address.State       := choose(C, l.watchlist_state, l.watchlist_state_2,l.watchlist_state_3, l.watchlist_state_4, 
						                                  l.watchlist_state_5, l.watchlist_state_6, l.watchlist_state_7);																						 
        self.Address.zip5        := choose(C, l.watchlist_zip, l.watchlist_zip_2,l.watchlist_zip_3, l.watchlist_zip_4, 
						                                  l.watchlist_zip_5, l.watchlist_zip_6, l.watchlist_zip_7);						       		 
			  Self.Country             := choose(C, l.watchlist_country, l.watchlist_country_2, l.watchlist_country_3, l.watchlist_country_4,
							                                l.watchlist_country_5, l.watchlist_country_6, l.watchlist_country_7);
				Self.EntityName          := choose(C, (string)l.watchlist_cmpy, (string)l.watchlist_cmpy_2, (string)l.watchlist_cmpy_3, (string)l.watchlist_cmpy_4,
							                                (string)l.watchlist_cmpy_5, (string)l.watchlist_cmpy_6, (string)l.watchlist_cmpy_7);
				Self.Sequence            :=  (integer) choose(C, l.RepWatchlist_seq_1, l.RepWatchlist_seq_2, l.RepWatchlist_seq_3, l.RepWatchlist_seq_4,
							                               l.RepWatchlist_seq_5, l.RepWatchlist_seq_6, l.RepWatchlist_seq_7);																						 
				self := [];
		 end;
		 
		 tmp_watchlist := normalize(biid_out, if (left.watchlist_table <> '', 1,
					                                   if (left.watchlist_table_2 <> '', 2,
																						    if (left.watchlist_table_3 <> '', 3,
																							     if (left.watchlist_table_4 <> '', 4,
																									    if (left.watchlist_table_5 <> '', 5,
																											   if (left.watchlist_table_6 <> '', 6,
																											     7)))))),
																								xform_WatchList(left,counter));
																								     																									 		 
		 iesp.income_risk.t_IncomeRiskAssessmentReportResponse 
		       set_layout_biid(incomeRisk_Services.layouts.biid_output_layout l,
					                 dataset(iesp.income_risk.t_EmployerWatchList) watchList_in,
													 dataset(iesp.share.t_RiskIndicator) dobRiskCode_param,
													 dataset(iesp.share.t_RiskIndicator) mileageRiskCode_param) := transform
													 
				tmpHighRisk     := dataset([{l.PRI_1,l.PRI_Desc_1},{l.PRI_2,l.PRI_Desc_2},
																		{l.PRI_3,l.PRI_Desc_3},{l.PRI_4,l.PRI_Desc_4},
																		{l.PRI_5,l.PRI_Desc_5},{l.PRI_6,l.PRI_Desc_6},
																		{l.PRI_7,l.PRI_Desc_7},{l.PRI_8,l.PRI_Desc_8},
																		{l.rep_pri_1,l.rep_PRI_desc_1},
																		{l.rep_pri_2,l.rep_PRI_desc_2},
																		{l.rep_pri_3,l.rep_PRI_desc_3},
																		{l.rep_pri_4,l.rep_PRI_desc_4},
																		{l.rep_pri_5,l.rep_PRI_desc_5},
																		{l.rep_pri_6,l.rep_PRI_desc_6},
																		{l.rep_followup_1,l.rep_followup_desc_1},
																		{l.rep_followup_2,l.rep_followup_desc_2},
																		{l.rep_followup_3,l.rep_followup_desc_3},
																		{l.rep_followup_4,l.rep_followup_desc_4}																		
																	 ],iesp.share.t_RiskIndicator);
        self.HighRiskIndicators   := tmpHighRisk + dobRiskCode_param + 
				                              mileageRiskCode_param; // currently max is set to 20
		    self.ProfessionalLicenses := choosen(PersonReports.proflic_records(did_sample_ds).proflicenses_v2, iesp.Constants.BR.MaxProfLicenses);
				 
         //self.WatchLists := dataset([watchList_in], iesp.income_risk.t_EmployerWatchList); 	
				self.WatchLists := watchList_in;				
				self.Messages :=  dataset([{'',''}], iesp.share.t_CodeMap); // future use.
				//SELF.Employer.Address.StreetName := l.addr1; 
				// SELF.Employer.Address.StreetNumber := '';
				// SELF.Employer.Address.StreetPredirection := '';
				// SELF.Employer.Address.StreetPostdirection := '';
				// SELF.Employer.Address.StreetSuffix := '';
				// SELF.Employer.Address.UnitDesignation := '';
				// SELF.Employer.Address.UnitNumber := '';
				SELF.Employer.Address.StreetAddress1 := l.addr1,
				// SELF.Employer.Address.StreetAddress2 := '',																							 
				SELF.Employer.Address.State := l.st,	
				SELF.Employer.Address.City  := l.p_city_name;
				SELF.Employer.Address.Zip5  := l.z5;
				SELF.Employer.Address.Zip4  := l.zip4;	
				SELF.Employer.Address.County := if (l.vercounty <> '', l.vercounty, county); // from BIID if possible otherwise echo input
				SELF.Employer.Address.PostalCode := if (l.z5 <> '', l.z5, postalCode); // echo input
				SELF.Employer.Address.StateCityZip := StateCityZip; // echo iput
																									 
         SELF.Employer.PhoneNumber  := l.phone10;					
				 SELF.Employer.CompanyName  := l.company_name;
         SELF.Employer.DBA          := l.company_name;  // for lack of better field putting this in here.
				 							
				 self.VerificationIndicators.Name     :=  l.repNameVerFlag  = 'Y'; 
				 self.VerificationIndicators.Address  :=  l.repAddrVerFlag  = 'Y';
				 self.VerificationIndicators.city     :=  l.repCityVerFlag  = 'Y';
				 self.VerificationIndicators.state    :=  l.repZipVerFlag   = 'Y';
				 self.VerificationIndicators.zip      :=  l.repNameVerFlag  = 'Y';
				 self.VerificationIndicators.zip4     :=  l.repZip4VerFlag  = 'Y';
				 self.VerificationIndicators.phone10  :=  l.repPhoneVerFlag = 'Y';
				 self.VerificationIndicators.ssn      :=  l.repSsnVerFlag   = 'Y';
				 self.VerificationIndicators.dob      :=  l.repDobVerFlag   = 'Y';
				 self.employer.EmployerVerificationIndicators.CompanyName := l.CnameMatchflag = 'Y';
				 self.employer.EmployerVerificationIndicators.Address := l.addrMatchflag = 'Y';
				 self.employer.EmployerVerificationIndicators.city    := l.cityMatchflag = 'Y';
				 self.employer.EmployerVerificationIndicators.state   := l.stateMatchflag = 'Y';
				 self.employer.EmployerVerificationIndicators.zip     := l.zipMatchflag = 'Y';
				 self.employer.EmployerVerificationIndicators.phone10 := l.PhoneMatchflag = 'Y';
				 self.employer.EmployerVerificationIndicators._fein   := l.FeinMatchflag = 'Y';
				 self := [];				
		end;			
		  			 			 
		 out_rec_biid := project(biid_out, set_layout_biid(left, tmp_watchList, 
		                                                   dob_riskCode_in,
		                                                   Mileage_riskCode)); // populate all the biid info
		 		 
		 iesp.income_risk.t_IncomeRiskAssessmentReportResponse
		         set_final(iesp.income_risk.t_IncomeRiskAssessmentReportResponse in_biid) := transform
        																 
        self._Header := [];
			
				self.ProfessionalLicenses := in_biid.ProfessionalLicenses;
				self.WatchLists           := in_biid.WatchLists;
				self.HighRiskIndicators   := in_biid.HighRiskIndicators;
				self.messages             := in_biid.Messages;
			  SELF.Employer.PhoneNumber := in_biid.Employer.phoneNumber;
				SELF.Employer.CompanyName := in_biid.Employer.CompanyName;
				SELF.Employer.DBA         := in_biid.Employer.DBA;									  
			//SELF.Employer.TaxID                   := '';			
				SELF.Employer.Address.StreetName           :=  in_biid.Employer.Address.StreetName, 																
				SELF.Employer.Address.StreetNumber         :=  in_biid.Employer.Address.StreetNumber,
			  SELF.Employer.Address.StreetPreDirection   := in_biid.Employer.Address.StreetPreDirection,
				SELF.Employer.Address.StreetPostDirection  := in_biid.Employer.Address.StreetPostDirection,
				SELF.Employer.Address.StreetSuffix         := in_biid.Employer.Address.StreetSuffix,
				SELF.Employer.Address.UnitDesignation      := in_biid.Employer.Address.UnitDesignation,
				SELF.Employer.Address.UnitNumber           := in_biid.Employer.Address.UnitNumber,
			  SELF.Employer.Address.StreetAddress1       := in_biid.Employer.Address.StreetAddress1,
				SELF.Employer.Address.State   := in_biid.Employer.Address.State,
				SELF.Employer.Address.City    := in_biid.Employer.Address.City,
				SELF.Employer.Address.Zip5    := in_biid.Employer.Address.Zip5,
				SELF.Employer.Address.Zip4    := in_biid.Employer.Address.Zip4,			
				SELF.Employer.Address.County    := in_biid.Employer.Address.County,
				SELF.Employer.Address.PostalCode    := in_biid.Employer.Address.PostalCode,
				SELF.Employer.Address.StateCityZip  := in_biid.Employer.Address.StateCityZip,
				self.VerificationIndicators.Name    := in_biid.VerificationIndicators.Name;
				self.VerificationIndicators.Address := in_biid.VerificationIndicators.Address;
				self.VerificationIndicators.city    := in_biid.VerificationIndicators.city;
				self.VerificationIndicators.state   := in_biid.VerificationIndicators.state;
				self.VerificationIndicators.zip     := in_biid.VerificationIndicators.zip;
				self.VerificationIndicators.zip4    := in_biid.VerificationIndicators.zip4;
				self.VerificationIndicators.phone10 := in_biid.VerificationIndicators.phone10;
				self.VerificationIndicators.ssn     := in_biid.VerificationIndicators.ssn;
				self.VerificationIndicators.dob     := in_biid.VerificationIndicators.dob;
				self.Employer.EmployerVerificationIndicators.CompanyName := in_biid.employer.EmployerVerificationIndicators.companyName;
				self.Employer.EmployerVerificationIndicators.Address := in_biid.employer.EmployerVerificationIndicators.Address;
				self.employer.EmployerVerificationIndicators.city    := in_biid.employer.EmployerVerificationIndicators.city;
				self.employer.EmployerVerificationIndicators.state   := in_biid.employer.EmployerVerificationIndicators.state;
				self.employer.EmployerVerificationIndicators.zip     := in_biid.employer.EmployerVerificationIndicators.zip;
				self.employer.EmployerVerificationIndicators.phone10 := in_biid.employer.EmployerVerificationIndicators.phone10;
				self.employer.EmployerVerificationIndicators._fein   := in_biid.employer.EmployerVerificationIndicators._fein;
			  self := [];
		 															 
     end;					
		 																		 		                    		 		 
		out_rec2 := project(out_rec_biid,  set_final(left));
		
		layout_tmp := record
		    string10 phoneNumber;
				string companyName;
				string dba;
			  string28 StreetName;
				string10 StreetNumber;
				string2 StreetPreDirection;
				string2 StreetPostDirection;
				string4 StreetSuffix;
				string10 UnitDesignation;
				string8 UnitNumber;
				string60 StreetAddress1;
				string60 StreetAddress2;
				string2 State;
				string25 City;
				string5 Zip5;
				string4 Zip4;
				string18 County;
				string9 PostalCode;
				string50 StateCityZip;
				integer EstEmployees;          
			  integer EstRevenueThousands;		
	      boolean V_Name;	
	      boolean V_Address;
	      boolean V_City;
	      boolean V_State;
				boolean V_Zip;
				boolean V_Zip4;
				boolean V_Phone10;
				boolean V_SSN;
				boolean V_DOB;
	      // company
				boolean V_Cname;
				boolean V_Caddress;
				boolean V_Ccity;
				boolean V_Cstate;
				boolean V_Czip;
				boolean V_Cphone10;
				boolean V_CFein;
		end;
		
		out_tmp := project(out_rec2, transform(layout_tmp,
		                      self.phoneNumber := left.Employer.phoneNumber;
													self.companyName := left.Employer.companyName;
													self.dba         := left.Employer.dba;
													SELF.StreetName  :=  left.Employer.Address.StreetName, 																
								SELF.StreetNumber          :=  left.Employer.Address.StreetNumber,
								SELF.StreetPreDirection    :=  left.Employer.Address.StreetPreDirection,
							  SELF.StreetPostDirection   := left.Employer.Address.StreetPostDirection,
								SELF.StreetSuffix      := left.Employer.Address.StreetSuffix,
								SELF.UnitDesignation   := left.Employer.Address.UnitDesignation,
								SELF.UnitNumber        := left.Employer.Address.UnitNumber,
								SELF.StreetAddress1    := left.Employer.Address.StreetAddress1,
								SELF.State             := left.Employer.Address.State,
								SELF.City              := left.Employer.Address.City,
								SELF.Zip5              := left.Employer.Address.Zip5,
								SELF.Zip4              := left.Employer.Address.Zip4,
								SELF.StreetAddress2    := left.Employer.Address.StreetAddress2,
								SELF.County            := left.Employer.Address.County,
								SELF.StateCityZip      := left.Employer.Address.StateCityZip,
								SELF.PostalCode        := left.Employer.Address.PostalCode,
								SELF.EstEmployees      := left.Employer.EstEmployees,
								SELF.EstRevenueThousands := left.Employer.EstRevenueThousands,					
				        self.V_Name        := left.VerificationIndicators.Name,
				        self.V_Address     := left.VerificationIndicators.Address,
				        self.V_city        := left.VerificationIndicators.city,
				        self.V_state       := left.VerificationIndicators.state,
				        self.V_zip         := left.VerificationIndicators.zip,
				        self.V_Zip4        := left.VerificationIndicators.zip4,
	              self.V_Phone10     := left.VerificationIndicators.phone10,
	              self.V_SSN         := left.VerificationIndicators.ssn,
	              self.V_DOB         := left.VerificationIndicators.dob,				 
				        self.V_CName       := left.employer.EmployerVerificationIndicators.CompanyName,
				        self.V_CAddress    := left.employer.EmployerVerificationIndicators.Address,
				        self.V_Ccity       := left.employer.EmployerVerificationIndicators.city,
				        self.V_Cstate      := left.employer.EmployerVerificationIndicators.state,
				        self.V_Czip        := left.employer.EmployerVerificationIndicators.zip,				 
	              self.V_CPhone10    := left.employer.EmployerVerificationIndicators.phone10,
				        self.V_Cfein       := left.employer.EmployerVerificationIndicators._fein				 
							));
		
		// setup a dataset so that it can be passed into project below to populate output structure
		// 
    out_tmp_ds := dataset([{out_tmp[1].phoneNumber, out_tmp[1].companyName, out_tmp[1].dba,
		                        out_tmp[1].StreetName,out_tmp[1].StreetNumber,out_tmp[1].StreetPreDirection,out_tmp[1].StreetPostDirection,
														out_tmp[1].StreetSuffix,out_tmp[1].UnitDesignation,out_tmp[1].UnitNumber,
														out_tmp[1].StreetAddress1,out_tmp[1].StreetAddress2,out_tmp[1].State,out_tmp[1].City,
														out_tmp[1].Zip5,out_tmp[1].Zip4,
														out_tmp[1].County,out_tmp[1].PostalCode,out_tmp[1].StateCityZip,
														out_tmp[1].EstEmployees, out_tmp[1].EstRevenueThousands,											
														out_tmp[1].V_Name, 
														out_tmp[1].V_Address, 
														out_tmp[1].V_City, 
														out_tmp[1].V_state,
														out_tmp[1].V_zip,
														out_tmp[1].V_zip4,
														out_tmp[1].V_phone10,
														out_tmp[1].V_ssn,
														out_tmp[1].V_dob,
														out_tmp[1].V_cname,
														out_tmp[1].V_caddress,
														out_tmp[1].V_ccity,
														out_tmp[1].V_cstate,
														out_tmp[1].V_czip,
														out_tmp[1].V_cphone10,
														out_tmp[1].V_cfein
														}
														], layout_tmp);
		
		 iesp.income_risk.t_IncomeRiskAssessmentReportResponse
		      set_final2 (iesp.income_risk.t_IncomeRiskAssessmentReportResponse in_gateway,
					            string11 taxId) := transform								
								self.NationalStats        := in_gateway.NationalStats;
								self.LocalStats           := in_gateway.LocalStats;
								self.ProfessionalLicenses := out_rec2.ProfessionalLicenses;
								self.Watchlists           := out_rec2.Watchlists;
								self.HighRiskIndicators   := out_rec2.HighRiskIndicators + in_gateway.HighRiskIndicators;
								self.messages             := out_rec2.Messages;
							  self.PositionPercentile   := in_gateway.PositionPercentile;
								self.JobTitle             := in_gateway.JobTitle;
	              self.JobFamily            := in_gateway.JobFamily;
	              self.StdIndustryClass     := in_gateway.StdIndustryClass;
	              self.EmploymentMiles      := in_gateway.EmploymentMiles;
								SELF.CompanySizeSensitiveIncome       := in_gateway.CompanySizeSensitiveIncome;
								SELF.Employer.PhoneNumber             := out_tmp_ds[1].phoneNumber;
								SELF.Employer.CompanyName             := out_tmp_ds[1].CompanyName;
				        SELF.Employer.DBA                     := out_tmp_ds[1].DBA;										 
								SELF.Employer.Address.StreetName           := out_tmp_ds[1].StreetName, 																
								SELF.Employer.Address.StreetNumber         := out_tmp_ds[1].StreetNumber,
								SELF.Employer.Address.StreetPreDirection   := out_tmp_ds[1].StreetPreDirection,
							  SELF.Employer.Address.StreetPostDirection  := out_tmp_ds[1].StreetPostDirection,
								SELF.Employer.Address.StreetSuffix         := out_tmp_ds[1].StreetSuffix,
								SELF.Employer.Address.UnitDesignation      := out_tmp_ds[1].UnitDesignation,
								SELF.Employer.Address.UnitNumber           := out_tmp_ds[1].UnitNumber,
								SELF.Employer.Address.StreetAddress1       := out_tmp_ds[1].StreetAddress1,
								SELF.Employer.Address.State                := out_tmp_ds[1].State,
								SELF.Employer.Address.City                 := out_tmp_ds[1].City,
								SELF.Employer.Address.Zip5                 := out_tmp_ds[1].Zip5,
								SELF.Employer.Address.Zip4                 := out_tmp_ds[1].Zip4,
								SELF.Employer.Address.StreetAddress2       := out_tmp_ds[1].StreetAddress2;    
								SELF.Employer.Address.County               := out_tmp_ds[1].County;
								SELF.Employer.Address.StateCityZip         := out_tmp_ds[1].StateCityZip;
								SELF.Employer.Address.PostalCode           := out_tmp_ds[1].PostalCode;												
								SELF.Employer.EstRevenueThousands          := out_tmp_ds[1].EstRevenueThousands;
								SELF.Employer.EstEmployees                 := out_tmp_ds[1].EstEmployees;											
								SELF.Employer.TaxID :=  TaxID; // just echo input here.		
								self.VerificationIndicators.Name       := out_tmp_ds[1].V_name,
								self.VerificationIndicators.Address    := out_tmp_ds[1].V_address, 
								self.VerificationIndicators.city       := out_tmp_ds[1].V_city,
								self.VerificationIndicators.state      := out_tmp_ds[1].V_state,
								self.VerificationIndicators.zip        := out_tmp_ds[1].V_zip,
								self.VerificationIndicators.zip4       := out_tmp_ds[1].V_zip4,
								self.VerificationIndicators.phone10    := out_tmp_ds[1].V_phone10,
								self.VerificationIndicators.ssn        := out_tmp_ds[1].V_ssn,
								self.VerificationIndicators.dob        := out_tmp_ds[1].V_dob,
								self.Employer.EmployerVerificationIndicators.CompanyName := out_tmp_ds[1].V_cname,
								self.Employer.EmployerVerificationIndicators.Address     := out_tmp_ds[1].V_cAddress,
								self.employer.EmployerVerificationIndicators.city        := out_tmp_ds[1].V_ccity,
								self.employer.EmployerVerificationIndicators.state       := out_tmp_ds[1].V_cstate,
								self.employer.EmployerVerificationIndicators.zip         := out_tmp_ds[1].V_czip,
								self.employer.EmployerVerificationIndicators.phone10     := out_tmp_ds[1].V_cphone10,
								self.employer.EmployerVerificationIndicators._fein       := out_tmp_ds[1].V_cfein,
								SELF._Header := []
     end;				
				
		out_rec := project(out_rec_gateway, set_final2(left, taxID));
		 													
		 // DEBUG
		 // output(tmp_watchlist, named('tmp_watchlist'));
		  // output(out_rec_biid, named('out_rec_biid'));			
      // output(out_rec2, named('out_rec2'));		
			// output(did_sample_ds, named('did_sample_ds_2'));
      // output(out_rec, named('out_rec'));
			
		 return(out_rec);
  end;				
	
	export Report_View := module	
	   export iesp.gateway_eri_salaryreport.t_ERISalaryReportResponse 
		          eri_gateway(dataset(iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest) eri_in,
							            DATASET(gateway.layouts.config) gateway_cfg
							) := function								   
				
				gateway_results := ERIGateway_SoapCall_Function(eri_in, gateway_cfg);
				// this is in the form iesp.gateway_eri_salaryreport.t_ERISalaryReportResponseEx
				
				gateway_rec := project(gateway_results, transform( 
				               iesp.gateway_eri_salaryreport.t_ERISalaryReportResponse, 
							self.records := left.response.records,
							self.summary := left.response.summary,
							self := []
							));
       return gateway_rec;								
		 end;
	end;
	 
	export Batch_View := module
	   //
	   // function calls a transform which takes input data from user and transform it into layout
		 // used for calling the business instant ID service.
		 //
		export Business_Risk.Layout_Input_Moxie_2
		    setBIIDReportInput(dataset(incomeRisk_services.layouts.income_risk_batch_input) in_batch) := function
		     
			Business_Risk.Layout_Input_Moxie_2	  
			             xformBiidInput(incomeRisk_services.layouts.income_risk_batch_input l) := transform
			         // business				
						self.name_company     := (string120) l.Comp_name;
						self.street_addr      := (string65)  l.comp_addr1;
						self.prim_range       := (string10) l.comp_prim_range;
						self.predir           := (string2) l.comp_predir;
						self.prim_name        := (string28) l.comp_prim_name;
						self.addr_suffix      := (string4) l.comp_addr_suffix;
						self.postdir          := (string2) l.comp_postdir;
						self.unit_desig       := (string10) l.comp_unit_desig;
						self.sec_range        := (string8) l.comp_sec_range;
						self.p_city_name      := (string25) l.comp_p_city_name;
						self.st               := (string2) l.comp_st;
						self.z5               := (string5) l.comp_z5;
						self.zip4             := (string4) l.comp_zip4;				
						self.phoneno          := l.company_phoneNumber;							 
							 // person
            self.name_first    := l.name_first;
						self.name_middle   := l.name_middle;
						self.name_last     := l.name_last;
						self.name_suffix   := l.name_suffix;	 	
						self.street_addr2  := l.addr1;
					  self.prim_range_2  := l.prim_range;
					  self.predir_2      := l.prim_range;
					  self.prim_name_2   := l.prim_range;
					  self.addr_suffix_2 := l.addr_suffix;
					  self.postdir_2     := l.postdir;
						self.unit_desig_2  := l.unit_desig;
					  self.sec_range_2   := l.sec_range;
						self.p_city_name_2 := l.p_city_name;
					  self.st_2          := l.st;
					  self.z5_2          := l.z5;
						self.zip4_2        := l.zip4;
							// self.ssn := 
							// self.dob :=
						self.phone_2       := l.homephone;
						self.rep_age       := ''; // l.
						self.dl_number     := l.dl;
						self.dl_state      := l.dlstate;							
						self := l;
						self := [];
					end;										 				 
					
			res := project(in_batch, xformBiidInput(left));     
		  return(res);
			
		end;
	
	  // This function grabs the input values from the input batch and sets up the
		// input structure for the call to the ERI gateway
		// The one business rule
	  export  
		 IncomeRisk_Services.layouts.t_ERISalaryReportRequest_acctno 
		   setERIGatewayRequest(dataset(incomeRisk_services.layouts.income_risk_batch_input) le
			) := function
								
			  IncomeRisk_Services.layouts.t_ERISalaryReportRequest_acctno  
			    xform_setGateway(incomeRisk_services.layouts.income_risk_batch_input l) := transform			
             SELF.acctno := l.acctno;																				 
						 SELF.RemoteLocations  :=[];
						 SELF.ServiceLocations :=[];
	
						 SELF.user.GLBPurpose    := '';//'0'; //l.glb; //'1';
						 SELF.user.DLPurpose     := '';//0; //l.dppa; //'1';
						 SELF.user.QueryID       := '';
						 SELF.user.ReferenceCode := ''; 
						 SELF.user.BillingCode   := '';
						 SELF.user :=[];
	
						 SELF.Reportby.JobTitle      := l.JobTitle;
						 SELF.Reportby.Employer      := if (l.dba <> '', l.dba, l.comp_name); // business rule
						 SELF.Reportby.EmployerMatch := l.EmployerMatch;
	
						 SELF.Reportby.JobExperience := l.YearsInJob;
						 SELF.ReportBy.Professionalexperience := l.ProfessionalExperience;
						 SELF.ReportBy.AnnualIncome  := if (l.AnnualIncome < 0 OR l.AnnualIncome = 0, 1, l.AnnualIncome);
						 SELF.ReportBy.SIC           := l.SIC;
						 SELF.ReportBy.NAICS         := l.NAICS;
	
						 SELF.ReportBy.SOC           := l.SOC;
						 SELF.ReportBy.BorrowerPostalCode := l.z5; //BorrowerZip;	
						 SELF.options                :=[];
						 SELF.ProfessionalExperience := l.ProfessionalExperience;
						 self.annualIncome           := l.AnnualIncome;
						 self.TaxId                  := l.taxId;
						 self.comp_County                 := l.comp_County;
		         self.comp_PostalCode             := l.comp_Postalcode;
		         self.comp_StateCityZip           := l.comp_stateCityZip;
						 // self := [];
					end;					 
			    ret_val := project(le,  xform_setGateway(left));			 		     				 			          
			 return (Ret_val);
		end;
	
	  //
	  //  Had to keep acctno, professionalExperience, annualIncome and TaxId fields associated
		//  with each row of input while maintaining the call to the gateway service 
		//  which required a slimer layout than initially passed in so had to temporarily save
		//  off the needed attrs before eri gateway was called so that
		//  they can be later added back to the same row
		//  from the gateway call.
		//  
		//
	  export incomeRisk_Services.layouts.t_ERISalaryReportResponse_acctno  
		      eri_gateway(dataset(IncomeRisk_Services.layouts.t_ERISalaryReportRequest_acctno) eri_in_plus,					           
											dataset(gateway.layouts.config) gateway_cfg
										 ) := function
      			
			  incomeRisk_Services.layouts.t_ERISalaryReportResponse_acctno   
			     eri_gateway_xform(incomeRisk_Services.layouts.t_ERISalaryReportRequest_acctno l) := transform
				      tmp_acctno                 := l.acctno;
							tmp_professionalExperience := l.ProfessionalExperience;
							tmp_annualIncome           := l.annualIncome;
							tmp_taxId                  := l.taxId;
							tmp_county                 := l.comp_county;
							tmp_postalcode             := l.comp_Postalcode;
							tmp_stateCityZip           := l.comp_stateCityZip;
				      eri_in_slim                := project(l, transform(iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest,
												                         self := left));		
              eri_in_slim_ds             := dataset([eri_in_slim], 	
							                              iesp.gateway_eri_salaryreport.t_ERISalaryReportRequest);																							 
							
						  batch_gateway_results      := ERIGateway_Soapcall_Function(eri_in_slim_ds, gateway_cfg);
												
							gateway_rec := project(batch_gateway_results, transform( 
								 incomeRisk_Services.layouts.t_ERISalaryReportResponse_acctno, 
								 self.records       := left.response.records,
								 self.summary       := left.response.summary,
								 self.acctno        := tmp_acctno,
								 self.ProfessionalExperience := tmp_professionalExperience,								 
								 self.annualIncome  := tmp_annualIncome,
								 self.taxId         := tmp_taxId;
								 self.comp_county			  := tmp_county;
								 self.comp_postalcode		:= tmp_postalcode;
								 self.comp_stateCityZip	:= tmp_stateCityZip;
								 self := []
							 ));																							                      																																						     
               self := gateway_rec[1];											 
				    end;
				 
				gateway_result_batch := project(eri_in_plus, eri_gateway_Xform(left));
				 // this returns gateway results with acctno professionalexp field 
				 //  attached for join later.
				                 			
			return (gateway_result_batch);	// function
	  
		end; 
		export incomeRisk_Services.layouts.income_risk_batch_output
		     setBatchReportOutput(
						dataset(incomeRisk_Services.layouts.t_ERISalaryReportResponse_acctno) eri_acctno,
						dataset(incomeRisk_Services.layouts.biid_output_layout) biid_out,
						dataset(Business_Risk.Layout_Input_Moxie_2 ) batch_in,
						dataset(doxie.layout_references) in_did
			 	) := function
				 
				  
										// acctno, annual income, professionalExperience and taxId all used
										// within this transform
										// are directly copied from users input recs and are not part of the 
										// t_ERISalaryReportResponse structure thus why
										// they can be directly referenced instead of doing l.Records[1].FIELDNAME
										//
										// all risk codes are calculated once for each individual account #
										// i.e. each successive call of the join 
										// and are then set for each row in the output
										//
					incomeRisk_Services.layouts.income_risk_batch_output  setOutputLayout(			
						        incomeRisk_Services.layouts.t_ERISalaryReportResponse_acctno l,
									  incomeRisk_Services.layouts.biid_output_layout r) := transform
										
					 self.Employer            :=        r.company_name;
					 self.EmployerTaxId       :=        l.TaxId;
					 self.EmployerAddress     :=        r.addr1;
					 self.EmployerCity        :=        r.p_city_name;
					 self.EmployerState       :=        r.st;
					 self.EmployerPostalCode  :=        r.z5;
					 self.EmployerEstrev      :=        l.Records[1].EmployerEstrev;
				   self.EmployerEsTempCount :=        l.Records[1].EmployerEsTempCount;
		       self.PositionPercentile  :=        l.Records[1].PositionPercentile;
		       self.NationalMean        :=        l.Records[1].NationalMean;
		       self.NationalMedian      :=        l.Records[1].NationalMedian;
		       self.NationalHigh        :=        l.Records[1].NationalHigh;
		       self.NationalLow         :=        l.Records[1].NationalLow;
		       self.National90Percentile :=       l.Records[1].National90Percentile;
		       self.National75Percentile :=       l.Records[1].National75Percentile;
		       self.National25Percentile :=       l.Records[1].National25Percentile;
		       self.National10Percentile :=       l.Records[1].National10Percentile;
		       self.NationalTotalCompensation :=  l.Records[1].NationalTotalCompensation;
		       self.NationalStandardError :=      l.Records[1].NationalStandardError;
		       self.LocalMean                :=   l.Records[1].LocalMean;
		       self.LocalMedian              :=   l.Records[1].LocalMedian;
		       self.LocalHigh                :=   l.Records[1].LocalHigh;
		       self.LocalLow                 :=   l.Records[1].LocalLow;
		       self.Local90Percentile        :=   l.Records[1].Local90Percentile;
		       self.Local75Percentile        :=   l.Records[1].Local75Percentile;
		       self.Local25Percentile        :=   l.Records[1].Local25Percentile;
		       self.Local10Percentile        :=   l.Records[1].Local10Percentile;
		       self.LocalTotalCompensation   :=   l.Records[1].LocalTotalCompensation;
		       self.LocalStandardError       :=   l.Records[1].LocalStandardError;
		       self.LocalBonusPercentage     :=   l.Records[1].LocalBonusPercentage;
		       self.LocalBenefitsPercentage  :=   l.Records[1].LocalBenefitsPercentage;
		       self.SicDescription           :=   l.Records[1].SicDescription;
		       self.Authorized               :=   l.Records[1].Authorized;
		       self.JobFamily                :=   l.Records[1].JobFamily;
		       self.JobFamilyNationalMax     :=   l.Records[1].JobFamilyNationalMax;
		       self.JobFamilyNationalMin     :=   l.Records[1].JobFamilyNationalMin;
		       self.JobFamilyLocalMax        :=   l.Records[1].JobFamilyLocalMax;
		       self.JobFamilyLocalMin        :=   l.Records[1].JobFamilyLocalMin;
		       self.JobTitle                 :=   l.Records[1].JobTitle;
					 tmp_in                        :=   project(batch_in(acctno = l.acctno), transform(Business_Risk.Layout_Input_Moxie_2,					                                           
																											self := left;
					                                            ));
           tmp_miles  := (integer) IncomeRisk_Services.functions.distance_between_addr(tmp_in);		
					 tmp_MilesBetweenHomeWorkRiskDS := IncomeRisk_Services.functions.checkmiles(tmp_miles);
					 
					 // professionalExperience is from input value
					 tmp_DOBRiskDS := IncomeRisk_Services.functions.checkDOB((unsigned8) r.rep_dob,
					                                (unsigned2) r.rep_age, l.ProfessionalExperience); 
																					                          // annual income is from input value
           // return empty datset (i.e. no risk code if gateway information is not filled in i.e
					 //  the *percentile* information is not populated so hard to report any error code at all here so 
					 // shortcut before going to the function the return empty DS
           tmp_salaryRiskDS := if ((integer)l.Records[1].Local25Percentile = 0 and (integer)l.Records[1].National25Percentile = 0,
					                         dataset([{'',''}], iesp.share.t_riskIndicator),
					                        IncomeRisk_Services.functions.checkSalary(
																		l.annualIncome,
																		if ((integer)l.Records[1].Local25Percentile <> 0, l.Records[1].Local25Percentile, l.Records[1].National25Percentile),
																		if ((integer)l.Records[1].Local75Percentile <> 0, l.Records[1].Local75Percentile, l.Records[1].National75Percentile)
																	));
           																	
					 self.EmploymentMiles          :=  tmp_miles;		
					 
           self.DOBRiskCode              :=  tmp_DOBRiskDS[1].RiskCode;
			     self.DOBRiskCode_Desc         :=  tmp_DOBRiskDS[1].Description;
			     self.MilesRiskCode            :=  tmp_MilesBetweenHomeWorkRiskDS[1].RiskCode;
			     self.MilesRiskCode_Desc       :=  tmp_MilesBetweenHomeWorkRiskDS[1].Description;
					 self.SalaryRiskCode           :=  tmp_salaryRiskDS[1].Riskcode;
			     self.SalaryRiskCode_Desc      :=  tmp_salaryRiskDS[1].Description;
					 
		       self.PostalCode               :=  l.Records[1].PostalCode;
		       self.ErrorMessage             :=  l.Records[1].ErrorMessage;
		       self.ErrorsReported           :=  l.Records[1].ErrorsReported;
		       self.SizeSensitive            :=  l.Records[1].SizeSensitive;
					 self.acctno                   :=  l.acctno;										
					 self := r;
					 self := l;
           end;																			
			                        			   
					  result_set := join(eri_acctno, biid_out,
						            left.acctno = right.account,
												setOutputLayout(left,right));
												
						return result_set;
			   end;
	end; // module batch_view
end; // module raw