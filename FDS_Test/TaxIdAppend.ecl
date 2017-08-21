import business_header,address,ut,versioncontrol,Business_Header_SS,did_add;

laybhb	:= business_header.Layout_bh_best							;
laybh		:= business_header.Layout_Business_Header_Base;

export TaxIdAppend(
	 string													pversion
	,dataset(Layouts.Input.PubRec	)	pSearchCriteria			= Files.Input.Pubrec
	,dataset(laybhb								)	pBusinessHeaderBest = business_header.files().base.business_header_best.qa
	,dataset(laybh								)	pBusinessHeader 		= business_header.files().base.business_headers.qa
	,boolean												pOverwrite					= false
	,boolean												pCsvout							= true
	,string													pSeparator					= '|'	

) :=
function

	dbhb_filter										:= pBusinessHeaderBest(			(fein				!= 0	) 
																										or	(			(prim_name	!= ''	)
																													or	(state			!= ''	)
																												)
																		);
	
	dbh_filter										:= pBusinessHeader(			(fein				!= 0	) 
																										or	(			(prim_name	!= ''	)
																													or	(state			!= ''	)
																												)
																		);
	
	Layouts.Response.TaxId_extract_temp tConvertBHB2Response(laybhb l,unsigned8 cnt) :=
	transform
		
		self.bdid												:= l.bdid;
		self.Extract.Record_ID				 	:= (string)cnt;
		self.Extract.Business_Name		 	:= stringlib.stringtouppercase(l.company_name);
		self.Extract.Street_Address		 	:= trim(Address.Addr1FromComponents(
																				 l.prim_range
																				,l.predir
																				,l.prim_name
																				,l.addr_suffix
																				,l.postdir				
																				,'',''
																			),left,right);
		self.Extract.Secondary_Address 	:= trim(Address.Addr1FromComponents(
																				 l.unit_desig
																				,l.sec_range	
																				,''
																				,''
																				,''
																				,''
																				,''
																			),left,right);
		self.Extract.City							 	:= l.city;
		self.Extract.State						 	:= l.state;
		self.Extract.Zip_Code					 	:= if(l.zip != 0,intformat(l.zip,5,1),'');
		self.Extract.phone						 	:= if(l.phone != 0,(string)l.phone,'');
		self.Extract.tax_ID 					 	:= if(l.fein != 0	,intformat(l.fein,9,1), '');
		self.Extract.last_report_date		:= if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen),8,1),'');
		self.clean_address.prim_range		:= l.prim_range		;
		self.clean_address.predir				:= l.predir				;
		self.clean_address.prim_name		:= l.prim_name		;
		self.clean_address.addr_suffix	:= l.addr_suffix	;
		self.clean_address.postdir			:= l.postdir			;
		self.clean_address.unit_desig		:= l.unit_desig		;
		self.clean_address.sec_range		:= l.sec_range		;
		self.clean_address.v_city_name	:= l.city					;
		self.clean_address.st						:= l.state				;
		self.clean_address.zip					:= intformat(l.zip,5,1);
		self.clean_address							:= [];
	end;

	Layouts.Response.TaxId_extract_temp tConvertBH2Response(laybh l,unsigned8 cnt) :=
	transform
		
		self.bdid												:= l.bdid;
		self.Extract.Record_ID				 	:= (string)cnt;
		self.Extract.Business_Name		 	:= stringlib.stringtouppercase(l.company_name);
		self.Extract.Street_Address		 	:= trim(Address.Addr1FromComponents(
																				 l.prim_range
																				,l.predir
																				,l.prim_name
																				,l.addr_suffix
																				,l.postdir				
																				,'',''
																			),left,right);
		self.Extract.Secondary_Address 	:= trim(Address.Addr1FromComponents(
																				 l.unit_desig
																				,l.sec_range	
																				,''
																				,''
																				,''
																				,''
																				,''
																			),left,right);
		self.Extract.City							 	:= l.city;
		self.Extract.State						 	:= l.state;
		self.Extract.Zip_Code					 	:= if(l.zip != 0,intformat(l.zip,5,1),'');
		self.Extract.phone						 	:= if(l.phone != 0,(string)l.phone,'');
		self.Extract.tax_ID 					 	:= if(l.fein != 0	,intformat(l.fein,9,1), '');
		self.Extract.last_report_date		:= if(l.dt_last_seen != 0, intformat(ut.Date_MMDDYYYY_i2((string)l.dt_last_seen),8,1),'');
		self.clean_address.prim_range		:= l.prim_range		;
		self.clean_address.predir				:= l.predir				;
		self.clean_address.prim_name		:= l.prim_name		;
		self.clean_address.addr_suffix	:= l.addr_suffix	;
		self.clean_address.postdir			:= l.postdir			;
		self.clean_address.unit_desig		:= l.unit_desig		;
		self.clean_address.sec_range		:= l.sec_range		;
		self.clean_address.v_city_name	:= l.city					;
		self.clean_address.st						:= l.state				;
		self.clean_address.zip					:= intformat(l.zip,5,1);
		self.clean_address							:= [];
	end;

	Layouts.Response.TaxId_Pubrec_temp tCleanPubrecAddress(Layouts.Input.PubRec l) :=
	transform

	  clean_address := address.CleanAddressParsed(
				trim(l.address,left,right) 
			+ ' '
			+ trim(l.secondary_address,left,right)
			,				trim(l.city			,left,right) 
			+ ' ' + trim(l.state		,left,right)
			+ ' ' + trim(l.zip_code	,left,right)
		);

		self								:= l;
		self								:= clean_address.addressrecord;
		self.bdid						:= 0;
		self.bdid_score			:= 0;

		
	end;

	dbhbresponse	:= project(dbhb_filter			,tConvertBHB2Response	(left,counter	));
	dbhresponse		:= project(dbh_filter				,tConvertBH2Response	(left,counter	));
	dpubrecclean	:= project(pSearchCriteria	,tCleanPubrecAddress	(left					));

	SearchCriteria_withtaxid 			:= dpubrecclean.Tax_ID_Number	!= '';
	SearchCriteria_withNameAddr		:= dpubrecclean.Business_Name 	!= ''	and dpubrecclean.Address != '';
	SearchCriteria_withNameState	:= dpubrecclean.Business_Name 	!= ''	and dpubrecclean.state 	!= '';

	pSearchCriteria_withtaxid 		:= dpubrecclean(SearchCriteria_withtaxid															);
	pSearchCriteria_withNameAddr	:= dpubrecclean(not SearchCriteria_withtaxid,SearchCriteria_withNameAddr);
	pSearchCriteria_withNameState	:= dpubrecclean(not SearchCriteria_withtaxid,not SearchCriteria_withNameAddr,SearchCriteria_withNameState);
	
	setSearchCriteria_withtaxid := set(pSearchCriteria_withtaxid		,Tax_ID_Number);
	setSearchCriteria_withState := set(pSearchCriteria_withNameState,trim(stringlib.stringtouppercase(state),left,right));
	
	pSearchCriteria_other					:= project(
		dpubrecclean(not SearchCriteria_withtaxid,not SearchCriteria_withNameAddr,not SearchCriteria_withNameState)
		,transform(
			{Layouts.Response.TaxId_Append_temp}
			,self.searchcriteria 	:= left	;
			 self									:= []		;
		)
	);
	
	pAllSearchCriteria						:= 
			pSearchCriteria_withtaxid 		
		+ pSearchCriteria_withNameAddr	
		+ pSearchCriteria_withNameState	
		 : persist('~thor_data400::persist::fds_test::taxidappend::pAllSearchCriteria');;
	
	dbhbresponse_withfein 			:= dbhbresponse(Extract.tax_ID	in setSearchCriteria_withtaxid);
	dbhbresponse_withaddr 			:= dbhbresponse(Extract.Street_Address	!= '');
	dbhbresponse_withstate 			:= dbhbresponse(Extract.State		in setSearchCriteria_withState);

	dbhresponse_withfein 				:= dbhresponse(Extract.tax_ID in setSearchCriteria_withtaxid);
	dbhresponse_withaddr 				:= dbhresponse(Extract.Street_Address		!= '');
	dbhresponse_withstate 			:= dbhresponse(Extract.State	in setSearchCriteria_withState);

	// match on fein--using bdid macro will not work since they do not provide a business name for this search, only fein
	
	// -- TaxId Match
	pSearchCriteria_withtaxid_withBdid := join(
		 distribute(dbhbresponse_withfein			,hash((unsigned8)Extract.tax_id	))
		,distribute(pSearchCriteria_withtaxid	,hash((unsigned8)Tax_ID_Number	))
		,(unsigned8)left.Extract.tax_id = (unsigned8)right.Tax_ID_Number
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= right				;
			 self.Appended_data.record_id		:= right.record_id	;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		)
		,hash
	);
	
	dresponse_taxid_nomatch := join(
		 distribute(dbhbresponse_withfein			,hash((unsigned8)Extract.tax_id	))
		,distribute(pSearchCriteria_withtaxid	,hash((unsigned8)Tax_ID_Number	))
		,(unsigned8)left.Extract.tax_id = (unsigned8)right.Tax_ID_Number
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= right				;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		)
		,right only
		,hash
	);

	pSearchCriteria_withtaxid_withBdid2 := join(
		 distribute(dbhresponse_withfein		,hash((unsigned8)Extract.tax_id								))
		,distribute(dresponse_taxid_nomatch	,hash((unsigned8)SearchCriteria.Tax_ID_Number	))
		,(unsigned8)left.Extract.tax_id = (unsigned8)right.SearchCriteria.Tax_ID_Number
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= right.Searchcriteria	;
			 self.Appended_data.record_id		:= right.Searchcriteria.record_id	;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		)
		,hash
	);

	dresponse_taxid_nomatch2 := join(
		 distribute(dresponse_taxid_nomatch							,hash((unsigned8)SearchCriteria.record_id	))
		,distribute(pSearchCriteria_withtaxid_withBdid2	,hash((unsigned8)SearchCriteria.record_id	))
		,(unsigned8)left.SearchCriteria.record_id = (unsigned8)right.SearchCriteria.record_id
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= left.Searchcriteria	;
			 self.Appended_data		:= []	;
			 self.bdid						:= 0	;
			 self.bdid_score			:= 0	;
		)
		,left only
		,hash
	);

	// -- Name Address Match
	BdidMatchset2		:= ['A'];

	Business_Header_SS.MAC_Add_BDID_Flex(
		 pSearchCriteria_withNameAddr					// Input Dataset						
		,BdidMatchset2                       	// BDID Matchset what fields to match on           
		,Business_Name	        							// company_name	              
		,prim_range		                        // prim_range		              
		,prim_name		                        // prim_name		              
		,zip					                        // zip5					              
		,sec_range		                        // sec_range		              
		,st						                        // state				              
		,''						                        // phone				              
		,Tax_ID_Number        								// fein              
		,bdid													        // bdid												
		,Layouts.Response.TaxId_Pubrec_temp   // Output Layout 
		,true	                             		// output layout has bdid score field?                       
		,bdid_score                           // bdid_score                 
		,pSearchCriteria_withNameAddr_withBdid// Output Dataset                   
		,75																		// score_threshold
//		,'prod'															// pFileVersion
//		,true																// puseotherenvironment
	);                                         
	
	fgetname_state(
		 string pbusiness_name
		,string pstate
		,dataset(layouts.response.PubRec_name_state) pNameState = project(pSearchCriteria_withNameState, transform(layouts.response.PubRec_name_state, self := left))
	) :=
	function
	
		lfilter := ut.CompanySimilar100(ut.CleanCompany(stringlib.stringtouppercase(pbusiness_name					))
																	, ut.CleanCompany(stringlib.stringtouppercase(pNameState.Business_name))
								) <= 10
		and trim(stringlib.stringtouppercase(pstate),left,right)	= trim(stringlib.stringtouppercase(pNameState.state),left,right)
		;
		
		dfilter := pNameState(lfilter);
		
		return dfilter[1];
	
	end;
