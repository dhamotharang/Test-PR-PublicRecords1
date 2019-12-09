import Healthcare_Header_Services,doxie,autostandardi,ut;
EXPORT Medlic_transform := module
		
		shared gm:=autostandardi.GlobalModule();

		Export dataset(prof_LicenseV2_Services.Medlic_layout.layout_w_penalt) rawDataToFlat(dataset(Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout) recs,UNSIGNED1 pt) := function

			prof_LicenseV2_Services.Medlic_layout.layout_w_penalt rowToFlat(Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout rec) := transform
					self.acctno:=rec.acctno;
					self.penalt := rec.record_penalty;
					self.ProviderID := if(rec.lnpid > 0, (string)rec.lnpid,(String)rec.srcid);
					self.did := (string)rec.dids[1].did;
					self.Gender_Name := rec.names[1].gender;
					self.sanc_flag := if(count(rec.legacysanctions)>0,true,false);
					//Name may not match NPI record try to make it match....
					testname := project(rec.names(nameSeq>0),transform(Healthcare_Header_Services.Layouts.layout_nameinfo,
															 keepRec := left.lastname=rec.NPIRaw[1].EntityInformation.EntityName.Last;
															 self.firstname:=left.firstname;
															 self.middlename:=left.middlename;
															 self.lastname:=if(keepRec,left.lastname,skip);
															 self := left;));
					self.Prov_Clean_fname := if(exists(testname),testname[1].firstname,rec.names[1].firstname);
					self.Prov_Clean_mname := if(exists(testname),testname[1].middlename,rec.names[1].middlename);
					self.Prov_Clean_lname := if(exists(testname),testname[1].lastname,rec.names[1].lastname);
					self.FullName := rec.names[1].CompanyName;
					self.TaxID := prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.get_taxid(project(rec.taxids,transform(doxie.ingenix_provider_module.ingenix_taxid_rec, self :=left;self:=[])));
					self.BirthDate := prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(sort(rec.dobs,-dob)[1].dob);
					self.Language:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.get_lang(project(rec.Languages,doxie.ingenix_provider_module.ingenix_language_rec));
					self.UPIN := prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.get_UPIN(project(rec.upins,transform(doxie.ingenix_provider_module.ingenix_upin_rec, self := left; self:=[])));
					self.Taxonomy_code:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.get_taxonomy_code(project(rec.Taxonomy,doxie.ingenix_provider_module.ingenix_taxonomy_rec));
					self.NPI := rec.npis[1].npi;
					self.License_1 := if(rec.statelicenses[1].LicenseNumber <> '',trim(rec.statelicenses[1].LicenseNumber,all)+' '+trim(rec.statelicenses[1].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[1].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[1].Termination_Date),'');
					self.License_2 := if(rec.statelicenses[2].LicenseNumber <> '',trim(rec.statelicenses[2].LicenseNumber,all)+' '+trim(rec.statelicenses[2].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[2].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[2].Termination_Date),'');
					self.License_3 := if(rec.statelicenses[3].LicenseNumber <> '',trim(rec.statelicenses[3].LicenseNumber,all)+' '+trim(rec.statelicenses[3].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[3].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[3].Termination_Date),'');
					self.License_4 := if(rec.statelicenses[4].LicenseNumber <> '',trim(rec.statelicenses[4].LicenseNumber,all)+' '+trim(rec.statelicenses[4].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[4].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[4].Termination_Date),'');
					self.License_5 := if(rec.statelicenses[5].LicenseNumber <> '',trim(rec.statelicenses[5].LicenseNumber,all)+' '+trim(rec.statelicenses[5].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[5].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[5].Termination_Date),'');
					self.License_6 := if(rec.statelicenses[6].LicenseNumber <> '',trim(rec.statelicenses[6].LicenseNumber,all)+' '+trim(rec.statelicenses[6].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[6].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[6].Termination_Date),'');
					self.License_7 := if(rec.statelicenses[7].LicenseNumber <> '',trim(rec.statelicenses[7].LicenseNumber,all)+' '+trim(rec.statelicenses[7].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[7].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[7].Termination_Date),'');
					self.License_8 := if(rec.statelicenses[8].LicenseNumber <> '',trim(rec.statelicenses[8].LicenseNumber,all)+' '+trim(rec.statelicenses[8].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[8].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[8].Termination_Date),'');
					self.License_9 := if(rec.statelicenses[9].LicenseNumber <> '',trim(rec.statelicenses[9].LicenseNumber,all)+' '+trim(rec.statelicenses[9].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[9].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[9].Termination_Date),'');
					self.License_10 := if(rec.statelicenses[10].LicenseNumber <> '',trim(rec.statelicenses[10].LicenseNumber,all)+' '+trim(rec.statelicenses[10].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[10].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[10].Termination_Date),'');
					self.License_11 := if(rec.statelicenses[11].LicenseNumber <> '',trim(rec.statelicenses[11].LicenseNumber,all)+' '+trim(rec.statelicenses[11].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[11].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[11].Termination_Date),'');
					self.License_12 := if(rec.statelicenses[12].LicenseNumber <> '',trim(rec.statelicenses[12].LicenseNumber,all)+' '+trim(rec.statelicenses[12].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[12].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[12].Termination_Date),'');
					self.License_13 := if(rec.statelicenses[13].LicenseNumber <> '',trim(rec.statelicenses[13].LicenseNumber,all)+' '+trim(rec.statelicenses[13].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[13].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[13].Termination_Date),'');
					self.License_14 := if(rec.statelicenses[14].LicenseNumber <> '',trim(rec.statelicenses[14].LicenseNumber,all)+' '+trim(rec.statelicenses[14].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[14].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[14].Termination_Date),'');
					self.License_15 := if(rec.statelicenses[15].LicenseNumber <> '',trim(rec.statelicenses[15].LicenseNumber,all)+' '+trim(rec.statelicenses[15].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[15].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[15].Termination_Date),'');
					self.License_16 := if(rec.statelicenses[16].LicenseNumber <> '',trim(rec.statelicenses[16].LicenseNumber,all)+' '+trim(rec.statelicenses[16].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[16].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[16].Termination_Date),'');
					self.License_17 := if(rec.statelicenses[17].LicenseNumber <> '',trim(rec.statelicenses[17].LicenseNumber,all)+' '+trim(rec.statelicenses[17].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[17].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[17].Termination_Date),'');
					self.License_18 := if(rec.statelicenses[18].LicenseNumber <> '',trim(rec.statelicenses[18].LicenseNumber,all)+' '+trim(rec.statelicenses[18].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[18].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[18].Termination_Date),'');
					self.License_19 := if(rec.statelicenses[19].LicenseNumber <> '',trim(rec.statelicenses[19].LicenseNumber,all)+' '+trim(rec.statelicenses[19].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[19].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[19].Termination_Date),'');
					self.License_20 := if(rec.statelicenses[20].LicenseNumber <> '',trim(rec.statelicenses[20].LicenseNumber,all)+' '+trim(rec.statelicenses[20].LicenseState,all) +' '+
															trim(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[20].effective_date),all) + ' - '+prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[20].Termination_Date),'');
					self.Lic1_Number:=rec.statelicenses[1].LicenseNumber;
					self.Lic1_State:=rec.statelicenses[1].LicenseState;
					self.Lic1_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[1].effective_date);
					self.Lic1_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[1].Termination_Date);
					self.Lic2_Number:=rec.statelicenses[2].LicenseNumber;
					self.Lic2_State:=rec.statelicenses[2].LicenseState;
					self.Lic2_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[2].effective_date);
					self.Lic2_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[2].Termination_Date);
					self.Lic3_Number:=rec.statelicenses[3].LicenseNumber;
					self.Lic3_State:=rec.statelicenses[3].LicenseState;
					self.Lic3_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[3].effective_date);
					self.Lic3_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[3].Termination_Date);
					self.Lic4_Number:=rec.statelicenses[4].LicenseNumber;
					self.Lic4_State:=rec.statelicenses[4].LicenseState;
					self.Lic4_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[4].effective_date);
					self.Lic4_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[4].Termination_Date);
					self.Lic5_Number:=rec.statelicenses[5].LicenseNumber;
					self.Lic5_State:=rec.statelicenses[5].LicenseState;
					self.Lic5_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[5].effective_date);
					self.Lic5_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[5].Termination_Date);
					self.Lic6_Number:=rec.statelicenses[6].LicenseNumber;
					self.Lic6_State:=rec.statelicenses[6].LicenseState;
					self.Lic6_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[6].effective_date);
					self.Lic6_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[6].Termination_Date);
					self.Lic7_Number:=rec.statelicenses[7].LicenseNumber;
					self.Lic7_State:=rec.statelicenses[7].LicenseState;
					self.Lic7_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[7].effective_date);
					self.Lic7_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[7].Termination_Date);
					self.Lic8_Number:=rec.statelicenses[8].LicenseNumber;
					self.Lic8_State:=rec.statelicenses[8].LicenseState;
					self.Lic8_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[8].effective_date);
					self.Lic8_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[8].Termination_Date);
					self.Lic9_Number:=rec.statelicenses[9].LicenseNumber;
					self.Lic9_State:=rec.statelicenses[9].LicenseState;
					self.Lic9_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[9].effective_date);
					self.Lic9_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[9].Termination_Date);
					self.Lic10_Number:=rec.statelicenses[10].LicenseNumber;
					self.Lic10_State:=rec.statelicenses[10].LicenseState;
					self.Lic10_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[10].effective_date);
					self.Lic10_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[10].Termination_Date);
					self.Lic11_Number:=rec.statelicenses[11].LicenseNumber;
					self.Lic11_State:=rec.statelicenses[11].LicenseState;
					self.Lic11_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[11].effective_date);
					self.Lic11_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[11].Termination_Date);
					self.Lic12_Number:=rec.statelicenses[12].LicenseNumber;
					self.Lic12_State:=rec.statelicenses[12].LicenseState;
					self.Lic12_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[12].effective_date);
					self.Lic12_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[12].Termination_Date);
					self.Lic13_Number:=rec.statelicenses[13].LicenseNumber;
					self.Lic13_State:=rec.statelicenses[13].LicenseState;
					self.Lic13_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[13].effective_date);
					self.Lic13_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[13].Termination_Date);
					self.Lic14_Number:=rec.statelicenses[14].LicenseNumber;
					self.Lic14_State:=rec.statelicenses[14].LicenseState;
					self.Lic14_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[14].effective_date);
					self.Lic14_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[14].Termination_Date);
					self.Lic15_Number:=rec.statelicenses[15].LicenseNumber;
					self.Lic15_State:=rec.statelicenses[15].LicenseState;
					self.Lic15_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[15].effective_date);
					self.Lic15_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[15].Termination_Date);
					self.Lic16_Number:=rec.statelicenses[16].LicenseNumber;
					self.Lic16_State:=rec.statelicenses[16].LicenseState;
					self.Lic16_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[16].effective_date);
					self.Lic16_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[16].Termination_Date);
					self.Lic17_Number:=rec.statelicenses[17].LicenseNumber;
					self.Lic17_State:=rec.statelicenses[17].LicenseState;
					self.Lic17_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[17].effective_date);
					self.Lic17_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[17].Termination_Date);
					self.Lic18_Number:=rec.statelicenses[18].LicenseNumber;
					self.Lic18_State:=rec.statelicenses[18].LicenseState;
					self.Lic18_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[18].effective_date);
					self.Lic18_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[18].Termination_Date);
					self.Lic19_Number:=rec.statelicenses[19].LicenseNumber;
					self.Lic19_State:=rec.statelicenses[19].LicenseState;
					self.Lic19_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[19].effective_date);
					self.Lic19_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[19].Termination_Date);
					self.Lic20_Number:=rec.statelicenses[20].LicenseNumber;
					self.Lic20_State:=rec.statelicenses[20].LicenseState;
					self.Lic20_Eff_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[20].effective_date);
					self.Lic20_Exp_Date:=prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.format_date(rec.statelicenses[20].Termination_Date);
					self.DEANumber := prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.get_dea(project(rec.deas,transform(doxie.ingenix_provider_module.ingenix_dea_rec,self.deanumber:=left.dea;self:=left;self:=[])));
					self.Degree:= prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.get_Degree(project(rec.degrees,doxie.ingenix_provider_module.ingenix_degree_rec));
					tmpSpec := rec.Specialties;
					self.Specialty_1 := IF(tmpSpec[1].specialtyGroupName != '',
				                         TRIM( tmpSpec[1].specialtyName ) + '-' + TRIM(tmpSpec[1].specialtyGroupName ),
				                         tmpSpec[1].specialtyName );
					self.Specialty_2 := IF(tmpSpec[2].specialtyGroupName != '',
				                         TRIM( tmpSpec[2].specialtyName ) + '-' + TRIM(tmpSpec[2].specialtyGroupName ),
				                         tmpSpec[2].specialtyName );
					self.Specialty_3 := IF(tmpSpec[3].specialtyGroupName != '',
				                         TRIM( tmpSpec[3].specialtyName ) + '-' + TRIM(tmpSpec[3].specialtyGroupName ),
				                         tmpSpec[3].specialtyName );
					self.Specialty_4 := IF(tmpSpec[4].specialtyGroupName != '',
				                         TRIM( tmpSpec[4].specialtyName ) + '-' + TRIM(tmpSpec[4].specialtyGroupName ),
				                         tmpSpec[4].specialtyName );
					self.Specialty_5 := IF(tmpSpec[5].specialtyGroupName != '',
				                         TRIM( tmpSpec[5].specialtyName ) + '-' + TRIM(tmpSpec[5].specialtyGroupName ),
				                         tmpSpec[5].specialtyName );
					self.Specialty_6 := IF(tmpSpec[6].specialtyGroupName != '',
				                         TRIM( tmpSpec[6].specialtyName ) + '-' + TRIM(tmpSpec[6].specialtyGroupName ),
				                         tmpSpec[6].specialtyName );
					self.Specialty_7 := IF(tmpSpec[7].specialtyGroupName != '',
				                         TRIM( tmpSpec[7].specialtyName ) + '-' + TRIM(tmpSpec[7].specialtyGroupName ),
				                         tmpSpec[7].specialtyName );
					self.Specialty_8 := IF(tmpSpec[8].specialtyGroupName != '',
				                         TRIM( tmpSpec[8].specialtyName ) + '-' + TRIM(tmpSpec[8].specialtyGroupName ),
				                         tmpSpec[8].specialtyName );
					self.Specialty_9 := IF(tmpSpec[9].specialtyGroupName != '',
				                         TRIM( tmpSpec[9].specialtyName ) + '-' + TRIM(tmpSpec[9].specialtyGroupName ),
				                         tmpSpec[9].specialtyName );
					self.Specialty_10 := IF(tmpSpec[10].specialtyGroupName != '',
				                         TRIM( tmpSpec[10].specialtyName ) + '-' + TRIM(tmpSpec[10].specialtyGroupName ),
				                         tmpSpec[10].specialtyName );
					self.Specialty_11 := IF(tmpSpec[11].specialtyGroupName != '',
				                         TRIM( tmpSpec[11].specialtyName ) + '-' + TRIM(tmpSpec[11].specialtyGroupName ),
				                         tmpSpec[11].specialtyName );
					self.Specialty_12 := IF(tmpSpec[12].specialtyGroupName != '',
				                         TRIM( tmpSpec[12].specialtyName ) + '-' + TRIM(tmpSpec[12].specialtyGroupName ),
				                         tmpSpec[12].specialtyName );
					self.Specialty_13 := IF(tmpSpec[13].specialtyGroupName != '',
				                         TRIM( tmpSpec[13].specialtyName ) + '-' + TRIM(tmpSpec[13].specialtyGroupName ),
				                         tmpSpec[13].specialtyName );
					self.Specialty_14 := IF(tmpSpec[14].specialtyGroupName != '',
				                         TRIM( tmpSpec[14].specialtyName ) + '-' + TRIM(tmpSpec[14].specialtyGroupName ),
				                         tmpSpec[14].specialtyName );
					self.Specialty_15 := IF(tmpSpec[15].specialtyGroupName != '',
				                         TRIM( tmpSpec[15].specialtyName ) + '-' + TRIM(tmpSpec[15].specialtyGroupName ),
				                         tmpSpec[15].specialtyName );
					self.Specialty_16 := IF(tmpSpec[16].specialtyGroupName != '',
				                         TRIM( tmpSpec[16].specialtyName ) + '-' + TRIM(tmpSpec[16].specialtyGroupName ),
				                         tmpSpec[16].specialtyName );
					self.Specialty_17 := IF(tmpSpec[17].specialtyGroupName != '',
				                         TRIM( tmpSpec[17].specialtyName ) + '-' + TRIM(tmpSpec[17].specialtyGroupName ),
				                         tmpSpec[17].specialtyName );
					self.Specialty_18 := IF(tmpSpec[18].specialtyGroupName != '',
				                         TRIM( tmpSpec[18].specialtyName ) + '-' + TRIM(tmpSpec[18].specialtyGroupName ),
				                         tmpSpec[18].specialtyName );
					self.Specialty_19 := IF(tmpSpec[19].specialtyGroupName != '',
				                         TRIM( tmpSpec[19].specialtyName ) + '-' + TRIM(tmpSpec[19].specialtyGroupName ),
				                         tmpSpec[19].specialtyName );
					self.Specialty_20 := IF(tmpSpec[20].specialtyGroupName != '',
				                         TRIM( tmpSpec[20].specialtyName ) + '-' + TRIM(tmpSpec[20].specialtyGroupName ),
				                         tmpSpec[20].specialtyName );
					self.Address1_1 := rec.addresses[1].address1;
					self.Address2_1 := rec.addresses[1].address2;
					self.City_1 := rec.addresses[1].v_city_name;
					self.St_1 := rec.addresses[1].st;
					self.Zip_1 := rec.addresses[1].z5;
					self.PhoneNumber_1 := rec.addresses[1].PhoneNumber;
					self.Address1_2 := rec.addresses[2].address1;
					self.Address2_2 := rec.addresses[2].address2;
					self.City_2 := rec.addresses[2].v_city_name;
					self.St_2 := rec.addresses[2].st;
					self.Zip_2 := rec.addresses[2].z5;
					self.PhoneNumber_2 := rec.addresses[2].PhoneNumber;
					self.Address1_3 := rec.addresses[3].address1;
					self.Address2_3 := rec.addresses[3].address2;
					self.City_3 := rec.addresses[3].v_city_name;
					self.St_3 := rec.addresses[3].st;
					self.Zip_3 := rec.addresses[3].z5;
					self.PhoneNumber_3 := rec.addresses[3].PhoneNumber;
					self.Address1_4 := rec.addresses[4].address1;
					self.Address2_4 := rec.addresses[4].address2;
					self.City_4 := rec.addresses[4].v_city_name;
					self.St_4 := rec.addresses[4].st;
					self.Zip_4 := rec.addresses[4].z5;
					self.PhoneNumber_4 := rec.addresses[4].PhoneNumber;
					self.Address1_5 := rec.addresses[5].address1;
					self.Address2_5 := rec.addresses[5].address2;
					self.City_5 := rec.addresses[5].v_city_name;
					self.St_5 := rec.addresses[5].st;
					self.Zip_5 := rec.addresses[5].z5;
					self.PhoneNumber_5 := rec.addresses[5].PhoneNumber;
					self.Address1_6 := rec.addresses[6].address1;
					self.Address2_6 := rec.addresses[6].address2;
					self.City_6 := rec.addresses[6].v_city_name;
					self.St_6 := rec.addresses[6].st;
					self.Zip_6 := rec.addresses[6].z5;
					self.PhoneNumber_6 := rec.addresses[6].PhoneNumber;
					self.Address1_7 := rec.addresses[7].address1;
					self.Address2_7 := rec.addresses[7].address2;
					self.City_7 := rec.addresses[7].v_city_name;
					self.St_7 := rec.addresses[7].st;
					self.Zip_7 := rec.addresses[7].z5;
					self.PhoneNumber_7 := rec.addresses[7].PhoneNumber;
					self.Address1_8 := rec.addresses[8].address1;
					self.Address2_8 := rec.addresses[8].address2;
					self.City_8 := rec.addresses[8].v_city_name;
					self.St_8 := rec.addresses[8].st;
					self.Zip_8 := rec.addresses[8].z5;
					self.PhoneNumber_8 := rec.addresses[8].PhoneNumber;
					self.Address1_9 := rec.addresses[9].address1;
					self.Address2_9 := rec.addresses[9].address2;
					self.City_9 := rec.addresses[9].v_city_name;
					self.St_9 := rec.addresses[9].st;
					self.Zip_9 := rec.addresses[9].z5;
					self.PhoneNumber_9 := rec.addresses[9].PhoneNumber;
					self.Address1_10 := rec.addresses[10].address1;
					self.Address2_10 := rec.addresses[10].address2;
					self.City_10 := rec.addresses[10].v_city_name;
					self.St_10 := rec.addresses[10].st;
					self.Zip_10 := rec.addresses[10].z5;
					self.PhoneNumber_10 := rec.addresses[10].PhoneNumber;
					self.GroupName_1 := rec.affiliates[1].name;
					self.GroupAffiliationAddress_1 := rec.affiliates[1].address1;
					self.GroupAffiliationCity_1 := rec.affiliates[1].p_city_name;
					self.GroupAffiliationState_1 := rec.affiliates[1].st;
					self.GroupAffiliationZip_1 := rec.affiliates[1].z5;
					self.GroupName_2 := rec.affiliates[2].name;
					self.GroupAffiliationAddress_2 := rec.affiliates[2].address1;
					self.GroupAffiliationCity_2 := rec.affiliates[2].p_city_name;
					self.GroupAffiliationState_2 := rec.affiliates[2].st;
					self.GroupAffiliationZip_2 := rec.affiliates[2].z5;
					self.GroupName_3 := rec.affiliates[3].name;
					self.GroupAffiliationAddress_3 := rec.affiliates[3].address1;
					self.GroupAffiliationCity_3 := rec.affiliates[3].p_city_name;
					self.GroupAffiliationState_3 := rec.affiliates[3].st;
					self.GroupAffiliationZip_3 := rec.affiliates[3].z5;
					self.GroupName_4 := rec.affiliates[4].name;
					self.GroupAffiliationAddress_4 := rec.affiliates[4].address1;
					self.GroupAffiliationCity_4 := rec.affiliates[4].p_city_name;
					self.GroupAffiliationState_4 := rec.affiliates[4].st;
					self.GroupAffiliationZip_4 := rec.affiliates[4].z5;
					self.GroupName_5 := rec.affiliates[5].name;
					self.GroupAffiliationAddress_5 := rec.affiliates[5].address1;
					self.GroupAffiliationCity_5 := rec.affiliates[5].p_city_name;
					self.GroupAffiliationState_5 := rec.affiliates[5].st;
					self.GroupAffiliationZip_5 := rec.affiliates[5].z5;
					self.GroupName_6 := rec.affiliates[6].name;
					self.GroupAffiliationAddress_6 := rec.affiliates[6].address1;
					self.GroupAffiliationCity_6 := rec.affiliates[6].p_city_name;
					self.GroupAffiliationState_6 := rec.affiliates[6].st;
					self.GroupAffiliationZip_6 := rec.affiliates[6].z5;
					self.GroupName_7 := rec.affiliates[7].name;
					self.GroupAffiliationAddress_7 := rec.affiliates[7].address1;
					self.GroupAffiliationCity_7 := rec.affiliates[7].p_city_name;
					self.GroupAffiliationState_7 := rec.affiliates[7].st;
					self.GroupAffiliationZip_7 := rec.affiliates[7].z5;
					self.GroupName_8 := rec.affiliates[8].name;
					self.GroupAffiliationAddress_8 := rec.affiliates[8].address1;
					self.GroupAffiliationCity_8 := rec.affiliates[8].p_city_name;
					self.GroupAffiliationState_8 := rec.affiliates[8].st;
					self.GroupAffiliationZip_8 := rec.affiliates[8].z5;
					self.GroupName_9 := rec.affiliates[9].name;
					self.GroupAffiliationAddress_9 := rec.affiliates[9].address1;
					self.GroupAffiliationCity_9 := rec.affiliates[9].p_city_name;
					self.GroupAffiliationState_9 := rec.affiliates[9].st;
					self.GroupAffiliationZip_9 := rec.affiliates[9].z5;
					self.GroupName_10 := rec.affiliates[10].name;
					self.GroupAffiliationAddress_10 := rec.affiliates[10].address1;
					self.GroupAffiliationCity_10 := rec.affiliates[10].p_city_name;
					self.GroupAffiliationState_10 := rec.affiliates[10].st;
					self.GroupAffiliationZip_10 := rec.affiliates[10].z5;
					self.HospitalName_1:= rec.hospitals[1].name;
					self.HospitalAffiliationAddress_1:= rec.hospitals[1].address1;
					self.HospitalAffiliationCity_1 := rec.hospitals[1].p_city_name;
					self.HospitalAffiliationState_1 := rec.hospitals[1].st;
					self.HospitalAffiliationZip_1 := rec.hospitals[1].z5;
					self.HospitalName_2:= rec.hospitals[2].name;
					self.HospitalAffiliationAddress_2:= rec.hospitals[2].address1;
					self.HospitalAffiliationCity_2 := rec.hospitals[2].p_city_name;
					self.HospitalAffiliationState_2 := rec.hospitals[2].st;
					self.HospitalAffiliationZip_2 := rec.hospitals[2].z5;
					self.HospitalName_3:= rec.hospitals[3].name;
					self.HospitalAffiliationAddress_3:= rec.hospitals[3].address1;
					self.HospitalAffiliationCity_3 := rec.hospitals[3].p_city_name;
					self.HospitalAffiliationState_3 := rec.hospitals[3].st;
					self.HospitalAffiliationZip_3 := rec.hospitals[3].z5;
					self.HospitalName_4:= rec.hospitals[4].name;
					self.HospitalAffiliationAddress_4:= rec.hospitals[4].address1;
					self.HospitalAffiliationCity_4 := rec.hospitals[4].p_city_name;
					self.HospitalAffiliationState_4 := rec.hospitals[4].st;
					self.HospitalAffiliationZip_4 := rec.hospitals[4].z5;
					self.HospitalName_5:= rec.hospitals[5].name;
					self.HospitalAffiliationAddress_5:= rec.hospitals[5].address1;
					self.HospitalAffiliationCity_5 := rec.hospitals[5].p_city_name;
					self.HospitalAffiliationState_5 := rec.hospitals[5].st;
					self.HospitalAffiliationZip_5 := rec.hospitals[5].z5;
					self.HospitalName_6:= rec.hospitals[6].name;
					self.HospitalAffiliationAddress_6:= rec.hospitals[6].address1;
					self.HospitalAffiliationCity_6 := rec.hospitals[6].p_city_name;
					self.HospitalAffiliationState_6 := rec.hospitals[6].st;
					self.HospitalAffiliationZip_6 := rec.hospitals[6].z5;
					self.HospitalName_7:= rec.hospitals[7].name;
					self.HospitalAffiliationAddress_7:= rec.hospitals[7].address1;
					self.HospitalAffiliationCity_7 := rec.hospitals[7].p_city_name;
					self.HospitalAffiliationState_7 := rec.hospitals[7].st;
					self.HospitalAffiliationZip_7 := rec.hospitals[7].z5;
					self.HospitalName_8:= rec.hospitals[8].name;
					self.HospitalAffiliationAddress_8 := rec.hospitals[8].address1;;
					self.HospitalAffiliationCity_8 := rec.hospitals[8].p_city_name;
					self.HospitalAffiliationState_8 := rec.hospitals[8].st;
					self.HospitalAffiliationZip_8 := rec.hospitals[8].z5;
					self.HospitalName_9:= rec.hospitals[9].name;
					self.HospitalAffiliationAddress_9 := rec.hospitals[9].address1;
					self.HospitalAffiliationCity_9 := rec.hospitals[9].p_city_name;
					self.HospitalAffiliationState_9 := rec.hospitals[9].st;
					self.HospitalAffiliationZip_9 := rec.hospitals[9].z5;
					self.HospitalName_10 := rec.hospitals[10].name;
					self.HospitalAffiliationAddress_10 := rec.hospitals[10].address1;
					self.HospitalAffiliationCity_10 := rec.hospitals[10].p_city_name;
					self.HospitalAffiliationState_10 := rec.hospitals[10].st;
					self.HospitalAffiliationZip_10 := rec.hospitals[10].z5;
					self.Residency_1 := rec.Residencies[1].Residency;
					self.Residency_2 := rec.Residencies[2].Residency;
					self.Residency_3 := rec.Residencies[3].Residency;
					self.Residency_4 := rec.Residencies[4].Residency;
					self.Residency_5 := rec.Residencies[5].Residency;
					self.Residency_6 := rec.Residencies[6].Residency;
					self.Residency_7 := rec.Residencies[7].Residency;
					self.Residency_8 := rec.Residencies[8].Residency;
					self.Residency_9 := rec.Residencies[9].Residency;
					self.Residency_10 := rec.Residencies[10].Residency;
					tmpMedSch := rec.medschools;
					self.MedSchoolName_1 := IF( tmpMedSch[1].medschoolName <> '',
				                             TRIM( tmpMedSch[1].medschoolName ) + ' ' + TRIM( tmpMedSch[1].GraduationYear ),
													           '');
					self.MedSchoolName_2 := IF( tmpMedSch[2].medschoolName <> '',
				                             TRIM( tmpMedSch[2].medschoolName ) + ' ' + TRIM( tmpMedSch[2].GraduationYear ),
													           '');
					self.MedSchoolName_3 := IF( tmpMedSch[3].medschoolName <> '',
				                             TRIM( tmpMedSch[3].medschoolName ) + ' ' + TRIM( tmpMedSch[3].GraduationYear ),
													           '');
					self.MedSchoolName_4 := IF( tmpMedSch[4].medschoolName <> '',
				                             TRIM( tmpMedSch[4].medschoolName ) + ' ' + TRIM( tmpMedSch[4].GraduationYear ),
													           '');
					self.MedSchoolName_5 := IF( tmpMedSch[5].medschoolName <> '',
				                             TRIM( tmpMedSch[5].medschoolName ) + ' ' + TRIM( tmpMedSch[5].GraduationYear ),
													           '');
					self.MedSchoolName_6 := IF( tmpMedSch[6].medschoolName <> '',
				                             TRIM( tmpMedSch[6].medschoolName ) + ' ' + TRIM( tmpMedSch[6].GraduationYear ),
													           '');
					self.MedSchoolName_7 := IF( tmpMedSch[7].medschoolName <> '',
				                             TRIM( tmpMedSch[7].medschoolName ) + ' ' + TRIM( tmpMedSch[7].GraduationYear ),
													           '');
					self.MedSchoolName_8 := IF( tmpMedSch[8].medschoolName <> '',
				                             TRIM( tmpMedSch[8].medschoolName ) + ' ' + TRIM( tmpMedSch[8].GraduationYear ),
													           '');
					self.MedSchoolName_9 := IF( tmpMedSch[9].medschoolName <> '',
				                             TRIM( tmpMedSch[9].medschoolName ) + ' ' + TRIM( tmpMedSch[9].GraduationYear ),
													           '');
					self.MedSchoolName_10 := IF( tmpMedSch[10].medschoolName <> '',
				                             TRIM( tmpMedSch[10].medschoolName ) + ' ' + TRIM( tmpMedSch[10].GraduationYear ),
													           '');
					self := [];
				End;
				out:=project(recs,rowToFlat(left));
				return out;
		End;
		
		Export processBatch(dataset(prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.pl_rec) batch_in,UNSIGNED1 pt) := function
			batchRows := project(batch_in,transform(Healthcare_Header_Services.Layouts.autokeyInput, 
																											self:=left));
			Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
				 self.penalty_threshold := pt;
				 self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
				 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
				 self.glb := gm.GLBPurpose;
		                 self.dppa := gm.DPPAPurpose;
				 self.drm := gm.DataRestrictionMask;	
				 self.includeSanctions:=true;
				// self:=[];Do not uncomment otherwise the default values will not get set.
			end;
			cfg:=dataset([buildConfig()]);
			rawdata := Healthcare_Header_Services.Records.getRecordsRawDoxie(batchRows,cfg);
			resort := join(batchRows,rawdata,left.acctno=right.acctno,
											transform(Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout, 
												tmpSrt := sort(right.statelicenses,map(left.license_state=LicenseState=>0,left.st=LicenseState=>1,2),-Termination_Date);
												tmpSrt1 := tmpSrt(LicenseState=tmpSrt[1].LicenseState and Termination_Date = tmpSrt[1].Termination_Date);
												tmpSrt2	:= sort(tmpSrt(LicenseState!=tmpSrt[1].LicenseState and Termination_Date!=tmpSrt[1].Termination_Date),-Termination_Date);
												self.statelicenses := tmpSrt1+tmpSrt2;
												self := right;));
			fmtdata:= rawDataToFlat(resort,pt);
			finaldata := sort(fmtdata,acctno,penalt);
			finaldata_grouped := dedup(sort(finaldata,acctno,penalt),acctno);//only return records with the same penalty as the lowest record in each batch row
			finaldata_filtered := join(finaldata,finaldata_grouped,left.acctno=right.acctno and left.penalt=right.penalt,transform(prof_LicenseV2_Services.Medlic_layout.layout_w_penalt, self:=left;));
			RETURN sort(finaldata_filtered,acctno);
		end;
end;