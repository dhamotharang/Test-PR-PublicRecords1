import iesp, BatchServices, ut, Business_Header, DNB, Gateway, STD, Doxie;

export BusinessInView_BatchService_Records := module

 export BatchServices.BusinessInView_BatchService_Layouts.EFX_batch_input   
	              SequenceInputRecs(BOOLEAN forceSeq = FALSE) := function 							 							 
		
		// generic layout with business inview information added.
		// use to sequence the incoming batch records
		
		  rec := BatchServices.BusinessInView_BatchService_Layouts.EFX_batch_input;

		  raw1 := DATASET([], rec) : STORED('batch_in', FEW);
		  raw0 := raw1 : GLOBAL;

		  rec tra(rec l) := TRANSFORM
			  SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, '500');
			  SELF := l;
		  end;

		  raw := PROJECT(raw0, tra(LEFT));

		  ut.MAC_Sequence_Records(raw, seq, raw_seq)

		  batch_BusInview_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);				
				  
		  return batch_BusInview_file;
	
    end;	

export BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportResponse_acctno
		      BatchCallTo_EFX_INVIEW_gateway(dataset(BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportRequest_acctno) efx_in_plus,					           
											Gateway.Layouts.Config gateway_cfg,
                      boolean call_gateway = false) := function
									
      			
			 BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportResponse_acctno   
			     efx_gateway_xform(BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportRequest_acctno l)
					 := transform
					    // save off acctno for adding to rec after it is returned from gateway.
				    tmp_acctno                 := l.acctno;			
							// input fields:
					  tmp_In_comp_name := l.In_comp_name;
						tmp_In_prim_range := l.In_prim_range;
						tmp_In_predir := l.In_predir;
						tmp_In_prim_name := l.In_prim_name;
						tmp_In_addr_suffix := l.In_addr_suffix;
						tmp_In_postdir := l.In_postdir;
						tmp_In_unit_desig := l.In_unit_desig;
						tmp_In_sec_range := l.In_sec_range;
						tmp_In_p_city_name := l.In_p_city_name;
						tmp_In_st := l.In_st;
						tmp_In_z5 := l.In_z5;
						tmp_In_zip4 := l.In_zip4;
				    tmp_In_mileradius := l.In_mileradius;
						tmp_In_workphone := l.In_workphone;
						tmp_In_fein := l.In_fein;
						tmp_in_bdid := l.in_bdid;
						tmp_in_duns_num := l.in_duns_num;
						// end input fields
						// these fields may possibly be filled in from the
						// rollupbusiness search and will be used for final output
						// if the efx gateway does not return info in these fields
						// so save them off into attributes here and then 
						// put them into the layout along with the gateway return results
						tmp_url                    := l.urlBusHeader;
						tmp_fein                   := l.feinBusHeader;
						tmp_FAX                    := l.Fax;
		        tmp_ticker_Symbol          := l.Ticker_Symbol;
		        tmp_Net_Worth              := l.Net_Worth;
		        tmp_Sales                  := l.SalesBusHeader;
						tmp_count_ucc              := l.count_ucc;
						tmp_count_jandL            := l.count_jandl; 
						tmp_count_bk               := l.count_bk;
				    efx_in_slim                := project(l, transform(iesp.gateway_inviewreport.t_InviewReportRequest,
												                         self := left));		
            efx_in_slim_ds             := dataset([efx_in_slim], 	
							                              iesp.gateway_inviewreport.t_InviewReportRequest);																							 
						batch_gateway_results      := 
								Gateway.SoapCall_Equifax(efx_in_slim_ds, gateway_cfg, call_gateway);								
						gateway_rec := project(batch_gateway_results, transform( 
								 BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportResponse_acctno, 
								 
						self._header                := left.response._header;
						self.ProductCodes           := left.response.ProductCodes;
					  self.CustomerSecurityInfo   := left.response.CustomerSecurityInfo;
					  self.CommercialCreditReport := left.response.CommercialCreditReport;			
						// add back in the attributes that were obtained from the rollup
						// business batch service in case the gateway doesnt' return information
						// in these attributes.
						self.acctno                 := tmp_acctno;			 		
						self.urlBusHeader           := tmp_url;
					  self.feinBusHeader          := tmp_fein;
					  self.FAX                    := tmp_Fax;
		        self.ticker_Symbol          := tmp_Ticker_Symbol;
		        self.Net_Worth              := tmp_Net_Worth;
		        self.SalesBusHeader         := tmp_Sales;
						
						self.count_ucc := tmp_count_ucc;
						self.count_jandL := tmp_count_jandL; 
						self.count_bk := tmp_count_bk;
								 
						// input fields:
						self.In_comp_name := tmp_In_comp_name;
						self.In_prim_range := tmp_In_prim_range;
						self.In_predir := tmp_In_predir;
						self.In_prim_name := tmp_In_prim_name;
						self.In_addr_suffix :=  tmp_In_addr_suffix;
						self.In_postdir := tmp_In_postdir;
						self.In_unit_desig :=  tmp_In_unit_desig;
						self.In_sec_range := tmp_In_sec_range;
						self.In_p_city_name := tmp_In_p_city_name;
						self.In_st := tmp_In_st;
						self.In_z5 := tmp_In_z5;
						self.In_zip4 := tmp_In_zip4;
						self.In_mileradius := tmp_In_mileradius;
						self.In_workphone := tmp_In_workphone;
						self.In_fein := tmp_In_fein;
						self.in_bdid := tmp_in_bdid;
						self.in_duns_num := tmp_in_duns_num;
						// input end;								 
						self := []
							 ));																							                      																																						     
           self := gateway_rec[1];											 
				  end; // transform
				
				// project input param to this function to setup the gateway layout
				// and save off all the fields that are needed to be saved following
				// the gateway call.
				gateway_result_batch := project(efx_in_plus, efx_gateway_Xform(left));
				 // this returns gateway results with acctno field 
				 //  attached for join later.
			return (gateway_result_batch);	// function
	  
		end; 

