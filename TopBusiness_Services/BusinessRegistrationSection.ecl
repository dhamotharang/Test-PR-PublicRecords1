import  TopBusiness_Services, BIPv2, iesp, MDR,BusReg,AutoStandardI, Census_Data, codes;
// TODO add in some more field names at least a start for bug reg section
//
export BusinessRegistrationSection := MODULE
export fn_fullView (
	dataset(topBusiness_services.BusinessRegistrationSection_Layouts.rec_input) ds_in_data,
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod
	) := function	  
	
	 ds_in_data_deduped := dedup(ds_in_data,all);
	    FETCH_LEVEL := in_options.BusinessReportFetchLevel;
			
			ds_BusRegs_raw_recs := TopBusiness_Services.Key_Fetches(
	                         project(ds_in_data_deduped, 
			                           BIPV2.IDlayouts.l_xlink_ids),
													 FETCH_LEVEL).ds_busreg_linkidskey_recs;
			
      // ds_BusRegs_raw_recs := BusReg.key_busreg_company_linkids.kfetch(
										// project(ds_in_data_deduped, 
			                           // BIPV2.IDlayouts.l_xlink_ids),
																 // FETCH_LEVEL
																 // ); 
										         				 																								      
		 topBusiness_services.BusinessRegistrationSection_Layouts.rec_business_registration_recordWLinkids
					xform( recordof(ds_busRegs_raw_recs) l) := transform		
			  self.ultid := l.ultid;
				self.orgid := l.orgid;
				self.seleid := l.seleid;
				self.proxid := l.proxid;
				self.powid  := l.powid;
				self.empid := l.empid;
				self.dotid := l.dotid;
					
			 CountyName := choosen(project(Census_Data.Key_Fips2County(
							                          keyed(state_code = l.clean_mailing_address.st) and 
																				// fipscount is 3 digits
			                                  keyed(county_fips = l.clean_mailing_address.fips_County)), transform({string18 countyName;},
																				 self.countyName := left.county_name)),1)[1].countyName;			
		
			  self.Address :=  iesp.ECL2ESP.SetAddress(
																	   l.clean_mailing_address.prim_name,
																	   l.clean_mailing_address.prim_range,
																	   l.clean_mailing_address.predir,
																	   l.clean_mailing_address.postdir,
																	   l.clean_mailing_address.addr_suffix,
																	   l.clean_mailing_address.unit_desig,
																	   l.clean_mailing_address.sec_range,
																	   l.clean_mailing_address.v_city_name,
																	   l.clean_mailing_address.st,
																	   l.clean_mailing_address.zip,
																		 l.clean_mailing_address.zip4,
																	   CountyName, // set county here.
																	    '','','','');				        				
          self.recordDate := iesp.ecl2esp.toDate(l.record_date);
					self.FileDate := iesp.ecl2esp.todate(l.clean_dates.File_date);
					self.ExpirationDate := iesp.ecl2esp.ToDate(l.clean_dates.Exp_date);
					self.ProccessDate := iesp.ecl2esp.ToDate(l.clean_dates.proc_date);
					self.CompanyName := l.rawfields.company;
					self.companyPhone10 := l.clean_phones.biz_phone;
					self.filingNumber := l.rawfields.filing_num;					
					self.Description := l.rawfields.descript;
					 self.corpcodeDecode   := Codes.BUSREG_COMPANY.corpcode(l.rawfields.corpcode);
				   self.sosCodeDecode   := Codes.BUSREG_COMPANY.sos_code(l.rawfields.sos_code);
				   self.filingCodDecode := Codes.BUSREG_COMPANY.filing_cod(l.rawfields.filing_cod);
	         self.statusDecode	   := codes.BUSREG_COMPANY.status(L.rawfields.status);
					 self.status := l.rawfields.status;
					//self := l;          			
					self := [];
			end;
		
		   ds_busRegs_recs := dedup(project(ds_busRegs_raw_recs, xform(left)), all);
	  					
   topbusiness_Services.BusinessRegistrationSection_Layouts.rec_linkids_plus_BusRegRecord  
	rollup_rptdetail(	 
		   topBusiness_services.BusinessRegistrationSection_Layouts.rec_business_registration_recordWLinkids l,
	  dataset( topBusiness_services.BusinessRegistrationSection_Layouts.rec_business_registration_recordWLinkids) allrows) := transform
		
    self.acctno  := '';			
		self.proxid  := l.proxid;
		self.dotid   := l.dotid;
		self.ultid   := l.ultid;
		self.orgid   := l.orgid;
		self.seleid  := l.seleid;
		self.powid   := l.powid;
		self.empid   := l.empid;
		self.BusinessRegistrations := choosen(project(allrows, transform(iesp.topbusinessReport.t_TopBusinessBusinessRegistrationRecord,
		                    self := left; self := [])), iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_BUSREG_RECORDS); // to do remove self := [] later
		
		self.BusinessRegistrationsRecordCount := count(allrows);		   
		// self.SourceDocs := if(count(allrows) > 0,
		   // choosen(
		   // project(allrows.sourceDocs, 
			  // transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,			
				// self := left)),
				 // iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)
				 // );  
		self := l;
	end;
 
  ds_all_grouped := group(sort(ds_busRegs_recs,  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																								 record), #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																								 ); 
  ds_all_rptdetail_rolled := rollup(ds_all_grouped,
																 group,
																 rollup_rptdetail(left,rows(left)));
 
   ds_raw_data_wAcctno := join(ds_in_data,ds_all_rptdetail_rolled, // in_data has acctno on it
	                         BIPV2.IDmacros.mac_JoinTop3Linkids(),
														transform(TopBusiness_Services.BusinessRegistrationSection_Layouts.rec_linkids_plus_BusRegRecord,
														   self.acctno   := left.acctno,
															 self          := right),
												left outer); // 1 out rec for every left (in_data) rec 																			 																		
																		 
    ds_final_results := rollup(group(sort(ds_raw_data_wAcctno,acctno),acctno),group,
		  transform(TopBusiness_Services.BusinessRegistrationSection_Layouts.rec_Final,				
		   self := left));			
			 
			 // debug outputs.
			 // output(ds_in_data_deduped, named('ds_in_data_deduped'));
			 
		   // output(ds_all_grouped, named('all_grouped'));
		   // output(ds_all_rptdetail_rolled, named('all_rptdetail_rolled'));
			 
     return ds_final_results;						 
  end; // function
	end; // module