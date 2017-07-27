import TopBusiness, iesp, AutoStandardI, MDR, BIPV2, TopBusiness_Services;
       
EXPORT URLSection := MODULE;
									
EXPORT fn_fullview(	
	dataset(TopBusiness_Services.Layouts.rec_input_ids) ds_in_data,	
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod,
	dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_busHeaderRecs 
	) := FUNCTION
	
	// Get the raw data just use URL's from bus header.
	
	FETCH_LEVEL := in_options.BusinessReportFetchLevel;
	 
	 ds_header_urls := project(ds_busHeaderRecs,
	              transform(TopBusiness_Services.URLSection_Layouts.URLRecord_plusLinkids,
								   self.source := left.source;
									 self.source_docid := (string50) left.vl_id; 
									 // self.acctno := left.acctno;
									 self.url := left.company_url;									 	                 												 			 				 		
                   tmpurl := left.company_url;
									 SlashPosition := stringlib.stringfind(tmpurl,'/',1);	
									 self.cleanurl := if (tmpurl <> '' and SlashPosition > 1,  tmpUrl[1..slashPosition-1],
			                                    tmpUrl);																														
									 self := left));														
	
	slim_sorted_raw_data := project(ds_header_urls,	                              
															  transform({string76 slim_url; recordof(left);},	
															 // only need to do the move to uppercase in one place.
                             tmpurl := stringlib.StringToUpperCase(left.cleanurl);
														SlashPosition := stringlib.stringfind(tmpurl,'/',1);	
														self.cleanurl := if (tmpurl <> '' and SlashPosition > 1,  tmpUrl[1..slashPosition-1],
			                                    tmpUrl);															 
	                          self.slim_url := if (trim(tmpurl, left, right)[1..4]='WWW.',tmpurl[5..length(tmpurl)], tmpurl);
														self := left
													));
   													
	// sort so that any rows with a url in them bubble to the top and
	// null string slim_url fields sort to the bottom
	sorted_raw_data_dedup := dedup(dedup(sort(slim_sorted_raw_data(slim_url <> '' and source <>  MDR.sourceTools.src_Dunn_Bradstreet), #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
	                                                      , -slim_url,record),
	                                                 #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
																								,slim_url), 
																all, except source, source_DocID, url, cleanurl,dotid,empid,powid);
																

   TopBusiness_Services.URLSection_Layouts.rec_URLRecord_plusdetails  url_rollup_rptdetail(
																									recordof(sorted_raw_data_dedup) l,
																								  dataset(recordof(sorted_raw_data_dedup)) allrows) := transform
					 
					   self.urls := choosen(project(allrows,transform(iesp.topbusinessReport.t_TopbusinessURL, 
			         self.url := left.slim_url;)),iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_URL_RECORDS);	
						 self.UrlrecordCount := count(allrows(url <> ''));
						 self.sourceDocs := if (count(allrows(url <> '' and source <> MDR.sourceTools.src_Dunn_Bradstreet)) > 0, 
						             choosen(project(allrows(source <> MDR.sourceTools.src_Dunn_Bradstreet), transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo,
												 isDNBDMIRow := MDR.sourceTools.SourceIsDunn_Bradstreet(left.source);
									self.businessIDs.dotid := if (not (isDNBDMIRow), left.dotid, 0);
									self.businessIDs.powid := if (not (isDNBDMIRow), left.powid, 0);
									self.businessIDs.empid := if (not  (isDNBDMIRow), left.empid, 0);															
								  self.businessIDs.proxid := if ( not (isDNBDMIRow), left.proxid, 0);		
									self.businessIDs.seleid := if (not (isDNBDMIRow), left.seleid, 0);
								  self.businessIDs.orgid := if (not (isDNBDMIRow), left.orgid, 0);
								  self.businessIDs.ultid := if (not  (isDNBDMIRow), left.ultid, 0);
									self.address := [];
									self.name := [];
									self.IdType := if (not  (isDNBDMIRow), 'vl_id', '');
									self.IdValue := if (not  (isDNBDMIRow), left.source_docid, '');
									self.Section := if (not  (isDNBDMIRow), topBusiness_services.constants.URLSectionName, '');
									self.Source := left.source;			
				          )), iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)
									);
								self := l; // this covers ultid, orgid, seleid etc...
						end;	
					 
         ds_all_grouped := group(sort(sorted_raw_data_dedup, 
				                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
														 ),   
				                     #expand(BIPV2.IDmacros.mac_ListTop3Linkids())
														 );
														 
					  ds_all_rptdetail_rolled := rollup(ds_all_grouped,
																     group,
																     url_rollup_rptdetail(left,rows(left)));
	
	// now add the account # back into the mix and ensure that a left outer join is done.

	ds_final_results := join(ds_in_data, ds_all_rptdetail_rolled,	                                          
	                                    	 BIPV2.IDmacros.mac_JoinTop3Linkids(),																			
																			 transform(TopBusiness_Services.URLSection_Layouts.rec_Final,																			          
                                         self.acctno := left.acctno;
																				 self := right), 
																				left outer);					
	 	
	// output(ds_urls_rawBusHeader, named('ds_urls_rawBusHeader'));
	 // output(ds_in_data, named('ds_in_data'));
	 // output(ds_header_urls, named('ds_header_urls'));
	
	// output(slim_sorted_raw_data, named('slim_sorted_raw_data'));
	
	// output(sorted_raw_data_dedup, named('sorted_raw_data_dedup'));
  // output(ds_all_grouped, named('ds_all_grouped'));
	// output(ds_all_rptdetail_rolled , named('ds_all_rptdetail_rolled'));
	
	 // output(ds_final_results, named('final_results'));
	return ds_final_results;
 end; // function
 
end; // module

