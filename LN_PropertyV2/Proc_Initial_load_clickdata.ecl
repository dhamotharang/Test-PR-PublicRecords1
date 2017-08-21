/*2008-08-28T16:47:31Z (Jason Trost)
property_use_code exclusion set
*/
#workunit('name','LN Property Clickdata')
import ln_propertyv2,ut ,_control;

fn_date_format(string in_date) := function
 out_date := if(in_date<>'',
              if(length(trim(in_date))=8,
			   in_date[1..4]+'-'+in_date[5..6]+'-'+in_date[7..8],
              if(length(trim(in_date))=6,
			   in_date[1..4]+'-'+in_date[5..6],
			 in_date)),in_date);

 return out_date;
end;
																												
export proc_Initial_load_clickdata(string filedate) := function
	
	property_use_exclusion_set := ['AGR','C&I','COM','GOV','IND','LAN','REC'];
	
	deed_ln			:= LN_PropertyV2.file_deed_building(ln_fares_id[1] != 'R' and current_record = 'Y'); 
	deed_land_use   := deed_ln(assessment_match_land_use_code ='' or assessment_match_land_use_code[1] ='1' );
	deed_prop_use   := deed_land_use(trim(property_use_code) not in property_use_exclusion_set);

	asses_ln		:= LN_PropertyV2.file_assessment_building(ln_fares_id[1] != 'R' and current_record = 'Y'); 
	asse_land_use   := asses_ln(standardized_land_use_code ='' or standardized_land_use_code[1] ='1')	;							 
	
	integer curr_yr       := (integer)(string)ut.getdate[1..4];
	integer three_yrs_ago := curr_yr - 3;
	
	asse_la_tax := asse_land_use(((integer)tax_year between three_yrs_ago and curr_yr) or ((integer)assessed_value_year between three_yrs_ago and curr_yr));

	
	layout_clickdata.l_tmp  reformat(asse_la_tax l) := transform 
	
	  self.process_date         := fn_date_format(l.process_date);
		self.transfer_date        := fn_date_format(l.transfer_date);
		self.recording_date       := fn_date_format(l.recording_date);
		self.sale_date            := fn_date_format(l.sale_date);
		self.prior_transfer_date  := fn_date_format(l.prior_transfer_date);
		self.prior_recording_date := fn_date_format(l.prior_recording_date);
		self.tape_cut_date        := fn_date_format(l.tape_cut_date);
		self.certification_date   := fn_date_format(l.certification_date);
		self.condo_project_name		:= l.condo_project_or_building_name;
		self.building_name				:= l.condo_project_or_building_name;
	  self.ltv                  := (string)(100*((integer)l.mortgage_loan_amount/(integer)l.sales_price))  ;
		self.latest_flag          := if(l.process_date = filedate , 'Y', '');
		self                      := l;
		
	end; 

	asse_date := project(asse_la_tax , reformat(left));

	asses_supp := fn_suppress_dnm.assess(asse_date); 

	layout_clickdata.l_tmp_d  reformat1(deed_ln l) := transform
	
	  self.process_date      := fn_date_format(l.process_date);
		self.contract_date     := fn_date_format(l.contract_date);
		self.recording_date    := fn_date_format(l.recording_date);
		self.arm_reset_date    := fn_date_format(l.arm_reset_date);
		self.first_td_due_date := fn_date_format(l.first_td_due_date);		
		self.ltv               := (string)( 100*((integer)l.first_td_loan_amount/(integer)l.sales_price))  ;
		self.latest_flag          := if(l.process_date = filedate , 'Y', '');
		self                   := l;
		
	end; 

	deed_date := project(deed_prop_use, reformat1(left)) ;	

    deed_supp := fn_suppress_dnm.deed(deed_date); 
	
    merged_t := output(asses_supp,, '~thor_data400::ln_propertyv2::taxf.clickid',__compressed__,overwrite);
									
	merged_d := output(deed_supp,, '~thor_data400::ln_propertyv2::Deedf.clickid',__compressed__,overwrite);
								
	// despray 

	DestinationIP := _control.IPAddress.edata12;

	dt := fileservices.despray( '~thor_data400::ln_propertyv2::taxf.clickid', DestinationIP, '/hds_180/property_clickdata/taxf.clickid_'+ut.GetDate+'.d00',,,,TRUE);
					
	dd := fileservices.despray( '~thor_data400::ln_propertyv2::Deedf.clickid', DestinationIP, '/hds_180/property_clickdata/Deedf.clickid_'+ut.GetDate+'.d00',,,,TRUE);
	
  send_email:= fileservices.SendEmail('cdsdataops@seisint.com,kgummadi@seisint.com','Property clickdata files available on edata12 /hds_180/property_clickdata/taxf.clickid_'+ut.GetDate+'.d00 and Deedf.clickid_'+ut.GetDate+'.d00' ,'');
  send_bad_email := FileServices.sendemail('krishna.gummadi@lexisnexis.com', 'property click data build failed', failmessage,'');

result := sequential(merged_t
										,merged_d
	                  ,dt,dd ) :success(send_email), failure(send_bad_email);
return  result ;

end;