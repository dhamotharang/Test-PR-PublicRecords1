import Statistics, versioncontrol, address;
export fStatistics(

	 dataset(layout.Employment_Out)	pPaw				= files().base.built	// during a build, this will house the new base file
	,dataset(layout.Employment_Out)	pPaw_Father	= files().base.qa			// during a build, this will house the previous base file
	,string													pversion													// version date
	,unsigned2											pwhichstats	= 0										// 0 = all stats, 1 - 5 = which subset to run

) := 
function

		pPaw_bdid_dids				:= table(pPaw					(bdid != 0, did != 0), {bdid, did}, bdid, did);
		pPaw_Father_bdid_dids	:= table(pPaw_Father	(bdid != 0, did != 0), {bdid, did}, bdid, did);
		
		paw_new_contacts := join(distribute(pPaw_bdid_dids				,hash64(bdid, did))
														,distribute(pPaw_Father_bdid_dids	,hash64(bdid, did))
													,		left.bdid = right.bdid
													and left.did	= right.did
													,transform(recordof(pPaw_bdid_dids), self := left)
													,left only
													,local
											);
		
		// -- dsubset1
		Statistics.mac_one_Field_Stats(paw_new_contacts, 'PawV2','PawV2 Base New Contacts',pversion,bdid       					,'bdid'       					,'integer',paw_new_contacts_bdid_one_field_stats									);
		Statistics.mac_one_Field_Stats(paw_new_contacts, 'PawV2','PawV2 Base New Contacts',pversion,did        					,'did'        					,'integer',paw_new_contacts_did_one_field_stats										);

		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,contact_id						,'contact_id'						,'integer',paw_contact_id_one_field_stats					);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,did 									,'did '									,'integer',paw_did_one_field_stats									);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,bdid									,'bdid'									,'integer',paw_bdid_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,ssn									,'ssn'									,'string0',paw_ssn_one_field_stats									);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,score								,'score'								,'string'	,paw_score_one_field_stats								,pFieldFew := true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_name					,'company_name'					,'string'	,paw_company_name_one_field_stats				);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_prim_range		,'company_prim_range'		,'string'	,paw_company_prim_range_one_field_stats	);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_predir				,'company_predir'				,'string'	,paw_company_predir_one_field_stats			);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_prim_name		,'company_prim_name'		,'string'	,paw_company_prim_name_one_field_stats		);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_addr_suffix	,'company_addr_suffix'	,'string'	,paw_company_addr_suffix_one_field_stats	);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_postdir			,'company_postdir'			,'string'	,paw_company_postdir_one_field_stats			);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_unit_desig		,'company_unit_desig'		,'string'	,paw_company_unit_desig_one_field_stats	);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_sec_range		,'company_sec_range'		,'string'	,paw_company_sec_range_one_field_stats		);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_city					,'company_city'					,'string'	,paw_company_city_one_field_stats				);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_state				,'company_state'				,'string'	,paw_company_state_one_field_stats				);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_zip					,'company_zip'					,'string0',paw_company_zip_one_field_stats					);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_zip4					,'company_zip4'					,'string0',paw_company_zip4_one_field_stats				);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_title				,'company_title'				,'string'	,paw_company_title_one_field_stats				,pHasBigSkew := true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_department		,'company_department'		,'string'	,paw_company_department_one_field_stats	);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_phone				,'company_phone'				,'string0',paw_company_phone_one_field_stats		);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_fein					,'company_fein'					,'string'	,paw_company_fein_one_field_stats				);

		// -- dsubset2
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,title								,'title'								,'string'	,paw_title_one_field_stats								,pHasBigSkew := true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,fname								,'fname'								,'string'	,paw_fname_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,mname								,'mname'								,'string'	,paw_mname_one_field_stats								,pHasBigSkew := true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,lname								,'lname'								,'string'	,paw_lname_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,name_suffix					,'name_suffix'					,'string'	,paw_name_suffix_one_field_stats					);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,prim_range						,'prim_range'						,'string'	,paw_prim_range_one_field_stats					);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,predir								,'predir'								,'string'	,paw_predir_one_field_stats							);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,prim_name						,'prim_name'						,'string'	,paw_prim_name_one_field_stats						);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,addr_suffix					,'addr_suffix'					,'string'	,paw_addr_suffix_one_field_stats					);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,postdir							,'postdir'							,'string'	,paw_postdir_one_field_stats							);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,unit_desig						,'unit_desig'						,'string'	,paw_unit_desig_one_field_stats					);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,sec_range						,'sec_range'						,'string'	,paw_sec_range_one_field_stats						);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,city									,'city'									,'string'	,paw_city_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,state								,'state'								,'string'	,paw_state_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,zip									,'zip'									,'string0'	,paw_zip_one_field_stats									);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,zip4									,'zip4'									,'string0'	,paw_zip4_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,county								,'county'								,'string0'	,paw_county_one_field_stats							);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,msa									,'msa'									,'string'	,paw_msa_one_field_stats									);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,geo_lat							,'geo_lat'							,'string'	,paw_geo_lat_one_field_stats							);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,geo_long							,'geo_long'							,'string'	,paw_geo_long_one_field_stats						);

		// -- dsubset3
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,phone								,'phone'								,'string0'	,paw_phone_one_field_stats								);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,email_address				,'email_address'				,'string'	,paw_email_address_one_field_stats				);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,dt_first_seen				,'dt_first_seen'				,'string0'	,paw_dt_first_seen_one_field_stats				,,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,dt_last_seen					,'dt_last_seen'					,'string0'	,paw_dt_last_seen_one_field_stats				,,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,record_type					,'record_type'					,'string'	,paw_record_type_one_field_stats					,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,active_phone_flag		,'active_phone_flag'		,'string'	,paw_active_phone_flag_one_field_stats		,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,GLB									,'GLB'									,'string'	,paw_GLB_one_field_stats									,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,source								,'source'								,'string'	,paw_source_one_field_stats							,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,DPPA_State						,'DPPA_State'						,'string'	,paw_DPPA_State_one_field_stats					,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,old_score						,'old_score'						,'string'	,paw_old_score_one_field_stats						,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,source_count					,'source_count'					,'integer',paw_source_count_one_field_stats				,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,dead_flag						,'dead_flag'						,'integer',paw_dead_flag_one_field_stats						,true);
		Statistics.mac_one_Field_Stats(pPaw, 'PawV2','PawV2 Base',pversion	,company_status				,'company_status'				,'string'	,paw_company_status_one_field_stats			,true);

		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid					,'Bdid'					,'integer'	,source		,'source'				,'string'		,false, true	,paw_bdid_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'Did'					,'integer'	,source		,'source'				,'string'		,false, true	,paw_did_source_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,company_fein	,'Company_Fein'	,'string0'	,source		,'source'				,'string'		,false, true	,paw_Fein_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,dppa_state		,'Dppa_State'		,'string'		,source		,'source'				,'string'		,true, true		,paw_Dppa_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,glb						,'Glb'					,'string'		,source		,'source'				,'string'		,true, true		,paw_Glb_source_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,record_type		,'record_type'	,'string'		,source		,'source'				,'string'		,true, true		,paw_record_type_source_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,phone					,'phone'				,'string0'	,source		,'source'				,'string'		,false, true	,paw_phone_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,email_address	,'email_address','string'		,source		,'source'				,'string'		,false, true	,paw_email_address_source_two_fields_stats	);

		// -- dsubset4
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,ssn						,'ssn'					,'string0'	,source		,'source'				,'string'		,false, true	,paw_ssn_source_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,company_phone	,'company_phone','string0'	,source		,'source'				,'string'		,false, true	,paw_company_phone_source_two_fields_stats	);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,dt_last_seen	,'dt_last_seen'	,'string0'	,source		,'source'				,'string'		,false, true	,paw_dt_last_seen_source_two_fields_stats		,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,dt_first_seen	,'dt_first_seen','string0'	,source		,'source'				,'string'		,false, true	,paw_dt_first_seen_source_two_fields_stats	,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,score					,'score'				,'string'		,source		,'source'				,'string'		,true, true		,paw_score_source_two_fields_stats					);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,old_score			,'old_score'		,'string'		,source		,'source'				,'string'		,true, true		,paw_old_score_source_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,source_count	,'source_count'	,'integer'	,source		,'source'				,'string'		,true, true		,paw_source_count_source_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,dead_flag			,'dead_flag'		,'integer'	,source		,'source'				,'string'		,true, true		,paw_dead_flag_source_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,company_status,'company_status','string'	,source		,'source'				,'string'		,true, true		,paw_company_status_source_two_fields_stats			);
                                                                                                                                                                   
		Statistics.mac_two_Fields_Stats(paw_new_contacts, 'PawV2','PawV2 Base New Contacts' ,pversion,bdid,'bdid','integer',did						,'did'					,'integer'	,false, false	,paw_new_contacts_bdid_did_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'bdid'					,'integer'	,did						,'did'					,'integer'	,false, false	,paw_bdid_did_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,phone					,'phone'				,'string0'	,false, false	,paw_bdid_phone_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,company_fein		,'company_Fein'	,'string0'	,false, false	,paw_bdid_fein_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,record_type		,'record_type'	,'string'		,false, true	,paw_bdid_record_type_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,DPPA_State			,'DPPA_State'		,'string'		,false, true	,paw_bdid_DPPA_State_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,glb						,'glb'					,'string'		,false, true	,paw_bdid_glb_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,email_address	,'email_address','string'		,false, false	,paw_bdid_email_address_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,company_phone	,'company_phone','string0'	,false, false	,paw_bdid_company_phone_two_fields_stats		);
		
		// -- dsubset5
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,ssn						,'ssn'					,'string0'	,false, false	,paw_bdid_ssn_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,dt_last_seen		,'dt_last_seen'	,'string0'	,false, false	,paw_bdid_dt_last_seen_two_fields_stats		,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,dt_first_seen	,'dt_first_seen','string0'	,false, false	,paw_bdid_dt_first_seen_two_fields_stats		,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,score					,'score'				,'string'		,false, true	,paw_bdid_score_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,old_score			,'old_score'		,'string'		,false, true	,paw_bdid_old_score_two_fields_stats				);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,source_count		,'source_count'	,'integer'	,false, true	,paw_bdid_source_count_two_fields_stats		,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,dead_flag			,'dead_flag'		,'integer'	,false, true	,paw_bdid_dead_flag_two_fields_stats			,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,bdid						,'Bdid'					,'integer'	,company_status	,'company_status','string'	,false, true	,paw_bdid_company_status_two_fields_stats	);
                                                                                                                                                                                                        
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,phone					,'phone'				,'string0'	,false, false	,paw_did_phone_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,company_fein		,'company_Fein'	,'string0'	,false, false	,paw_did_fein_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,record_type		,'record_type'	,'string'	,false, true	,paw_did_record_type_two_fields_stats			);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,DPPA_State			,'DPPA_State'		,'string'	,false, true	,paw_did_DPPA_State_two_fields_stats				);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,glb						,'glb'					,'string'	,false, true	,paw_did_glb_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,email_address	,'email_address','string'	,false, false	,paw_did_email_address_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,company_phone	,'company_phone','string0'	,false, false	,paw_did_company_phone_two_fields_stats		);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,ssn						,'ssn'					,'string0'	,false, false	,paw_did_ssn_two_fields_stats							);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,dt_last_seen		,'dt_last_seen'	,'string0'	,false, false	,paw_did_dt_last_seen_two_fields_stats			,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,dt_first_seen	,'dt_first_seen','string0'	,false, false	,paw_did_dt_first_seen_two_fields_stats		,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,score					,'score'				,'string'	,false, true	,paw_did_score_two_fields_stats						);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,old_score			,'old_score'		,'string'	,false, true	,paw_did_old_score_two_fields_stats				);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,source_count		,'source_count'	,'integer',false, true	,paw_did_source_count_two_fields_stats			,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,dead_flag			,'dead_flag'		,'integer',false, true	,paw_did_dead_flag_two_fields_stats				,true);
		Statistics.mac_two_Fields_Stats(pPaw, 'PawV2','PawV2 Base' ,pversion ,did						,'did'					,'integer'	,company_status	,'company_status','string',false, true	,paw_did_company_status_two_fields_stats		);
                                                                                                         		              		                                                 
		dsubset1 :=                                                                                                               
			paw_new_contacts_bdid_one_field_stats	
		+ paw_new_contacts_did_one_field_stats		
		+ paw_contact_id_one_field_stats					
		+ paw_did_one_field_stats										
		+ paw_bdid_one_field_stats									
		+ paw_ssn_one_field_stats									
		+ paw_score_one_field_stats								
		+ paw_company_name_one_field_stats				
		+ paw_company_prim_range_one_field_stats		
		+ paw_company_predir_one_field_stats				
		+ paw_company_prim_name_one_field_stats			
		+ paw_company_addr_suffix_one_field_stats	
		+ paw_company_postdir_one_field_stats				
		+ paw_company_unit_desig_one_field_stats	
		+ paw_company_sec_range_one_field_stats			
		+ paw_company_city_one_field_stats					
		+ paw_company_state_one_field_stats				
		+ paw_company_zip_one_field_stats						
		+ paw_company_zip4_one_field_stats				
		+ paw_company_title_one_field_stats					
		+ paw_company_department_one_field_stats		
		+ paw_company_phone_one_field_stats					
		+ paw_company_fein_one_field_stats
		;

		dsubset2 :=                                                                                                               
			paw_title_one_field_stats										
		+ paw_fname_one_field_stats									
		+ paw_mname_one_field_stats										
		+ paw_lname_one_field_stats								
		+ paw_name_suffix_one_field_stats						
		+ paw_prim_range_one_field_stats						
		+ paw_predir_one_field_stats								
		+ paw_prim_name_one_field_stats							
		+ paw_addr_suffix_one_field_stats						
		+ paw_postdir_one_field_stats										
		+ paw_unit_desig_one_field_stats					
		+ paw_sec_range_one_field_stats							
		+ paw_city_one_field_stats									
		+ paw_state_one_field_stats								
		+ paw_zip_one_field_stats									
		+ paw_zip4_one_field_stats									
		+ paw_county_one_field_stats								
		+ paw_msa_one_field_stats									
		+ paw_geo_lat_one_field_stats								
		+ paw_geo_long_one_field_stats							
		;

		dsubset3 :=                                                                                                               
			paw_phone_one_field_stats									
		+ paw_email_address_one_field_stats				
		+ paw_dt_first_seen_one_field_stats					
		+ paw_dt_last_seen_one_field_stats					
		+ paw_record_type_one_field_stats						
		+ paw_active_phone_flag_one_field_stats		
		+ paw_GLB_one_field_stats									
		+ paw_source_one_field_stats									
		+ paw_DPPA_State_one_field_stats					
		+ paw_old_score_one_field_stats							
		+ paw_source_count_one_field_stats					
		+ paw_dead_flag_one_field_stats						
		+ paw_company_status_one_field_stats				
		+ paw_bdid_source_two_fields_stats						
		+ paw_did_source_two_fields_stats						
		+ paw_Fein_source_two_fields_stats					
		+ paw_Dppa_source_two_fields_stats					
		+ paw_Glb_source_two_fields_stats							
		+ paw_record_type_source_two_fields_stats			
		+ paw_phone_source_two_fields_stats						
		+ paw_email_address_source_two_fields_stats	
		;

		dsubset4 :=                                                                                                               
			paw_ssn_source_two_fields_stats							
		+ paw_company_phone_source_two_fields_stats	
		+ paw_dt_last_seen_source_two_fields_stats		
		+ paw_dt_first_seen_source_two_fields_stats		
		+ paw_score_source_two_fields_stats					
		+ paw_old_score_source_two_fields_stats				
		+ paw_source_count_source_two_fields_stats	
		+ paw_dead_flag_source_two_fields_stats				
		+ paw_company_status_source_two_fields_stats	
		+ paw_new_contacts_bdid_did_two_fields_stats	
		+ paw_bdid_did_two_fields_stats								
		+ paw_bdid_phone_two_fields_stats								
		+ paw_bdid_fein_two_fields_stats							
		+ paw_bdid_record_type_two_fields_stats					
		+ paw_bdid_DPPA_State_two_fields_stats			
		+ paw_bdid_glb_two_fields_stats								
		+ paw_bdid_email_address_two_fields_stats			
		+ paw_bdid_company_phone_two_fields_stats			
		;
		
		dsubset5 :=                                                                                                               
			paw_bdid_ssn_two_fields_stats								
		+ paw_bdid_dt_last_seen_two_fields_stats			
		+ paw_bdid_dt_first_seen_two_fields_stats					
		+ paw_bdid_score_two_fields_stats						
		+ paw_bdid_old_score_two_fields_stats					
		+ paw_bdid_source_count_two_fields_stats			
		+ paw_bdid_dead_flag_two_fields_stats				
		+ paw_bdid_company_status_two_fields_stats	
		+ paw_did_phone_two_fields_stats						
		+ paw_did_fein_two_fields_stats							
		+ paw_did_record_type_two_fields_stats		
		+ paw_did_DPPA_State_two_fields_stats				
		+ paw_did_glb_two_fields_stats							
		+ paw_did_email_address_two_fields_stats		
		+ paw_did_company_phone_two_fields_stats	
		+ paw_did_ssn_two_fields_stats							
		+ paw_did_dt_last_seen_two_fields_stats			
		+ paw_did_dt_first_seen_two_fields_stats		
		+ paw_did_score_two_fields_stats					
		+ paw_did_old_score_two_fields_stats			
		+ paw_did_source_count_two_fields_stats				
		+ paw_did_dead_flag_two_fields_stats			
		+ paw_did_company_status_two_fields_stats	
		;
		
		return
				if(pwhichstats in [0,1], dsubset1, dataset([],Statistics.Layouts.standard_stat_out))
			+ if(pwhichstats in [0,2], dsubset2, dataset([],Statistics.Layouts.standard_stat_out))
			+ if(pwhichstats in [0,3], dsubset3, dataset([],Statistics.Layouts.standard_stat_out))
			+ if(pwhichstats in [0,4], dsubset4, dataset([],Statistics.Layouts.standard_stat_out))
			+ if(pwhichstats in [0,5], dsubset5, dataset([],Statistics.Layouts.standard_stat_out))
		;                                
end;