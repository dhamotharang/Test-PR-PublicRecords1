import Statistics, versioncontrol, address, corp2, paw;
export fStatistics :=
module

	export business_headers(
	
		 dataset(Layout_Business_Header_Base) 						pBh										= files().base.business_headers.built
		,dataset(Layout_Business_Header_Base) 						pBh_father						= files().base.business_headers.qa
		,string																						pversion
		,unsigned8																				pmax_rcid							= max_rcid()
		,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps				= PAW.fCorpInactives()
		,dataset(Layout_Business_Header_Temp						)	pBH_Basic_Match_FEIN	= persists().BHBasicMatchFEIN
		,dataset(Layout_Business_Header_Temp						)	pBH_Basic_Match_SALT	= persists().BHBasicMatchSALT
		,dataset(Layout_Business_Header_Temp						)	pBH_Match_Init				= persists().BHMatchInit
		,dataset(Layout_SIC_Code												) pSic_Code							= Persists().BHBDIDSIC								
	
	) := 
	function

//unique new bdids
//bdids per address
//one record bdids
		lay_bh_address :=
		record
			Layout_Business_Header_Base;
			string200 address;
		end;
		
		InactiveCorpsBdids := project(pInactiveCorps, transform({unsigned6 bdid}, self := left));
		
		Bh := project(pbh, transform(lay_bh_address, self := left;
						self.address := trim(stringlib.stringtolowercase(
														Address.Addr1FromComponents(left.prim_range, left.predir, left.prim_name,
                         left.addr_suffix, left.postdir, left.unit_desig, left.sec_range) 
						+ ' ' + Address.Addr2FromComponents(left.city, left.state, intformat(left.zip,5,1))))));



		new_bdids							:= Bh(bdid > pmax_rcid);
		dold_bdids						:= Bh(bdid <= pmax_rcid);
		
		find_one_record_bdids	:= table(Bh, {bdid, unsigned8 cnt := count(group)}, bdid)(cnt = 1);
		one_record_bdids			:= join( Bh										
																	,find_one_record_bdids
																	,left.bdid = right.bdid
																	,transform(lay_bh_address, self := left)
//																	,local
															);

		one_year_ago := (unsigned4)((string)((unsigned)pversion[1..4] - 1) + pversion[5..]);
		find_old_bdids	:= table(Bh, {bdid, unsigned4 dt_last_seen := max(group, dt_last_seen)}, bdid)(dt_last_seen < one_year_ago);
															
		multiple_record_bdids		:= join( 
																	 Bh										
																	,find_one_record_bdids
																	,left.bdid = right.bdid
																	,transform(lay_bh_address, self := left)
//																	,local
																	,left only
															);
		active_businesses := join(multiple_record_bdids
														,InactiveCorpsBdids
														,left.bdid = right.bdid
														,transform(lay_bh_address, self := left)
//														,local
														,left only
												);
					
		good_businesses := join( sort(distribute(active_businesses, bdid), bdid, local)
														,sort(distribute(find_old_bdids, bdid), bdid, local)
														,left.bdid = right.bdid
														,transform(lay_bh_address, self := left)
//														,local
														,left only
														,local
												);

		//find total new rcids
		//rcids lost 
		//rcids 
		new_rcids							:= Bh(rcid > pmax_rcid);
		old_rcids							:= Bh(rcid <= pmax_rcid);
		
		//find old rcids
		//so, want to find out number of bdid collapses, but already know this from SALT
		//number of old rcids lost
		//number of new rcids
		
		dSALTCollapsedBdids	:= 
		join(
			 distribute(table(pBH_Basic_Match_SALT, {bdid}, bdid), bdid)
			,distribute(table(pBH_Basic_Match_FEIN, {bdid}, bdid), bdid)
			,left.bdid = right.bdid
			,transform({unsigned6 bdid}, self.bdid := right.bdid)
			,local
			,right only
		);
		
		dNonSaltCollapses := join(
			 distribute(table(pbh_father, {bdid}, bdid), bdid)
			,distribute(table(pBH_Basic_Match_FEIN(bdid <= pmax_rcid), {bdid}, bdid), bdid)
			,left.bdid = right.bdid
			,transform({unsigned6 bdid}, self.bdid := left.bdid)
			,local
			,left only
		);
		
		dFindRcidsInCommon := join(
			 distribute(table(pbh, {rcid, bdid}, rcid, bdid), rcid)
			,distribute(table(pBH_Match_Init, {rcid, bdid}, rcid, bdid), rcid)
			,left.rcid = right.rcid
			,transform({unsigned6 bdid, unsigned6 rcid}, self := left)
			,local
		);

		dAllCollapses := join(
			 distribute(dFindRcidsInCommon, rcid)
			,distribute(table(pBH_Match_Init, {rcid, bdid}, rcid, bdid), rcid)
			,left.rcid = right.rcid
			and left.bdid = right.bdid
			,transform({unsigned6 bdid, unsigned6 rcid}, self := left)
			,local
			,left only
		);
	

		Statistics.mac_one_Field_Stats(dSALTCollapsedBdids	, 'business_header','Business Header Base SALT Collapsed Bdids'	,pversion,bdid	,'bdid'	,'integer',SALT_collapsed_bh_bdid_one_field_stats							);
		Statistics.mac_one_Field_Stats(dAllCollapses				, 'business_header','Business Header Base All Collapsed Bdids'	,pversion,bdid	,'bdid'	,'integer',all_collapsed_bh_bdid_one_field_stats					);
		Statistics.mac_one_Field_Stats(new_bdids						, 'business_header','Business Header Base New Bdids'			,pversion,bdid	,'bdid'	,'integer',new_bh_bdid_one_field_stats											);
		Statistics.mac_one_Field_Stats(find_one_record_bdids, 'business_header','Business Header Base Orphan Bdids'		,pversion,bdid	,'bdid'	,'integer',orphan_bh_bdid_one_field_stats										);
		Statistics.mac_one_Field_Stats(good_businesses			, 'business_header','Business Header Base Good Businesses',pversion,bdid	,'bdid'	,'integer',Good_bh_bdid_one_field_stats											);

		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,bdid											,'bdid'											,'integer',bh_bdid_one_field_stats											);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,source										,'source'										,'string'	,bh_source_one_field_stats										,true);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,source_group							,'source_group'							,'string'	,bh_source_group_one_field_stats							);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,vendor_id								,'vendor_id'								,'string'	,bh_vendor_id_one_field_stats								);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,dt_first_seen						,'dt_first_seen'						,'integer',bh_dt_first_seen_one_field_stats						);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,dt_last_seen							,'dt_last_seen'							,'integer',bh_dt_last_seen_one_field_stats							);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,dt_vendor_first_reported	,'dt_vendor_first_reported'	,'integer',bh_dt_vendor_first_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,dt_vendor_last_reported	,'dt_vendor_last_reported'	,'integer',bh_dt_vendor_last_reported_one_field_stats	);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,company_name							,'company_name'							,'string'	,bh_company_name_one_field_stats							);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,prim_name								,'prim_name'								,'string'	,bh_prim_name_one_field_stats								);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,city											,'city'											,'string'	,bh_city_one_field_stats											);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,state										,'state'										,'string'	,bh_state_one_field_stats										,true);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,zip											,'zip'											,'integer',bh_zip_one_field_stats											);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,phone										,'phone'										,'integer',bh_phone_one_field_stats										);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,fein											,'fein'											,'integer',bh_fein_one_field_stats											);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,current									,'current'									,'boolean',bh_current_one_field_stats									);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,dppa											,'dppa'											,'boolean',bh_dppa_one_field_stats											);
		Statistics.mac_one_Field_Stats(bh, 'business_header','Business Header Base',pversion,address									,'address'									,'string'	,bh_address_one_field_stats								);

		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,source										,'source'										,'string'		,false, true	,bh_bdid_source_two_fields_stats										);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,vendor_id	,'Vendor_id','string'		,source										,'source'										,'string'		,false, true	,bh_vendor_id_source_two_fields_stats								);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,fein				,'Fein'			,'integer'	,source										,'source'										,'string'		,false, true	,bh_Fein_source_two_fields_stats										);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,dppa				,'Dppa'			,'boolean'	,source										,'source'										,'string'		,false, true	,bh_Dppa_source_two_fields_stats										);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,current		,'Current'	,'boolean'	,source										,'source'										,'string'		,false, true	,bh_Current_source_two_fields_stats									);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,vendor_id								,'Vendor_id'								,'string'		,false, false	,bh_bdid_vendor_id_two_fields_stats									);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,phone										,'phone'										,'integer'	,false, false	,bh_bdid_phone_two_fields_stats											);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,fein											,'Fein'											,'integer'	,false, false	,bh_bdid_fein_two_fields_stats											);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,current									,'Current'									,'boolean'	,false, false	,bh_bdid_current_two_fields_stats										);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,dppa											,'Dppa'											,'boolean'	,false, false	,bh_bdid_dppa_two_fields_stats											);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,dt_vendor_first_reported	,'dt_vendor_first_reported'	,'integer'	,false, false	,bh_bdid_dt_vendor_first_reported_two_fields_stats	);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,dt_last_seen							,'dt_last_seen'							,'integer'	,false, false	,bh_bdid_dt_last_seen_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,bdid				,'Bdid'			,'integer'	,address								,'Address'								,'string'		,false, false	,bh_bdid_address_two_fields_stats									);
		Statistics.mac_two_Fields_Stats(bh, 'business_header','Business Header Base' ,pversion ,state			,'State'		,'string'		,source										,'source'										,'string'		,true	, true	,bh_state_source_two_fields_stats										);
                                                                                                                                                                                                        
		Statistics.mac_two_Fields_Stats(pSic_Code, 'business_header','Business Header Sic Codes' ,pversion ,bdid			,'bdid'		,'integer'		,source										,'source'										,'string'		,false	, true	,bhsicode_bdid_source_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pSic_Code, 'business_header','Business Header Sic Codes' ,pversion ,bdid			,'bdid'		,'integer'		,sic_code									,'sic_code'									,'string'		,false	, true	,bhsicode_bdid_siccode_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pSic_Code, 'business_header','Business Header Sic Codes' ,pversion ,source		,'source'	,'string'			,sic_code									,'sic_code'									,'string'		,true		, true	,bhsicode_source_siccode_two_fields_stats		);

		return
			salt_collapsed_bh_bdid_one_field_stats			
		+ all_collapsed_bh_bdid_one_field_stats	
		+ bh_bdid_one_field_stats										
		+ bh_source_one_field_stats									
		+ new_bh_bdid_one_field_stats											
		+ orphan_bh_bdid_one_field_stats										
		+ Good_bh_bdid_one_field_stats											
		+ bh_source_group_one_field_stats						
		+ bh_vendor_id_one_field_stats								
		+ bh_dt_first_seen_one_field_stats						
		+ bh_dt_last_seen_one_field_stats						
		+ bh_dt_vendor_first_reported_one_field_stats
		+ bh_dt_vendor_last_reported_one_field_stats	
		+ bh_company_name_one_field_stats						
		+ bh_prim_name_one_field_stats								
		+ bh_city_one_field_stats										
		+ bh_state_one_field_stats										
		+ bh_zip_one_field_stats											
		+ bh_phone_one_field_stats										
		+ bh_fein_one_field_stats										
		+ bh_current_one_field_stats									
		+ bh_dppa_one_field_stats		
