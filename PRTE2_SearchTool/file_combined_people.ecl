import data_services, prte2_bankruptcy, prte2_corp, prte2_globalwatchlists,prte2_corp,prte2_doc,prte2_death_master,ut,
	prte2_gong,prte2_dlv2,prte2_email_data,prte2_faa,prte2_foreclosure,prte2_lnproperty,prte2_sexoffender,PRTE2_liens,Risk_Indicators,
	prte2_paw,doxie_build,Relationship,prte2_vehicle,prte2_watercraft,prte2_prof_licensev2, header, std, doxie,prte2_header,BIPV2,
	prte2_marriage_divorce,LiensV2, RoxieKeyBuild, prte2_phonesplus, AddressReport_Services, personReports,PRTE2_Infutor, 
	prte2_doc_images, prte2_sexoffender_images, prte2_Prof_License_Mari, prte2_sanctn, prte2_sanctn_np;
	
	
EXPORT file_combined_people(Boolean FCRA = false, Boolean dtc = false) := function

		bk := prte2_bankruptcy.keys.key_bankruptcyv3_did(FCRA);
		Layouts.Layout_People from_bk(bk le) := transform
			self.did := (unsigned6)le.did;//debtor_did
			self.Bankruptcy_cnt := 1;
			end;
		bks := project(bk,from_bk(left));

		cp := prte2_corp.keys.key_corp_cont_did(ut.TitleRank(cont_type_desc) <= 6 and did!=0);
		Layouts.Layout_People from_corp(cp le) := transform
			self.did := (unsigned6)le.did;
			self.Corporate_Affiliation_cnt := 1;
		end;
		cps := if (FCRA, Dataset([],Layouts.Layout_People), project(cp,from_corp(left)));  //No FCRA data for corp

		c := prte2_doc.keys.key_criminal_offenders_did(FCRA);// 
		Layouts.Layout_People from_c(c le) := transform
			self.did := (unsigned6)le.did;
			self.Criminal_cnt := 1;
		end;
		cs := project(c,from_c(left));

		cdoc := prte2_doc.keys.key_criminal_offenders_did(FCRA)(data_type='1');// 
		Layouts.Layout_People from_cdoc(cdoc le) := transform
			self.did := (unsigned6)le.did;
			self.Criminal_DOC_cnt := 1;
		end;
		cdocs := project(cdoc,from_cdoc(left));

		dm := if (FCRA,prte2_death_master.keys.key_death_masterv2_did_fcra, prte2_death_master.keys.key_death_masterv2_did);
		Layouts.Layout_People from_dm(dm le) := transform
			self.did := (unsigned6)le.did;
			self.Deceased_cnt := 1;
		end;
		dms := project(dm, from_dm(left));

		gn := prte2_gong.keys.key_gong_history_did(FCRA);
		Layouts.Layout_People from_gn(gn le) := transform
			self.did := (unsigned6)le.did;
			self.Directory_Assistance_Gong_cnt := 1;
		end;
		gns := project(gn, from_gn(left));

		d :=  prte2_dlv2.keys.key_dl2_dl_did_public;
		Layouts.Layout_People from_d(d le) := transform
			self.did := le.did;
			self.DL_cnt := 1;
		end;  
		ds := if (FCRA, Dataset([],Layouts.Layout_People), project(d,from_d(left)));  //No FCRA data for dl

		em := prte2_email_data.keys.key_did(FCRA);
		Layouts.Layout_People from_em(em le) := transform
			self.did := (unsigned6)le.did;
			self.Email_cnt := 1;
		end;  
		ems := project(em,from_em(left));

		faaf := prte2_faa.keys.key_aircraft_did(FCRA);
		Layouts.Layout_People from_faa(faaf le) := transform
			self.did := (unsigned6)le.did;
			self.FAA_Aircraft_cnt := 1;
		end;
		fas := project(faaf,from_faa(left));

		fcl := prte2_foreclosure.keys.key_foreclosures_did;
		Layouts.Layout_People from_fcl(fcl le) := transform
			self.did := (unsigned6)le.did;
			self.Foreclosure_cnt := 1;
		end;
		fcls := if (FCRA, Dataset([],Layouts.Layout_People), project(fcl, from_fcl(left)));//No foreclosure fcra data

		nod := prte2_foreclosure.keys.key_NOD_DID;
		Layouts.Layout_People from_nod(nod le) := transform
			self.did := (unsigned6)le.did;
			self.Notice_of_Default_cnt := 1;
		end;
		nods := if (FCRA, Dataset([],Layouts.Layout_People), project(nod, from_nod(left)));//No foreclosure fcra data

		gwl := prte2_globalwatchlists.keys.key_patriot_did_file;
		Layouts.Layout_People from_gwl(gwl le) := transform
			self.did := (unsigned6)le.did;
			self.GWL_cnt := 1;
		end;
		gwls := if (FCRA, Dataset([],Layouts.Layout_People), project(gwl, from_gwl(left)));//No globalwatchlist FCRA data

		pr :=  prte2_lnproperty.keys.key_search_did(FCRA);
		Layouts.Layout_People from_prop(pr le) := transform
			self.did := (unsigned6)le.s_did;
			self.Property_cnt := 1;
		end;
		ps := project(pr,from_prop(left));  

		s := prte2_sexoffender.keys.Key_SexOffender_DID(FCRA);//  SexOffender.file_Main;
		Layouts.Layout_People from_s(s le) := transform
			self.did := (unsigned6)le.did;
			self.Sex_Offender_cnt := 1;
		end;
		ss := project(s,from_s(left));
		
		paw := if(FCRA, project(prte2_paw.keys.key_did_fcra,{ unsigned6 did, unsigned6 contact_id }), prte2_paw.keys.key_did);
		Layouts.Layout_People from_paw(paw le) := TRANSFORM
			self.did := (unsigned6)le.did;
			self.People_at_Work_cnt := 1;
		END;
		d_paw := project(paw,from_paw(LEFT));
		
		h := 	if(	~dtc,
							if(FCRA,
								project(index({unsigned6 s_did},
															{Layouts.person_header_fcra},
															constants.FCRA_Header),//prte2_header.files.file_headers;//doxie_build.file_header_building; 
												transform({Layouts.person_header}, self.did := left.s_did, self := left))
								,
								project(dataset(constants.File_Person_Header,
																{prte2_header.files.file_headers},
																flat),
												{Layouts.person_header})),
							project(PRTE2_Infutor.Keys.key_infutorbest_did,Layouts.person_header) );		//key_infutorbest_did//Key_Header_Infutor_Knowx
		Layouts.Layout_People from_h(h le) := transform
			self.Person_Header_cnt := 1;
			self.did := le.did;
		end;
		hs := project(h,from_h(left));

		Layouts.Layout_People from_ha(h le) := transform
			self.Addresses_cnt := 1;
			self.did := le.did;
		end;
		has := project(dedup(h,did,prim_range ,predir ,prim_name ,suffix ,postdir ,unit_desig ,sec_range ,city_name ,st ,zip ,zip4,ALL), from_ha(left));

		Layouts.Layout_People from_hssn(h le) := transform
			self.SSN_Cnt   := 1;
			self.did := le.did;
		end;
		hssns := project(dedup(h,did,ssn,ALL), from_hssn(left));

		
		rel1 := Relationship.file_relative;
		PRTE2_SearchTool.Layouts.Layout_People from_rel1(rel1 le) := transform
			self.First_Degree_Relatives_cnt   := 1;
			self.did := le.did1;
		end;
		rel1s := if (FCRA, 
															Dataset([],PRTE2_SearchTool.Layouts.Layout_People),
															project(dedup(rel1(title in Header.relative_titles.set_FirstDegreeRelative),did1,did2,ALL), from_rel1(left)));//no fcra relatives

		relative1 := distribute(Relationship.file_relative(title in Header.relative_titles.set_FirstDegreeRelative), hash(did1, did2));

