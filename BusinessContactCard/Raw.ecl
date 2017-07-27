import BIPV2, BIPV2_Best, BIPV2_build, doxie_cbrs, Corp2, Corp2_services, MDR, doxie, ut, iesp;
EXPORT Raw := MODULE
	SHARED makeBusinessIds_BIP(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in) := function
		bip_ids			 := project(ds_in, 
														transform(BIPV2.IDlayouts.l_xlink_ids, 															
														 self.proxweight := 0;
														 self.proxscore := 0;
														 self.seleweight := 0;
														 self.selescore := 0;
														 self.ultscore := 0;
														 self.ultweight := 0;
														 self.dotscore := 0;
														 self.dotweight := 0;
														 self.orgscore := 0;
														 self.orgweight := 0;
														 self.powscore := 0;
														 self.powweight := 0;
														 self.empscore := 0;
														 self.empweight := 0;																														 													
														 self := left, 														
														 ));
		return bip_ids;
	end;
	
	SHARED getBusinessHeaderBest_BIP(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																	 BusinessContactCard.IParam.options in_mod) := function
		bip_ids 							:= makeBusinessIds_BIP(ds_in);
		FETCH_LEVEL 					:= in_mod.BusinessReportFetchLevel;
		SELEID_FILTER 				:= FETCH_LEVEL in [BIPV2.IDconstants.Fetch_Level_UltID, BIPV2.IDconstants.Fetch_Level_OrgID, BIPV2.IDconstants.Fetch_Level_SELEID];
		ds_businessHeader_raw := BIPV2_Best.Key_LinkIds.KFetch(bip_ids,FETCH_LEVEL);	 
		ds_businessHeader			:= if(SELEID_FILTER, ds_businessHeader_raw(proxid = 0), ds_businessHeader_raw);
		ds_businessHeader_best:= JOIN(ds_in, ds_businessHeader,
																	LEFT.ultid  = RIGHT.ultid AND
																	LEFT.orgid  = RIGHT.orgid AND							
																	LEFT.seleid = RIGHT.seleid,
																	TRANSFORM(BusinessContactCard.Layouts.rec_company_best,
																						company_name			:= right.company_name[1];
																						company_address		:= right.company_address[1];
																						company_phone			:= right.company_phone[1];
																						company_fein			:= right.company_fein[1];
																						SELF.acctno				:= LEFT.acctno,
																						self.bdid					:= right.company_bdid,
																						self.company_name	:= company_name.company_name,
																						self.dt_last_seen	:= (string)company_name.dt_last_seen,
																						self.prim_range		:= company_address.company_prim_range,
																						self.predir				:= company_address.company_predir,
																						self.prim_name		:= company_address.company_prim_name,
																						self.addr_suffix	:= company_address.company_addr_suffix,
																						self.postdir			:= company_address.company_postdir,
																						self.unit_desig		:= company_address.company_unit_desig,
																						self.sec_range		:= company_address.company_sec_range,
																						self.city					:= company_address.address_v_city_name,
																						self.state				:= company_address.company_st,
																						self.zip					:= company_address.company_zip5,
																						self.zip4					:= company_address.company_zip4,
																						self.county_name	:= company_address.county_name,
																						self.phone				:= company_phone.company_phone,
																						self.fein					:= company_fein.company_fein,
																						self							:= LEFT, //BIP ids
																						self							:= [] //fromdca, best_flags, isCurrent, hasBBB, level, msaDesc, msa
																						),
																	LIMIT(0), KEEP(1));
		return ds_businessHeader_best;
	end;
	
	SHARED getBusinessHeaderBest_BDID(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in) := function
		FOR_SUBJECT_COMPANY			:= false;
		just_bdids    					:= DEDUP(SORT( PROJECT(ds_in, doxie_cbrs.layout_references), bdid ), bdid);
		ds_businessHeader				:= doxie_cbrs.fn_best_information(just_bdids,FOR_SUBJECT_COMPANY);
		ds_businessHeader_best	:= JOIN(ds_in, ds_businessHeader, 
																	 LEFT.group_id = (UNSIGNED6)RIGHT.bdid, 
																	 TRANSFORM(BusinessContactCard.Layouts.rec_company_best, 
																						 SELF.acctno   := LEFT.acctno,
																						 SELF.bdid     := (UNSIGNED6)RIGHT.bdid, 
																						 SELF.group_id := LEFT.group_id,
																						 SELF          := RIGHT),
																	LIMIT(0), KEEP(1));
		return ds_businessHeader_best;
	end;
	
	EXPORT getBusinessHeaderBest(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
															 BusinessContactCard.IParam.options in_mod) := function
		ds_businessHeaderBest_BIP 	:= getBusinessHeaderBest_BIP(ds_in, in_mod);
		ds_businessHeaderBest_BDID	:= getBusinessHeaderBest_BDID(ds_in);
		ds_businessHeaderBest_raw		:= if(in_mod.isBIPReport, ds_businessHeaderBest_BIP, ds_businessHeaderBest_BDID);
		ds_BusinessHeaderBest				:= dedup(sort(ds_businessHeaderBest_raw, record), record);	
		// output(ds_businessHeaderBest_BIP, named('ds_businessHeaderBest_BIP'));
		// output(ds_businessHeaderBest_BDID, named('ds_businessHeaderBest_BDID'));
		return ds_businessHeaderBest;
	end;
	
	SHARED getCorpRecords_BIP(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
													 BusinessContactCard.IParam.options in_mod) := function
		bip_ids 							:= makeBusinessIds_BIP(ds_in);
		FETCH_LEVEL 					:= in_mod.BusinessReportFetchLevel;
		ds_corpRecords 				:= join(ds_in, Corp2.Key_Linkids.Corp.kFetch(bip_ids,FETCH_LEVEL), 
																	LEFT.ultid  = RIGHT.ultid AND
																	LEFT.orgid  = RIGHT.orgid AND							
																	LEFT.seleid = RIGHT.seleid,
																	transform(BusinessContactCard.Layouts.rec_corp,
																						self.corp_status_desc := right.corp_status_desc,
																						self.corp_status_date	:= right.corp_status_date,
																						self := left),
																	LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CORP2_PER_REC_BIP));
		return ds_corpRecords;
	end;
	
	SHARED getCorpRecords_BDID(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in) := function
		acctnos_bdids 			:= DEDUP(SORT( PROJECT(ds_in, doxie_cbrs.layout_references_acctno), acctno, bdid ), acctno, bdid);
		
		ds_corp_keys				:= Corp2_services.corp2_raw.get_corpkeys_from_bdids_batch(acctnos_bdids);
		
		grouped_in_corpkeys	:= GROUP(SORT(ds_corp_keys, corp_key), corp_key);
		
		ds_corpRecs_raw			:= JOIN( grouped_in_corpkeys, corp2.Key_Corp_corpkey, 
																 KEYED(RIGHT.corp_key = LEFT.corp_key),
																 TRANSFORM( RECORDOF(corp2.Key_Corp_corpkey), SELF := RIGHT, SELF := []),
																 LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CORP2_PER_REC_BDID));
												 
		ds_corpRecords 			:= JOIN(ds_corp_keys, ds_corpRecs_raw, 
																 LEFT.corp_key = RIGHT.corp_key, 
																 transform(BusinessContactCard.Layouts.rec_corp,
																					self.corp_status_desc := right.corp_status_desc,
																					self.corp_status_date	:= right.corp_status_date,
																					self := left),
																 LEFT OUTER,
																 LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CORP2_PER_REC_BDID));
		return ds_corpRecords;
	end;
	
	EXPORT getCorpRecords(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
												BusinessContactCard.IParam.options in_mod) := function
		ds_corpRecords_BIP 		:= getCorpRecords_BIP(ds_in, in_mod);
		ds_corpRecords_BDID 	:= getCorpRecords_BDID(ds_in);
		ds_corpRecords_raw		:= if(in_mod.isBIPReport, ds_corpRecords_BIP, ds_corpRecords_BDID);
		ds_corpRecords				:= DEDUP(SORT(ds_corpRecords_raw, acctno, -corp_status_date), acctno);
		// output(ds_corpRecords_BIP, named('ds_corpRecords_BIP'));
		// output(ds_corpRecords_BDID, named('ds_corpRecords_BDID'));
		return ds_corpRecords;
	end;
	
	SHARED getBusinessHeaderParentRecord_BIP(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																					 BusinessContactCard.IParam.options in_mod) := function
		FETCH_LEVEL 					:= in_mod.BusinessReportFetchLevel;
		BusinessContactCard.Layouts.rec_company_best xformBIPParentRec(ds_in in_rec) := transform
			bip_ids 							:= makeBusinessIds_BIP(dataset(in_rec));
			ds_busHeaderRecs 			:= BIPV2.Key_BH_Linking_Ids.kfetch(bip_ids,FETCH_LEVEL);
			dsUltlinkIDInfo 			:= dedup(sort(project(ds_BusHeaderRecs(ParentAboveSELE = true),
																							 transform(BIPV2.IDlayouts.l_xlink_ids,  
																												 self.ultid := 0;
																												 self.orgid := 0;
																												 self.seleid := 0;// not sure what to put here.														
																												 self.proxid := left.ultimate_proxid;
																												 self.powid := 0;
																												 self.empid := 0;
																												 self.dotid := 0;
																												 self := [];
																												 )),
																				 proxid),
																		proxid);
			// SPECIFICALLY use the ProxID level fetch here since we want a specific parent
			// for a particular proxid
			ds_parentRecord_raw	 		:= if(exists(dsUltlinkIDInfo), BIPV2_Best.Key_LinkIds.kfetch(dsUltlinkIDInfo, BIPV2.IDconstants.Fetch_Level_PROXID,,,false))[1];
			company_name 						:= ds_parentRecord_raw.company_name[1];
			company_address 				:= ds_parentRecord_raw.company_address[1];
			company_phone						:= ds_parentRecord_raw.company_phone[1];
			company_fein						:= ds_parentRecord_raw.company_fein[1];
			SELF.acctno 						:= in_rec.acctno,
			self.parent_ids.bdid		:= ds_parentRecord_raw.company_bdid,
			self.parent_ids.proxid 	:= ds_parentRecord_raw.proxid,
			self.parent_ids.ultid		:= ds_parentRecord_raw.ultid,
			self.parent_ids.orgid		:= ds_parentRecord_raw.orgid,
			self.parent_ids.seleid	:= ds_parentRecord_raw.seleid,
			self.parent_ids.dotid		:= ds_parentRecord_raw.dotid,
			self.parent_ids.empid		:= ds_parentRecord_raw.empid,
			self.parent_ids.powid		:= ds_parentRecord_raw.powid,
			self.company_name				:= company_name.company_name,
			self.dt_last_seen 			:= (string)company_name.dt_last_seen,
			self.prim_range 				:= company_address.company_prim_range,
			self.predir							:= company_address.company_predir,
			self.prim_name					:= company_address.company_prim_name,
			self.addr_suffix				:= company_address.company_addr_suffix,
			self.postdir		 				:= company_address.company_postdir,
			self.unit_desig					:= company_address.company_unit_desig,
			self.sec_range					:= company_address.company_sec_range,
			self.city								:= company_address.address_v_city_name, 
			self.state							:= company_address.company_st,
			self.zip								:= company_address.company_zip5,
			self.zip4								:= company_address.company_zip4,
			self.county_name				:= company_address.county_name,
			self.phone							:= company_phone.company_phone,
			self.fein								:= company_fein.company_fein,
			self										:= in_rec, //BIP ids
			self										:= [] //fromdca, best_flags, isCurrent, hasBBB, level, msaDesc, msa
		end;
		ds_parentRecord				:= project(ds_in, xformBIPParentRec(left));
		return ds_parentRecord;
	end;
	
	SHARED getBusinessHeaderParentRecord_BDID(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in) := function
		//equivalent of doxie_cbrs.ultimate_parent_information() without needing to call Business_Header.Key_BH_SuperGroup_BDID again since we already have the groupid
		bdids 										:= choosen(dedup(sort(ds_in, bdid), bdid),1);
		just_bdids    						:= PROJECT(bdids, transform(doxie_cbrs.layout_references,
																													self.bdid := left.group_id));
		ds_parentRecord_raw				:= choosen(join(just_bdids,doxie_cbrs.fn_best_information(just_bdids,true),left.bdid=(unsigned6)right.bdid),1);
		ds_ParentRecord						:= JOIN(ds_in, ds_parentRecord_raw, 
																			LEFT.group_id = (UNSIGNED6)RIGHT.bdid, 
																			TRANSFORM(BusinessContactCard.Layouts.rec_company_best, 
																								SELF.acctno   := LEFT.acctno,
																								SELF.bdid     := (UNSIGNED6)RIGHT.bdid, 
																								SELF.group_id := LEFT.group_id, 
																								SELF.parent_ids.bdid := LEFT.group_id,
																								SELF          := RIGHT),
																			LIMIT(0), KEEP(1));
		return ds_ParentRecord;
	end;
	
	EXPORT getBusinessHeaderParentRecord(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																			BusinessContactCard.IParam.options in_mod) := function
		ds_parentRecord_BIP			:= getBusinessHeaderParentRecord_BIP(ds_in, in_mod);
		ds_parentRecord_BDID		:= getBusinessHeaderParentRecord_BDID(ds_in);
		ds_parentRecord_Raw			:= if(in_mod.isBIPReport, ds_parentRecord_BIP, ds_parentRecord_BDID);
		ds_parentRecord					:= dedup(sort(ds_parentRecord_Raw, record), record);
		// output(ds_parentRecord_BIP, named('ds_parentRecord_BIP'));
		// output(ds_parentRecord_BDID, named('ds_parentRecord_BDID'));
		return ds_parentRecord;
	end;
	
	SHARED getPhoneVariationsRecords_BIP(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																			 BusinessContactCard.IParam.options in_mod) := function
		FETCH_LEVEL 						:= in_mod.BusinessReportFetchLevel;
		bip_ids 								:= makeBusinessIds_BIP(ds_in);
		ds_busHeaderRecs 				:= BIPV2.Key_BH_Linking_Ids.kfetch(bip_ids,FETCH_LEVEL)(NOT MDR.sourceTools.SourceIsEBR(source) OR NOT doxie.DataRestriction.EBR);
		ds_phoneVariations_raw	:= join(ds_in, ds_busHeaderRecs(company_phone <>''), 
																	 LEFT.ultid  = RIGHT.ultid AND
																	 LEFT.orgid  = RIGHT.orgid AND							
																	 LEFT.seleid = RIGHT.seleid,
																	 transform(BusinessContactCard.Layouts.rec_phone_variations_normalized,
																						 self.phone := right.company_phone,
																						 self				:= left),
																	 LIMIT(0), KEEP(iesp.constants.BR.MaxPhones));
		ds_phoneVariations				:= dedup(sort(ds_phoneVariations_raw, acctno, phone), acctno, phone);
		return ds_phoneVariations;
	end;
	
	SHARED getPhoneVariationsRecords_BDID(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in) := function
		get_phone_variations(UNSIGNED6 unique_id) := FUNCTION
			ds_phone_variations := doxie_cbrs.phone_variations_base( DATASET( [{unique_id}], doxie_cbrs.layout_references ) ).records;
			RETURN PROJECT(ds_phone_variations, BusinessContactCard.Layouts.rec_phones);
		END;
		ds_phoneVariations_raw := PROJECT(ds_in, TRANSFORM(BusinessContactCard.Layouts.rec_phone_variations,
																											 SELF.phones := CHOOSEN(get_phone_variations(LEFT.bdid), iesp.constants.BR.MaxPhones),
																											 SELF        := LEFT));
		ds_phoneVariations := NORMALIZE(ds_phoneVariations_raw, LEFT.phones, 
																		TRANSFORM(BusinessContactCard.Layouts.rec_phone_variations_normalized, 
																							SELF := LEFT, 
																							SELF := RIGHT));
		return ds_phoneVariations;
	end;
	
	EXPORT getPhoneVariationsRecords(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																	 BusinessContactCard.IParam.options in_mod) := function
		ds_phoneVariationsRecords_BIP := getPhoneVariationsRecords_BIP(ds_in, in_mod);
		ds_phoneVariationsRecords_BDID:= getPhoneVariationsRecords_BDID(ds_in);
		ds_phoneVariationsRecords			:= if(in_mod.isBIPReport, ds_phoneVariationsRecords_BIP, ds_phoneVariationsRecords_BDID);
		// output(ds_phoneVariationsRecords_BIP, named('ds_phoneVariationsRecords_BIP'));
		// output(ds_phoneVariationsRecords_BDID, named('ds_phoneVariationsRecords_BDID'));
		return ds_phoneVariationsRecords;
	end;
	
	SHARED getBusinessHeaderContact_BIP(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																			BusinessContactCard.IParam.options in_mod) := function
		bip_ids 											:= makeBusinessIds_BIP(ds_in);
		FETCH_LEVEL 									:= in_mod.BusinessReportFetchLevel;
		string8 CurDate := stringlib.getDateYYYYMMDD();
		ds_businessHeaderContact_raw	:= Bipv2_build.key_contact_linkids.kFetch(bip_ids, FETCH_LEVEL)
																		(current or
																		((unsigned4) dt_last_seen_contact <> 0 and 
																		(unsigned4) dt_last_seen_contact >= (unsigned4) ut.DateFrom_DaysSince1900(ut.DaysSince1900(CurDate[1..4], CurDate[5..6], CurDate[7..8]) - (integer)'730')));
		BusinessContactCard.Layouts.rec_contact xformContact(BusinessContactCard.Layouts.rec_ids_in L, ds_businessHeaderContact_raw R) := transform
			self.did 					:= R.contact_did;       
			self.record_type 	:= '';  //no equivalent in BIP?  
			self.company_title:= R.contact_job_title_derived;   
			self.title 				:= R.contact_name.title;
			self.fname 				:= R.contact_name.fname;
			self.mname				:= R.contact_name.mname;
			self.lname				:= R.contact_name.lname;
			self.name_suffix	:= R.contact_name.name_suffix;
			self.name_score		:= R.contact_name.name_score;
			self.ssn					:= R.contact_ssn;
			self.prim_range		:= R.company_address.prim_range;
			self.predir				:= R.company_address.predir;
			self.prim_name		:= R.company_address.prim_name;
			self.addr_suffix	:= R.company_address.addr_suffix;
			self.postdir			:= R.company_address.postdir;
			self.unit_desig		:= R.company_address.unit_desig;
			self.sec_range		:= R.company_address.sec_range;
			self.city					:= R.company_address.v_city_name;
			self.state				:= R.company_address.st;
			self.zip					:= (integer)R.company_address.zip;
			self.zip4					:= (integer)R.company_address.zip4;
			self.county				:= '';//L.company_address.fips_county;
			self.geo_lat			:= R.company_address.geo_lat;
			self.geo_long			:= R.company_address.geo_long;
			self.phone				:= if(R.company_phone <> '', (integer)R.company_phone, (integer)R.contact_phone);
			self.email_address:= R.contact_email;
			self.title_rank 	:= 0;
			self.is_exec 			:= false;
			self 							:= L;//acctno, BIP ids
			self							:= R;// dt_first_seen, dt_last_seen, source, from_hdr, company_department
		end;
		ds_businessHeaderContact_acctno	:= join(ds_in, ds_businessHeaderContact_raw,
																					LEFT.ultid  = RIGHT.ultid AND
																					LEFT.orgid  = RIGHT.orgid AND							
																					LEFT.seleid = RIGHT.seleid,
																					xformContact(left, right),
																					LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CONTACTS_PER_REC));
		ds_businessHeaderContact				:= DEDUP(SORT(ds_businessHeaderContact_acctno(did != 0), ultid, orgid, seleid, did, -dt_last_seen), ultid, orgid, seleid, did);
		// output(ds_businessHeaderContact_raw, named('ds_businessHeaderContact_raw'));
		// output(ds_businessHeaderContact, named('ds_businessHeaderContact'));
		return ds_businessHeaderContact;
	end;
	
	SHARED getBusinessHeaderContact_BDID(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in) := function
		CURRENT             						:= 'C';
		just_bdids    									:= DEDUP(SORT( PROJECT(ds_in, doxie_cbrs.layout_references), bdid ), bdid);
		ds_businessHeaderContact_raw 		:= doxie_cbrs.contact_records(just_bdids)(record_type = CURRENT AND TRIM(lname) != ''); //doxie_cbrs.layout_contacts 
		ds_businessHeaderContact_acctno	:= JOIN( ds_in, ds_businessHeaderContact_raw, 
		                                      LEFT.bdid = (UNSIGNED6)RIGHT.bdid,
																			    TRANSFORM(BusinessContactCard.Layouts.rec_contact,
																			              SELF						:= LEFT, //acctno, ids
																								    SELF          	:= RIGHT,
																										SELF.title_rank	:= 0,
																										SELF.is_exec		:= false),
																					LIMIT(0), KEEP(BusinessContactCard.Constants.MAX_CONTACTS_PER_REC));
		ds_businessHeaderContact				:= DEDUP(SORT(ds_businessHeaderContact_acctno(did != 0), bdid, did, -dt_last_seen), bdid, did);
		return ds_businessHeaderContact;
	end;
	
	EXPORT getBusinessHeaderContacts(dataset(BusinessContactCard.Layouts.rec_ids_in) ds_in,
																	 BusinessContactCard.IParam.options in_mod) := function
		// 	Go get the Contacts records. 
		//	Note that the 'same' Contact may be retrieved, as he/she may be a Contact for more than one business.
		// 	Dedup and sort will need to be handled by the caller
		ds_businessHeaderContact_BIP	:= getBusinessHeaderContact_BIP(ds_in, in_mod);
		ds_businessHeaderContact_BDID	:= getBusinessHeaderContact_BDID(ds_in);
		ds_businessHeaderContact			:= if(in_mod.isBIPReport, ds_businessHeaderContact_BIP, ds_businessHeaderContact_BDID);
		// output(ds_businessHeaderContact_BIP, named('ds_businessHeaderContact_BIP'));
		// output(ds_businessHeaderContact_BDID, named('ds_businessHeaderContact_BDID'));
		return ds_businessHeaderContact;
	end;
	
END;