//		+ bh_address_one_field_stats
		+ bh_bdid_source_two_fields_stats											
		+ bh_vendor_id_source_two_fields_stats									
		+ bh_Fein_source_two_fields_stats											
		+ bh_Dppa_source_two_fields_stats											
		+ bh_Current_source_two_fields_stats										
		+ bh_bdid_vendor_id_two_fields_stats										
		+ bh_bdid_phone_two_fields_stats												
		+ bh_bdid_fein_two_fields_stats												
		+ bh_bdid_current_two_fields_stats											
		+ bh_bdid_dppa_two_fields_stats												
		+ bh_bdid_dt_vendor_first_reported_two_fields_stats		
		+ bh_bdid_dt_last_seen_two_fields_stats	
//		+ bh_bdid_address_two_fields_stats
		+ bh_state_source_two_fields_stats											
		+ bhsicode_bdid_source_two_fields_stats													
		+ bhsicode_bdid_siccode_two_fields_stats													
		+ bhsicode_source_siccode_two_fields_stats											
		;		
		
	end;

	export business_contacts(
	
		 dataset(Layout_Business_Contact_Full_new)	pBc					= files().base.business_contacts.built	//during a build, this will house the new base file
		,dataset(Layout_Business_Contact_Full_new)	pBc_father	= files().base.business_contacts.qa			//during a build, this will house the previous base file
		,string																			pversion
	
	) := 
	function

