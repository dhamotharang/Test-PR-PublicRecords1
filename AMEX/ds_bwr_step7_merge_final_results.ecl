#workunit('name','AMEX - Merge Final Results - nonfcra');
#option ('hthorMemoryLimit', 1000);
//                    RUN on THOR_200
eyeball := 10;

// chunk := '_0_1mill_FCRA';
// chunk := '_1_2mill_FCRA';
// chunk := '_2_3mill_FCRA';
chunk := '_3_4mill_FCRA';


// chunk := '_0_1mill';
// chunk := '_1_2mill';
// chunk := '_2_3mill';
// chunk := '_3_4mill';

outProc1Recs := dataset ('~dvstemp::out::amex_job1_process1_relatives_all_21million', amex.layouts.outputProc1, thor);		
outProc2Recs := dataset ('~dvstemp::out::amex_job1_process5_relatives_output', amex.layouts.outputProc2, thor);					
// outProc1Recs := distribute(dataset ('~dvstemp::out::AMEX_job1_process1_output' + chunk, amex.layouts.outputProc1, thor), hash(account));							
// outProc2Recs := distribute(dataset ('~dvstemp::out::AMEX_job1_process2_output' + chunk, amex.layouts.outputProc2, thor), hash(account));
								
output(choosen(outproc1recs, eyeball), named('outproc1recs'));
output(choosen(outproc2recs, eyeball), named('outproc2recs'));

amex.layouts.outputFinal finalFormat(amex.layouts.outputProc1 l,  amex.layouts.outputProc2 r) := transform
  self.account := l.account;
	self.Link_ID := intformat(l.bs.did, 12,1);
	self.Addr1_zip9:= r.addrs1_zip + r.addrs1_zip4;
	self.Addr1_date_first_seen:= (string)r.addrs1_dt_first_seen;
	self.Addr1_date_last_seen:= (string)r.addrs1_dt_last_seen;
	self.Addr1_length_of_residence:= amex.fn_YearsMonthsApart(r.addrs1_dt_first_seen,r.addrs1_dt_last_seen);
	self.Addr1_number_of_relatives:= (string)r.addrs1_relativesAtAddr;
	self.Addr1_estimated_value:= r.avm1_valuation;
	self.Addr2_zip9:= r.addrs2_zip + r.addrs2_zip4;
	self.Addr2_date_first_seen:= (string)r.addrs2_dt_first_seen ;
	self.Addr2_date_last_seen:= (string)r.addrs2_dt_last_seen;
	self.Addr2_length_of_residence:= amex.fn_YearsMonthsApart(r.addrs2_dt_first_seen,r.addrs2_dt_last_seen);
	self.Addr2_number_of_relatives:= (string)r.addrs2_relativesAtAddr;
	self.Addr2_estimated_value:= r.avm2_valuation;
	self.Addr3_zip9:= r.addrs3_zip + r.addrs3_zip4;
	self.Addr3_date_first_seen:= (string)r.addrs3_dt_first_seen;
	self.Addr3_date_last_seen:= (string)r.addrs3_dt_last_seen;
	self.Addr3_length_of_residence:= amex.fn_YearsMonthsApart(r.addrs3_dt_first_seen,r.addrs3_dt_last_seen);
	self.Addr3_number_of_relatives:= (string)r.addrs3_relativesAtAddr;
	self.Addr3_estimated_value:= r.avm3_valuation;
	self.Addr4_zip9:= r.addrs4_zip + r.addrs4_zip4;
	self.Addr4_date_first_seen:= (string)r.addrs4_dt_first_seen;
	self.Addr4_date_last_seen:= (string)r.addrs4_dt_last_seen;
	self.Addr4_length_of_residence:= amex.fn_YearsMonthsApart(r.addrs4_dt_first_seen,r.addrs4_dt_last_seen);
	self.Addr4_number_of_relatives:= (string)r.addrs4_relativesAtAddr;
	self.Addr4_estimated_value:= r.avm4_valuation;
	self.Addr5_zip9:= r.addrs5_zip + r.addrs5_zip4;
	self.Addr5_date_first_seen:= (string)r.addrs5_dt_first_seen;
	self.Addr5_date_last_seen:= (string)r.addrs5_dt_last_seen;
	self.Addr5_length_of_residence:= amex.fn_YearsMonthsApart(r.addrs5_dt_first_seen,r.addrs5_dt_last_seen);
	self.Addr5_number_of_relatives:= (string)r.addrs5_relativesAtAddr;
	self.Addr5_estimated_value:= r.avm5_valuation;
	self.Economic_trajectory_recent_move:= if(l.bs.did=0, '', l.ita.EconomicTrajectory);
	self.Address_stability_indicator:= if(l.bs.did=0, '', l.ita.AddrStability);
	self.Curr_addr_Median_Income:= r.easi_MED_HHINC;
	self.Curr_Addr_Median_Home_Val:= r.easi_MED_HVAL;
	self.Curr_Addr_Murder_Index:= r.easi_MURDERS;
	self.Curr_Addr_Car_Theft_Index:= r.easi_CARTHEFT;
  self.Curr_Addr_Burglary_Index:= r.easi_BURGLARY;
	self.Curr_Addr_Crime_Index:= r.easi_TOTCRIME;
 	self.Attended_High_school_indicator:= r.college.Attended_High_school_indicator;
	self.Years_since_HS_Graduation:= r.college.Years_since_HS_Graduation;
	self.College_indicator1:= r.college.College_indicator1;
	self.College_public_private_flag1:= r.college.College_public_private_flag1;
	self.College_2yr_4yr__grad_indicator1:= r.college.College_2yr_4yr__grad_indicator1;
	self.College_Education_program_tier1:= r.college.College_Education_program_tier1;
	self.Employer_hit_flag:= if (r.paw_contact_id > 0, 'Y', 'N'); 
	self.Most_recent_company_name:= r.paw_company_name;
	self.Most_recent_title:= r.paw_company_title;
	self.Employer_date_last_seen:= r.paw_dt_last_seen;
	self.Professional_license_hit:= if (l.bs.Professional_License.Professional_License_flag, 'Y','N');
	self.License_type:= l.bs.Professional_License.License_type;
	self.License_date_last_seen:= (string)l.bs.Professional_License.date_most_recent;
	self.Personal_wealth_index:= if(l.bs.did=0, '', l.ita.WealthIndex);
	self.Property_owned_num:= (string)l.bs.address_verification.owned.property_total;
	self.Property_sold_num:= (string)l.bs.address_verification.sold.property_total;
	self.Num_aircraft_owned:= (string)l.bs.aircraft.aircraft_count;
	self.Num_watercraft_owned:= (string)l.bs.watercraft.watercraft_count;
	self.Registered_voter_indicator:= if (r.voter_vtid > 0, 'Y', 'N');
	self.Bankruptcy_filing_count:= l.ita.BankruptCount;
	self.Criminal_activity_count:= (string)l.bs.bjl.criminal_count;
	self.Lein_filing_count:= l.ita.LiensCount;
	self.Relatives_property_owned_count:= (string)l.bs.Relatives.owned.relatives_property_count;
	avgCnt := (l.bs.Relatives.owned.relatives_property_count / l.bs.Relatives.relative_count);
  avgPercent := if ( avgCnt > 0, (DECIMAL4_2)avgCnt,0);
	self.Num_properties_owned_per_relative := (string)avgPercent;
	self.Relative_bankruptcy_count := (string)l.bs.Relatives.relative_bankrupt_count;
	