/*
	pSearchCriteria_withNameState_withBdid := project(
		 dbhbresponse_withstate
		,transform(
		 	 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= fgetname_state(left.Extract.Business_name,left.clean_address.st);
			 self.SearchCriteria	:= []						;
			 self.Appended_data.record_id		:= self.Searchcriteria.record_id	;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		
		)
	)(SearchCriteria.Business_name != '');

	
	);
*/
	// -- Business Name, State match
	pSearchCriteria_withNameState_withBdid := join(
		 dbhbresponse_withstate				
		,project(pSearchCriteria_withNameState, transform(layouts.response.PubRec_name_state, self := left))
		,ut.CompanySimilar100(ut.CleanCompany(stringlib.stringtouppercase(left.Extract.Business_name)), ut.CleanCompany(stringlib.stringtouppercase(right.Business_name))) <= 10
		and trim(stringlib.stringtouppercase(left.clean_address.st),left,right)	= trim(stringlib.stringtouppercase(right.state),left,right)
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= right				;
			 self.SearchCriteria	:= []						;
			 self.Appended_data.record_id		:= right.record_id	;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		)
		,lookup
	): persist('~thor_data400::persist::fds_test::taxidappend::pSearchCriteria_withNameState_withBdid');
	
	dresponse_state_nomatch := join(
		 pSearchCriteria_withNameState					
		,pSearchCriteria_withNameState_withBdid	
		,	left.record_id = right.searchcriteria.record_id
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= left									;
			 self.Appended_data.record_id		:= left.record_id	;
			 self.Appended_data		:= right.appended_data	;
			 self.bdid						:= left.bdid						;
			 self.bdid_score			:= 0										;
		)
		,left only
	);
