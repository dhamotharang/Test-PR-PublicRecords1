Import ams, address,dea;
EXPORT Provider_Records_Functions_AMS := MODULE
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myConst := Healthcare_Provider_Services.Constants;
	shared mylayouts := Healthcare_Provider_Services.Layouts;
	shared mytransforms := Healthcare_Provider_Services.Provider_Records_Transforms;

	Export doCustomMatchAMS (dataset(myLayouts.CombinedHeaderResults) src, 
													 dataset(Healthcare_Provider_Services.Provider_Records_Matching.matchData) match) := function
			
			outRec := myLayouts.CombinedHeaderResults;
			outRec xform(outRec l, Healthcare_Provider_Services.Provider_Records_Matching.matchData r) := transform
							self.hcid := (integer)r.ingKey;
							self:= l;
							self:=[];
			end;
			myResults := join(src,match,left.SrcId = (integer)right.amsKey,
																	xform(left,right),
																	keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			myResultsNoHit := join(src,match,left.SrcId = (integer)right.amsKey,
																	transform(outRec, self:=left),left only);
			return myResults+myResultsNoHit;
	end;

	Export checkAMS(dataset(mylayouts.slimINGforAMSLookup) input) := function
		outlayout := mylayouts.searchKeyResults;
		ams_recs_npi := dedup(sort(join(dedup(input(npi<>''),npi),ams.keys().main.NPI.qa(),
																				 keyed(left.npi=right.npi),
																				 transform(outlayout,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;
																										self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_NPI_RECS), limit(0)),record),record);
		ams_recs_did := dedup(sort(join(dedup(input(did>0),did),ams.keys().main.did.qa(),
																				 keyed(left.did=right.did), 
																				 transform(outlayout,self.prov_id:=(unsigned6)right.ams_id; self.acctno:=left.acctno;
																										self.src:=myConst.SRC_AMS),
																				 keep(myConst.MAX_DID_RECS), limit(0)),record),record);
		// output(ams_recs_npi);
		// output(ams_recs_did);
		return dedup(sort(ams_recs_npi+ams_recs_did,record),record);
	end;
	export getAmsGroupAffiliations(dataset(mylayouts.slimforLookup) provs) := function
			getGroupsIDs := join(provs,ams.keys().Affiliation.AMSID.qa,keyed((string)left.prov_id = right.ams_id) and 
												keyed(right.record_type = AMS._Constants().CURRENT) and 
												right.rawfields.affil_status = AMS._Constants().ACTIVE AND 
												right.isparent = FALSE and 
												right.rawfields.affil_type != AMS._Constants().PROVIDER_TO_HOSPITAL,keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			getActualAffiliations := JOIN(getGroupsIDs,ams.keys().main.amsid.qa,
												KEYED(LEFT.ams_other_id = RIGHT.ams_id),
												transform(mylayouts.layout_affiliateHospital, 
															self.acctno := left.acctno;
															SELF.providerid := (unsigned6)left.ams_id;
															self.BDID := right.BDID;
															self.name := RIGHT.rawdemographicsfields.acct_name;
															self.addrPenalty := myFn.getHospitalAffiliationPenalty(left.prim_name, left.p_city_name, left.St, left.Z5, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.p_city_name, RIGHT.clean_company_address.st, RIGHT.clean_company_address.zip);
															self.address1 := Address.Addr1FromComponents(RIGHT.clean_company_address.prim_range, RIGHT.clean_company_address.predir, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.addr_suffix, RIGHT.clean_company_address.postdir, RIGHT.clean_company_address.unit_desig, RIGHT.clean_company_address.sec_range);
															self.prim_range := RIGHT.clean_company_address.prim_range;
															self.predir := RIGHT.clean_company_address.predir;
															self.prim_name := RIGHT.clean_company_address.prim_name;
															self.addr_suffix := RIGHT.clean_company_address.addr_suffix;
															self.postdir := RIGHT.clean_company_address.postdir;
															self.unit_desig := RIGHT.clean_company_address.unit_desig;
															self.sec_range := RIGHT.clean_company_address.sec_range;
															self.p_city_name := RIGHT.clean_company_address.p_city_name;
															self.st := RIGHT.clean_company_address.st;
															self.z5 := RIGHT.clean_company_address.zip;
															self.zip4 := RIGHT.clean_company_address.zip4;
															self:=[]),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			mylayouts.layout_Child_affiliateHospital doRollup(mylayouts.layout_affiliateHospital l, 
																									dataset(mylayouts.layout_affiliateHospital) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := choosen(r,myConst.MAX_GROUP_AFFILIATIONS);
			END;
			results_rolled := rollup(group(sort(getActualAffiliations,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	export getAmsHospitalInfo(dataset(mylayouts.slimforLookup) provs) := function
			getGroupsIDs := join(provs,ams.keys().Affiliation.AMSID.qa,keyed((string)left.prov_id = right.ams_id) and 
												keyed(right.record_type = AMS._Constants().CURRENT) and 
												right.rawfields.affil_status = AMS._Constants().ACTIVE AND 
												right.isparent = FALSE and 
												right.rawfields.affil_type = AMS._Constants().PROVIDER_TO_HOSPITAL,keep(Constants.MAX_RECS_ON_JOIN), limit(0));
			getActualAffiliations := JOIN(getGroupsIDs,ams.keys().main.amsid.qa,
												KEYED(LEFT.ams_other_id = RIGHT.ams_id),
												transform(mylayouts.layout_affiliateHospital, 
															self.acctno := left.acctno;
															SELF.providerid := (unsigned6)left.ams_id;
															self.BDID := right.BDID;
															self.name := RIGHT.rawdemographicsfields.acct_name;
															self.addrPenalty := myFn.getHospitalAffiliationPenalty(left.prim_name, left.p_city_name, left.St, left.Z5, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.p_city_name, RIGHT.clean_company_address.st, RIGHT.clean_company_address.zip);
															self.address1 := Address.Addr1FromComponents(RIGHT.clean_company_address.prim_range, RIGHT.clean_company_address.predir, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.addr_suffix, RIGHT.clean_company_address.postdir, RIGHT.clean_company_address.unit_desig, RIGHT.clean_company_address.sec_range);
															self.prim_range := RIGHT.clean_company_address.prim_range;
															self.predir := RIGHT.clean_company_address.predir;
															self.prim_name := RIGHT.clean_company_address.prim_name;
															self.addr_suffix := RIGHT.clean_company_address.addr_suffix;
															self.postdir := RIGHT.clean_company_address.postdir;
															self.unit_desig := RIGHT.clean_company_address.unit_desig;
															self.sec_range := RIGHT.clean_company_address.sec_range;
															self.p_city_name := RIGHT.clean_company_address.p_city_name;
															self.st := RIGHT.clean_company_address.st;
															self.z5 := RIGHT.clean_company_address.zip;
															self.zip4 := RIGHT.clean_company_address.zip4;
															self:=[]),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			mylayouts.layout_Child_affiliateHospital doRollup(mylayouts.layout_affiliateHospital l, dataset(mylayouts.layout_affiliateHospital) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := choosen(r,myConst.MAX_HOSPITAL_AFFILIATIONS);
			END;
			results_rolled := rollup(group(sort(getActualAffiliations,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsNpis(dataset(mylayouts.slimforLookup) provs) := function
		result := join(provs,ams.keys().IDNumber.AMSID.qa, 
									 KEYED((String)LEFT.prov_id = RIGHT.ams_id) 
									 and keyed(right.record_type = AMS._Constants().CURRENT)
									 and right.src_cd_desc = 'NPI',
									 transform(mylayouts.layout_npi,
														 self.acctno:=left.acctno;
														 SELF.providerid := (unsigned6)right.ams_id;
														 self.npi:=right.rawfields.indy_id),
									 keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		mylayouts.layout_child_npi doRollup(mylayouts.layout_npi l, dataset(mylayouts.layout_npi) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getAmsDeas(dataset(mylayouts.slimforLookup) provs) := function
		result := join(provs,ams.keys().IDNumber.AMSID.qa, 
									 KEYED((String)LEFT.prov_id = RIGHT.ams_id)
									 and keyed(right.record_type = AMS._Constants().CURRENT)
									 and right.src_cd_desc = 'DEA',
									 transform(mylayouts.layout_dea,
														 self.acctno:=left.acctno;
														 SELF.providerid := (unsigned6)right.ams_id;
														 self.dea:=right.rawfields.indy_id, 
														 self.expiration_date:=right.rawfields.indy_id_end_date),
								   keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		f_deas2 := dedup(sort(JOIN(result,dea.Key_dea_reg_num,keyed(left.dea=right.dea_registration_number),transform(mylayouts.layout_dea, self.expiration_date:=right.Expiration_Date;self :=left),keep(myConst.MAX_RECS_ON_JOIN), limit(0)),acctno,providerid,dea,-Expiration_Date),acctno,providerid,dea,Expiration_Date);
		f_deas := result+f_deas2;
		f_deas_srt := sort(f_deas(DEA<>''), record);
		f_deas_dep := sort(dedup(f_deas_srt, acctno,providerid,dea,Expiration_Date),acctno,providerid,dea,-Expiration_Date);
		mylayouts.layout_child_dea doRollup(mylayouts.layout_dea l, dataset(mylayouts.layout_dea) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_deas_dep,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	// Export getAmsDegrees(dataset(mylayouts.slimforLookup) provs) := function
		// result := join(provs,ams.keys().Degree.amsid.qa, 
									 // KEYED((String)LEFT.prov_id = RIGHT.ams_id),
												// transform(mylayouts.layout_degree, 
																	// self.acctno:=left.acctno;
																	// self.providerid:=(unsigned6)right.ams_id;
																	// self.Degree := right.rawfields.degree;self:=[]),
								   // keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		// mylayouts.layout_child_degree doRollup(mylayouts.layout_degree l, dataset(mylayouts.layout_degree) r) := TRANSFORM
			// SELF.acctno := l.acctno;
			// self.ProviderID := l.ProviderID;
			// self.childinfo := r;
		// END;
		// results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		// return results_rolled;
	// End;
	// Export getAmsSpecialty(dataset(mylayouts.slimforLookup) provs) := function
		// result := join(provs,ams.keys().specialty.amsid.qa, 
									 // KEYED((String)LEFT.prov_id = RIGHT.ams_id),
												// transform(mylayouts.layout_specialty, 
																	// self.acctno:=left.acctno;
																	// self.providerid:=(unsigned6)right.ams_id;
																	// self.SpecialtyName := right.specialty_desc;self:=[]),
								   // keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		// mylayouts.layout_child_specialty doRollup(mylayouts.layout_specialty l, dataset(mylayouts.layout_specialty) r) := TRANSFORM
			// SELF.acctno := l.acctno;
			// self.ProviderID := l.ProviderID;
			// self.childinfo := r;
		// END;
		// results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		// return results_rolled;
	// End;
	Export getAmsLicenses(dataset(mylayouts.slimforLookup) provs) := function
		result := dedup(sort(join(provs,ams.keys().StateLicense.amsid.qa, 
									 KEYED((String)LEFT.prov_id = RIGHT.ams_id)
									 and keyed(right.record_type = AMS._Constants().CURRENT),
									 transform(mylayouts.layout_licenseinfo,
												self.licenseAcctno := left.acctno;
												SELF.providerid := (unsigned6)right.ams_id;
												self.licenseSeq := 1;
												self.LicenseState := right.rawfields.st_lic_state;
												self.LicenseNumber := myFn.removeLeadingZeros(myFn.cleanLicenses(right.rawfields.st_lic_num));
												self.LicenseStatus := right.rawfields.st_lic_status;
												self.Effective_Date := right.rawfields.st_lic_issue_date;
												self.Termination_Date:=right.rawfields.st_lic_exp_date),
										keep(myConst.MAX_RECS_ON_JOIN), limit(0)),LicenseState,-Termination_Date, LicenseNumber),all);
		mylayouts.layout_child_licenseinfo doRollup(mylayouts.layout_licenseinfo l, dataset(mylayouts.layout_licenseinfo) r) := TRANSFORM
			SELF.acctno := l.licenseAcctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,licenseAcctno,ProviderID),licenseAcctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;

end;