//Find second degree relatives.  Block case of second degree relative being self.
		first_second_dg_rels := join(	relative1, 
																																							relative1, 
																																							left.did2 = right.did1 and left.did1 != right.did2,
																																							transform({unsigned6 did1, unsigned6 did2}, self.did1 := left.did1, self.did2 := right.did2)
																																							,local);

		r4 := dedup(sort(first_second_dg_rels,record,local),did1,did2,local);
//Remove cases where second degree relative is also a first degree relative.
		r5 := join(	r4, relative1, 
								left.did1 = right.did1 and left.did2 = right.did2,
								transform(	{unsigned6 did1, unsigned6 did2},
														self.did1 := left.did1,
														self.did2 := left.did2),
								local);
		r6 := project(r4 + r5,{	unsigned6 did1,unsigned6 did2,boolean dg1:= false});
		r7 := rollup(sort(r6, did1,did2,local), transform({	unsigned6 did1,unsigned6 did2,boolean dg1:= false}, self.dg1 := true, self := left), did1, did2);
		
		second_dg_rels := r7(dg1 = false);
		PRTE2_SearchTool.Layouts.Layout_People from_rel3(second_dg_rels le) := transform
			self.Second_Degree_Relatives_cnt   := 1;
			self.did := le.did1;
		end;
		rel3s := if (FCRA, Dataset([],PRTE2_SearchTool.Layouts.Layout_People),project(second_dg_rels, from_rel3(left)));//no fcra relatives