/*
	// last resort, match to real business headers
	pSearchCriteria_withNameState_withBdid2 := project(
		 dbhresponse_withstate
		,transform(
		 	 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= fgetname_state(left.Extract.Business_name,left.clean_address.st,project(dresponse_state_nomatch, transform(layouts.response.PubRec_name_state, self := left.SearchCriteria)));
			 self.SearchCriteria	:= []						;
			 self.Appended_data.record_id		:= self.Searchcriteria.record_id	;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		
		)
	)(SearchCriteria.Business_name != '');
*/
	pSearchCriteria_withNameState_withBdid2 := join(
		 dbhresponse_withstate		
		,project(dresponse_state_nomatch, transform(layouts.response.PubRec_name_state, self := left.SearchCriteria))
		,	ut.CompanySimilar100(ut.CleanCompany(stringlib.stringtouppercase(left.Extract.Business_name)), ut.CleanCompany(stringlib.stringtouppercase(right.Business_name))) <= 10
		and trim(stringlib.stringtouppercase(left.clean_address.st),left,right)				= trim(stringlib.stringtouppercase(right.state),left,right)
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= right				;
			 self.SearchCriteria	:= []						;
			 self.Appended_data.record_id		:= self.Searchcriteria.record_id	;
			 self.Appended_data		:= left.Extract	;
			 self.bdid						:= left.bdid		;
			 self.bdid_score			:= 0						;
		)
		,lookup
	): persist('~thor_data400::persist::fds_test::taxidappend::pSearchCriteria_withNameState_withBdid2');

	dresponse_state_nomatch2 := join(
		 distribute(dresponse_state_nomatch									,hash(trim(stringlib.stringtouppercase(searchcriteria.record_id	))))
		,distribute(pSearchCriteria_withNameState_withBdid2	,hash(trim(stringlib.stringtouppercase(searchcriteria.record_id	))))
		,	left.searchcriteria.record_id = right.searchcriteria.record_id
		,transform(
			 Layouts.Response.TaxId_Append_temp
			,self.SearchCriteria	:= left.searchcriteria	;
			 self.Appended_data.record_id		:= left.Searchcriteria.record_id	;
			 self.Appended_data		:= right.appended_data	;
			 self.bdid						:= left.bdid						;
			 self.bdid_score			:= 0										;
		)
		,left only
		,local
	);

	// get append info for name addr matches
	dgetbhinfo1 := join(
		 distribute(dbhbresponse																		,bdid)
		,distribute(pSearchCriteria_withNameAddr_withBdid(bdid != 0),bdid)
		,left.bdid = right.bdid
		,transform(
			{Layouts.Response.TaxId_Append_temp}
			,self.SearchCriteria	:= right;
			 self.Appended_data.record_id		:= self.Searchcriteria.record_id	;
			 self.Appended_data		:= left.extract;
			 self.bdid						:= right.bdid;
			 self.bdid_score			:= right.bdid_score;
		)
		,right outer
		,hash
	)
	+ project(pSearchCriteria_withNameAddr_withBdid(bdid = 0)
		,transform(Layouts.Response.TaxId_Append_temp, self.searchcriteria := left, self := [])
	)
	: persist('~thor_data400::persist::fds_test::taxidappend::NameAddrAppendMatches');


	dgetbhinfo2 := pSearchCriteria_withNameState_withBdid + pSearchCriteria_withNameState_withBdid2 
		: persist('~thor_data400::persist::fds_test::taxidappend::NameStateAppendMatches');

	dgetbhinfo3 := dresponse_state_nomatch2
	: persist('~thor_data400::persist::fds_test::taxidappend::NameStateNoMatches');

	response_taxid_match	:= dgetbhinfo1.SearchCriteria.Tax_ID_Number	!= '' 																							and dgetbhinfo1.bdid != 0;
	response_addr_match		:= dgetbhinfo1.SearchCriteria.Business_Name != ''	and dgetbhinfo1.SearchCriteria.Address	!= '' and dgetbhinfo1.bdid != 0;
	response_state_match	:= dgetbhinfo2.SearchCriteria.Business_Name != ''	and dgetbhinfo2.SearchCriteria.state 		!= '' and dgetbhinfo2.bdid != 0;
  
	response_taxid_nomatch	:= dgetbhinfo1.SearchCriteria.Tax_ID_Number	!= '' 																							and dgetbhinfo1.bdid = 0;
	response_addr_nomatch		:= dgetbhinfo1.SearchCriteria.Business_Name != ''	and dgetbhinfo1.SearchCriteria.Address	!= '' and dgetbhinfo1.bdid = 0;
	response_state_nomatch	:= dgetbhinfo3.SearchCriteria.Business_Name != ''	and dgetbhinfo3.SearchCriteria.state 		!= '' and dgetbhinfo3.bdid = 0;

	dresponse_taxid_match		:= pSearchCriteria_withtaxid_withBdid + pSearchCriteria_withtaxid_withBdid2;
	dresponse_addr_match		:= dgetbhinfo1(not response_taxid_match,response_addr_match			);
	dresponse_state_match		:= dgetbhinfo2(response_state_match															);
  
