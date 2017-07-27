import  TopBusiness_Services, BIPv2, iesp, MDR,IRS5500,AutoStandardI, Census_Data;

export IRS5500section := MODULE
export fn_fullView (
	dataset(topBusiness_services.IRS5500Section_Layouts.rec_input) ds_in_data,
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod
	) := function	  
	
	 FETCH_LEVEL := in_options.BusinessReportFetchLevel;
	 ds_in_data_deduped := dedup(ds_in_data,all);
	
      ds_irs5500_raw_recs := IRS5500.Key_LinkIDs.kfetch(project(ds_in_data_deduped, 
			                           BIPV2.IDlayouts.l_xlink_ids),FETCH_LEVEL);		                 
										         				 																								      
		 topBusiness_services.IRS5500Section_Layouts.rec_IRS5500Record 						
					xform_parent( recordof(ds_irs5500_raw_recs) l) := transform		
			  self.acctno := ''; // set later.
				self.FormNumber := l.form_id; // ??? on this field
				self.FormDate := iesp.ecl2esp.toDateString8(l.form_date);
				self.TransactionDate := iesp.ecl2esp.toDateString8(l.trans_date);
				self.PlanNumber := l.plan_number;
				self.PlanName := l.plan_name;
	
				self.FormPlanYearBeginDate := iesp.ecl2esp.toDatestring8(l.Form_plan_year_begin_date);
				self.PlanEffectiveDate := iesp.ecl2esp.toDateString8(l.plan_eff_date);
		// sponsor
				self.FEIN := l.ein;// TODO check on this field;
				self.SponsorName := l.sponsor_dfe_name; // NAME
				self.SponsorDFEPhoneNumber := '';
					
			// CountyName := choosen(project(Census_Data.Key_Fips2County(
							                          // keyed(state_code = l.st) and 
																				//fipscount is 3 digits
			                                  // keyed(county_fips = l.fipsCounty)), transform({string18 countyName;},
																				 // self.countyName := left.county_name)),1)[1].countyName;			
																				 
		    sponsCounty := choosen(project(Census_Data.Key_Fips2County(
							                          keyed(state_code = l.spons_st) and 
																				// fipscount is 3 digits
			                                  keyed(county_fips = l.spons_county[3..5])), transform({string18 countyName;},
																				 self.countyName := left.county_Name)),1)[1].countyName;			
																				 
			  // self.Address :=  iesp.ECL2ESP.SetAddress(
																	// l.prim_name,l.prim_range,l.predir,l.postdir,
																	// l.addr_suffix,l.unit_desig,l.sec_range,l.v_city_name,
																	// l.st,l.zip,l.zip4,
																	// CountyName, // set county here.
																	// '','','','');			
																	
					self.Address :=												iesp.ecl2esp.setAddress(l.spons_prim_name,
					                        l.spons_prim_range,l.spons_predir,
																	l.spons_postdir, l.spons_addr_suffix,
																	l.spons_unit_desig,
																	l.spons_sec_range,
																	l.spons_p_city_name,
																	l.spons_st,
																	l.Spons_zip5,
																	l.spons_zip4,
																	sponsCounty,
																	'','','','');
																			     
		      self.businessCode := l.business_code;				
          self.Administrator.Name := l.admin_name;
					self.Administrator.CareofName := l.admin_care_of_name;
					 // seems like sponsor address is always same as admin address
					 //
					self.Administrator.address :=  iesp.ECL2ESP.SetAddress(
																	//l.prim_name,l.prim_range,l.predir,l.postdir,
																	l.admn_str_address, '','','',
																	//l.addr_suffix,l.unit_desig,l.sec_range,
																	'','','',
																	//l.v_city_name,																	
																	l.admin_city,
																	//l.st,l.zip,l.zip4,
																	l.admin_state, l.admin_zip_code, '',
																	'', //CountyName, // set county here.
																	'','','','');				   
          self.Administrator.fein := l.admin_ein;
					self.administrator.phone := l.admin_phone_num;
					self.administrator.signatureDate := iesp.ecl2esp.todatestring8(l.admin_signed_date);
					self.administrator.signature := l.admin_signed_name;
					self.Sponsor.fullname := l.sponsor_dfe_name;
					self.sponsor.doingbusinessAs := l.spons_dfe_dba_name;
          self.Sponsor.address := iesp.ecl2esp.setAddress(l.spons_prim_name,
					                        l.spons_prim_range,l.spons_predir,
																	l.spons_postdir, l.spons_addr_suffix,
																	l.spons_unit_desig,
																	l.spons_sec_range,
																	l.spons_p_city_name,
																	l.spons_st,
																	l.Spons_zip5,
																	l.spons_zip4,
																	sponsCounty,
																	'','','','');
																	
					self.Sponsor.phone := l.spon_dfe_phone_num;
					//self.Sponsor.businessCode := l.business_code;
					self.Sponsor.lastReportedName := l.last_rpt_spons_name;
					self.Sponsor.lastReportedFein := l.last_rpt_spons_ein;
					self.Sponsor.lastReportedPlanNumber := l.last_rpt_plan_num;
					self.Sponsor.SignatureDate := iesp.ecl2esp.todatestring8(l.spons_signed_date);
					self.sponsor.fein := l.ein; // ????? just a guess
					self.sponsor.businessCode := '';
					
					self.Preparer.name := l.preparer_name;
					self.Preparer.address := iesp.ecl2esp.setAddress(l.preparer_str_address,'','','',
																	//l.prim_name,l.prim_range,
					                        //l.predir,l.postdir,
																	'','','',l.preparer_city,
																	//l.addr_suffix,l.unit_desig,l.sec_range,l.v_city_name,
																	l.preparer_state,l.preparer_zip_code,'',
																	//l.st,l.zip,l.zip4,
																	//CountyName, // set county here.
																	'',
																	'','','','');	
					self.Preparer.fein := l.preparer_ein;
					self.Preparer.phone := l.preparer_phone_num;
					self.RSI := l.RSI;
					self.DocumentLocatorNumber := l.Document_Locator_Number;
					self.FormTaxPRD := l.form_tax_prd;
					self.TypePlanEntityIndicator := l.Type_plan_entity_ind;
					self.TypeDFEPlanEntity := l.Type_DFE_Plan_Entity;
					self.TypePlanFilingIndicator := l.Type_plan_filing_ind;
					self.CollectiveBargainIndicator     := l.collective_bargain_ind;
					self.ExtApplicationFiledIndicator   := l.Ext_application_filed_ind;
					self.SponsorDFEDBAName        := l.Spons_dfe_dba_name;
					self.SponsorDFECareOfName     := l.Spons_dfe_Care_of_name;
					self.SponsorDFEmailStrAddress := l.Spons_dfe_mail_str_address;
          self.SponsorDFELoc01Address   := l.Spons_dfe_loc_01_addr;
					self.SponsorDFELoc02Address   := l.Spons_dfe_loc_02_addr;
					self.SponsorDFEForeignRouteCD := l.Spons_dfe_foreign_route_cd;
					self.SponsorDFEForeignMailCountry := l.Spons_dfe_Foreign_mail_cntry;
					
					self.AdminStreetAddress     := l.Admn_str_address;
					self.AdminForeignRouteCD := l.Admin_foreign_route_cd;
					self.AdminForeignMailingCountry := l.admin_foreign_mailing_cntry;
					self.LastReportedSponsorName := l.last_rpt_spons_name;
					self.LastReportedSponsorFein := l.last_rpt_spons_ein;
					self.LastReportedPlanNumber  := l.Last_rpt_plan_num;
					
					self.preparerStrAddress         := l.Preparer_str_address;
					self.preparerForeignRouteCd     := l.preparer_foreign_route_cd;
          self.preparerFrgnMailingCountry := l.preparer_frgn_mailing_cntry;
						
					self.AdminSignatureInd   :=  l.admin_signanture_ind;
					self.AdminSignedDate     := l.admin_signed_date;
					self.AdminSignedName     := l.admin_signed_name;

					self.SponsorSignatureIndicator := l.spons_signature_ind;
					self.SponsorSignedDate   :=    l.spons_signed_date;
					self.SponsorSignedName   :=  l.spons_signed_name;         
					self.sponsor.Name        := iesp.ecl2esp.setName(l.spons_sign_fname,l.spons_sign_mname, 
					                                           l.spons_sign_lname,l.spons_sign_suffix,l.spons_sign_title);			
          self.sponsor.sponsSignNameScore := l.spons_sign_name_score;																										 
										
					self.TotPartcpBoyCnt    := l.tot_partcp_boy_cnt;
          self.TotActivePartcpCnt := l.tot_active_partcp_cnt;
          self.RtdSepPartcpRcvgCnt  := l.rtd_sep_partcp_rcvg_cnt;
          self.RtdSepPartcpFutCnt  := l.rtd_sep_partcp_fut_cnt;
          self.SubtActRtdSepCnt   := l.subtl_act_rtd_sep_cnt;
          self.BenefRcvgBnftCnt   := l.benef_rcvg_bnft_cnt;
          self.TotActRtdSepBenefCnt := l.tot_act_rtd_sep_benef_cnt;
          self.PartcpAccountBalCnt  := l.partcp_account_bal_cnt;
          self.SepPartcpParttlVstCnt := l.sep_partcp_partl_vstd_cnt;
          self.SSAPartCpPartlVSTDCnt := l.ssa_filer_partl_vstd_cnt;
          self.PensionBenefitPlanID :=l.pension_benefit_plan_id;
          self.TypePensionBnftCode := l.type_pension_bnft_code;
          self.WelfareBenefitPlanIndicator := l.welfare_benefit_plan_ind;
          self.TypeWelfareBnftCode := l.type_welfare_bnft_code;
          self.FringeBenefitPlanIndicator := l.fringe_benefit_plan_ind;
          self.FundingArrangementCode := l.funding_arrangement_code;
          self.BenefitCode := l.benefit_code;
          self.ScheduleAttachments.SchRAttachedIndicator  := l.sch_r_attached_ind;					
          self.ScheduleAttachments.SchTAttachedIndicator   := l.sch_t_attached_ind;
          
					self.ScheduleAttachments.SchTAttachedCount := (integer) l.num_sch_t_attached_cnt;
          self.ScheduleAttachments.SchTPndgInfoPriorYearDate := l.sch_t_pndg_info_prior_yr_date;
          self.ScheduleAttachments.SchBAttachedIndicator := l.sch_b_attached_ind;
          self.ScheduleAttachments.SchEattachedIndicator  := l.sch_e_attached_ind;
          self.ScheduleAttachments.SchSsaAttachedIndicator := l.sch_ssa_attached_ind;
          self.ScheduleAttachments.SchHattachedIndicator :=  l.sch_h_attached_ind;
          self.ScheduleAttachments.SchIattachedIndicator := l.sch_i_attached_ind;
          self.ScheduleAttachments.SchAattachedIndicator :=l.sch_a_attached_ind;
          
					self.ScheduleAttachments.SchAAttachedCount := (integer) l.num_sch_a_attached_cnt;
          self.ScheduleAttachments.SchCattachedIndicator := l.sch_c_attached_ind;
          self.ScheduleAttachments.SchDattachedIndicator  := l.sch_d_attached_ind;
          self.ScheduleAttachments.SchGattachedIndicator := l.sch_g_attached_ind;
          self.ScheduleAttachments.SchPattachedIndicator  := l.sch_p_attached_ind;
         
					self.ScheduleAttachments.SchPAttachedCount := (integer) l.num_sch_p_attached_cnt;
          self.ScheduleAttachments.SchFAttachedIndicator := l.sch_f_attached_ind;

          self.Name := 
					 // iesp.ecl2esp.SetName( 
					// l.name_first, l.name_middle, l.name_last,l.name_suffix,l.name_prefix);			
                       iesp.ecl2esp.setName(l.spons_sign_fname,l.spons_sign_mname, 
					                                           l.spons_sign_lname,l.spons_sign_suffix,l.spons_sign_title);			
          self.Score := //l.score;
					              (string3) l.spons_sign_name_score;
          self.IsMailingAddr := l.mail_Addr;

					
					 // self.SourceDocs := dataset([transform(iesp.topBusiness_share.t_TopBusinessSourceDocInfo,						
					
						// self.SourceCode := MDR.sourceTools.src_IRS_5500,
						// self.SourceDocID := ''; 
						// self.businessIDs.proxid := l.proxid;
						// self.businessIDs.dotid := l.dotid;
						// self.businessIDs.powid := l.powid;
						// self.businessIDs.seleid := l.seleid;
						// self.businessIDs.empid := l.empid;
						// self.businessIDs.ultid := l.ultid;
						// self.businessIDs.orgid := l.orgid;
						// self.IdType := '';
	          // self.IdValue := '';
	          // self.Section := '';
	          // self.Source := MDR.sourceTools.src_IRS_5500,
	          // self.Address := '';
	          // self.Name :=  '';
						// self := l;
						// )]);
					self := l;          			
					//self := [];
			end;
		
		   ds_irs5500_recs := dedup(project(ds_irs5500_raw_recs, xform_parent(left)), all);
	  					
   topbusiness_Services.IRS5500Section_Layouts.rec_linkids_plus_IRS5500Record 
	rollup_rptdetail(	 
		  topBusiness_services.IRS5500Section_Layouts.rec_IRS5500Record 	 l,
	  dataset( topBusiness_services.IRS5500Section_Layouts.rec_IRS5500Record 	) allrows) := transform
		
    self.acctno  := '';			
		self.proxid  := l.proxid;
		self.dotid   := l.dotid;
		self.ultid   := l.ultid;
		self.orgid   := l.orgid;
		self.seleid := l.seleid;
		self.powid   := l.powid;
		self.empid   := l.empid;
		self.IRS5500s := choosen(project(allrows, transform(iesp.topbusinessReport.t_TopBusinessIRS5500record,
		                    self := left)), iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_IRS5500_RECORDS);
		
		self.IRS5500RecordCount := count(allrows);		   
		// self.SourceDocs := if(count(allrows) > 0,
		   // choosen(
		   // project(allrows.sourceDocs, 
			  // transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,			
				// self := left)),
				 // iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)
				 // );  
		self := l;
	end;
 
  ds_all_grouped := group(sort(ds_irs5500_recs,  #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																								 -FormPlanYearBeginDate.Year,-FormPlanYearBeginDate.Month,
																								 -FormPlanYearBeginDate.day,
																								 record), #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																								 ); 
  ds_all_rptdetail_rolled := rollup(ds_all_grouped,
																 group,
																 rollup_rptdetail(left,rows(left)));
 
   ds_raw_data_wAcctno := join(ds_in_data,ds_all_rptdetail_rolled, // in_data has acctno on it
	                         BIPV2.IDmacros.mac_JoinTop3Linkids(),
														transform(TopBusiness_Services.IRS5500Section_Layouts.rec_linkids_plus_IRS5500Record,
														   self.acctno   := left.acctno,
															 self          := right),
												left outer); // 1 out rec for every left (in_data) rec 																			 																		
																		 
    ds_final_results := rollup(group(sort(ds_raw_data_wAcctno,acctno),acctno),group,
		  transform(TopBusiness_Services.IRS5500Section_Layouts.rec_Final,				
		   self := left));			
			 
			 // debug outputs.
			 // output(ds_in_data_deduped, named('ds_in_data_deduped'));
			 
		   // output(ds_all_grouped, named('all_grouped'));
		   // output(ds_all_rptdetail_rolled, named('all_rptdetail_rolled'));
			 
     return ds_final_results;						 
  end; // function
	end; // module