//Third degree relatives
	    third_dg_rels_inclusive1 := join(	second_dg_rels, 
																																							relative1, 
																																							left.did2 = right.did1 and left.did1 != right.did2,
																																							transform({unsigned6 did1, unsigned6 did2}, self.did1 := left.did1, self.did2 := right.did2)
																																							,local);
				 //Remove first and second degree relatives that are included in third_dg_rels_inclusive1
					third_inclusive := project(third_dg_rels_inclusive1,{	unsigned6 did1,unsigned6 did2,string dg12:= 'third'});
					lower_inclusive := project(first_second_dg_rels ,{	unsigned6 did1,unsigned6 did2,string dg12:= 'lower'});
					third_and_lower_inclusive := third_inclusive + lower_inclusive;
				
					third_dg_rels := rollup(sort(third_and_lower_inclusive, did1,did2,local), transform({	unsigned6 did1,unsigned6 did2,string dg12}, self.dg12 := 'both', self := left), did1, did2)(dg12 = 'third');

				PRTE2_SearchTool.Layouts.Layout_People from_rel4(third_dg_rels le) := transform
						self.Third_Degree_Relatives_cnt   := 1;
						self.did := le.did1;
						end;
				rel4s := if (FCRA, Dataset([],PRTE2_SearchTool.Layouts.Layout_People),project(third_dg_rels, from_rel4(left)));//no fcra relatives
						
		assoc := Relationship.file_relative(Header.relative_titles.fn_get_str_title(title) = 'Associate');
		Layouts.Layout_People from_assoc(assoc le) := transform
			self.Associates_cnt   := 1;
			self.did := le.did1;
		end;
		assocs := if (FCRA, Dataset([],Layouts.Layout_People),project(dedup(assoc,did1,did2,ALL), from_assoc(left)));//no fcra relatives

		nbhr := Relationship.file_relative(Header.relative_titles.fn_get_str_title(title) = 'Neighbor');
		Layouts.Layout_People from_nbhr(nbhr le) := transform
			self.Neighbors_cnt   := 1;
			self.did := le.did1;
		end;
		nbhrs := if (FCRA, Dataset([],Layouts.Layout_People),project(dedup(nbhr,did1,did2,ALL), from_nbhr(left)));//no fcra relatives

		v := prte2_vehicle.keys.did;
		Layouts.Layout_People from_v(v le) := transform
			self.did := le.append_did;
			self.MVR_cnt := 1;				   
		end;
		vs := if (FCRA, Dataset([],Layouts.Layout_People),project(v,from_v(left)));//There's no FCRA vehicle data

		m := prte2_watercraft.keys.key_watercraft_did(FCRA);
		Layouts.Layout_People from_m(m le) := transform
			self.did := le.l_did;
			self.Watercraft_cnt := 1;
		end;
		ms := project(m,from_m(left));

		pl := prte2_prof_licensev2.keys.key_proflic_did(FCRA);
		Layouts.Layout_People from_pl(pl le) := transform
			self.did := (unsigned6)le.did;
			self.Professional_License_cnt := 1;
		end;
		pls := project(pl,from_pl(left));  


		gwlo :=  prte2_globalwatchlists.keys.key_patriot_did_file(pty_key[1..4]= 'OFAC');//prte2_globalwatchlists.Files.GWL_dids(pty_key[1..4]= 'OFAC');
		Layouts.Layout_People from_gwlo(gwlo le) := transform
			self.did := (unsigned6)le.did;
			self.GWL_OFAC_Only_cnt := 1;
		end;
		gwlos := if (FCRA, Dataset([],Layouts.Layout_People),project(gwlo, from_gwlo(left)));//No FCRA data for global watch list

		//fcra headers handled in definition of h above
		aka := dedup(sort(h, did, title, fname, mname, lname, name_suffix), did, title, fname, mname, lname, name_suffix);
		Layouts.Layout_People from_aka(aka le) := transform
			self.did := (unsigned6)le.did;
			self.AKAs_cnt := 1;
		end;
		akas := project(aka, from_aka(left));

		mdv := prte2_marriage_divorce.keys.key_mar_div_did(FCRA);
		Layouts.Layout_People from_mdv(mdv le) := transform
			self.did := (unsigned6)le.did;
			self.Marriage_and_Divorce_cnt := 1;
		end;
		mdvs := project(mdv, from_mdv(left));

		lien := PRTE2_liens.key_liens_DID(FCRA);
		Layouts.Layout_People from_lien(lien le) := transform
			self.did := (unsigned6)le.did;
			self.Liens_cnt := 1;
		end;
		liens := project(lien, from_lien(left));

		jdg := join(	lien,
									prte2_liens.files.main_out(filing_type_desc in LiensV2.filing_type_desc.JUDGMENT), 
									left.tmsid = right.tmsid and left.rmsid = right.rmsid,
									transform({string12 did}, self.did := (string) left.did, self := left, self := right));
		Layouts.Layout_People from_jdg(jdg le) := transform
			self.did := (unsigned6)le.did;
			self.Judgements_cnt := 1;
		end;
		jdgs := project(jdg, from_jdg(left));

		evc := join(	lien, prte2_liens.files.main_out(std.str.touppercase(eviction) = 'Y'), 
									left.tmsid = right.tmsid and left.rmsid = right.rmsid,
									transform({string12 did}, self.did := (string) left.did, self := left, self := right));
		Layouts.Layout_People from_evc(evc le) := transform
			self.did := (unsigned6)le.did;
			self.Evictions_cnt := 1;
		end;
		evcs := project(evc, from_evc(left));

		ppls := prte2_phonesplus.keys.key_phonesplus_did;
		Layouts.Layout_People from_ppls(ppls le) := transform
			self.did := (unsigned6)le.l_did;
			self.PhonesPlus_cnt := 1;
		end;
		pplss := if (FCRA, Dataset([],Layouts.Layout_People), project(ppls, from_ppls(left)));//There's no FCRA phonesplus data

		slimrec := record
			prte2_corp.files.corp2_corp_Base.corp_ra_name;
			prte2_corp.files.corp2_corp_Base.bdid;
			prte2_corp.files.corp2_corp_Base.corp_key;
		end;
		slimcorp := dedup(project(prte2_corp.files.corp2_corp_Base, slimrec), record, all);
		rega := join(	prte2_corp.files.corp2_cont_Base, 
					slimcorp,
					left.cont_name = right.corp_ra_name and
					left.bdid = right.bdid and
					left.corp_key = right.corp_key,
					transform({unsigned6 did}, self := left));
		Layouts.Layout_People from_rega(rega le) := transform
			self.did := (unsigned6)le.did;
			self.Registered_Agent_cnt := 1;
		end;
		regas := if (FCRA, Dataset([],Layouts.Layout_People), project(rega, from_rega(left)));//No FCRA corp

		exec_file := index(	{ unsigned6 bdid},
										Layouts.layout_contacts_bdid, constants.Key_Business_Header_Contacts);
		exec := exec_file(BIPV2.BL_Tables.ContactTitle(company_title) in set(BIPV2.BL_Tables.ExecutiveTitles, position_title));
		Layouts.Layout_People from_exec(exec le) := transform
			self.did := (unsigned6)le.did;
			self.Executives_cnt := 1;
		end;
		execs := if (FCRA, Dataset([],Layouts.Layout_People),project(exec(did != 0), from_exec(left))); //no FCRA business_header data
		
		//fcra headers handled in h above
		h2 := project(h, recordof(h) or {dataset(Risk_Indicators.Layout_Desc) HRI_Address := dataset([], Risk_Indicators.Layout_Desc)});
		maxHriPer_value := AddressReport_Services.Constants.MaxCountHRI;
		doxie.mac_AddHRIAddress(h2, outfile);
		hri_addr := outfile(Count(HRI_Address) >0);
		Layouts.Layout_People from_hri_addr(hri_addr le) := transform
			self.did := (unsigned6)le.did;
			self.Address_HRI_cnt := 1;
		end;
		hri_addrs := project(hri_addr(did != 0), from_hri_addr(left));
		
		layout_names_HRI := recordof(h) or {personReports.layouts.ssn_hri_rec and not [ssn]};        
		persons_noHRI := project( h(ssn!=''), transform(layout_names_HRI,self := left,
																												self.cnt := 0,
																											 self.ssn_issue_early := 0,
																											 self.ssn_issue_last := 0,
																											 self.ssn_issue_place := '' ,
																											 self.hri_ssn := dataset([],risk_indicators.layout_desc)
																											 ));
		mac_AddHRISSN(persons_noHRI,persons_HRI,FALSE,20);
		hri_ssn := persons_HRI(count(hri_ssn) >0);
		Layouts.Layout_People from_hri_ssn(hri_ssn le) := transform
			self.did := (unsigned6)le.did;
			self.SSN_HRI_cnt := 1;
		end;
		hri_ssns := project(hri_ssn(did != 0), from_hri_ssn(left));


