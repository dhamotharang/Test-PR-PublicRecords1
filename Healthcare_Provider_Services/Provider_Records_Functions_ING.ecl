
Import ams, address,ingenix_natlprof,doxie_crs,doxie,dea;
EXPORT Provider_Records_Functions_ING := MODULE
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myConst := Healthcare_Provider_Services.Constants;
	shared mylayouts := Healthcare_Provider_Services.Layouts;
	shared mytransforms := Healthcare_Provider_Services.Provider_Records_Transforms;

	Export doCustomMatchIng (dataset(myLayouts.CombinedHeaderResults) src, 
													 dataset(Healthcare_Provider_Services.Provider_Records_Matching.matchData) match) := function
			
			outRec := myLayouts.CombinedHeaderResults;
			outRec xform(outRec l, Healthcare_Provider_Services.Provider_Records_Matching.matchData r) := transform
							self.hcid := if(r.matchID <> '',(integer)r.matchID,(integer)r.ingKey);
							self:= l;
							self:=[];
			end;
			myResults := join(src,match(ingkey<>''),left.SrcId = (integer)right.ingkey,
																	xform(left,right),
																	keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			myResultsNoHit := join(src,match(ingkey<>''),left.SrcId = (integer)right.ingkey,
																	transform(outRec, self:=left),left only);
			return myResults+myResultsNoHit;
	end;
	Export getLanguages(dataset(mylayouts.slimforLookup) input) := Function
		mylayouts.layout_language get_languages(mylayouts.slimforLookup l,ingenix_natlprof.key_language_providerid r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self.LanguageTierTypeID := (unsigned2) r.LanguageTierTypeID;
			self.language := r.language;
		end;
		f_languages := join(input(src=myConst.SRC_ING),
												ingenix_natlprof.key_language_providerid,
												keyed((integer)left.srcid=right.l_providerid),get_languages(left,right),
												keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		f_languages_srt := sort(f_languages(Language<>''), record);
		f_languages_dep := dedup(f_languages_srt, record, except LanguageTierTypeID);
		mylayouts.layout_child_language doRollup(mylayouts.layout_language l, dataset(mylayouts.layout_language) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_languages_dep,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	end;
	Export appendLanguage (dataset(mylayouts.slimforLookup) inputSlim, 
												 dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Language := getLanguages(inputSlim);
		results := join(inputRecs,fmtRec_Language, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.Languages := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export getResidency(dataset(mylayouts.slimforLookup) input) := Function
		residency_key := ingenix_natlprof.key_residency_providerid;
		mylayouts.layout_residency get_residencies(mylayouts.slimforLookup l,residency_key r) := transform
				 self.acctno := l.acctno;
				 self.providerid := r.l_providerid;
				 self.ResidencyTierTypeID := (unsigned2) r.ResidencyTierTypeID;
				 self.Residency := r.Residency;
				 self.BDID := r.BDID;
		end;

		f_residencies := join(input(src=myConst.SRC_ING),residency_key,
													keyed((integer)left.srcid =right.l_providerid),get_residencies(left,right),
													keep(myConst.MAX_RECS_ON_JOIN), limit(0));

		f_residencies_srt := sort(f_residencies(Residency<>''), acctno,providerid,trim(residency,all));
		f_residencies_dep := dedup(f_residencies_srt, acctno,providerid,trim(residency,all));

		pid_residency_rec_clean := record
				 mylayouts.layout_residency;
				 string120 Residency2;
				 unsigned4 len;
		end;
		f_residencies_prepclean := project(f_residencies_dep,transform(pid_residency_rec_clean,
																																		str1:= stringLib.StringFindReplace(stringLib.StringToUpperCase(left.Residency),'HOSPITAL','');
																																		str2:= stringLib.StringFindReplace(str1,'UNIVERSITY','');
																																		str3:= stringLib.StringFindReplace(str2,'MEDICAL','');
																																		str4:= stringLib.StringFindReplace(str3,'CLINIC','');
																																		str5:= stringLib.StringFindReplace(str4,'OF','');
																																		str6:= stringLib.StringFindReplace(str5,'AND','');
																																		strfinal:= stringLib.StringFindReplace(str6,'THE','');
																																		self.providerid := left.providerid;
																																		self.Residency2:=trim(strfinal,all),
																																		self.len:=length(trim(strfinal,all)),
																																		self := left));
		mylayouts.layout_residency doRemoveBadResidencies(pid_residency_rec_clean l) := TRANSFORM
			tmp:=f_residencies_prepclean(Residency<>l.Residency);
			ds_tmp := tmp(Residency2[1..l.len]=l.Residency2,len>l.len);
			SELF.acctno := l.acctno;
			self.providerid:=l.providerid;
			self.BDID := l.bdid;
			self.Residency := if(exists(ds_tmp),skip,l.Residency);
			self.ResidencyTierTypeID := l.ResidencyTierTypeID;
		END;
		f_residencies_clean:=project(f_residencies_prepclean,doRemoveBadResidencies(left));
		f_residencies_final:=dedup(f_residencies_clean,acctno,providerid,stringLib.StringToUpperCase(Residency),all);
		mylayouts.layout_child_residency doRollup(mylayouts.layout_residency l, dataset(mylayouts.layout_residency) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_residencies_final,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	end;
	Export appendResidency (dataset(mylayouts.slimforLookup) inputSlim, 
													dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Residency := getResidency(inputSlim);
		results := join(inputRecs,fmtRec_Residency, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.Residencies := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export getMedSchool(dataset(mylayouts.slimforLookup) input) := Function
		medschool_key := ingenix_natlprof.key_medschool_providerid;

		mylayouts.layout_medschool get_medschools(mylayouts.slimforLookup l,medschool_key r) := transform
				 self.acctno := l.acctno;
				 self.providerid := r.l_providerid;
				 self.MedSchoolTierTypeID := (unsigned2) r.MedSchoolTierTypeID;
			self := r;
		end;

		f_medschools := join(input(src=myConst.SRC_ING),medschool_key,keyed((integer)left.srcid =right.l_providerid),get_medschools(left,right),
			keep(myConst.MAX_RECS_ON_JOIN), limit(0));

		f_medschools_srt := sort(f_medschools(MedSchoolName<>''), record);
		f_medschools_dep := dedup(f_medschools_srt, record, except MedSchoolTierTypeID);

		pid_medschool_rec_clean := record
				mylayouts.layout_medschool;
				string120 MedSchoolName2;
				unsigned4 len;
		end;
		f_medschools_prepclean := project(f_medschools_dep,transform(pid_medschool_rec_clean,
																			str1:= stringLib.StringFindReplace(stringLib.StringToUpperCase(left.medschoolname),'SCHOOL','');
																			str2:= stringLib.StringFindReplace(str1,'MEDICAL','');
																			str3:= stringLib.StringFindReplace(str2,'OF','');
																			str4:= stringLib.StringFindReplace(str3,'AND','');
																			strfinal:= stringLib.StringFindReplace(str4,'THE','');
																			self.Medschoolname2:=trim(strfinal,all),
																			self.len:=length(trim(strfinal,all)),
																			self.providerid := left.providerid;
																			self := left));
		mylayouts.layout_medschool doRemoveBadMedSchool(f_medschools_prepclean l) := TRANSFORM
			tmp:=f_medschools_prepclean(MedSchoolName<>l.medschoolname);
			ds_tmp := tmp(medschoolname2[1..l.len]=l.medschoolname2,graduationyear=l.graduationyear,len>l.len);
			self.acctno := l.acctno;
			self.providerid := l.providerid;
			self.BDID := l.bdid;
			self.medschoolname := if(exists(ds_tmp),skip,l.medschoolname);
			self.graduationyear := l.graduationyear;
			self.medschoolTierTypeID := l.medschoolTierTypeID;
		END;
		f_medschools_clean:=project(f_medschools_prepclean,doRemoveBadMedSchool(left));
		mylayouts.layout_child_medschool doRollup(mylayouts.layout_medschool l, dataset(mylayouts.layout_medschool) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_medschools_clean,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	end;
	Export appendMedSchool (dataset(mylayouts.slimforLookup) inputSlim, 
													dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_MedSchool := getMedSchool(inputSlim);
		results := join(inputRecs,fmtRec_MedSchool, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.MedSchools := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	Export getTaxonomy(dataset(mylayouts.slimforLookup) input) := Function
		taxonomy_key := Ingenix_NatlProf.key_NPI_providerid;

		mylayouts.layout_taxonomy get_taxonomy(mylayouts.slimforLookup l,taxonomy_key r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self := r;
		end;

		f_taxonomy := join(input(src=myConst.SRC_ING),taxonomy_key,
												keyed((integer)left.srcid =right.l_providerid),get_taxonomy(left,right),
												keep(doxie_crs.constants.max_taxonomy));

		f_taxonomy_srt := sort(f_taxonomy(TaxonomyCode<>''), record);
		f_taxonomy_dep := dedup(f_taxonomy_srt, record);
		mylayouts.layout_child_taxonomy doRollup(mylayouts.layout_taxonomy l, dataset(mylayouts.layout_taxonomy) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(f_taxonomy_dep,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	end;
	Export appendTaxonomy (dataset(mylayouts.slimforLookup) inputSlim, 
												 dataset(mylayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
		fmtRec_Taxonomy := getTaxonomy(inputSlim);
		results := join(inputRecs,fmtRec_Taxonomy, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(mylayouts.CombinedHeaderResultsDoxieLayout,
																							self.Taxonomy := right.childinfo;
																							self := left),left outer);
		return results;
	end;
	export getIngHospitalInfo(dataset(mylayouts.slimforLookup) provs) := function
			pid_hospital_rec := record
				string20	 	acctno := '';
				string28  	in_prim_name := '';
				string25  	in_p_city_name := '';
				string2   	in_st := '';
				string5   	in_z5 := '';
				unsigned6 providerid;
				doxie.ingenix_provider_module.ingenix_hospital_rec;
			end;

			pid_hospital_rec get_hospitals(mylayouts.slimforLookup l,ingenix_natlprof.key_hospital_providerid r) := transform
					 self.acctno := l.acctno;
					 self.in_prim_name := l.prim_name;
					 self.in_p_city_name := l.p_city_name;
					 self.in_st := l.st;
					 self.in_z5 := l.z5;
					 self.providerid := r.l_providerid;
					 self.HospitalNameTierTypeID := (unsigned2) r.HospitalNameTierTypeID;
				self := r;
			end;
			f_hospitals := join(provs,ingenix_natlprof.key_hospital_providerid,keyed(left.prov_id= right.l_providerid),get_hospitals(left,right),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			f_hospitals_srt := sort(f_hospitals(HospitalName<>''), record);
			f_hospitals_dep := dedup(f_hospitals_srt, record, except HospitalNameTierTypeID);
			pid_hospital_rec_clean := record
					string20	 	acctno := '';
					string28  	in_prim_name := '';
					string25  	in_p_city_name := '';
					string2   	in_st := '';
					string5   	in_z5 := '';
					unsigned6 providerid;
					doxie.ingenix_provider_module.ingenix_hospital_rec;
					string120 HospitalName2;
					unsigned4 len;
			end;
			f_hospitals_prepclean := project(f_hospitals_dep,transform(pid_hospital_rec_clean,
																		str1:= stringLib.StringFindReplace(stringLib.StringToUpperCase(left.hospitalname),'HOSPITAL','');
																		str2:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str1),'COMMUNITY','');
																		str3:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str2),'CENTER','');
																		str4:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str3),'CLINIC','');
																		strfinal:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str4),'HEALTH','');
																		self.hospitalname2:=trim(strfinal,all),
																		self.len:=length(trim(strfinal,all)),
																		self := left));
			//Clean Hospitals
			pid_hospital_rec doCleanHospital(pid_hospital_rec_clean l) := TRANSFORM
				tmp:=f_hospitals_prepclean(HospitalName<>l.HospitalName and acctno=l.acctno and providerid = l.providerid);
				ds_tmp := tmp(HospitalName2[1..l.len]=l.HospitalName2,address[1.10]=l.address[1.10],len>l.len);
				SELF.providerid := l.providerid;
				self.BDID := l.bdid;
				self.HospitalName := if(exists(ds_tmp),skip,l.HospitalName);
				self.HospitalNameTierTypeID := l.HospitalNameTierTypeID;
				self.Address := l.address;
				self.City := l.City;
				self.State := l.State;
				self.Zip := l.Zip;
				self := l;
			END;
			f_hospitals_clean := project(f_hospitals_prepclean,doCleanHospital(left));
			//rollup Hospital
			pid_hospital_rec doRollHospital(pid_hospital_rec l, pid_hospital_rec r) := TRANSFORM
				SELF.providerid := l.providerid;
				self.BDID := l.bdid;
				self.HospitalName := l.HospitalName;
				self.HospitalNameTierTypeID := if(l.HospitalNameTierTypeID<r.HospitalNameTierTypeID,l.HospitalNameTierTypeID,r.HospitalNameTierTypeID);
				self.Address := if(l.address <>'',l.address,r.address);
				self.City := if(l.City <>'',l.City,r.city);
				self.State := if(l.State <>'',l.State,r.state);
				self.Zip := if(l.Zip <>'',l.Zip,r.zip);
				self.acctno := l.acctno;
				self.in_prim_name := l.in_prim_name;
				self.in_p_city_name := l.in_p_city_name;
				self.in_st := l.in_st;
				self.in_z5 := l.in_z5;
			END;
			f_hospitals_rollup := rollup(f_hospitals_clean,doRollHospital(left,right),acctno,providerid,hospitalname);
			result:=project(f_hospitals_rollup, transform(mylayouts.layout_affiliateHospital,
													self.acctno := left.acctno;
													SELF.providerid := left.providerid;
													self.BDID := (integer)left.BDID;
													self.name := left.hospitalname;
													self.addrPenalty := 
														if( 
															left.in_prim_name != '' OR left.in_p_city_name != '' OR left.in_St != '' OR left.in_Z5 != '',
															myFn.getHospitalAffiliationPenalty(left.in_prim_name, left.in_p_city_name, left.in_St, left.in_Z5, left.address, left.city, left.state, left.zip),
															0
														);
													self.address1 := left.address;
													self.p_city_name := left.city;
													self.st := left.state;
													self.z5 := left.zip;
													self := []));
				mylayouts.layout_Child_affiliateHospital doRollup(mylayouts.layout_affiliateHospital l, dataset(mylayouts.layout_affiliateHospital) r) := TRANSFORM
					SELF.acctno := l.acctno;
					self.ProviderID := l.ProviderID;
					self.childinfo := choosen(r,myConst.MAX_HOSPITAL_AFFILIATIONS);
				END;
				results_rolled := rollup(group(sort(result,acctno,providerid),acctno,providerid),group,doRollup(left,rows(left)));
			return results_rolled;
	end;
	
	Export getIngGroupAffiliations(dataset(mylayouts.slimforLookup) provs) := function
			pid_group_rec := record
				string20	 	acctno := '';
				string28  	in_prim_name := '';
				string25  	in_p_city_name := '';
				string2   	in_st := '';
				string5   	in_z5 := '';
				unsigned6 providerid;
				doxie.ingenix_provider_module.ingenix_group_rec;
			end;

			pid_group_rec get_groups(mylayouts.slimforLookup l,ingenix_natlprof.key_group_providerid r) := transform
					 self.acctno := l.acctno;
					 self.in_prim_name := l.prim_name;
					 self.in_p_city_name := l.p_city_name;
					 self.in_st := l.st;
					 self.in_z5 := l.z5;
					 self.providerid := r.l_providerid;
					 self.GroupNameTierTypeID := (unsigned2) r.GroupNameTierTypeID;
				self := r;
			end;

			f_groups := join(provs,ingenix_natlprof.key_group_providerid,keyed(left.prov_id =right.l_providerid),get_groups(left,right),
				keep(myConst.MAX_RECS_ON_JOIN), limit(0));

			f_groups_srt := sort(f_groups(GroupName<>''), record, except GroupNameTierTypeID);
			f_groups_dep := dedup(f_groups_srt, record, except GroupNameTierTypeID);

			pid_group_rec_clean := record
					 string20	 	acctno := '';
					 string28  	in_prim_name := '';
					 string25  	in_p_city_name := '';
					 string2   	in_st := '';
					 string5   	in_z5 := '';
					 unsigned6 providerid;
				doxie.ingenix_provider_module.ingenix_group_rec;
					string120 GroupName2;
					unsigned4 len;
			end;
			f_groups_prepclean := project(f_groups_dep,transform(pid_group_rec_clean,
																														str1:= stringLib.StringFindReplace(stringLib.StringToUpperCase(left.Groupname),'GROUP','');
																														str2:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str1),'GRP','');
																														str3:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str2),'INC','');
																														str4:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str3),'ASSOCIATES','');
																														str5:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str4),'ASSOC','');
																														str6:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str5),'CORPORATION','');
																														str7:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str6),'CORP','');
																														str8:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str7),'CENTER','');
																														str9:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str8),'OF','');
																														str10:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str9),'AND','');
																														strfinal:= stringLib.StringFindReplace(stringLib.StringToUpperCase(str10),'THE','');
																														self.GroupName2:=trim(strfinal,all),
																														self.len:=length(trim(strfinal,all)),
																														self := left));
			//rollup Groups
			pid_group_rec_clean doCleanGroups(pid_group_rec_clean l) := TRANSFORM
				tmp:=f_groups_prepclean(GroupName<>l.GroupName and acctno=l.acctno and providerid = l.providerid);
				ds_tmp := tmp(GroupName2[1..l.len]=l.GroupName2,len>l.len);
				SELF.providerid := l.providerid;
				self.BDID := l.bdid;
				self.groupname := if(exists(ds_tmp),skip,l.groupname);
				self.GroupNameTierTypeID := l.GroupNameTierTypeID;
				self.Address := l.address;
				self.City := l.City;
				self.State := l.State;
				self.Zip := l.Zip;
				self := l;
			END;
			f_groups_clean := project(f_groups_prepclean,doCleanGroups(left));
			pid_group_rec doRollGroups(pid_group_rec l, pid_group_rec r) := TRANSFORM
				SELF.providerid := l.providerid;
				self.BDID := l.bdid;
				self.groupname := l.groupname;
				self.GroupNameTierTypeID := if(l.GroupNameTierTypeID<r.GroupNameTierTypeID,l.GroupNameTierTypeID,r.GroupNameTierTypeID);
				self.Address := if(l.address <>'',l.address,r.address);
				self.City := if(l.City <>'',l.City,r.city);
				self.State := if(l.State <>'',l.State,r.state);
				self.Zip := if(l.Zip <>'',l.Zip,r.zip);
				self.acctno := l.acctno;
				self.in_prim_name := l.in_prim_name;
				self.in_p_city_name := l.in_p_city_name;
				self.in_st := l.in_st;
				self.in_z5 := l.in_z5;
			END;
			f_groups_rollup := rollup(project(f_groups_clean,pid_group_rec),doRollGroups(left,right),acctno,providerid,stringlib.StringToUpperCase(groupname));
			result:=project(f_groups_rollup, transform(mylayouts.layout_affiliateHospital,
													self.acctno := left.acctno;
													SELF.providerid := left.providerid;
													self.BDID := (integer)left.BDID;
													self.name := left.groupname;
													self.addrPenalty := 
														if( 
															left.in_prim_name != '' OR left.in_p_city_name != '' OR left.in_St != '' OR left.in_Z5 != '',
															myFn.getHospitalAffiliationPenalty(left.in_prim_name, left.in_p_city_name, left.in_St, left.in_Z5, left.address, left.city, left.state, left.zip),
															0
														);
													self.address1 := left.address;
													self.p_city_name := left.city;
													self.st := left.state;
													self.z5 := left.zip;
													self := []));
			
				mylayouts.layout_Child_affiliateHospital doRollup(mylayouts.layout_affiliateHospital l, dataset(mylayouts.layout_affiliateHospital) r) := TRANSFORM
					SELF.acctno := l.acctno;
					self.ProviderID := l.ProviderID;
					self.childinfo := choosen(r,myConst.MAX_GROUP_AFFILIATIONS);
				END;
				results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
			return results_rolled;
	End;
	Export getIngUPINs(dataset(mylayouts.slimforLookup) provs) := function
		pid_upin_rec := record
			string20	 	acctno := '';
			unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_upin_rec;
		end;

		pid_upin_rec get_upins(mylayouts.slimforLookup l,ingenix_natlprof.key_UPIN_providerid r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self.UPINTierTypeID := (unsigned2) r.UPINTierTypeID;
			self := r;
		end;

		f_upins := join(provs,ingenix_natlprof.key_UPIN_providerid,keyed(left.prov_id =right.l_providerid),get_upins(left,right),
			keep(myConst.MAX_RECS_ON_JOIN), limit(0));

		f_upins_srt := sort(f_upins(upin<>''), record);
		f_upins_dep := dedup(f_upins_srt, record, except UPINTierTypeID);
		result:=project(f_upins_dep, transform(mylayouts.layout_upin,
												self.acctno := left.acctno;
												SELF.providerid := left.providerid;
												self.upin := left.upin;
												self := []));
		mylayouts.layout_child_upin doRollup(mylayouts.layout_upin l, dataset(mylayouts.layout_upin) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getIngDeas(dataset(mylayouts.slimforLookup) provs) := function
		mylayouts.pid_dea_rec get_deas(mylayouts.slimforLookup l,ingenix_natlprof.key_DEA_providerid r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self.DEANumberTierTypeID := (unsigned2) r.DEANumberTierTypeID;
			self.expiration_date := '';
			self.deanumber := trim(r.deaNumber,all);
			self := r;
		end;

		f_deas1 := join(provs(prov_id>0),ingenix_natlprof.key_DEA_providerid,keyed(left.prov_id = right.l_providerid),get_deas(left,right),
			keep(myConst.MAX_RECS_ON_JOIN), limit(0));

		f_deas2 := dedup(sort(JOIN(f_deas1,dea.Key_dea_reg_num,keyed(left.deanumber= right.dea_registration_number),transform(mylayouts.pid_dea_rec, self.expiration_date:=right.Expiration_Date;self :=left;),keep(myConst.MAX_RECS_ON_JOIN), limit(0)),acctno,providerid,deanumber,-Expiration_Date),acctno,providerid,deanumber,Expiration_Date);
		f_deas := JOIN(f_deas1,f_deas2,left.acctno=right.acctno and left.deanumber = right.deanumber,transform(mylayouts.pid_dea_rec, self.expiration_date:=right.expiration_date;self :=left),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		f_deas_srt := sort(f_deas(DEANumber<>''), record);
		f_deas_dep := sort(dedup(f_deas_srt, acctno,providerid,deanumber,Expiration_Date),acctno,providerid,deanumber,-Expiration_Date);

		//rollup DEA
		mylayouts.pid_dea_rec doRollDea(mylayouts.pid_dea_rec l, mylayouts.pid_dea_rec r) := TRANSFORM
			self.acctno := l.acctno;
			SELF.providerid := l.providerid;
			self.deanumber := trim(l.deanumber,all);
			self.deanumberTierTypeID := if(l.deanumberTierTypeID<r.deanumberTierTypeID,l.deanumberTierTypeID,r.deanumberTierTypeID);
			self.expiration_date := if(l.expiration_date <>'',l.expiration_date,r.expiration_date);
		END;
		f_dea_rollup := rollup(f_deas_dep,doRollDea(left,right),acctno,providerid,deanumber,Expiration_Date);
		result:=project(f_dea_rollup, transform(mylayouts.layout_dea,
												self.acctno:=left.acctno;
												SELF.providerid := left.providerid;
												self.dea := trim(left.deanumber,all);
												self.expiration_date := left.expiration_date;
												self := []));
		mylayouts.layout_child_dea doRollup(mylayouts.layout_dea l, dataset(mylayouts.layout_dea) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getIngNPIs(dataset(mylayouts.slimforLookup) provs) := function
		pid_ing_npi_rec := record
			string20	 	acctno := '';
			unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_npi_rec;
		end;

		pid_ing_npi_rec get_npis(mylayouts.slimforLookup l,ingenix_natlprof.key_NPI_providerid r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self.NPITierTypeID := (unsigned2) r.NPITierTypeID;
			self := r;
		end;

		f_npis := join(provs,ingenix_natlprof.key_NPI_providerid,keyed(left.prov_id =right.l_providerid),get_npis(left,right),
			keep(myConst.MAX_RECS_ON_JOIN), limit(0));

		f_npis_srt := sort(f_npis(npi<>''), record);
		f_npis_dep := dedup(f_npis_srt, record, except NPITierTypeID);
		result:=project(f_npis_dep, transform(mylayouts.layout_npi,
												self.acctno := left.acctno;
													SELF.providerid := left.providerid;
												self.npi := left.npi;
												self := []));
		mylayouts.layout_child_npi doRollup(mylayouts.layout_npi l, dataset(mylayouts.layout_npi) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
		return results_rolled;
	End;
	Export getIngLicenses(dataset(mylayouts.slimforLookup) provs) := function
		pid_license_rec := record
			string20	 	acctno := '';
			unsigned6 providerid;
			doxie.ingenix_provider_module.ingenix_license_rpt_rec;
			string licensestatus := '';
		end;

		pid_license_rec get_licenses(mylayouts.slimforLookup l,ingenix_natlprof.key_license_providerid r) := transform
			self.acctno := l.acctno;
			self.providerid := r.l_providerid;
			self.LicenseNumberTierTypeID := (unsigned2) r.LicenseNumberTierTypeID;
			self := r;
		end;

		f_licenses := join(provs,ingenix_natlprof.key_license_providerid,keyed(left.prov_id = right.l_providerid),
													get_licenses(left,right),keep(myConst.MAX_RECS_ON_JOIN), limit(0));

		f_licenses_srt := sort(f_licenses(LicenseNumber<>'' or LicenseState<>''), acctno, providerid, LicenseState,-Termination_Date, LicenseNumber);
		f_licenses_dep := dedup(f_licenses_srt, acctno,providerid, LicenseState,Termination_Date, LicenseNumber);

		pid_license_rec doRemoveBadLicense(pid_license_rec l) := TRANSFORM
			SELF.acctno := l.acctno;
			SELF.providerid := l.providerid;
			self.licensestate := l.licensestate;
			self.licensenumber :=  myFn.removeLeadingZeros(myFn.cleanLicenses(l.licensenumber));
			self.LicenseStatus := l.licensestatus;
			self.effective_date := l.effective_date;
			self.termination_date := if(l.termination_date <>'',
																	l.termination_date,
																	if(exists(f_licenses_dep(licensenumber=l.licensenumber,
																							licensestate=l.licensestate,
																							termination_date<>'')
																						),skip,l.termination_date));
			self.licensenumberTierTypeID := l.licensenumberTierTypeID;
		END;
		f_licenses_clean:=project(f_licenses_dep,doRemoveBadLicense(left));

		//rollup License
		pid_license_rec doRollLicense(pid_license_rec l, pid_license_rec r) := TRANSFORM
			SELF.acctno := l.acctno;
			SELF.providerid := l.providerid;
			self.licensestate := l.licensestate;
			self.licensenumber := l.licensenumber;
			self.licensestatus := l.licensestatus;
			self.effective_date := if(l.effective_date <>'',l.effective_date,r.effective_date);
			self.termination_date := if(l.termination_date <>'',l.termination_date,r.termination_date);
			self.licensenumberTierTypeID := if(l.licensenumberTierTypeID<r.licensenumberTierTypeID,l.licensenumberTierTypeID,r.licensenumberTierTypeID);
		END;

		f_licenses_rollup := rollup(f_licenses_clean,doRollLicense(left,right),acctno, providerid, licensenumber, licensestate, termination_date);
		f_licenses_rollup_sorted := sort(f_licenses_rollup,acctno,providerid,licensestate, -termination_date, licensenumber);
		result:=project(f_licenses_rollup_sorted, transform(mylayouts.layout_licenseinfo,
												self.licenseAcctno := left.acctno;
													SELF.providerid := left.providerid;
												self.licenseSeq := 1;
												self.LicenseState := left.licensestate;
												self.LicenseNumber := left.licensenumber;
												self.LicenseStatus := left.licensestatus;
												self.Effective_Date :=left.effective_date;
												self.Termination_Date:=left.termination_date;
												self := []));
		mylayouts.layout_child_licenseinfo doRollup(mylayouts.layout_licenseinfo l, dataset(mylayouts.layout_licenseinfo) r) := TRANSFORM
			SELF.acctno := l.licenseAcctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		results_rolled := rollup(group(sort(result,licenseAcctno,ProviderID),licenseAcctno,ProviderID),group,doRollup(left,rows(left)));
		// output(provs);
		// output(f_licenses);
		return results_rolled;
	End;

end;