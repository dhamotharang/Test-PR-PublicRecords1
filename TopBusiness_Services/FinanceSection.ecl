IMPORT AutoStandardI, BIPV2, iesp, MDR, TopBusiness_Services;

EXPORT FinanceSection := MODULE;

 // *********** Main function to return BIPV2 format business report results
 export fn_FullView(
 	dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_ids_wacctno
	,Layouts.rec_input_options  in_options
	,AutoStandardI.DataRestrictionI.params in_mod
	                 ):= function

  FETCH_LEVEL := in_options.BusinessReportFetchLevel;											

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_ids_only := project(ds_in_ids_wacctno,
	                                 transform(BIPV2.IDlayouts.l_xlink_ids,
	                                             self := left,
																							 self := []));
  

  // ***** Get needed data from individual sources by fetching from the appropriate key file.

  // *** Key fetch to get DCAV2 (aka LNCA) data.
  ds_dca_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_only, // input file to join key with
								                                     FETCH_LEVEL,
																										 TopBusiness_Services.Constants.defaultJoinLimit).ds_dca_linkidskey_recs;

  // Project DCAV2 key recs onto common layout with just fields needed for the section 
  // output or source viewing/linking.
	ds_dca_slimmed := project(ds_dca_keyrecs, 
	   transform(FinanceSection_Layouts.rec_ids_withdata_slimmed,
	     self.source       := MDR.sourceTools.src_DCA,
			 self.source_docid := trim(left.rawfields.enterprise_num), 
			 self.annual_sales_amount:= (integer) left.rawfields.sales,			 
       // Convert 6 char fye/fiscal year end in mmddyy format to yyyymmdd
			 // If length=5 (i.e. 92411 ), add leading zero.
		   string6 temp_fye := if(length(left.rawfields.fye)=5,
			                        '0' + left.rawfields.fye,
															left.rawfields.fye);
			 self.sales_as_of_date := (unsigned4) if (temp_fye[6] != '', 
				                                        if ((integer) temp_fye[5..6] < 50,
					                                         '20' + temp_fye[5..6] + temp_fye[1..2] + temp_fye[3..4],
					                                         '19' + temp_fye[5..6] + temp_fye[1..2] + temp_fye[3..4]),
																							  '');
			 self := left, // to preserve ids
			 ));


  // *** Key fetch to get EBR 5600(Demographic) data.
  ds_ebr_key5600recs := TopBusiness_Services.Key_Fetches(ds_in_ids_only, // input file to join key with
								                                         FETCH_LEVEL,
																												 TopBusiness_Services.Constants.defaultJoinLimit).ds_ebr5600_linkidskey_recs;

  // Filter to only use the Current (record_type=C) records and then
  // project EBR key recs onto common layout with just the fields needed for the section 
  // output or source viewing/linking.
  ds_ebr_slimmed := project(ds_ebr_key5600recs(record_type='C'),
	   transform(FinanceSection_Layouts.rec_ids_withdata_slimmed,
	     self.source       := MDR.sourceTools.src_EBR,
			 self.source_docid := trim(left.file_number), 
			 self.sales_as_of_date := (unsigned4) left.process_date_last_seen;
			 self.annual_sales_amount:= TopBusiness_Services.Functions.convert_EBR_sales(left.sales_actual);
			 self := left, // to preserve ids
			 ));

  // Sort/dedup to only keep the 1 most recent (highest sales_as_of_date) "Current" record with 
	// the highest annual_sales_amount, per source_docid(file_number).
	// Added for bug 155186, since some sets of linkids have mutiple EBR "Current" recs per file_number.
	ds_ebr_deduped := dedup(sort(ds_ebr_slimmed,
	                             #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
															 source_docid,
                               -sales_as_of_date, 
															 -annual_sales_amount),
	                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
													source_docid
												 );


  // *** Key fetch to get Shelia Greco data.
  ds_sg_keyrecs := TopBusiness_Services.Key_Fetches(ds_in_ids_only, // input file to join key with
								                                     FETCH_LEVEL,
																										 TopBusiness_Services.Constants.defaultJoinLimit).ds_sg_linkidskey_recs;

  // Filter to only use the recs with a non-blank "sales" amount.
	ds_sg_keyrecs_wsales := ds_sg_keyrecs(rawfields.sales !='');

	ds_sg_slimmed := project(ds_sg_keyrecs_wsales,
	   transform(FinanceSection_Layouts.rec_ids_withdata_slimmed,
				self.source      := MDR.sourceTools.src_Sheila_Greco,
			 self.source_docid := '', 
       // v--- On 04/09/13 by comparision of the raw data against how it is displayed in
			 //   www.nexis.com in the library=COMPNY & file=SGACOM; the "sales" figure is in millions.
  		 // Since decimal amounts were found in the raw data (see bug 148227), first cast to a 
			 // REAL8 for the decimal, then multiple by 1 million, then cast the computational 
			 // result to INTEGER to drop the decimal values.
			 self.annual_sales_amount := (integer) (((REAL8) left.rawfields.sales) * 1000000);
			 self.sales_as_of_date    := left.clean_dates.lastupdate; //???
			 self := left, // to preserve ids
			 )); 


  // Concatenate recs from all sources
	ds_finrecs_all := ds_dca_slimmed +
										ds_ebr_deduped +
										ds_sg_slimmed;

  // Sort/dedup all recs from combined file that have non-zero sales amounts, 
	// to only keep 1 records per set of linkids/source/source_docid.
	ds_finrecs_deduped := dedup(sort(ds_finrecs_all(annual_sales_amount != 0),
	                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																   source,
																   source_docid,
                                   -sales_as_of_date, 
																   -annual_sales_amount, record),
	                            #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
													    source, 
													    source_docid
													   );

  // Transforms for the final iesp Finance Section layouts
	//
  // transform to handle "Source" child dataset
	iesp.topbusiness_share.t_TopBusinessSourceDocInfo
	  tf_rpt_source(FinanceSection_Layouts.rec_ids_withdata_slimmed  l) := transform
		self.BusinessIds := l, // to store all linkids
    self.IdType      := //depends upon source 
		                    if(l.source=MDR.sourceTools.src_DCA,Constants.enterprisenumber,
												   if(l.source=MDR.sourceTools.src_EBR,Constants.filenumber,
													    '')),  // otherwise SheilaGreco, but no SG has no specific id field
		self.IdValue     := l.source_docid,
		self.Section     := Constants.FinanceSectionName,
		self.Source      := l.source,
		self := [],
  end;

  // Project onto the iesp report detail layout.
	FinanceSection_Layouts.rec_ids_plus_FinanceDetail
	  tf_rptdetail(FinanceSection_Layouts.rec_ids_withdata_slimmed l) := transform
     self.SourceDocs 	:= project(l,tf_rpt_source(left)),
	   self.AnnualSales := (string) l.annual_sales_amount,
		 self.SalesDate   := iesp.ECL2ESP.toDate(l.sales_as_of_date);
		 self             := l, // to preserve all ids
	end;

  ds_recs_rptdetail := project(ds_finrecs_deduped,tf_rptdetail(left));

	ds_recs_rptdetail tf_rptdetail_denormed(FinanceSection_Layouts.rec_ids_plus_FinanceDetail l, 
																					dataset(iesp.topbusiness_share.t_TopBusinessSourceDocInfo) r) := transform
		self.SourceDocs := choosen(r, iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
		self := l;
	end;
	
	// Add all the source docs.
  ds_recs_rptdetail_denormed := Denormalize(ds_recs_rptdetail, ds_recs_rptdetail.SourceDocs,
																						left.ultid = right.businessids.ultid and
																						left.orgid = right.businessids.orgid and
																						left.seleid = right.businessids.seleid,
																						group,
																						tf_rptdetail_denormed(left,rows(right)));					

  // Sort/Group/Rollup all recs for each set of linkids.
  FinanceSection_Layouts.rec_ids_plus_FinanceSecRec tf_rollup_rptdetail(
	  FinanceSection_Layouts.rec_ids_plus_FinanceDetail l,
	  dataset(FinanceSection_Layouts.rec_ids_plus_FinanceDetail) allrows) := transform
      self.acctno   := '';  // just null out here; it will be assigned in a join below
		  self.Finances := choosen(project(allrows,
		                                   transform(iesp.topbusinessReport.t_topBusinessFinance, 
														             self := left)),
															 iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_FINANCE_RECORDS);	
		  self          := l; // to preserve all ids
	end;
	
	ds_all_rptdetail_grouped := group(sort(ds_recs_rptdetail_denormed,
	                                       #expand(BIPV2.IDmacros.mac_ListTop3Linkids()),
																				  -SalesDate, 
																          -(INTEGER)AnnualSales,
																				 record),
	                                  #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																		);
																		
  ds_all_rptdetail_rolled := rollup(ds_all_rptdetail_grouped,
																    group,
																    tf_rollup_rptdetail(left,rows(left)));
																										

  // Attach input acctnos back to the linkids
  ds_all_wacctno_joined := join(ds_in_ids_wacctno,ds_all_rptdetail_rolled,
                                  BIPV2.IDmacros.mac_JoinTop3Linkids(),
														    transform(FinanceSection_Layouts.rec_ids_plus_FinanceSecRec,
														      self.acctno := left.acctno,
															    self        := right),
														    left outer); // 1 out rec for every left (input ds) rec
															 
	ds_final_results := project(ds_all_wacctno_joined,
		                         transform(FinanceSection_Layouts.rec_Final,
			                         self := left));								 
															 
  // Uncomment for debugging
  // output(ds_in_ids_wacctno,           named('ds_in_ids_wacctno'));
	// output(ds_in_ids_only,              named('ds_in_ids_only'));
	// output(ds_dca_keyrecs,              named('ds_dca_keyrecs'));
	// output(ds_dca_slimmed,              named('ds_dca_slimmed'));
	// output(ds_ebr_key5600recs,          named('ds_ebr_key5600recs'));
	// output(ds_ebr_slimmed,              named('ds_ebr_slimmed'));
	// output(ds_ebr_deduped,              named('ds_ebr_deduped'));
	// output(ds_sg_keyrecs,               named('ds_sg_keyrecs'));
  // output(ds_sg_keyrecs_wsales,        named('ds_sg_keyrecs_wsales'));
	// output(ds_sg_slimmed,               named('ds_sg_slimmed'));
  // output(ds_finrecs_all,              named('ds_finrecs_all'));	
  // output(ds_finrecs_deduped,          named('ds_finrecs_deduped'));
  // output(ds_recs_rptdetail,           named('ds_recs_rptdetail'));
	// output(ds_recs_rptdetail_denormed,  named('ds_recs_rptdetail_denormed'));
  // output(ds_all_rptdetail_grouped,    named('ds_all_rptdetail_grouped'));
  // output(ds_all_rptdetail_rolled,     named('ds_all_rptdetail_rolled'));
  // output(ds_all_wacctno_joined,       named('ds_all_wacctno_joined'));
	// output(ds_final_results,            named('ds_final_results'));

	return ds_final_results;

 end; //end of FullView function

END; //end of module

/*  to test, in a builder window use this: 
IMPORT AutoStandardI;

  // Report section input options.  
	// Just 2 booleans for now: lnbranded and internal_testing
  ds_options := dataset([{false, false}],topbusiness_services.Layouts.rec_input_options);

  // Report section input params.  
	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '000' : stored('DataRestrictionMask'); //pos 3=0 to use EBR
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

fin_sec := TopBusiness_Services.FinanceSection.fn_FullView(
             dataset([{
                      //{'dca1d', 0, 0, 0, 0, 28, 28, 28}
                      //{'ebr1da', 0, 0, 0, 0, 8, 8, 8},
                      //{'ebr1db', 0, 0, 0, 0, 1, 1, 1}
                      //{'ebr3d', 0, 0, 0, 0, 7739, 7739, 7739}
                      //{'ebr4d', 0, 0, 0, 0, 22443, 22443, 22443}
                      //{'ebr5p', 0, 0, 0, 0, 11085450, 11085450, 11085450} //bug 123769
                      //{'ebr6p', 0, 0, 0, 0, 9596, 9596, 9596} //bug 133469
                      //{'ebr7p', 0, 0, 0, 0, 213, 213, 213} //revised sales_actual test1
                      //{'sg1d', 0, 0, 0, 0, 284086381, 284086381, 284086381}
                      //{'ebr8p', 0, 0, 0, 0, 10892, 10892, 10892} // bug 145560, ebr source doc issue?
                      //{'sg2dp', 0, 0, 0, 0, 3943, 3943, 3943} //sg sales amount w/decimals issue
                      //{'sg2bp', 0, 0, 0, 0, 94560, 94560, 94560} //sales amount w/decimals issue
                      //{'multi1p0', 0, 0, 0, 0, 46506520, 233, 233} // bug 155186 test case 0?, fix to output <SourceDocs> for all srcs/recs with fin data; ?? DCA, ?? EBR & ?? SG recs
                      //{'ebr9p', 0, 0, 0, 0, 4827787, 4827787, 4827787} // bug 155186 test case 1 GOOGLE INC., fix to output <SourceDoc> recs for all srcs/recs with fin data; linkids recs = 0 DCA, 35 EBR & 0 SG recs

                     ],topbusiness_services.Layouts.rec_input_ids)
 						,ds_options[1]
					  ,tempmod
           );
output(fin_sec);
*/