// Integer	DocImages_cnt
		// d_image := prte2_doc_images.Keys.DID;
		// Layouts.Layout_People from_doc_images(d_image le) := transform
			// self.did := le.did;
			// self.DocImages_cnt := 1;				   
		// end;
		// d_images := if(FCRA, Dataset([],Layouts.Layout_People),project(d_image,from_doc_images(left)));//There's no FCRA doc images data
	
// Integer SexOffenderImages_cnt
		// o_image := prte2_sexoffender_images.Keys.DID;
		// Layouts.Layout_People from_offender_images(o_image le) := transform
			// self.did := le.did;
			// self.SexOffenderImages_cnt := 1;				   
		// end;
		// o_images := if(FCRA, Dataset([],Layouts.Layout_People),project(o_image,from_offender_images(left)));//There's no FCRA sex offender images data
	
// Integer MARI_License_cnt
		mari := prte2_prof_license_mari.Keys.key_did(FCRA);
		Layouts.Layout_People from_mari(mari le) := transform
			self.did := (unsigned6)le.did;
			self.MARI_License_cnt := 1;
		end;
		maris := project(mari,from_mari(left)); 
		
// Integer Public Sanctn
   pub_sanctn := prte2_sanctn.Keys.did;
				Layouts.Layout_People from_pub_sanctn(pub_sanctn le) := transform
				self.did := (unsigned6)le.did;
				self.Public_Sanctn_cnt := 1;
		end;
		pub_sanctns := if(FCRA, Dataset([],Layouts.Layout_People),project(pub_sanctn, from_pub_sanctn(left))); //There's no FCRA sanctn data
		