// work around the bug with relative criminal count in a history mode.  
// if the relatives count is less than the count of relatives with criminal records, cap the relative criminal count to at least 1 less than the relative count
	self.Relative_criminal_count := (string)if(l.bs.Relatives.relative_count<l.bs.Relatives.relative_criminal_count, l.bs.Relatives.relative_count-1, l.bs.Relatives.relative_criminal_count) ;
	self.Num_Relative_Criminals_within_25_miles := (string)if(l.bs.Relatives.relative_count<l.bs.Relatives.criminal_relative_within25miles, l.bs.Relatives.relative_count-1, l.bs.Relatives.criminal_relative_within25miles);
	
	self.Num_relatives := (string)l.bs.Relatives.relative_count;
	self.Num_LN_Sources := (string)models.Common.countw(l.bs.iid.sources, ', ');
	self.Total_time_on_file:= amex.fn_YearsMonthsApart((integer)l.ita.DateLastUpdate, (integer)l.ita.SubjectFirstSeen);
	self.Inferred_min_age:= if(l.bs.did=0, '', (string)l.bs.inferred_age ) ;
	age_today_from_reported_dob := risk_indicators.years_apart((unsigned)'20091201', l.bs.reported_dob);
	self.Best_reported_age:= if(l.bs.did=0, '', if(l.bs.reported_dob=0, '', (string)age_today_from_reported_dob) );
	self.rels := r.rels;

//  these fields are mapped, but not populated... 
//  ... don't have permissible purpose for vehicles
	self.Num_vehicles_owned:= (string)l.bs.vehicles.current_count;
// 	... most recent occupation is the same thing as most recent title	
	self.Most_recent_occupation:= r.paw_title;
//  ... we don't have second college info
	self.College_indicator2:= r.college.College_indicator2;
	self.College_public_private_flag2:= r.college.College_public_private_flag2;
	self.College_2yr_4yr__grad_indicator2:= r.college.College_2yr_4yr__grad_indicator2;
	self.College_Education_program_tier2:= r.college.College_Education_program_tier2;

			
	self := [];
end;
                                  
results := join(outProc1Recs, outProc2recs, left.account=right.account, finalFormat(LEFT, RIGHT), local);
OUTPUT (results, , '~dvstemp::out::AMEX_finaloutput_may17' + chunk, CSV(QUOTE('"')), overwrite);
// OUTPUT (results, , '~dvstemp::out::AMEX_relatives_finaloutput_deduped_may17', CSV(QUOTE('"')));
// OUTPUT (choosen(results, eyeball), named('final_results'));