//	dresponse_taxid_nomatch		:= dgetbhinfo1(	response_taxid_nomatch	);
	dresponse_addr_nomatch		:= dgetbhinfo1(	response_addr_nomatch		);
//	dresponse_state_nomatch		:= dgetbhinfo3(	response_state_nomatch	);
                                        
	dresponse_taxid_match_deduped			:= dedup(sort(dresponse_taxid_match		,SearchCriteria.Record_ID), SearchCriteria.Record_ID,keep 5);
	dresponse_nameaddr_match_deduped	:= dedup(sort(dresponse_addr_match		,SearchCriteria.Record_ID), SearchCriteria.Record_ID,keep 5);
	dresponse_namestate_match_deduped	:= dedup(sort(dresponse_state_match		,SearchCriteria.Record_ID), SearchCriteria.Record_ID,keep 5);

	dAll_matches := 
			dresponse_taxid_match_deduped			
		+ dresponse_nameaddr_match_deduped	
		+ dresponse_namestate_match_deduped	
		; 
	
	dAll_nomatches :=
			dresponse_taxid_nomatch2 
		+ dresponse_addr_nomatch 
		+ dgetbhinfo3
		;
	
	dAll_nomatches_proj := project(dAll_nomatches, transform(Layouts.Response.TaxId_append,self.SearchCriteria := left;self := [])) : persist('~thor_data400::persist::fds_test::taxidappend::dAll_nomatches_proj');

	dresponse					:= sort(dAll_matches + dAll_nomatches + pSearchCriteria_other, (unsigned8)SearchCriteria.Record_ID) : persist('~thor_data400::persist::fds_test::taxidappend');

	dresponse_reformat := project(dresponse	,transform(Layouts.Response.TaxId_Append, self := left));
	
	dresponse_ids			:= table(dresponse, {searchcriteria.Record_ID},searchcriteria.Record_ID,few);
	
	// -- Output File
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.TaxID_Append.new										,dresponse_reformat	,BuildResponseFile,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.TaxID_Append.new + 'PipeDelimited'	,dresponse_reformat	,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);

	// -- Stats
	dresponse_forstats := project(dresponse	,transform({Layouts.Response.TaxId_append,string stuff}, self := left;self.stuff := 'G'));
	
	layout_stat := 
	record
    integer countGroup := count(group);
		dresponse_forstats.stuff  ;