// Integer NonPuble Sanctn
		nonpub_sanctn := prte2_sanctn_np.keys.midex_rpt_nbr(did != 0, dbcode = 'N');
				Layouts.Layout_People from_nonpub_sanctn(nonpub_sanctn le) := transform
				self.did := (unsigned6)le.did;
				self.NonPublic_Sanctn_cnt := 1;
		end;
		nonpub_sanctns := if(FCRA, Dataset([],Layouts.Layout_People),project(nonpub_sanctn, from_nonpub_sanctn(left))); //There's no FCRA doc sanctn data

// Integer FreddieMac
freddie_mac := prte2_sanctn_np.keys.midex_rpt_nbr(did != 0, dbcode = 'F');
				Layouts.Layout_People from_freddie_mac(freddie_mac le) := transform
				self.did := (unsigned6)le.did;
				self.FreddieMac_Sanctn_cnt := 1;
		end;
		freddie_macs := if(FCRA, Dataset([],Layouts.Layout_People),project(freddie_mac, from_freddie_mac(left))); //There's no FCRA doc images data

		combined_people := (bks + cps + cs + dms + gns + ds + ems + fas + fcls + gwls + ps + nbhrs + liens +  hri_addrs +
																						evcs + ss + d_paw +hs + vs + ms + pls + gwlos + cdocs + has + hssns + rel1s + rel3s + assocs + akas + mdvs + jdgs +
																						pplss + nods + regas + hri_ssns + rel4s + maris + pub_sanctns + nonpub_sanctns + freddie_macs)(did<>0);

		comb_cnts_d := distribute(combined_people, hash(did));

		people_grouped_layout := record
				Unsigned6 DID := comb_cnts_d.did;
				Integer First_Degree_Relatives_cnt := sum(group,comb_cnts_d.First_Degree_Relatives_cnt   );
				Integer Second_Degree_Relatives_cnt := sum(group,comb_cnts_d.Second_Degree_Relatives_cnt   );
				Integer Associates_cnt := sum(group,comb_cnts_d.Associates_cnt   );
				Integer Neighbors_cnt := sum(group,comb_cnts_d.Neighbors_cnt   );
				Integer AKAs_cnt := if(sum(group,comb_cnts_d.AKAs_cnt) > 0,sum(group,comb_cnts_d.AKAs_cnt)-1,0);
				Integer Bankruptcy_cnt := sum(group,comb_cnts_d.Bankruptcy_cnt   );
				Integer Corporate_Affiliation_cnt := sum(group,comb_cnts_d.Corporate_Affiliation_cnt   );
				Integer Criminal_cnt := sum(group,comb_cnts_d.Criminal_cnt   );
				Integer Criminal_DOC_cnt := sum(group,comb_cnts_d.Criminal_DOC_cnt   );
				Boolean in_Deceased := if(sum(group,comb_cnts_d.Deceased_cnt) > 0, true, false);
				Integer Directory_Assistance_Gong_cnt := sum(group,comb_cnts_d.Directory_Assistance_Gong_cnt   );
				Integer DL_cnt := sum(group,comb_cnts_d.DL_cnt   );
				Integer Email_cnt := sum(group,comb_cnts_d.Email_cnt   );
				Integer FAA_Aircraft_cnt := sum(group,comb_cnts_d.FAA_Aircraft_cnt   );
				Integer Foreclosure_cnt := sum(group,comb_cnts_d.Foreclosure_cnt   );
				Integer GWL_cnt := sum(group,comb_cnts_d.GWL_cnt   );
				Boolean in_GWL_OFAC_Only := if(sum(group,comb_cnts_d.GWL_OFAC_Only_cnt)>0, true, false);
				Boolean in_Address_HRI := if(sum(group,comb_cnts_d.Address_HRI_cnt)>0, true, false);
				Boolean in_SSN_HRI := if(sum(group,comb_cnts_d.SSN_HRI_cnt)>0,true,false);
				Integer Liens_cnt := sum(group,comb_cnts_d.Liens_cnt   );
				Integer Judgements_cnt := sum(group,comb_cnts_d.Judgements_cnt   );
				Integer Evictions_cnt := sum(group,comb_cnts_d.Evictions_cnt   );
				Integer Marriage_and_Divorce_cnt := sum(group,comb_cnts_d.Marriage_and_Divorce_cnt   );
				Integer MVR_cnt := sum(group,comb_cnts_d.MVR_cnt   );
				Integer Notice_of_Default_cnt := sum(group,comb_cnts_d.Notice_of_Default_cnt   );
				Integer People_at_Work_cnt := sum(group,comb_cnts_d.People_at_Work_cnt   );
				Boolean in_Person_Header := if(sum(group,comb_cnts_d.Person_Header_cnt)>0,true,false);
				Integer PhonesPlus_cnt := sum(group,comb_cnts_d.PhonesPlus_cnt   );
				Integer Professional_License_cnt := sum(group,comb_cnts_d.Professional_License_cnt   );
				Integer Property_cnt := sum(group,comb_cnts_d.Property_cnt   );
				Integer Registered_Agent_cnt := sum(group,comb_cnts_d.Registered_Agent_cnt   );
				Integer Sex_Offender_cnt := sum(group,comb_cnts_d.Sex_Offender_cnt   );
				Integer Watercraft_cnt := sum(group,comb_cnts_d.Watercraft_cnt   );
				Integer Addresses_cnt := sum(group,comb_cnts_d.Addresses_cnt   );
				Integer SSN_Cnt := sum(group,comb_cnts_d.SSN_Cnt   );
				Integer Third_Degree_Relatives_cnt := sum(group,comb_cnts_d.Third_Degree_Relatives_cnt);
				Integer MARI_License_cnt := sum(group,comb_cnts_d.MARI_License_cnt );
				Integer Public_Sanctn_cnt := sum(group,comb_cnts_d.Public_Sanctn_cnt );
				Integer NonPublic_Sanctn_cnt := sum(group,comb_cnts_d.NonPublic_Sanctn_cnt );
				Integer FreddieMac_Sanctn_cnt := sum(group,comb_cnts_d.FreddieMac_Sanctn_cnt );
		end;      
							 

		people_grouped := table(comb_cnts_d,people_grouped_layout,did, local);

		people_grouped_layout2 := record
			people_grouped_layout;
			Dataset(Layouts.business_bdid_layout) owned_businesses_bdid {maxcount(25)}:=  Dataset([],Layouts.business_bdid_layout);
			Dataset(Layouts.business_linkid_layout) owned_businesses_linkid {maxcount(25)}:=  Dataset([],Layouts.business_linkid_layout);
			//business_linkid_layout
			integer Owned_Business_bdid_cnt := 0;
			integer Owned_Business_linkid_cnt := 0;
		end;

		people_grouped2 := project(people_grouped, people_grouped_layout2);
		
		people_j1 := join(people_grouped2, People_Owned_BDIDs.Records,
											left.did = right.did,
											transform({people_grouped2},
																self.owned_businesses_bdid := choosen(project(right.company_titles, Layouts.business_bdid_layout),25);
																self.Owned_Business_bdid_cnt := count(right.company_titles);
																self := left;
																), left outer);
		people_j := join(people_j1, People_Owned_LinkIDs.Records,
											left.did = right.did,
											transform({people_grouped2},
																self.owned_businesses_linkid := choosen(right.businesses_linkids,25);
																self.Owned_Business_linkid_cnt := count(right.businesses_linkids);
																self := left;
																), left outer);															
		

		demorecs 	:= dataset([	
									{888800000005,1,1,1,1,1,1,1,1,1,true ,1,1,1,1,1,1,false,true ,false,1,1,1,1,1,1,1,true ,1,1,1,1,1,1,1,1,1,1,1,1,1,[{1}],[{1}],1,1},
									{888800000029,2,2,2,2,2,2,2,2,2,false,2,2,2,2,2,2,false,true ,true ,2,2,2,2,2,2,2,false,2,2,2,2,2,2,2,2,2,2,2,2,2, [{1},{2}], [{1},{2}],2,2},
									{888800000046,3,3,3,3,3,3,3,3,3,false,3,3,3,3,3,3,true ,false,false,3,3,3,3,3,3,3,true ,3,3,3,3,3,3,3,3,3,3,3,3,3, [{1},{2},{3}],[{1},{2},{3}],3,3}], 
									people_grouped_layout2)
									;
		ds_people :=  demorecs  + people_j;
		return ds_people;
End;