//**********************
// this function sets the initial input for the rollup business batch search.
// it also calls rollup business batch service to get business information
// and it calls the gateway to return business records.
// and eventually returns all the information collected into a
// final layout which is returned.
export setInput(Gateway.Layouts.Config gateway_cfg, 
                RollupBusiness_BatchService_Interfaces.Input args) := function
 
  // these are set not per acctno but are global but are passed into
	// the gateway in each record so obtain the values from the soap input
	// field here for these 3 options.
    BOOLEAN tmpincludebusinesscreditrisk       := FALSE : STORED('Includebusinesscreditrisk');		 
		BOOLEAN tmpincludebusinessfailurerisklevel := FALSE : STORED('Includebusinessfailurerisklevel');
	 	BOOLEAN tmpincludecustombcir               := FALSE : STORED('Includecustombcir');									 

    SHARED mod_access := MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
      EXPORT unsigned1 glb := args.glbpurpose;
      EXPORT unsigned1 dppa := args.dppapurpose;
    END;    
  // sequence the records
	batch_input := SequenceInputRecs(false);
	
	duns_rec := RECORD
	RECORDOF(DNB.key_DNB_DunsNum);
	END;

layout_with_dt_last_seen := RECORD
		BatchServices.BusinessInView_BatchService_Layouts.layout_input_gateway;
		//qSTRING9   duns_num;		
		string8   date_last_seen;
		END;
		
layout_with_dt_last_seen
		Xfm_joined_recset(BatchServices.BusinessInView_BatchService_Layouts.EFX_batch_input l,
		                      duns_rec r)
				:= TRANSFORM
					SELF.comp_name 			:= (qSTRING120)r.business_name; 
					SELF.prim_range 		:= (qSTRING10)r.prim_range;
					SELF.predir 				:= (qSTRING2)r.predir;
					SELF.prim_name			:= (qSTRING28)r.prim_name;
					SELF.addr_suffix 		:= (qSTRING4)r.addr_suffix;
					SELF.postdir 				:= (qSTRING2)r.postdir;
					SELF.unit_desig 		:= (qSTRING10)r.unit_desig;
					SELF.sec_range 			:= (qSTRING8)r.sec_range;
					SELF.p_city_name 		:= (qSTRING25)r.p_city_name;
					SELF.st 						:= (qSTRING2)r.st;
					SELF.z5 						:= (qSTRING5)r.zip;
					SELF.zip4 					:= (qSTRING4)r.zip4;
					SELF.workphone 			:= (qSTRING10)r.telephone_number;
					SELF.bdid 					:= (qSTRING15)r.bdid;
					SELF.acctno					:= l.acctno;
					  milerad              := (integer) l.mileradius;
					SELF.mileradius			:= if (milerad > 5, (qstring3) '5', (qstring3) l.mileradius);
					SELF.fein						:= '';
					SELF.max_results		:= '';
					SELF.duns_num				:= (qSTRING9)r.duns;
					SELF.date_last_seen := (qSTRING8)r.date_last_seen;
					
											 self.In_comp_name := l.comp_name;
						self.In_prim_range := l.prim_range;
						self.In_predir := l.predir;
						self.In_prim_name := l.prim_name;
						self.In_addr_suffix := l.addr_suffix;
						self.In_postdir := l.postdir;
						self.In_unit_desig := l.unit_desig;
						self.In_sec_range := l.sec_range;
						self.In_p_city_name := l.p_city_name;
						self.In_st := l.st;
						self.In_z5 := l.z5;
						self.In_zip4 := l.zip4;						
						self.In_workphone := l.workphone;
						self.In_fein := l.fein;
						self.in_bdid := l.bdid;
						self.in_mileradius := l.mileradius;
						self.in_duns_num := l.duns_num;
					SELF := r;
					self := [];
					
					END;
								
duns_num_only := JOIN(batch_input(duns_num <> ''),DNB.key_DNB_DunsNum, KEYED(LEFT.duns_num=RIGHT.duns)
                                            AND Doxie.Compliance.use_DNB(mod_access.DataPermissionMask)
											AND RIGHT.record_type = 'C',
											Xfm_joined_recset(LEFT, RIGHT));
											