//unique new bdids
//bdids per address
//one record bdids
//new bdid, did combos
//how many have blank bdids, dids

		pBc_bdid_dids					:= table(pBc					(bdid != 0, did != 0), {bdid, did}, bdid, did);
		pBc_father_bdid_dids	:= table(pBc_father	(bdid != 0, did != 0), {bdid, did}, bdid, did);
		
		bc_new_contacts := join(distribute(pBc_bdid_dids, hash64(bdid, did))
														,distribute(pBc_father_bdid_dids, hash64(bdid, did))
													,		left.bdid = right.bdid
													and left.did	= right.did
													,transform(recordof(pBc_bdid_dids), self := left)
													,local
													,left only
											);
		
		
		Statistics.mac_one_Field_Stats(bc_new_contacts, 'business_header','Business Contacts Base New Contacts',pversion,bdid       					,'bdid'       					,'integer',bh_new_contacts_bdid_one_field_stats									);
		Statistics.mac_one_Field_Stats(bc_new_contacts, 'business_header','Business Contacts Base New Contacts',pversion,did        					,'did'        					,'integer',bh_new_contacts_did_one_field_stats										);

		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,bdid       					,'bdid'       					,'integer',bh_bdid_one_field_stats									);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,did        					,'did'        					,'integer',bh_did_one_field_stats										);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,contact_score 			,'contact_score' 				,'integer',bh_contact_score_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,vendor_id 					,'vendor_id' 						,'string'	,bh_vendor_id_one_field_stats							);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,dt_first_seen 			,'dt_first_seen' 				,'integer',bh_dt_first_seen_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,dt_last_seen  			,'dt_last_seen'  				,'integer',bh_dt_last_seen_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,source        			,'source'								,'string'	,bh_source_one_field_stats								,true);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,record_type   			,'record_type'   				,'string'	,bh_record_type_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,from_hdr 						,'from_hdr' 						,'string'	,bh_from_hdr_one_field_stats							);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,glb    							,'glb'    							,'boolean',bh_glb_one_field_stats										);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,dppa   							,'dppa'   							,'boolean',bh_dppa_one_field_stats									);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,lname								,'lname'								,'string'	,bh_lname_one_field_stats									);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,prim_name						,'prim_name'						,'string'	,bh_prim_name_one_field_stats							);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,city								,'city'									,'string'	,bh_city_one_field_stats									);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,state								,'state'								,'string'	,bh_state_one_field_stats									,true);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,zip									,'zip'									,'integer',bh_zip_one_field_stats										);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,phone								,'phone'								,'integer',bh_phone_one_field_stats									);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,email_address				,'email_address'				,'string'	,bh_email_address_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,ssn									,'ssn'									,'integer',bh_ssn_one_field_stats										);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_source_group,'company_source_group'	,'string'	,bh_company_source_group_one_field_stats	);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_name				,'company_name'					,'string'	,bh_company_name_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_prim_name		,'company_prim_name'		,'string'	,bh_company_prim_name_one_field_stats			);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_city				,'company_city'					,'string'	,bh_company_city_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_state				,'company_state'				,'string'	,bh_company_state_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_zip					,'company_zip'					,'integer',bh_company_zip_one_field_stats						);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_phone				,'company_phone'				,'integer',bh_company_phone_one_field_stats					);
		Statistics.mac_one_Field_Stats(pBc, 'business_header','Business Contacts Base',pversion,company_fein				,'company_fein'					,'integer',bh_company_fein_one_field_stats					);

		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,source					,'source'				,'string'		,false, true	,bh_bdid_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'Did'					,'integer'	,source					,'source'				,'string'		,false, true	,bh_did_source_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,vendor_id			,'Vendor_id'		,'string'		,source					,'source'				,'string'		,false, true	,bh_vendor_id_source_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,company_fein		,'Company_Fein'	,'integer'	,source					,'source'				,'string'		,false, true	,bh_Fein_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,dppa						,'Dppa'					,'boolean'	,source					,'source'				,'string'		,true, true		,bh_Dppa_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,glb						,'Glb'					,'boolean'	,source					,'source'				,'string'		,true, true		,bh_Glb_source_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,record_type		,'record_type'	,'string'		,source					,'source'				,'string'		,true, true		,bh_record_type_source_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,from_hdr				,'from_hdr'			,'string'		,source					,'source'				,'string'		,true, true		,bh_from_hdr_source_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,phone					,'phone'				,'integer'	,source					,'source'				,'string'		,false, true	,bh_phone_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,email_address	,'email_address','string'		,source					,'source'				,'string'		,false, true	,bh_email_address_source_two_fields_stats	);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,ssn						,'ssn'					,'integer'	,source					,'source'				,'string'		,false, true	,bh_ssn_source_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,company_phone	,'company_phone','integer'	,source					,'source'				,'string'		,false, true	,bh_company_phone_source_two_fields_stats	);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,dt_last_seen		,'dt_last_seen'	,'integer'	,source					,'source'				,'string'		,true	, true	,bh_dt_last_seen_two_fields_stats					);

		Statistics.mac_two_Fields_Stats(bc_new_contacts, 'business_header','Business Contacts Base New Contacts' ,pversion ,bdid						,'bdid'					,'integer'	,did						,'did'					,'integer'	,false, false	,bh_new_contacts_bdid_did_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'bdid'					,'integer'	,did						,'did'					,'integer'	,false, false	,bh_bdid_did_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'bdid'					,'integer'	,vendor_id			,'Vendor_id'		,'string'		,false, false	,bh_bdid_vendor_id_two_fields_stats				);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,phone					,'phone'				,'integer'	,false, false	,bh_bdid_phone_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,company_fein		,'company_Fein'	,'integer'	,false, false	,bh_bdid_fein_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,record_type		,'record_type'	,'string'		,false, true	,bh_bdid_record_type_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,from_hdr				,'from_hdr'			,'string'		,false, true	,bh_bdid_from_hdr_two_fields_stats				);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,dppa						,'Dppa'					,'boolean'	,false, true	,bh_bdid_dppa_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,glb						,'glb'					,'boolean'	,false, true	,bh_bdid_glb_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,email_address	,'email_address','string'		,false, false	,bh_bdid_email_address_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,company_phone	,'company_phone','integer'	,false, false	,bh_bdid_company_phone_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,ssn						,'ssn'					,'integer'	,false, false	,bh_bdid_ssn_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,bdid						,'Bdid'					,'integer'	,dt_last_seen		,'dt_last_seen'	,'integer'	,false, true	,bh_bdid_dt_last_seen_two_fields_stats		);
                                                                                                                                                                                                        
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,vendor_id			,'Vendor_id'		,'string'		,false, false	,bh_did_vendor_id_two_fields_stats				);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,phone					,'phone'				,'integer'	,false, false	,bh_did_phone_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,company_fein		,'company_Fein'	,'integer'	,false, false	,bh_did_fein_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,record_type		,'record_type'	,'string'		,false, true	,bh_did_record_type_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,from_hdr				,'from_hdr'			,'string'		,false, true	,bh_did_from_hdr_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,dppa						,'Dppa'					,'boolean'	,false, true	,bh_did_dppa_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,glb						,'glb'					,'boolean'	,false, true	,bh_did_glb_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,email_address	,'email_address','string'		,false, false	,bh_did_email_address_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,company_phone	,'company_phone','integer'	,false, false	,bh_did_company_phone_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,ssn						,'ssn'					,'integer'	,false, false	,bh_did_ssn_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pBc, 'business_header','Business Contacts Base' ,pversion ,did						,'did'					,'integer'	,dt_last_seen		,'dt_last_seen'	,'integer'	,false, false	,bh_did_dt_last_seen_two_fields_stats			);
                                                                                                         		              		
		return                                                                                                              
			bh_bdid_one_field_stats								
		+ bh_new_contacts_bdid_one_field_stats	 
		+ bh_new_contacts_did_one_field_stats	
		+ bh_did_one_field_stats									
		+ bh_contact_score_one_field_stats				
		+ bh_vendor_id_one_field_stats						
		+ bh_dt_first_seen_one_field_stats				
		+ bh_dt_last_seen_one_field_stats				
		+ bh_source_one_field_stats							
		+ bh_record_type_one_field_stats					
		+ bh_from_hdr_one_field_stats						
		+ bh_glb_one_field_stats									
		+ bh_dppa_one_field_stats								
		+ bh_lname_one_field_stats								
		+ bh_prim_name_one_field_stats						
		+ bh_city_one_field_stats								
		+ bh_state_one_field_stats								
		+ bh_zip_one_field_stats									
		+ bh_phone_one_field_stats								
		+ bh_email_address_one_field_stats					
		+ bh_ssn_one_field_stats											
		+ bh_company_source_group_one_field_stats	
		+ bh_company_name_one_field_stats					
		+ bh_company_prim_name_one_field_stats				
		+ bh_company_city_one_field_stats						
		+ bh_company_state_one_field_stats						
		+ bh_company_zip_one_field_stats						
		+ bh_company_phone_one_field_stats						
		+ bh_company_fein_one_field_stats
		+ bh_new_contacts_bdid_did_two_fields_stats
		+ bh_bdid_source_two_fields_stats						
		+ bh_did_source_two_fields_stats							
		+ bh_vendor_id_source_two_fields_stats					
		+ bh_Fein_source_two_fields_stats					
		+ bh_Dppa_source_two_fields_stats					
		+ bh_Glb_source_two_fields_stats						
		+ bh_record_type_source_two_fields_stats		
		+ bh_from_hdr_source_two_fields_stats			
		+ bh_phone_source_two_fields_stats					
		+ bh_email_address_source_two_fields_stats	
		+ bh_ssn_source_two_fields_stats						
		+ bh_company_phone_source_two_fields_stats	
		+ bh_dt_last_seen_two_fields_stats					
		+ bh_bdid_did_two_fields_stats						
		+ bh_bdid_vendor_id_two_fields_stats			
		+ bh_bdid_phone_two_fields_stats					
		+ bh_bdid_fein_two_fields_stats					
		+ bh_bdid_record_type_two_fields_stats		
		+ bh_bdid_from_hdr_two_fields_stats			
		+ bh_bdid_dppa_two_fields_stats						
		+ bh_bdid_glb_two_fields_stats								
		+ bh_bdid_email_address_two_fields_stats		
		+ bh_bdid_company_phone_two_fields_stats		
		+ bh_bdid_ssn_two_fields_stats								
		+ bh_bdid_dt_last_seen_two_fields_stats			
		+ bh_did_vendor_id_two_fields_stats				
		+ bh_did_phone_two_fields_stats					
		+ bh_did_fein_two_fields_stats							
		+ bh_did_record_type_two_fields_stats		
		+ bh_did_from_hdr_two_fields_stats				
		+ bh_did_dppa_two_fields_stats						
		+ bh_did_glb_two_fields_stats							
		+ bh_did_email_address_two_fields_stats
		+ bh_did_company_phone_two_fields_stats
		+ bh_did_ssn_two_fields_stats					
		+ bh_did_dt_last_seen_two_fields_stats	
		;		
		
	end;

	export super_group(
	
		 dataset(Layout_BH_Super_Group) pSg				= files().base.Super_Group.built
		,string													pversion
	
	) := 
	function

		find_one_record_gids	:= table(pSg, {group_id, unsigned8 cnt := count(group)}, group_id)(cnt = 1);
		one_record_bdids			:= join( pSg										
																	,find_one_record_gids
																	,left.group_id = right.group_id
																	,transform(recordof(pSg), self := left)
//																	,local
															);

		Statistics.mac_one_Field_Stats(pSg, 'business_header','Super Group',pversion,bdid			,'bdid'			,'integer',bh_bdid_one_field_stats		);
		Statistics.mac_one_Field_Stats(pSg, 'business_header','Super Group',pversion,group_id	,'group_id'	,'integer',bh_group_id_one_field_stats);
		
		Statistics.mac_one_Field_Stats(one_record_bdids, 'business_header','Super Group Orphan Groupids',pversion,group_id			,'group_id'			,'integer',bh_orphan_group_id_one_field_stats		);

		Statistics.mac_two_Fields_Stats(pSg, 'business_header','Super Group' ,pversion ,group_id,'group_id','integer',bdid	,'bdid'	,'integer'		,false, false	,bh_group_id_bdid_two_fields_stats);

		return 
			bh_bdid_one_field_stats										
		+ bh_group_id_one_field_stats			
		+ bh_orphan_group_id_one_field_stats
		+ bh_group_id_bdid_two_fields_stats						
		;		
		
	end;
	
	
	export all(
		 string																						pversion
		,dataset(Layout_Business_Header_Base						) pBh										= files().base.business_headers.built
		,dataset(Layout_Business_Header_Base						) pBh_father						= files().base.business_headers.qa
		,dataset(Layout_Business_Contact_Full_new				)	pBc										= files().base.business_contacts.built	//during a build, this will house the new base file
		,dataset(Layout_Business_Contact_Full_new				)	pBc_father						= files().base.business_contacts.qa			//during a build, this will house the previous base file
		,dataset(Layout_BH_Super_Group									) pSg										= files().base.Super_Group.built
		,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps				= PAW.fCorpInactives()
		,unsigned8																				pmax_rcid							= max_rcid()
		,dataset(Layout_Business_Header_Temp						)	pBH_Basic_Match_FEIN	= persists().BHBasicMatchFEIN
		,dataset(Layout_Business_Header_Temp						)	pBH_Basic_Match_SALT	= persists().BHBasicMatchSALT
		,dataset(Layout_Business_Header_Temp						)	pBH_Match_Init				= persists().BHMatchInit
		,dataset(Layout_SIC_Code												) pSic_Code							= Persists().BHBDIDSIC									
		
	) := 
		business_headers(pBh, pBh_father,pversion,pmax_rcid,pInactiveCorps,pBH_Basic_Match_FEIN,pBH_Basic_Match_SALT,pBH_Match_Init,pSic_Code)
	+ business_contacts(pBc,pBc_father, pversion)
	+ super_group(pSg,pversion)
	;

//should be function, pass in dataset + version, get back statistics
/*
# total BH records
# of unique bdids
# of new unique bdids(bdids above the maxrcid)
average number of records per bdid(interesting to see what SALT does to this)
max records per bdid
min records per bdid
average number of bdids per address, and top 5 addresses
number of records without address per source
percentage of records without address per source
number of bdids without address
number of bdids without address & phone & fein
number of records per source
number of unique bdids per source
# of old bdids with dt_last_seen older than 2006/2007?
# of dead bdids -- maybe get this from deadco & look at what Julie F. is doing with PAW
earliest dt_first_seen(filtering out zeroes)
latest dt_last_seen(filtering out zeroes)
earliest dt_vendor_first_reported(filtering out zeroes)
latest dt_vendor_last_reported(filtering out zeroes)
# of new BH records
List of new sources(if there are any)
# of unique phones
# of new unique phones
# total of records with phones
# of unique feins
# of new unique feins
# total of records with feins
List of sources of records with feins
# of unique addresses
# of unique names
# of dppa records
# of glb records
# of both glb and dppa records
# of dppa records by state(dppa_state field in BC)

Same stats for business contacts and paw as above plus:
# of unique dids
# of new unique dids
paw score distribution
paw confidence groups sample
*/



end;