//		Record_ID_CountNonBlank          := sum(group,if(dresponse_forstats.Appended_data.Record_ID					<>'',1,0));
		Business_Name_CountNonBlank      := sum(group,if(dresponse_forstats.Appended_data.Business_Name			<>'',1,0));
		Street_Address_CountNonBlank     := sum(group,if(dresponse_forstats.Appended_data.Street_Address		<>'',1,0));
		Secondary_Address_CountNonBlank  := sum(group,if(dresponse_forstats.Appended_data.Secondary_Address	<>'',1,0));
		City_CountNonBlank               := sum(group,if(dresponse_forstats.Appended_data.City							<>'',1,0));
		State_CountNonBlank              := sum(group,if(dresponse_forstats.Appended_data.State							<>'',1,0));
		Zip_Code_CountNonBlank           := sum(group,if(dresponse_forstats.Appended_data.Zip_Code					<>'',1,0));
		phone_CountNonBlank              := sum(group,if(dresponse_forstats.Appended_data.phone							<>'',1,0));
		tax_ID_CountNonBlank             := sum(group,if(dresponse_forstats.Appended_data.tax_ID 						<>'',1,0));
		last_report_date_CountNonBlank   := sum(group,if(dresponse_forstats.Appended_data.last_report_date	<>'',1,0));
                                                                       
	end;
	
	dresponse_fill_stats := table(dresponse_forstats, layout_stat, stuff,few);

	// -- match rates
	countpSearchCriteria			:= count(pSearchCriteria						);
	countpAllSearchCriteria		:= count(pAllSearchCriteria					);
	countdAll_nomatches				:= count(dAll_nomatches_proj				);
	
	countpSearchCriteria_withtaxid 			:= count(pSearchCriteria_withtaxid 			);
	countpSearchCriteria_withNameAddr		:= count(pSearchCriteria_withNameAddr		);
	countpSearchCriteria_withNameState	:= count(pSearchCriteria_withNameState	);
	countpSearchCriteria_other					:= count(pSearchCriteria_other					);
	
	countdresponse_taxid_nomatch				:= count(dresponse_taxid_nomatch2				);
	countdresponse_addr_nomatch					:= count(dresponse_addr_nomatch					);
	countdresponse_state_nomatch				:= count(dgetbhinfo3										);
	
	matchrate 					:= (real8)(countpAllSearchCriteria - countdAll_nomatches) / (real8)countpAllSearchCriteria * 100.0;
	
	matchrate_taxid 		:= (real8)(countpSearchCriteria_withtaxid			- countdresponse_taxid_nomatch) / (real8)countpSearchCriteria_withtaxid			* 100.0;
	matchrate_nameaddr 	:= (real8)(countpSearchCriteria_withNameAddr	- countdresponse_addr_nomatch	) / (real8)countpSearchCriteria_withNameAddr	* 100.0;
	matchrate_namestate := (real8)(countpSearchCriteria_withNameState - countdresponse_state_nomatch) / (real8)countpSearchCriteria_withNameState	* 100.0;
	
	return parallel(
		 output('FDS Append Results Follow'		,named('_'																		))
		,BuildResponseFile
		,BuildResponseFilePipe
		,output(countpSearchCriteria							,named('FDS_Search_File_Record_Count'					))
		,output(countpAllSearchCriteria						,named('FDS_Search_File_With_Search_Criteria'	))
		,output(countpSearchCriteria_withtaxid 		,named('FDS_Search_File_With_TaxId'						))
		,output(countpSearchCriteria_withNameAddr	,named('FDS_Search_File_With_Name_Address'		))
		,output(countpSearchCriteria_withNameState,named('FDS_Search_File_With_Name_State'			))
		,output(countpSearchCriteria_other				,named('FDS_Search_File_Other'								))
		,output(dresponse_fill_stats							,named('Appended_fields_fill_Rates'						))
		,output(count(dresponse_ids)							,named('Response_record_ids_double_check'			))
		,output(countdAll_nomatches								,named('FDS_Records_Not_Matched'							))
		,output(countdresponse_taxid_nomatch			,named('FDS_Taxid_Records_Not_Matched'				))
		,output(countdresponse_addr_nomatch				,named('FDS_Name_Addr_Records_Not_Matched'		))
		,output(countdresponse_state_nomatch			,named('FDS_Name_State_Records_Not_Matched'		))
		,output(matchrate													,named('Percentage_Match_Rate_All'						))
		,output(matchrate_taxid 									,named('Percentage_Match_Rate_Taxid'					))
		,output(matchrate_nameaddr 								,named('Percentage_Match_Rate_Name_Address'		))
		,output(matchrate_namestate 							,named('Percentage_Match_Rate_Name_State'			))
		,output(dresponse_taxid_nomatch2					,named('dresponse_taxid_nomatch2'							))
		,output(dresponse_addr_nomatch						,named('dresponse_addr_nomatch'								))
		,output(dgetbhinfo3												,named('dresponse_state_nomatch'							))
	);                                          

end;