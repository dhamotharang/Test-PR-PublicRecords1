Import data_services, prte2_bankruptcy,prte2_busreg,prte2_corp,prte2_gong,prte2_faa,prte2_fbn,prte2_foreclosure,prte2_globalwatchlists,
prte2_domains, prte2_liens, LiensV2, std, prte2_vehicle, prte2_lnproperty, prte2_ucc, prte2_watercraft,prte2_prof_License_MARI, 
prte2_sanctn, prte2_sanctn_np, BIPV2, _control,doxie_cbrs;

Export file_combined_business(Boolean FCRA = false, Boolean legacy = true) := Function

		// Integer Addresses_cnt;
		busad := if (	legacy,
																project(index(	{ unsigned6 bdid},
																															Layouts.bdid_pl_layout, Constants.Key_BDID_PL),
																								transform({unsigned6 id, integer Addresses_cnt := 1 , unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
																project(index({unsigned6 ultid, unsigned6 orgid, unsigned6 seleid, unsigned6 proxid, unsigned6 powid, unsigned6 empid, unsigned6 dotid},
																														Layouts.bipv2_header_layout, Constants.Key_Linkids),
																								transform({unsigned6 id, integer Addresses_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid))
														);

		busads := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(busad,Layouts.Layout_Businesses));//No FCRA business headers
		
		// Integer Bankruptcy_cnt;
		bk := if (legacy,
												project(prte2_bankruptcy.keys.key_bankruptcyv3_bdid(FCRA),
																				transform({unsigned6 id, integer Bankruptcy_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := (unsigned6)left.p_bdid)),
												project(prte2_bankruptcy.keys.key_bankruptcyv2_search_linkids.Key(seleid > 0),
																				transform({unsigned6 id, integer Bankruptcy_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid))
												);
		bks := project(bk,Layouts.Layout_Businesses);
		
		// Boolean in_Business_Header;
		bh := if (legacy,
												project(index({unsigned6 bdid}, layouts.business_header_best, Constants.Key_BH_Best),
																				transform({unsigned6 id, integer Business_Header_cnt := 1 , unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
												project(index({unsigned6 ultid, unsigned6 orgid, unsigned6 seleid, unsigned6 proxid, unsigned6 powid, unsigned6 empid, unsigned6 dotid},
																										Layouts.bipv2_header_layout,Constants.Key_Linkids),
																				transform({unsigned6 id, integer Business_Header_cnt := 1 , unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));

		bhs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(bh,Layouts.Layout_Businesses));
		
		// Integer Business_Associates_cnt;
		bassoc_bdid := project(index({unsigned6 bdid}, layouts.business_header_best, Constants.Key_BH_Best),doxie_cbrs.layout_references);
		ba_bdid := business_associates_records(bassoc_bdid);
		bassoc_linkid := index(	{unsigned6 seleid1, unsigned6 seleid2},
																										{unsigned6 seleid1,  unsigned6 seleid2,  integer2 duns_number_score,  integer2 duns_number_cnt,  integer2 enterprise_number_score,  integer2 enterprise_number_cnt,  integer2 source_score,  integer2 source_cnt,  integer2 contact_score,  integer2 contact_cnt,  integer2 address_score,  integer2 address_cnt,  integer2 namest_score,  integer2 namest_cnt,  integer2 charter_score,  integer2 charter_cnt,  integer2 fein_score,  integer2 fein_cnt,  integer2 mname_score,  integer2 contact_ssn_score,  integer2 contact_phone_score,  integer2 contact_email_username_score,  unsigned4 dt_first_seen_track,  unsigned4 dt_last_seen_track,  unsigned4 dt_first_seen_contact_track,  unsigned4 dt_last_seen_contact_track,  unsigned2 total_cnt,  integer2 total_score},
																										Constants.Key_Bipv2_seleid_relative);
		ba_link := project(dedup(bassoc_linkid, seleid1, seleid2, all), {unsigned6 seleid1, unsigned6 seleid2});
		ba := if(	legacy,
												project(ba_bdid(bdid != 0),
																				transform({unsigned6 id, integer Business_Associates_cnt := 1 , unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
												project(ba_link,
																				transform({unsigned6 id, integer Business_Associates_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid1, self.ultid := left.seleid1, self.orgid := left.seleid1))
										);
		bas :=  if(FCRA, Dataset([],Layouts.Layout_Businesses),project(ba,Layouts.Layout_Businesses));
		
		// Integer Business_Industry_NAICS_cnt;
					bin  := project(	index({unsigned6 ultid, unsigned6 orgid, unsigned6 seleid, unsigned6 proxid, unsigned6 powid, unsigned6 empid, unsigned6 dotid},
																												layouts.bipv2_industry_linkids,Constants.Key_BipV2_Industry),
																						transform({unsigned6 id, integer Business_Industry_NAICS_cnt := 1 , unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid));
					bins := 	 if (legacy,
																			Dataset([],Layouts.Layout_Businesses),
																			project(bin,Layouts.Layout_Businesses));
																			
		// Integer Business_Name_Variations_cnt;
			ds_name_var := index({unsigned6 bdid}, layouts.bdid_pl_layout, constants.Key_BDID_PL);
			ds_name_var_dedup := dedup(sort(ds_name_var, bdid, company_name), bdid, company_name);
		 name_v :=  if(	legacy,
																		project(ds_name_var_dedup(bdid != 0),
																										transform({unsigned6 id, integer Business_Associates_cnt := 1 , unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
																		project(	index({unsigned6 ultid, unsigned6 orgid, unsigned6 seleid, unsigned6 proxid, unsigned6 powid, unsigned6 empid, unsigned6 dotid},
																												Layouts.BipV2_best_linkids,Constants.Key_Best_Linkids),
																											transform({unsigned6 id, integer Business_Name_Variations_cnt := 1 , unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		 name_vs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(name_v,Layouts.Layout_Businesses));
		
		// Integer Business_Registrations_cnt;
		busreg := if(	legacy,
																project(prte2_busreg.keys.key_busreg_company_bdid (bdid != 0),
																				transform({unsigned6 id, integer Business_Registrations_cnt := 1 , unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
																project(prte2_busreg.keys.key_busreg_company_linkids.Key,
																				transform({unsigned6 id, integer Business_Registrations_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		busregs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(busreg,Layouts.Layout_Businesses));
		
		// Integer Corporations_SOS_cnt;
		corpsos := if(legacy,
																project(prte2_corp.files.corp2_corp_Base(corp_src_type = 'SOS'),
																				transform({unsigned6 id, integer Corporations_SOS_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0 }, self.id := left.bdid)),
																project(prte2_corp.Keys.Key_Corp2_LinkIDs.Key(corp_src_type = 'SOS'),
																				transform({unsigned6 id, integer Corporations_SOS_cnt := 1, unsigned6 ultid, unsigned6 orgid }, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		corpsoss := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(corpsos,Layouts.Layout_Businesses));
		
		// Integer Directory_Assistance_Gong_cnt;
		gong := if( legacy,
														project(prte2_gong.keys.key_gong_hist_bdid,
																		transform({unsigned6 id, integer Directory_Assistance_Gong_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
														project(prte2_gong.keys.LinkIds.Key,
																		transform({unsigned6 id, integer Directory_Assistance_Gong_cnt := 1 , unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		
		gongs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(gong,Layouts.Layout_Businesses));
		
		// Integer Executives_cnt;
		exec := if(legacy,
													project(index(	{ unsigned6 bdid},
																						Layouts.layout_contacts_bdid, 
																						constants.Key_Business_Header_Contacts)(BIPV2.BL_Tables.ContactTitle(company_title) in set(BIPV2.BL_Tables.ExecutiveTitles, position_title)),
																					transform({unsigned6 id, integer Executives_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
													project(index( 	{unsigned6 ultid,unsigned6 orgid,unsigned6 seleid,unsigned6 proxid,unsigned6 powid,unsigned6 empid,unsigned6 dotid},
																						Layouts.bip_contact_linkid,
																						constants.Key_BipV2_Contacts)(executive_ind = true),
																					transform({unsigned6 id, integer Executives_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		execs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(exec,Layouts.Layout_Businesses));
		
		// Integer FAA_Aircraft_cnt;
		faa := if (	legacy,
														project(prte2_faa.keys.Key_Aircraft_reg_bdid,
																		transform({unsigned6 id, integer FAA_Aircraft_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bd)),
														project(prte2_faa.keys.key_aircraft_linkids.Key,
																		transform({unsigned6 id, integer FAA_Aircraft_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		faas := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(faa,Layouts.Layout_Businesses));
		
		// Integer Fictitious_Businesses_cnt;
		fbn := if(legacy,
												project(prte2_fbn.keys.key_fbnv2_bdid,
																transform({unsigned6 id, integer Fictitious_Businesses_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
												project(prte2_fbn.keys.Key_LinkIds.key,
																transform({unsigned6 id, integer Fictitious_Businesses_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		fbns := project(fbn,Layouts.Layout_Businesses);
		
		// Integer Foreclosure_cnt;
		fcl := if(legacy,
												project(prte2_foreclosure.keys.key_foreclosures_bdid,
																transform({unsigned6 id, integer Foreclosure_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
												project(prte2_foreclosure.keys.key_foreclosures_linkids.key,
																transform({unsigned6 id, integer Foreclosure_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		fcls := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(fcl,Layouts.Layout_Businesses));
		
		// Integer GWL_cnt;
		gwl := prte2_globalwatchlists.keys.key_patriot_bdid_file;
		Layouts.Layout_Businesses from_gwl(gwl le) := transform
			self.ID := (unsigned6)le.bdid;
			self.GWL_cnt := 1;
		end;
		gwls := if (legacy and ~FCRA, project(gwl,from_gwl(left)), Dataset([],Layouts.Layout_Businesses));
		
		// Boolean in_GWL_OFAC_Only;
		gwlo := prte2_globalwatchlists.Files.GWL_patriot_bdid(bdid!=0,pty_key[1..4]= 'OFAC');
		Layouts.Layout_Businesses from_gwlo(gwlo le) := transform
			self.ID := (unsigned6)le.bdid;
			self.GWL_OFAC_Only_cnt := 1;
		end;
		gwlos := if (legacy and ~FCRA, project(gwlo, from_gwlo(left)), Dataset([],Layouts.Layout_Businesses));
		
		// Integer Internet_Domain_cnt;
		dom := if(legacy,
												project(prte2_domains.keys.Key_bdid,
																transform({unsigned6 id, integer Internet_Domain_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
												project(prte2_domains.keys.Key_LinkIds.key,
																transform({unsigned6 id, integer Internet_Domain_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		doms := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(dom, Layouts.Layout_Businesses));
		
		// Integer Liens_cnt;
		lien := if(legacy,
													project(PRTE2_liens.Key_liens_BDID(FCRA),
																	transform({unsigned6 id, integer Liens_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.p_bdid)),
													project(PRTE2_liens.Key_party_LinkIDs.key,
																	transform({unsigned6 id, integer Liens_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		liens := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(lien, Layouts.Layout_Businesses));

		// Integer Judgements_cnt;
		jdg_bdid := join(prte2_liens.files.Party_out((integer)bdid>0), 
																			prte2_liens.files.main_out(filing_type_desc in LiensV2.filing_type_desc.JUDGMENT), 
																			left.tmsid = right.tmsid and left.rmsid = right.rmsid,
																			transform({unsigned6 id, integer Judgements_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := (unsigned6)left.bdid));
		jdg_linkid := join(PRTE2_liens.Key_party_LinkIDs.key, 
																					prte2_liens.files.main_out(filing_type_desc in LiensV2.filing_type_desc.JUDGMENT), 
																					left.tmsid = right.tmsid and left.rmsid = right.rmsid,
																					transform({unsigned6 id, integer Judgements_cnt := 1, unsigned6 ultid, unsigned6 orgid},  self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid));
		jdg := if(legacy,jdg_bdid, jdg_linkid);
		jdgs :=if(FCRA, Dataset([],Layouts.Layout_Businesses),project(jdg,Layouts.Layout_Businesses));
		
		// Integer Evictions_cnt;
		evc_bdid := join(prte2_liens.files.Party_out((integer)bdid>0), 
																			prte2_liens.files.main_out(std.str.touppercase(eviction) = 'Y'), 
																			left.tmsid = right.tmsid and left.rmsid = right.rmsid,
																			transform({unsigned6 id, integer Evictions_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := (unsigned6)left.bdid));
		evc_linkid := join(PRTE2_liens.Key_party_LinkIDs.key, 
																					prte2_liens.files.main_out(std.str.touppercase(eviction) = 'Y'), 
																					left.tmsid = right.tmsid and left.rmsid = right.rmsid,
																					transform({unsigned6 id, integer Evictions_cnt := 1, unsigned6 ultid, unsigned6 orgid},  self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid));
		evc := if(legacy, evc_bdid, evc_linkid);
		evcs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(evc, Layouts.Layout_Businesses));
		
		// Integer MVR_cnt;
		v := if (legacy,
										 project( prte2_vehicle.keys.bdid,
															transform({unsigned6 id, integer MVR_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.Append_BDID)),
										 project( prte2_vehicle.keys.linkids.key,
															transform({unsigned6 id, integer MVR_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		vs := project(v, Layouts.Layout_Businesses);
		
		// Integer Property_cnt;
		prop := if(	legacy,
														project(prte2_lnproperty.keys.Key_Search_BDID,
																		transform({unsigned6 id, integer Property_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
														project(prte2_lnproperty.keys.Key_LinkIds.key,
																		transform({unsigned6 id, integer Property_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		props := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(prop, Layouts.Layout_Businesses));
		
		// Integer Registered_Agent_cnt;			
		slimrec := record
			prte2_corp.files.corp2_corp_Base.corp_ra_name;
			prte2_corp.files.corp2_corp_Base.bdid;
			prte2_corp.files.corp2_corp_Base.corp_key;
		end;
		corp_linkids := prte2_corp.keys.Key_Corp2_LinkIDs.key(corp_ra_title_desc = 'REGISTERED AGENT');
		slimrec2 := record
			corp_linkids.corp_ra_name;
			corp_linkids.ultid;
			corp_linkids.orgid;
			corp_linkids.seleid;
			corp_linkids.corp_key;
		end;
		slimcorp := dedup(project(prte2_corp.files.corp2_corp_Base, slimrec), record, all);
		rega_linkid := project(dedup(project(corp_linkids, slimrec2), record, all), 
																									transform({unsigned6 id, integer Registered_Agent_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid));
		rega_bdid := join(	prte2_corp.files.corp2_cont_Base, 
																					slimcorp,
																					left.cont_name = right.corp_ra_name and
																					left.bdid = right.bdid and
																					left.corp_key = right.corp_key,
																					transform({unsigned6 id, integer Registered_Agent_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid));
		rega := if(legacy, rega_bdid, rega_linkid);
		regas := project(rega, Layouts.Layout_Businesses);
		
		// Integer UCC_cnt;
		ucc := if(	legacy,
													project(prte2_ucc.keys.key_bdid,
																	transform({unsigned6 id, integer UCC_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
													project(prte2_ucc.keys.Key_LinkIds.key,
																	transform({unsigned6 id, integer UCC_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));
		uccs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(ucc, Layouts.Layout_Businesses));
		
		// Integer Watercraft_cnt;
		wtrc := if(	legacy,
														project(prte2_watercraft.keys.key_watercraft_bdid,
																		transform({unsigned6 id, integer Watercraft_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.l_bdid)),
														project(prte2_watercraft.keys.Key_LinkIds.key,
																		transform({unsigned6 id, integer Watercraft_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));			
		wtrcs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(wtrc,Layouts.Layout_Businesses));
		
		
//Integer MARI_License	
		mari := if(	legacy,
														project(prte2_prof_license_mari.keys.key_bdid,
																		transform({unsigned6 id, integer MARI_License_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
														project(prte2_prof_license_mari.keys.Key_LinkIds.key,
																		transform({unsigned6 id, integer MARI_License_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));			
		maris := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(mari,Layouts.Layout_Businesses));
				

//Integer Public Sanctn	
		sanctn := if(	legacy,
														project(prte2_sanctn.keys.midex_rpt_nbr(bdid != 0),
																		transform({unsigned6 id, integer Public_Sanctn_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
														project(prte2_sanctn.keys.LinkIds.key,
																		transform({unsigned6 id, integer Public_Sanctn_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));			
		sanctns := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(sanctn,Layouts.Layout_Businesses));


//Integer NonPublic Sanctn
 	sanctn_np := if(	legacy,
														project(prte2_sanctn_np.keys.midex_rpt_nbr(bdid != 0, dbcode = 'N'),
																		transform({unsigned6 id, integer NonPublic_Sanctn_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
														project(prte2_sanctn_np.keys.linkids_party(dbcode = 'N'),
																		transform({unsigned6 id, integer NonPublic_Sanctn_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));			
		sanctn_nps := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(sanctn_np,Layouts.Layout_Businesses));


//Integer FreddieMac	
		freddie_mac := if(	legacy,
														project(prte2_sanctn_np.keys.midex_rpt_nbr(bdid != 0, dbcode = 'F'),
																		transform({unsigned6 id, integer FreddieMac_Sanctn_cnt := 1, unsigned6 ultid :=0, unsigned6 orgid:=0}, self.id := left.bdid)),
														project(prte2_sanctn_np.keys.linkids_party(dbcode = 'F'),
																		transform({unsigned6 id, integer FreddieMac_Sanctn_cnt := 1, unsigned6 ultid, unsigned6 orgid}, self.id := left.seleid, self.ultid := left.ultid, self.orgid := left.orgid)));			
		freddie_macs := if(FCRA, Dataset([],Layouts.Layout_Businesses),project(freddie_mac,Layouts.Layout_Businesses));

		
combined_business := (bks + busregs + corpsoss + gongs + faas + fbns + fcls + gwls + gwlos + doms +
																						liens + jdgs + evcs + vs + props + regas + uccs + wtrcs + busads + execs + 
																						bhs + bas + bins + name_vs + maris + sanctns + sanctn_nps + freddie_macs)(id<>0);

		comb_cnts_d := distribute(combined_business, hash(id));
		
	

		business_grouped_layout := record
				Unsigned6 ID := comb_cnts_d.id;
				Unsigned6 UltID := Max(group,comb_cnts_d.ultid);
				Unsigned6 OrgID := Max(group,comb_cnts_d.orgid);
				Integer Addresses_cnt := sum(group,comb_cnts_d.Addresses_cnt   );
				Integer Bankruptcy_cnt := sum(group,comb_cnts_d.Bankruptcy_cnt   );
				Boolean in_Business_Header := if(sum(group,comb_cnts_d.Business_Header_cnt) > 0, true, false);
				Integer Business_Associates_cnt := sum(group,comb_cnts_d.Business_Associates_cnt   );
				Integer Business_Industry_NAICS_cnt := sum(group,comb_cnts_d.Business_Industry_NAICS_cnt   );		
				Integer Business_Name_Variations_cnt := sum(group,comb_cnts_d.Business_Name_Variations_cnt   );
				Integer Business_Registrations_cnt := sum(group,comb_cnts_d.Business_Registrations_cnt   );
				Integer Corporations_SOS_cnt := sum(group,comb_cnts_d.Corporations_SOS_cnt   );
				Integer Directory_Assistance_Gong_cnt := sum(group,comb_cnts_d.Directory_Assistance_Gong_cnt   );
				Integer Executives_cnt := sum(group,comb_cnts_d.Executives_cnt   );
				Integer FAA_Aircraft_cnt := sum(group,comb_cnts_d.FAA_Aircraft_cnt   );
				Integer Fictitious_Businesses_cnt := sum(group,comb_cnts_d.Fictitious_Businesses_cnt   );
				Integer Foreclosure_cnt := sum(group,comb_cnts_d.Foreclosure_cnt   );
				Integer GWL_cnt := sum(group,comb_cnts_d.GWL_cnt   );
				Boolean in_GWL_OFAC_Only := if(sum(group,comb_cnts_d.GWL_OFAC_Only_cnt)>0, true, false);
				Integer Internet_Domain_cnt := sum(group,comb_cnts_d.Internet_Domain_cnt   );
				Integer Liens_cnt := sum(group,comb_cnts_d.Liens_cnt   );		
				Integer Judgements_cnt := sum(group,comb_cnts_d.Judgements_cnt   );
				Integer Evictions_cnt := sum(group,comb_cnts_d.Evictions_cnt   );
				Integer MVR_cnt := sum(group,comb_cnts_d.MVR_cnt   );
				Integer Property_cnt := sum(group,comb_cnts_d.Property_cnt   );
				Integer Registered_Agent_cnt := sum(group,comb_cnts_d.Registered_Agent_cnt   );
				Integer UCC_cnt := sum(group,comb_cnts_d.UCC_cnt   );
				Integer Watercraft_cnt := sum(group,comb_cnts_d.Watercraft_cnt   );
				Integer MARI_License_cnt := sum(group,comb_cnts_d.Mari_License_cnt );
				Integer Public_Sanctn_cnt := sum(group,comb_cnts_d.Public_Sanctn_cnt );
				Integer NonPublic_Sanctn_cnt := sum(group,comb_cnts_d.NonPublic_Sanctn_cnt );
				Integer FreddieMac_Sanctn_cnt := sum(group,comb_cnts_d.FreddieMac_Sanctn_cnt );
		end;      
							 

		business_grouped := table(comb_cnts_d,business_grouped_layout,id, local);

		ds_businesses 	:= dataset([	
									{1,1,1,1,1,true,1,1,1,1,1,1,1,1,1,1,1,false,1,1,1,1,1,1,1,1,1,1,1,1,1},
									{2,2,2,2,2,true,2,2,2,2,2,2,2,2,2,2,2,false,2,2,2,2,2,2,2,2,2,2,2,2,2},
									{3,3,3,3,3,true,3,3,3,3,3,3,3,3,3,3,3,true,3,3,3,3,3,3,3,3,3,3,3,3,3}], 
									business_grouped_layout)
									+ 
									business_grouped;


		return ds_businesses;
End;