duns_num_dedup := DEDUP(SORT(duns_num_only,acctno,-date_last_seen),acctno);

duns_num_dedup_formatted := PROJECT(duns_num_dedup, BatchServices.BusinessInView_BatchService_Layouts.layout_input_gateway);
//returned deduped duns_num to same layout as tmpbusHeaderInput and bestBusinessRecs
	
  // this transform puts the input recs into a layout conducive to the
	// rollowup business batch service
	tmpbusHeaderInput := project(batch_input(bdid = '' AND duns_num = ''), transform(BatchServices.BusinessInView_BatchService_Layouts.layout_input_gateway,
	                    self.acctno      := left.acctno;
											self.comp_name   := STD.Str.ToUpperCase(left.comp_name);
											self.prim_range  := STD.Str.ToUpperCase(left.prim_range);
											self.predir      := STD.Str.ToUpperCase(left.predir);
											self.prim_name   := STD.Str.ToUpperCase(left.prim_name);
											self.addr_suffix := STD.Str.ToUpperCase(left.addr_suffix);
											self.postdir     := STD.Str.ToUpperCase(left.postdir);
											self.unit_desig  := STD.Str.ToUpperCase(left.unit_desig);
											self.sec_range   := STD.Str.ToUpperCase(left.sec_range);
											self.p_city_name := STD.Str.ToUpperCase(left.p_city_name);
											self.st 				 := STD.Str.ToUpperCase(left.st);
											self.z5 			   := left.z5;
											self.zip4 		   := left.zip4;
											         milerad := (integer) left.mileradius;
											SELF.mileradius	 := if (milerad > 5, (qstring3) '5',(qstring3) left.mileradius);
											self.workphone   := left.workphone;
											self.fein        := left.fein;
	                    self.bdid        := left.bdid;// this should be blank											
											self.duns_num    := left.duns_num;
											self.max_results := left.max_results; 	
											 self.In_comp_name := left.comp_name;
						self.In_prim_range := left.prim_range;
						self.In_predir := left.predir;
						self.In_prim_name := left.prim_name;
						self.In_addr_suffix := left.addr_suffix;
						self.In_postdir := left.postdir;
						self.In_unit_desig := left.unit_desig;
						self.In_sec_range := left.sec_range;
						self.In_p_city_name := left.p_city_name;
						self.In_st := left.st;
						self.In_z5 := left.z5;
						self.In_zip4 := left.zip4;						
						self.In_workphone := left.workphone;
						self.In_fein := left.fein;
						self.in_bdid := left.bdid;
						self.in_mileradius := left.mileradius;
						self.in_duns_num := left.duns_num;
						      self := [];
											));  	
											
  
	bestBusinessRecs :=  join (batch_input(bdid <> '' and duns_num = ''), Business_Header.Key_BH_Best,
	                          keyed( (unsigned6) left.bdid = right.bdid) AND 
                            doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
														transform(BatchServices.BusinessInView_BatchService_Layouts.layout_input_gateway,
														   self.bdid := (qstring15) right.bdid,
															  self.acctno      := left.acctno;
											self.comp_name   := STD.Str.ToUpperCase(right.company_name);
											self.prim_range  := STD.Str.ToUpperCase(right.prim_range);
											self.predir      := STD.Str.ToUpperCase(right.predir);
											self.prim_name   := STD.Str.ToUpperCase(right.prim_name);
											self.addr_suffix := STD.Str.ToUpperCase(right.addr_suffix);
											self.postdir     := STD.Str.ToUpperCase(right.postdir);
											self.unit_desig  := STD.Str.ToUpperCase(right.unit_desig);
											self.sec_range   := STD.Str.ToUpperCase(right.sec_range);
											self.p_city_name := STD.Str.ToUpperCase(right.city);
											self.st 				 := STD.Str.ToUpperCase(right.state);
											self.z5 			   := (qstring5) right.zip;
											self.zip4 		   := (qstring4) right.zip4;
											milerad := (integer) left.mileradius;
											SELF.mileradius	 := if (milerad > 5, (qstring3) '5',(qstring3) left.mileradius);
											self.workphone   := (qstring16) right.phone;
											self.fein        := (qstring9) right.fein;
                      self.max_results := (qstring3) args.MaxResultsPerRow;			
												 self.In_comp_name := left.comp_name;
						self.In_prim_range := left.prim_range;
						self.In_predir := left.predir;
						self.In_prim_name := left.prim_name;
						self.In_addr_suffix := left.addr_suffix;
						self.In_postdir := left.postdir;
						self.In_unit_desig := left.unit_desig;
						self.In_sec_range := left.sec_range;
						self.In_p_city_name := left.p_city_name;
						self.In_st := left.st;
						self.In_z5 := left.z5;
						self.In_zip4 := left.zip4;						
						self.In_workphone := left.workphone;
						self.In_fein := left.fein;
						self.in_bdid := left.bdid;
						self.in_mileradius := left.mileradius;
						self.in_duns_num := left.duns_num;
						  self := [];
											), limit(1000,skip));
																						 
	busHeaderInput :=  bestBusinessRecs + 
	                   tmpbusHeaderInput + duns_num_dedup_formatted;

																													
	// this function calls the rollup business batch search and returns the recs from that.
	// it also appends the derog (bk/j&L/ucc) counts for each row of input and maintains
	// the acctno associated with each input row throughout the batch service.
	busHeaderResults := BatchServices.RollupBusiness_BatchService_Records(project(busHeaderInput,transform(BatchServices.BusinessInView_BatchService_Layouts.layout_header_in,
	                                                                              self := left)),args).Records_with_derog_COUNT;
	
	busHeaderResultsDeduped := dedup(sort(busHeaderResults,acctno,-best_dt_last_seen), acctno);
	
	// this join takes the results from the rollupbusiness batch service and
  // put them into a layout which the business inview_report gateway needs for input
	// it also grabs several fields from the DCA keys in the rollup business search
	// and stores them in case the EFX (business inview report gateway) is not able
	// to provide them in the return results.
	busHeaderResultsWithGatewayInfo := join(busHeaderInput, busHeaderResultsDeduped,
	                                     left.acctno = right.acctno, 
																			 transform(BatchServices.BusinessInView_BatchService_Layouts.layout_input_gateway,
																			 self.acctno := left.acctno;
																			 self.comp_name := right.Best_Company_name;
																			 self.feinbusHeader := right.Best_fein;
																			 self.workphone := right.best_phone;
																			 self.prim_range := right.best_prim_range;
																			 self.prim_name := right.best_prim_name;
																			 self.predir := right.best_predir;
																			 self.addr_suffix := right.best_addr_suffix;
																			 self.postdir := right.best_postdir;
																			 self.unit_desig := right.best_unit_desig;
																			 self.sec_range := right.best_sec_range;
																			 self.p_city_name := right.best_city;
																			 self.st := right.best_state;
																			 self.z5 := right.best_zip;
																			 self.zip4 := right.best_zip4;	
																			 self.urlBusHeader := right.url;
																			 self.FAX := right.FAX;
																			 self.Ticker_Symbol := right.Ticker_Symbol;
																			 self.Net_Worth := right.Net_worth;
																			 self.SalesBusHeader := right.sales;
																			 self.count_ucc := right.count_ucc;
																			 self.count_jandL := right.count_jandl; 
																			 self.count_bk := right.count_bk;		
                                       self := left; // includes echoed input fields.															 
                                       self := [];																	
																			 ), limit(1000));

	
	  // this tranform takes the input DS and sets the fields into rows
		// to match the required input fields for the gateway.
		//
		
		BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportRequest_acctno 
		  setEFXGatewayRequest(
			  BatchServices.BusinessInView_BatchService_Layouts.layout_input_gateway l) := TRANSFORM		
			self.acctno          := l.acctno;
			self.urlBusHeader    := l.urlBusHeader;
			self.FAX             := l.FAX;
			self.Ticker_Symbol   := l.Ticker_Symbol;
			self.Net_Worth       := l.Net_worth;
			self.SalesBusHeader  := l.salesBusHeader;
			self.FeinbusHeader   := l.feinBusHeader;			
			self.count_ucc := l.count_ucc;
			self.count_jandL :=  l.count_jandl; 
			self.count_bk :=  l.count_bk;
		
			// input 
			self.In_comp_name   := l.In_comp_name;
			self.In_prim_range  := l.In_prim_range;
			self.In_predir      := l.in_predir;
			self.In_prim_name   := l.in_prim_name;
			self.In_addr_suffix := l.in_addr_suffix;
			self.In_postdir     := l.in_postdir;
			self.In_unit_desig  := l.in_unit_desig;
			self.In_sec_range   := l.in_sec_range;
			self.In_p_city_name := l.in_p_city_name;
			self.In_st          := l.in_st;
			self.In_z5          := l.In_z5;
			self.In_zip4        := L.In_zip4;		
			self.In_workphone   := l.In_workphone;
			self.in_mileradius   := l.In_mileradius;
			self.In_fein        := l.in_Fein;
			self.in_bdid				:= l.in_bdid;
			self.in_duns_num		:= l.in_duns_num;
		// end input echo
		
		// ***********************
		// SELF.user.ReferenceCode 
	  // SELF.user.BillingCode 
	  // SELF.user.QueryId 
	  // SELF.user.CompanyId 
		SELF.user.glbpurpose := (string) mod_access.glb;
		SELF.user.dlpurpose := (string) mod_access.dppa;
		// SELF.user.LoginHistoryId 
	  // SELF.user.DebitUnits 
	  // SELF.user.IP 
	  // SELF.user.IndustryClass 
	  // SELF.user.ResultFormat 
	  // SELF.user.LogAsFunction 
	  // SELF.user.SSNMask 
	  // SELF.user.DOBMask 
	  // SELF.user.DLMask 
	  // SELF.user.DataRestrictionMask 
	  // SELF.user.DataPermissionMask 
	  // SELF.user.ApplicationType 
	  // SELF.user.SSNMaskingOn 
	  // SELF.user.DLMaskingOn 
  	// t_EndUserInfo EndUser 
	  // SELF.user.MaxWaitSeconds 
	  // SELF.user.RelatedTransactionId 
	  // SELF.user.AccountNumber 
    // SELF.user.TestDataEnabled 
	  // SELF.user.TestDataTableName 
		
		SELF.ReportBy.CompanyName := l.comp_name;
		SELF.ReportBy.FEIN := l.fein;
		SELF.ReportBy.PhoneNumber := l.workphone;
		SELF.ReportBy.Address.StreetNumber := l.prim_range;
		SELF.ReportBy.Address.StreetPreDirection := l.predir;
		SELF.ReportBy.Address.StreetName := l.prim_name;
		SELF.ReportBy.Address.StreetSuffix := l.addr_suffix;
		SELF.ReportBy.Address.StreetPostDirection := l.postdir;
		SELF.ReportBy.Address.UnitDesignation := l.unit_desig;
		SELF.ReportBy.Address.UnitNumber := l.sec_range;
		SELF.ReportBy.Address.City := l.p_city_name;
		SELF.ReportBy.Address.State := l.st;
		SELF.ReportBy.Address.Zip5 := l.z5;
		SELF.ReportBy.Address.Zip4 := l.zip4;
		SELF.ReportBy := [];
		
		SELF.options.includebusinesscreditrisk       :=  tmpincludebusinesscreditrisk;
		SELF.options.includebusinessfailurerisklevel :=  tmpincludebusinessfailurerisklevel;
		SELF.options.includecustombcir               :=  tmpincludecustombcir;
		SELF.options := [];
		
		SELF := [];
	END;
	
	
	gatewayRequestDS := project(busHeaderResultsWithGatewayInfo , setEFXGatewayRequest(left));
	                       
	
  // this function below:
	// BatchCallTo_EFX_INVIEW_gateway(GatewayRequestDS,gateway_url_in),
	// calls the EFX gateway and returns a Large dataset based on each input
	// record.
	
	emptyGatewayReturnResultDS :=
	             project(gatewayrequestDS,
                 transform(BatchServices.BusinessInView_BatchService_Layouts.t_InviewReportResponse_acctno,
									self := left,  
									self := []
							));
	
	// if any of the 3 EFX gateway options are set call the gateway routine otherwise 
	// use an empty dataset.
	//
  call_inview_gateway := tmpincludebusinesscreditrisk OR tmpincludebusinessfailurerisklevel OR tmpincludecustombcir;
	gatewayReturnResultDS  
	       := if (call_inview_gateway,   
								BatchCallTo_EFX_INVIEW_gateway(GatewayRequestDS, gateway_cfg, call_inview_gateway),
								emptyGatewayReturnResultDS
	 );	
	
	// the following set of transforms is used to break down the gateway results into
	// managable pieces so that the results can be put into a flat layout.
	
	iesp.gateway_inviewreport.t_InvInquiry
	       xformInquiries(iesp.gateway_inviewreport.t_InvInquiry l) := transform
				   self := l;							
				 end;
							
  iesp.gateway_inviewreport.t_InvAlert
	      xformAlerts(iesp.gateway_inviewreport.t_InvAlert l) := transform
				  self := l;
				end;

  iesp.gateway_inviewreport.t_InvAvgDBT
	      xformAvgDBT(iesp.gateway_inviewreport.t_InvAvgDBT l) := transform
				  self := l;
				end;
 
  // this transform takes the results from the gateway and puts them into a flat layout
	// because the gateway return results are within several levels of nesting
	// multiple projects and several temporary attributes are established to
	// keep temporary data before it is flattened out.
	// iesp.gateway_inviewreport is an important attribute to be familiar with before
	// attempting to decipher this code.	
	//
  final_result := 
	  project(gatewayReturnResultDS,
	            transform(BatchServices.BusinessInView_BatchService_Layouts.final_layout,
								self.acctno        := left.acctno,
								
								tmpIdTraits := project(left.CommercialcreditReport.IdTraits,
								                         transform(iesp.gateway_inviewreport.t_InvIdTrait,
																				      self := left));
								                             
                tmpUltimateParentIdTraits := project(left.CommercialCreditReport.UltimateParent.IdTraits,
								                             transform(iesp.gateway_inviewreport.t_InvIdTrait,
																						   self := left));                			
																							 
								// grab the fien from deep inside the structure
								 tmpIdNumberTraits := project(tmpIdTraits[1].IdNumberTraits,
														                 transform(iesp.gateway_inviewreport.t_InvIdNumberTrait,
																						  self :=  left)); 
                // if the gateway doesn't provide the fein (buried within tmpIdNumberTraits,
								// use the fein obtained from the business header
                //
	              self.fein          := if (tmpidNumberTraits[1].idNumber <> 0, 
								                           (string9) (tmpidNumberTraits[1].idNumber),
								                                  left.FeinbusHeader);
	              self.FAX           := left.Fax,
	              self.Ticker_Symbol := left.Ticker_Symbol,
	              self.Net_Worth     := left.Net_Worth,
	              
								tmpInquiries := project(left.CommercialCreditReport.inquiries,
														         xformInquiries(left));
                self.InqueriesDate1     := tmpInquiries[1].InquiryDate;
								self.InqueriesIndustry1 := tmpInquiries[1].Industry;
								self.InqueriesDate2     := tmpInquiries[2].InquiryDate;
								self.InqueriesIndustry2 := tmpInquiries[2].Industry;
								self.InqueriesDate3     := tmpInquiries[3].InquiryDate;
								self.InqueriesIndustry3 := tmpInquiries[3].Industry;
								self.InqueriesDate4     := tmpInquiries[4].InquiryDate;
								self.InqueriesIndustry4 := tmpInquiries[4].Industry;
								self.InqueriesDate5     := tmpInquiries[5].InquiryDate;
								self.InqueriesIndustry5 := tmpInquiries[5].Industry;
								self.InqueriesDate6     := tmpInquiries[6].InquiryDate;
								self.InqueriesIndustry6 := tmpInquiries[6].Industry;
																											
								tmpAlerts := project(left.CommercialCreditReport.Alerts, 
														        xformAlerts(left));
                self.AlertCode1       := tmpAlerts[1].AlertCode;
								self.AlertDescription1 := tmpAlerts[1].AlertDescription;
								self.AlertCode2        := tmpAlerts[2].AlertCode;
								self.AlertDescription2 := tmpAlerts[2].AlertDescription;
								self.AlertCode3        := tmpAlerts[3].AlertCode;
								self.AlertDescription3 := tmpAlerts[3].AlertDescription;
								self.AlertCode4        := tmpAlerts[4].AlertCode;
								self.AlertDescription4 := tmpAlerts[4].AlertDescription;
								self.AlertCode5        := tmpAlerts[5].AlertCode;
								self.AlertDescription5 := tmpAlerts[5].AlertDescription;
								self.AlertCode6        := tmpAlerts[6].AlertCode;
								self.AlertDescription6 := tmpAlerts[6].AlertDescription;				
																																										 
                tmpAvgDBTs := project(left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.AvgDBTs,
														                 xformAvgDBT(left));
                
								self.AvgDBTsdateDBT1 := tmpAvgDBTs[1].DateDBT;
								self.AvgDBTsDBT1 := tmpAvgDBTs[1].DBT;
								self.AvgDBTsdateDBT2 := tmpAvgDBTs[2].DateDBT;
								self.AvgDBTsDBT2 := tmpAvgDBTs[2].DBT;
								self.AvgDBTsdateDBT3 := tmpAvgDBTs[3].DateDBT;
								self.AvgDBTsDBT3 := tmpAvgDBTs[3].DBT;
								self.AvgDBTsdateDBT4 := tmpAvgDBTs[4].DateDBT;
								self.AvgDBTsDBT4 := tmpAvgDBTs[4].DBT;
								self.AvgDBTsdateDBT5 := tmpAvgDBTs[5].DateDBT;
							  self.AvgDBTsDBT5 := tmpAvgDBTs[5].DBT;
								self.AvgDBTsdateDBT6 := tmpAvgDBTs[6].DateDBT;
								self.AvgDBTsDBT6 := tmpAvgDBTs[6].DBT;               																				                																					 
			  																						 
                tmpAddressTraits := project(tmpIdTraits[1].AddressTraits,
														                 transform(iesp.gateway_inviewreport.t_InvAddressTrait,
																						  self :=  left));               																						
																							                																						                              
                 self.primAddrCity  :=  tmpAddresstraits[1].city;
								 self.primAddrState := tmpAddressTraits[1].State;
								 self.primAddrPostalcode :=  tmpAddressTraits[1].postalcode;
								 self.primAddrStreetAddress1 := tmpAddressTraits[1].AddressLine1;
								
							   self.phone := project(tmpAddressTraits[1].TelephoneTraits,
																								  transform(iesp.gateway_inviewreport.t_InvTelephoneTrait,
																									  self := left))[1].TelephoneNumber;
                 self.companyName := project(tmpIdTraits[1].CompanyNameTraits,
								                            transform(iesp.gateway_inviewreport.t_InvCompanyNameTrait,
																				   self := left))[1].BusinessName;
								  self.ultimateParent := project(tmpUltimateParentIdTraits[1].CompanyNameTraits,
								                         transform(iesp.gateway_inviewreport.t_InvCompanyNameTrait,
																				   self := left))[1].BusinessName;          
                  tmpGatewayurl := project(tmpIdTraits[1].internetTraits,
								                         transform(iesp.gateway_inviewreport.t_InvInternetTrait,
																				   self := left))[1].URLName;
																// use gateway EFX value first if that doesn't exist use the string
																// from the business header 
                  self.url := if (tmpGatewayurl <> '', tmpGatewayurl, left.urlBusHeader); 
																																        											                        			               																								 
                  self.NumberOfActiveTrades := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NumberOfActiveTrades;
								  self.CurrentCreditLimitTotals := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.CurrentCreditLimitTotals;
								  self.HiCreditOrOrigLoanAmtTotals := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.HiCreditOrOrigLoanAmtTotals;
								  self.BalanceTotals := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.BalanceTotals;
								  self.PastDueAmtTotals := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.PastDueAmtTotals;
								  self.NewDelinquencies := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewDelinquencies;
								  self.NewAccounts := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewAccounts;
								  self.NewInquiries := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewInquiries;
								  self.NewUpdates := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewUpdates;
								  self.NumberOfAccounts := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NumberOfAccounts;
								  self.NumberOfChargeOffs := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NumberOfChargeOffs;
									self.CreditActiveSince := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.CreditActiveSince;
									self.TotalPastDue := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.TotalPastDue;
									self.MostSevereStatus := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.MostSevereStatus;
									self.HighestCredit := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.HighestCredit;
									self.TotalExposure := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.TotalExposure;
									self.AverageOpenBalance := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.AverageOpenBalance;
									self.MedianBalance := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.MedianBalance;
									self.MostSevereStatus24Months :=  left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.MostSevereStatus24Months;
									self.AcctOpen := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.AcctOpen;
									self.NewAcctClosed     := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewAcctClosed;
									self.NonChargeOffDel   := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NonChargeOffDel;
									self.NewChargeOffAmt   := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewChargeOffAmt;
									self.NewMostSevStatus  := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewMostSevStatus;
									self.HiCreditExt36Mo   := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.HiCreditExt36Mo;
									self.NumClosed         := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NumClosed;
									self.NewChargeOffAccts := left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.NewChargeOffAccts;
									tmpChargeOffAmt := project(left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.ChargeOffAmt,
														              transform(iesp.gateway_inviewreport.t_InvMoneyType,
																					self := left));
                  self.ChargeOffAmtCurrency := tmpChargeOffamt.Currency;
									self.ChargeOffAmtContent := tmpChargeoffAmt.Content_;
									tmpTotBal       := project(left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.TotBal,
														                       transform(iesp.gateway_inviewreport.t_InvMoneyType,
																									 self := left));
                  self.totBalCurrency := tmpTotBal.Currency;
									self.totBalContent := tmpTotBal.Content_;
									tmpBalDue       := project(left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.BalDue,
														                        transform(iesp.gateway_inviewreport.t_InvMoneyType,
																									 self := left));
                  self.BalDueCurrency := tmpBalDue.Currency;																									 
                  self.BalDueContent := tmpBalDue.Content_;
																									 
									TmpAtRiskBal    := project(left.CommercialCreditReport.ReportAttributes.NonFinancialSummary.SummaryAttributes.AtRiskBal,
														                        transform(iesp.gateway_inviewreport.t_InvMoneyType,
																									 self := left));
                  self.AtRiskBalCurrency := tmpAtRiskBal.Currency;
									self.AtRiskBalContent := tmpAtRiskBal.Content_;
                  self.YearsInBusiness := project(left.CommercialCreditReport.FirmographicsTraits,
														                          transform({string yearsInBusiness;},
																											    self.YearsInBusiness := left.CurrentFirm.YearsInBusiness;
																													))[1].YearsInBusiness;														                														
									self.YearStarted    := project(left.CommercialCreditReport.FirmographicsTraits,
														                      transform({string yearStarted;},
																									  self.YearStarted := left.CurrentFirm.YearStarted;
																										))[1].YearStarted;	
																										
                  gatewayTmpSales := project(left.CommercialCreditReport.FirmographicsTraits,
									                                 transform({string Sales;},
																									   self.Sales := left.currentFirm.AnnualSalesRange.Content_;
																										 ))[1].Sales;
                  // use gateway EFX value first if that doesn't exist use the string
																// from the business header 																										 
                  self.Sales :=  if (gatewayTmpSales <> '', gatewayTmpSales, left.SalesBusHeader);																										 
                  
                  self.RecentSinceDate := left.CommercialCreditReport.ReportAttributes.RecentSinceDate;																									
	                self.count_ucc := left.count_ucc;
									self.count_jandl := left.count_jandl;
									self.count_bk := left.count_bk;
									// input recs:
									
									self.In_comp_name   := left.In_comp_name;
									self.In_prim_range  := left.In_prim_range;
									self.In_predir      := left.in_predir;
									self.In_prim_name   := left.in_prim_name;
									self.In_addr_suffix := left.in_addr_suffix;
									self.In_postdir     := left.in_postdir;
									self.In_unit_desig  := left.in_unit_desig;
								  self.In_sec_range   := left.in_sec_range;
									self.In_p_city_name := left.in_p_city_name;
									self.In_st          := left.in_st;
								  self.In_z5          := left.In_z5;
									self.In_zip4        := Left.In_zip4;									
									self.In_workphone   := left.In_workphone;
									self.in_mileradius  := left.In_mileradius;
									self.In_fein        := left.in_Fein;
									self.in_bdid				:= left.in_bdid;
									self.in_duns_num		:= left.in_duns_num;
									//
									tmpDecisionTools := project(left.CommercialCreditReport.DecisionTools, 
										transform(iesp.gateway_inviewreport.t_InvScoreData,						
											self.ScoreName := left.ScoreName;
											self.Score := left.Score;
											self.ReasonCodes := project(left.Reasoncodes,  
												transform(iesp.gateway_inviewreport.t_InvReasonCode,
													self := left));
										self := left,																																	
										self := []));
									self.ScoreName_1    := tmpDecisionTools[1].scoreName;
									self.score_1        := tmpDecisionTools[1].score;
									self.reasonCode1_1  := tmpDecisionTools[1].ReasonCodes[1].code;
									self.reasonScore1_1 := tmpDecisionTools[1].ReasonCodes[1].score;
									self.reasonContent1_1 := tmpDecisionTools[1].ReasonCodes[1].content_;
									self.reasonCode1_2  :=  tmpDecisionTools[1].ReasonCodes[2].code;
									self.reasonScore1_2 := tmpDecisionTools[1].ReasonCodes[2].score;
									self.reasonContent1_2 := tmpDecisionTools[1].ReasonCodes[2].content_;				 
									self.reasonCode1_3  := tmpDecisionTools[1].ReasonCodes[3].code;
									self.reasonScore1_3 := tmpDecisionTools[1].ReasonCodes[3].score;
									self.reasonContent1_3 := tmpDecisionTools[1].ReasonCodes[3].content_;
									self.reasonCode1_4  := tmpDecisionTools[1].ReasonCodes[4].code;
									self.reasonScore1_4 := tmpDecisionTools[1].ReasonCodes[4].score;
									self.reasonContent1_4 := tmpDecisionTools[1].ReasonCodes[4].content_;
									self.reasonCode1_5  := tmpDecisionTools[1].ReasonCodes[5].code;
									self.reasonScore1_5 := tmpDecisionTools[1].ReasonCodes[5].score;
									self.reasonContent1_5 := tmpDecisionTools[1].ReasonCodes[5].content_;
									self.reasonCode1_6  := tmpDecisionTools[1].ReasonCodes[6].Code;
									self.reasonScore1_6 := tmpDecisionTools[1].ReasonCodes[6].Score;
									self.reasoncontent1_6 := tmpDecisionTools[1].ReasonCodes[6].content_;
				 
									self.ScoreName_2    := tmpDecisionTools[2].scoreName;
									self.score_2        := tmpDecisionTools[2].score;
									self.reasonCode2_1  := tmpDecisionTools[2].ReasonCodes[1].code;
									self.reasonScore2_1 := tmpDecisionTools[2].ReasonCodes[1].score;
									self.reasonContent2_1 := tmpDecisionTools[2].ReasonCodes[1].content_;
									self.reasonCode2_2  :=  tmpDecisionTools[2].ReasonCodes[2].code;
									self.reasonScore2_2 := tmpDecisionTools[2].ReasonCodes[2].score;
									self.reasonContent2_2 := tmpDecisionTools[2].ReasonCodes[2].content_;				 
									self.reasonCode2_3  := tmpDecisionTools[2].ReasonCodes[3].code;
									self.reasonScore2_3 := tmpDecisionTools[2].ReasonCodes[3].score;
									self.reasonContent2_3 := tmpDecisionTools[2].ReasonCodes[3].content_;
									self.reasonCode2_4  := tmpDecisionTools[2].ReasonCodes[4].code;
									self.reasonScore2_4 := tmpDecisionTools[2].ReasonCodes[4].score;
									self.reasonContent2_4 := tmpDecisionTools[2].ReasonCodes[4].content_;
									self.reasonCode2_5  := tmpDecisionTools[2].ReasonCodes[5].code;
									self.reasonScore2_5 := tmpDecisionTools[2].ReasonCodes[5].score;
									self.reasonContent2_5 := tmpDecisionTools[2].ReasonCodes[5].content_;
									self.reasonCode2_6  := tmpDecisionTools[2].ReasonCodes[6].Code;
									self.reasonScore2_6 := tmpDecisionTools[2].ReasonCodes[6].Score;
									self.reasoncontent2_6 := tmpDecisionTools[2].ReasonCodes[6].content_;										
						      self := [];														 
									));
		

 // output(busHeaderresults, named('busHeaderresults')); 																		  
 // output(gatewayReturnResultDS, named('gatewayReturnResultDS'));                                       
 // output(BusinessCommercialCreditReport, named('BusinessCommercialCreditReport'));
 // output(FirmographicsReport, named('FirmographicsReport'));
 // output(Add_Derog_Counts, named('Add_Derog_Counts'));
 // output(final_result, named('final_result'));
 // output(outResult, named('outResult'));
 // output(decisionTools, named('DecisionTools'));
 // output(out_result, named('out_result'));	
 // output(busHeaderInput, named('busHeaderInput'));	
 // output(GatewayInputWithBooleansAdded, named('GatewayInputWithBooleansAdded'));
 // output(tmpbusHeaderInput, named('tmpbusHeaderInput'));
 // output(bestBusinessRecs, named('bestBusinessRecs'));
 // output(busHeaderInput, named('busHeaderInput'));
 // output(busHeaderresults , named('busHeaderresults'));
// output(busHeaderResultsWithGatewayInfo, named('busHeaderResultsWithGatewayInfo'));
 
	return final_result; 
	end; // function
end; // module


