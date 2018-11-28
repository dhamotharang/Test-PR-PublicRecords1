import doxie, iesp, AutoStandardI, NPPES, DidVille, BatchServices, Business_Header_SS;

EXPORT Provider_Records_Transforms := MODULE
		shared myLayouts := Healthcare_Provider_Services.Layouts;
		shared myConst := Healthcare_Provider_Services.Constants;
		shared legacyLayout := doxie.ingenix_provider_module;
		Shared LegacySearch := legacyLayout.layout_ingenix_provider_search_plus;
		shared LegacyReport := legacyLayout.layout_ingenix_provider_report;
		shared LegacyReportWithVerification := myLayouts.LegacyReportWithVerifications;
		//Rollup data by acctno,srcid, src
		Export myLayouts.CombinedHeaderResults doSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
			SELF.acctno := l.acctno;
			self.HCID := if(l.hcid <> 0, l.hcid,l.SrcId);
			self.SrcId := l.SrcId;
			self.Src := l.Src;
			self.isHeaderResult := l.isHeaderResult;
			self.isDerivedSource := l.isDerivedSource;
			self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
			self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
			self.Addresses     := SORT(DEDUP( NORMALIZE( allRows, LEFT.Addresses, TRANSFORM( Layouts.layout_addressinfo, SELF := RIGHT	)	), RECORD, ALL, HASH ), -last_seen, -v_last_seen );
			self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
			self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
			self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Layouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
			self.dids          := DEDUP( NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	), did, ALL );
			self.bdids         := DEDUP( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	), bdid, ALL );
			self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
			self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids, TRANSFORM( Layouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
			self.upins         := DEDUP( NORMALIZE( allRows, LEFT.upins, TRANSFORM( Layouts.layout_upin, SELF := RIGHT	)	), upin, ALL );
			self.npis          := DEDUP( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF.npi := TRIM(RIGHT.npi,ALL), SELF := RIGHT	)	), npi, ALL );
			self.deas          := DEDUP( SORT( NORMALIZE( allRows, LEFT.deas, TRANSFORM( Layouts.layout_dea, SELF.dea := TRIM(RIGHT.dea,ALL), SELF := RIGHT	)	), dea, -expiration_date), dea, expiration_date );
			self.clianumbers   := DEDUP( NORMALIZE( allRows, LEFT.clianumbers, TRANSFORM( Layouts.layout_clianumber, SELF := RIGHT	)	), clianumber, ALL );
			self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Layouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
			self.StateLicenses := DEDUP( SORT( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), LicenseState,-Termination_Date, LicenseNumber), LicenseState, Termination_Date, LicenseNumber );
			self.affiliates    := DEDUP( NORMALIZE( allRows, LEFT.affiliates, TRANSFORM( Layouts.layout_affiliateHospital, SELF := RIGHT	)	), RECORD, ALL );
			self.hospitals     := DEDUP( NORMALIZE( allRows, LEFT.hospitals, TRANSFORM( Layouts.layout_affiliateHospital, SELF := RIGHT	)	), RECORD, ALL, HASH );
		END;

		Export mylayouts.layout_licenseinfo addLicSeq(Layouts.layout_licenseinfo l, integer c) := TRANSFORM
						self.licenseSeq := c;
						self := l;
		END;

		Export Layouts.layout_licenseinfo doStateLicenseRollup(Layouts.layout_licenseinfo l, dataset(Layouts.layout_licenseinfo) allRows) := transform 
			self.Effective_Date := min(allRows(Effective_Date<>''),Effective_Date);
			self.Termination_Date := max(allRows,Termination_Date);
			self := l;
		END;

		Export mylayouts.CombinedHeaderResults doFinalRollup(mylayouts.CombinedHeaderResults l, 
																								DATASET(mylayouts.CombinedHeaderResults) allRows) := TRANSFORM
			SELF.acctno := l.acctno;
			self.HcId   := l.hcid;
			self.SrcId  := l.SrcId;
			self.Src    := if(l.isHeaderResult,myConst.SRC_HEADER,l.Src);
			self.isHeaderResult := l.isHeaderResult;
			self.glb_ok	:= Functions.allowGLB();
			self.dppa_ok:= Functions.allowDPPA();
			self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
			self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( Layouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
			/*Add logic to sort based on requirements
				normalize the addresses
				sort them so similar address are together and get priority fields in first position
				dedupe out duplicates that are the exact same address, but to not have the priority fields set
				resort the address using the priority sorting below.
				**** Primary Sorting Sequence ****
				Ingenix provides addrTypeCode, addrVerificationStatusFlag and addrVerificationDate
				AMS provides addrGoldFlag and addrConfidenceValue
				Order should be the following and secondary should be on reported dates after this criteria
				AMS addrGoldFlag = Y 																							---> top verified address from AMS
				Ingenix addrTypeCode = 'C' and addrVerificationStatusFlag = 'X' 	---> top verified address from Ingenix
				AMS addrConfidenceValue sorted decending 													---> Verified older/previous verified addresses from AMS
				Ingenix addrTypeCode = 'C' and addrVerificationStatusFlag = 'C' or 'U' ---> Un-Verfied  older addresses from Ingenix
				Any other provider should follow after
				**** Secondary Sort Sequence ****
				NOTES addrSeq in AMS records is really bob_rank and in other datasets is it always 1 so
				after sorting on the above criteria you should use seq to ensure that the AMS records get lined up correctly in
				the addrConfidenceValue <> '' step.  
				**** Third sort Sequence ****			
				Finally, put a decending on the seen dates to put think in oder after that 
			*/
			normaddr:=NORMALIZE(allRows, LEFT.Addresses, TRANSFORM( Layouts.layout_addressinfo, 
																										self.addrSeqGrp := map(right.addrGoldFlag='Y'=>1,
																																					right.addrTypeCode='C' and right.addrVerificationStatusFlag = 'X' =>2,
																																					right.addrConfidenceValue <> '' => 3,
																																					right.addrTypeCode='C' and right.addrVerificationStatusFlag = 'C' =>4,
																																					right.addrTypeCode='C' and right.addrVerificationStatusFlag = 'U' =>5,6);
																										SELF := RIGHT));
			sortaddr:=sort(normaddr,prim_range,predir,prim_name,addr_suffix,postdir,
															 unit_desig,sec_range,p_city_name,v_city_name,st,z5,addrSeqGrp,-addrConfidenceValue,addrSeq, -last_seen, -v_last_seen);
			dedupAddr:=dedup(sortaddr,prim_range,predir,prim_name,addr_suffix,postdir,
															 unit_desig,sec_range,p_city_name,v_city_name,st,z5);
			reSortAddr:=sort(dedupAddr,addrSeqGrp,-addrConfidenceValue, addrSeq, -last_seen, -v_last_seen);
			self.Addresses     := Choosen(reSortAddr,100);
			self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
			self.dobs          := sort(DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL ),-dob);
			self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Layouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
			self.dids          := DEDUP( sort(NORMALIZE( allRows, LEFT.dids, TRANSFORM( Layouts.layout_did, SELF := RIGHT	)	),did,-freq), did, ALL );
			self.bdids         := DEDUP( sort(NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Layouts.layout_bdid, SELF := RIGHT	)	),bdid,-freq), bdid, ALL );
			self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
			self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids, TRANSFORM( Layouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
			self.upins         := DEDUP( NORMALIZE( allRows, LEFT.upins, TRANSFORM( Layouts.layout_upin, SELF := RIGHT	)	), upin, ALL );
			self.npis          := DEDUP( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Layouts.layout_npi, SELF.npi := TRIM(RIGHT.npi,ALL), SELF := RIGHT	)	), npi, ALL );
			self.deas          := DEDUP( SORT( NORMALIZE( allRows, LEFT.deas, TRANSFORM( Layouts.layout_dea, SELF.dea := TRIM(RIGHT.dea,ALL), SELF := RIGHT	)	), dea, -expiration_date), dea, expiration_date );
			self.clianumbers   := DEDUP( NORMALIZE( allRows, LEFT.clianumbers, TRANSFORM( Layouts.layout_clianumber, SELF := RIGHT	)	), clianumber, ALL );
			self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Layouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
			//Adding code to do rollup within each license to get most recent and first expire date to provide range
			self.StateLicenses := project(rollup(group(SORT( NORMALIZE( allRows, LEFT.StateLicenses, TRANSFORM( Layouts.layout_licenseinfo, SELF := RIGHT	)	), LicenseState,LicenseNumber,-Termination_Date),LicenseState,LicenseNumber),group,doStateLicenseRollup(left, rows(left))),addLicSeq(left,counter));
			self.affiliates    := DEDUP( NORMALIZE( allRows, LEFT.affiliates, TRANSFORM( Layouts.layout_affiliateHospital, SELF := RIGHT	)	), RECORD, ALL );
			self.hospitals     := DEDUP( NORMALIZE( allRows, LEFT.hospitals, TRANSFORM( Layouts.layout_affiliateHospital, SELF := RIGHT	)	), RECORD, ALL, HASH );
		END;

		shared legacyLayout.ingenix_npi_rec processNpi(iesp.npireport.t_NPIReport rec, integer c, string Verified) := transform
				self.NPI := rec.NPIInformation.NPINumber;
				self.NPITierTypeID:=0;
				self.NPPESVerified:=if(c=1,Verified,'NO');
		end;
		shared legacyLayout.ingenix_npi_rec processNpiSource(myLayouts.layout_npi rec) := transform
				self.NPI := rec.NPI;
				self.NPITierTypeID:=0;
				self.NPPESVerified:='NO';
		end;
		Export LegacyReport fmtLegacyRpt(myLayouts.CombinedHeaderResultsDoxieLayout resultRec, IParams.searchParams searchCriteria =  module(project(AutoStandardI.GlobalModule(), IParams.searchParams, opt)) end) := transform
			myGender := resultRec.Names(Gender<>'')[1].Gender;
			self.ProviderID:= if(resultRec.isHeaderResult,(string)resultRec.hcid,(string)resultRec.SrcID);
			self.ProviderSrc:= resultRec.Src;
			self.Gender := myGender;
			self.Gender_Name := map(myGender='M' => 'MALE',
															myGender='F' => 'FEMALE',
															myGender);
			self.sanc_flag := if(count(resultRec.Sanctions) >0,true,false);
			self.sanction_id := sort(project(resultRec.Sanctions,legacyLayout.ingenix_sanc_child_rec)(sanc_id>0),sanc_id);
			self.providerdid := project(resultRec.dids, transform(legacyLayout.ingenix_did_rec,self.did:=(string)left.did));
			self.name:= project(resultRec.Names, transform(legacyLayout.ingenix_name_rec,
																							self.Prov_Clean_fname := left.FirstName;
																							self.Prov_Clean_mname := left.MiddleName;
																							self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																							self.Prov_Clean_name_suffix := left.Suffix;
																							self := [];));
			self.taxid := project(resultRec.taxids, transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
			self.dob := project(resultRec.dobs, transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
			//Add rules about DOD
			dodTmp := dataset([{(string)resultRec.DeathLookup,resultRec.DateofDeath}],legacyLayout.ingenix_dod_rec);
			dodFull := dedup(sort(project(resultRec.optouts(death_ind<>''), transform(legacyLayout.ingenix_dod_rec, self.DeceasedIndicator := left.death_ind; self.DeceasedDate:=left.death_dt))+dodTmp,-DeceasedDate),record)(DeceasedDate<>'');
			self.dod := if(searchCriteria.IsShowAllDoDs,dodFull,choosen(dodFull,1));
			self.language := project(resultRec.Languages,legacyLayout.ingenix_language_rec);
			self.upin := project(resultRec.upins,transform(legacyLayout.ingenix_upin_rec,self.UPIN:=left.upin;self := []));
			npi_recs := project(resultRec.NPIRaw,processNpi(Left,counter,resultRec.NPPESVerified));
			npi_recs_orig := project(resultRec.npis,processNpiSource(left));
			npi_recs_filter := join(npi_recs,npi_recs_orig,left.npi=right.npi,right only);//Only keep those that are not dupes
			npi_recs_final := dedup(sort(npi_recs+npi_recs_filter,if(nppesverified = 'YES', 1, 2),npi),npi);
			self.npi := npi_recs_final;
			self.license := project(resultRec.StateLicenses, transform(legacyLayout.ingenix_license_rpt_rec,
																												self.LicenseState := left.LicenseState;
																												self.LicenseNumber := left.LicenseNumber;
																												self.Effective_Date := left.Effective_Date;
																												self.Termination_Date := left.Termination_Date;
																												self := []));
			self.dea := dedup(sort(project(resultRec.deas,transform(legacyLayout.ingenix_dea_rec,
																												self.DEANumber:=left.dea;
																												self.expiration_date := left.expiration_date;
																												self := []))(expiration_date<>''),deanumber,-expiration_date),deanumber,expiration_date);

			self.degree := project(resultRec.Degrees,legacyLayout.ingenix_degree_rec);
			self.specialty := project(resultRec.Specialties,legacyLayout.ingenix_specialty_rec);
			self.business_address := project(resultRec.Addresses, transform(legacyLayout.ingenix_addr_rpt_rec,
																			tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																			tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																								self.Prov_Clean_prim_range:=left.prim_range;
																								self.Prov_Clean_predir:=left.predir;
																								self.Prov_Clean_prim_name:=left.prim_name;
																								self.Prov_Clean_addr_suffix:=left.addr_suffix;
																								self.Prov_Clean_postdir:=left.postdir;
																								self.Prov_Clean_unit_desig:=left.unit_desig;
																								self.Prov_Clean_sec_range:=left.sec_range;
																								self.Prov_Clean_p_city_name:=left.p_city_name;
																								self.Prov_Clean_v_city_name:=left.v_city_name;
																								self.Prov_Clean_st:=left.st;
																								self.Prov_Clean_zip:=left.z5;
																								self.Prov_Clean_zip4:=left.zip4;
																								self.prov_Clean_geo_lat:=left.geo_lat;
																								SELF.prov_Clean_geo_long:=left.geo_long;
																								SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>'');
																								self.first_seen := left.first_seen;
																								self.last_seen := left.last_seen;
																								self := []));
			self.group_affiliation := project(resultRec.affiliates, transform(legacyLayout.ingenix_group_rec,
																								self.BDID := (string)left.bdid;
																								self.GroupName := left.name;
																								self.Address := left.address1;
																								self.City := left.p_city_name;
																								self.State := left.st;
																								self.Zip := left.z5;
																								self := []));
			self.hospital_affiliation := project(resultRec.hospitals, transform(legacyLayout.ingenix_hospital_rec,
																								self.BDID := (string)left.bdid;
																								self.HospitalName := left.name;
																								self.Address := left.address1;
																								self.City := left.p_city_name;
																								self.State := left.st;
																								self.Zip := left.z5;
																								self := []));
			self.residency := project(resultRec.Residencies,legacyLayout.ingenix_residency_rec);
			self.medschool := project(resultRec.MedSchools,legacyLayout.ingenix_medschool_rec);
			self.taxonomy := project(resultRec.Taxonomy,legacyLayout.ingenix_taxonomy_rec);
			self.sanction_data := sort(project(resultRec.Sanctions,legacyLayout.ingenix_sanc_child_rec_full),(integer)sanc_id);
			self.SSN := dedup(sort(project(resultRec.SSNLookups,legacyLayout.ingenix_ssn_rec)+project(resultRec.ssns,legacyLayout.ingenix_ssn_rec),record),record);
			self.medicareoptout := project(resultRec.optouts, transform(legacyLayout.ingenix_medicare_optout_rec,
																					self.OptOutSiteDescription:=left.optout_sitedesc;
																					self.AffidavitReceivedDate:=left.optout_rec_dt;
																					self.OptOutEffectiveDate:=left.optout_eff_dt;
																					self.OptOutTerminationDate:=left.optout_term_dt;
																					self.OptOutStatus:=left.optout_status;
																					self.LastUpdate:=left.optout_last_update;
																					self := []))(OptOutSiteDescription<>'' or OptOutTerminationDate<>'');
			self.Deceased := resultRec.DeathLookup or exists(resultRec.optouts(death_ind='Y'));
			self := resultRec;
			self := [];
		end;
		Export LegacyReportWithVerification fmtLegacyRptWithVerifications(myLayouts.CombinedHeaderResultsDoxieLayout resultRec, IParams.searchParams searchCriteria =  module(project(AutoStandardI.GlobalModule(), IParams.searchParams, opt)) end) := transform
			myGender := resultRec.Names(Gender<>'')[1].Gender;
			self.ProviderID:= if(resultRec.isHeaderResult,(string)resultRec.hcid,(string)resultRec.SrcID);
			self.ProviderSrc:= resultRec.Src;
			self.Gender := myGender;
			self.Gender_Name := map(myGender='M' => 'MALE',
															myGender='F' => 'FEMALE',
															myGender);
			self.sanc_flag := if(count(resultRec.Sanctions) >0,true,false);
			self.sanction_id := sort(project(resultRec.Sanctions,legacyLayout.ingenix_sanc_child_rec)(sanc_id>0),sanc_id);
			self.providerdid := project(resultRec.dids, transform(legacyLayout.ingenix_did_rec,self.did:=(string)left.did));
			self.name:= project(resultRec.Names, transform(legacyLayout.ingenix_name_rec,
																							self.Prov_Clean_fname := left.FirstName;
																							self.Prov_Clean_mname := left.MiddleName;
																							self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																							self.Prov_Clean_name_suffix := left.Suffix;
																							self := [];));
			self.taxid := project(resultRec.taxids, transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
			self.dob := project(resultRec.dobs, transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
			//Add rules about DOD
			dodTmp := dataset([{(string)resultRec.DeathLookup,resultRec.DateofDeath}],legacyLayout.ingenix_dod_rec);
			dodFull := dedup(sort(project(resultRec.optouts(death_ind<>''), transform(legacyLayout.ingenix_dod_rec, self.DeceasedIndicator := left.death_ind; self.DeceasedDate:=left.death_dt))+dodTmp,-DeceasedDate),record)(DeceasedDate<>'');
			self.dod := if(searchCriteria.IsShowAllDoDs,dodFull,choosen(dodFull,1));
			self.language := project(resultRec.Languages,legacyLayout.ingenix_language_rec);
			self.upin := project(resultRec.upins,transform(legacyLayout.ingenix_upin_rec,self.UPIN:=left.upin;self := []));
			npi_recs := project(resultRec.NPIRaw,processNpi(Left,counter,resultRec.NPPESVerified));
			npi_recs_orig := project(resultRec.npis,processNpiSource(left));
			npi_recs_filter := join(npi_recs,npi_recs_orig,left.npi=right.npi,right only);//Only keep those that are not dupes
			npi_recs_final := dedup(sort(npi_recs+npi_recs_filter,if(nppesverified = 'YES', 1, 2),npi),npi);
			self.npi := npi_recs_final;
			self.license := project(resultRec.StateLicenses, transform(legacyLayout.ingenix_license_rpt_rec,
																												self.LicenseState := left.LicenseState;
																												self.LicenseNumber := left.LicenseNumber;
																												self.Effective_Date := left.Effective_Date;
																												self.Termination_Date := left.Termination_Date;
																												self := []));
			self.dea := dedup(sort(project(resultRec.deas,transform(legacyLayout.ingenix_dea_rec,
																												self.DEANumber:=left.dea;
																												self.expiration_date := left.expiration_date;
																												self := []))(expiration_date<>''),deanumber,-expiration_date),deanumber,expiration_date);

			self.degree := project(resultRec.Degrees,legacyLayout.ingenix_degree_rec);
			self.specialty := project(resultRec.Specialties,legacyLayout.ingenix_specialty_rec);
			self.business_address := project(resultRec.Addresses, transform(legacyLayout.ingenix_addr_rpt_rec,
																			tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																			tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																								self.Prov_Clean_prim_range:=left.prim_range;
																								self.Prov_Clean_predir:=left.predir;
																								self.Prov_Clean_prim_name:=left.prim_name;
																								self.Prov_Clean_addr_suffix:=left.addr_suffix;
																								self.Prov_Clean_postdir:=left.postdir;
																								self.Prov_Clean_unit_desig:=left.unit_desig;
																								self.Prov_Clean_sec_range:=left.sec_range;
																								self.Prov_Clean_p_city_name:=left.p_city_name;
																								self.Prov_Clean_v_city_name:=left.v_city_name;
																								self.Prov_Clean_st:=left.st;
																								self.Prov_Clean_zip:=left.z5;
																								self.Prov_Clean_zip4:=left.zip4;
																								self.prov_Clean_geo_lat:=left.geo_lat;
																								SELF.prov_Clean_geo_long:=left.geo_long;
																								SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>'');
																								self.first_seen := left.first_seen;
																								self.last_seen := left.last_seen;
																								self := []));
			self.group_affiliation := project(resultRec.affiliates, transform(legacyLayout.ingenix_group_rec,
																								self.BDID := (string)left.bdid;
																								self.GroupName := left.name;
																								self.Address := left.address1;
																								self.City := left.p_city_name;
																								self.State := left.st;
																								self.Zip := left.z5;
																								self := []));
			self.hospital_affiliation := project(resultRec.hospitals, transform(legacyLayout.ingenix_hospital_rec,
																								self.BDID := (string)left.bdid;
																								self.HospitalName := left.name;
																								self.Address := left.address1;
																								self.City := left.p_city_name;
																								self.State := left.st;
																								self.Zip := left.z5;
																								self := []));
			self.residency := project(resultRec.Residencies,legacyLayout.ingenix_residency_rec);
			self.medschool := project(resultRec.MedSchools,legacyLayout.ingenix_medschool_rec);
			self.taxonomy := project(resultRec.Taxonomy,legacyLayout.ingenix_taxonomy_rec);
			self.sanction_data := sort(project(resultRec.Sanctions,legacyLayout.ingenix_sanc_child_rec_full),(integer)sanc_id);
			self.SSN := dedup(sort(project(resultRec.SSNLookups,legacyLayout.ingenix_ssn_rec)+project(resultRec.ssns,legacyLayout.ingenix_ssn_rec),record),record);
			self.medicareoptout := project(resultRec.optouts, transform(legacyLayout.ingenix_medicare_optout_rec,
																					self.OptOutSiteDescription:=left.optout_sitedesc;
																					self.AffidavitReceivedDate:=left.optout_rec_dt;
																					self.OptOutEffectiveDate:=left.optout_eff_dt;
																					self.OptOutTerminationDate:=left.optout_term_dt;
																					self.OptOutStatus:=left.optout_status;
																					self.LastUpdate:=left.optout_last_update;
																					self := []))(OptOutSiteDescription<>'' or OptOutTerminationDate<>'');
			self.Deceased := resultRec.DeathLookup or exists(resultRec.optouts(death_ind='Y'));
			self := resultRec;
			self := [];
		end;
	Export LegacySearch fmtLegacySearch (myLayouts.CombinedHeaderResults resultRec) := transform
		self.ProviderID:= if(resultRec.isHeaderResult,(string)resultRec.hcid,(string)resultRec.SrcID);
		self.ProviderSrc:= resultRec.Src;
		self.did:=(string)resultRec.dids[1].did;
		self.name:= project(choosen(resultRec.Names,myConst.MAX_SEARCH_RECS), 
																	transform(legacyLayout.ingenix_name_rec,
																						self.Prov_Clean_fname := left.FirstName;
																						self.Prov_Clean_mname := left.MiddleName;
																						self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																						self.Prov_Clean_name_suffix := left.Suffix;
																						self := [];));
		self.taxid := project(choosen(resultRec.taxids,myConst.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
		self.dob := project(choosen(resultRec.dobs,myConst.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
		self.license := dedup(sort(project(choosen(resultRec.StateLicenses,myConst.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_license_rec,self := left;self := [])),record),record);
		self.address := project(choosen(resultRec.Addresses,myConst.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_addr_rec_online,
																							tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																							tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																							self.Prov_Clean_prim_range:=left.prim_range;
																							self.Prov_Clean_predir:=left.predir;
																							self.Prov_Clean_prim_name:=left.prim_name;
																							self.Prov_Clean_addr_suffix:=left.addr_suffix;
																							self.Prov_Clean_postdir:=left.postdir;
																							self.Prov_Clean_unit_desig:=left.unit_desig;
																							self.Prov_Clean_sec_range:=left.sec_range;
																							self.Prov_Clean_p_city_name:=left.p_city_name;
																							self.Prov_Clean_v_city_name:=left.v_city_name;
																							self.Prov_Clean_st:=left.st;
																							self.Prov_Clean_zip:=left.z5;
																							self.Prov_Clean_zip4:=left.zip4;
																							self.first_seen := left.first_seen;
																							self.last_seen := left.last_seen;
																							SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>''); 
																							self := []));
	end;

	//Did Frequency Logic
	Export processDids(dataset(myLayouts.layout_did) ds) := Function  
		grp:=group(sort(ds,did),did);
		tmprec := record
			did:=grp.did;
			freq:=count(group);
		end;
		t:=table(grp,tmprec,did,few);
		f:=sort(project(t,myLayouts.layout_did),-freq);
		return f;
	end;
	//BDid Frequency Logic
	Export processBDids(dataset(myLayouts.layout_bdid) ds) := Function  
		grp:=group(sort(ds,bdid),bdid);
		tmprec := record
			bdid:=grp.bdid;
			freq:=count(group);
		end;
		t:=table(grp,tmprec,bdid,few);
		f:=sort(project(t,myLayouts.layout_bdid),-freq);
		return f;
	end;

	//AMS Base transforms
	Export myLayouts.CombinedHeaderResults build_ams_base(myLayouts.ams_base_with_input_plus_penalties l, UNSIGNED1 maxPenalty) := transform
		self.acctno := if(l.namePenalty>maxPenalty or (l.isExactAddressMatch and l.addrPenalty>0),skip,l.acctno);
		self.sources := dataset([{l.ams_id,myConst.SRC_AMS}],myLayouts.layout_SrcID);
		self.HCID := if(l.hid <> 0, l.hid,(integer)l.ams_id);
		self.srcID := (integer)l.ams_id;
		self.src := myConst.SRC_AMS;
		self.names := dataset([{1,l.namePenalty,l.rawdemographicsfields.acct_name,
													l.clean_name.fname,
													l.clean_name.mname,
													l.clean_name.lname,
													l.clean_name.name_suffix,
													l.clean_name.title,
													l.rawdemographicsfields.gen_cd}],myLayouts.layout_nameinfo);
		tmp_phones := l.clean_phones;
		tmp_phones_off := project(tmp_phones,transform(myLayouts.layout_phone, self.phone:=left.phone;self.phonetype:='Office Phone'));
		tmp_phones_fax := project(tmp_phones,transform(myLayouts.layout_phone, self.phone:=left.fax;self.phonetype:='Office Fax'));
		self.Addresses := dataset([{l.rawaddressfields.bob_rank,0,
													l.rawaddressfields.gold_record_flag,
													l.rawaddressfields.bob_value,
													l.rawaddressfields.addr_type,
													l.rawaddressfields.addr_status,
													l.rawaddressfields.update_date,
													l.addrPenalty,
													l.rawaddressfields.ams_street,
													'',
													l.clean_company_address.prim_range,
													l.clean_company_address.predir,
													l.clean_company_address.prim_name,
													l.clean_company_address.addr_suffix,
													l.clean_company_address.postdir,
													l.clean_company_address.unit_desig,
													l.clean_company_address.sec_range,
													l.clean_company_address.p_city_name,
													l.clean_company_address.v_city_name,
													l.clean_company_address.st,
													l.clean_company_address.zip,
													l.clean_company_address.zip4,
													l.dt_last_seen,
													l.dt_first_seen,
													l.dt_vendor_last_reported,
													l.dt_vendor_first_reported,
													l.clean_company_address.geo_lat,
													l.clean_company_address.geo_long,
													l.clean_phones.phone,
													l.clean_phones.fax,
													dataset([],myLayouts.layout_addressphone)}],myLayouts.layout_addressinfo);
		self.dobs := dataset([{l.rawdemographicsfields.dob_date}],myLayouts.layout_dob)(dob<>'');
		self.phones := project(tmp_phones_off+tmp_phones_fax,transform(myLayouts.layout_phone, skip(left.phone=''), self:=left));
		self.dids := if(l.did_score>myConst.DID_SCORE_THRESHOLD and l.did>0,dataset([{(integer)l.did}],myLayouts.layout_did));
		self.optouts := dataset([{'',
															'',
															'',
															'',
															l.opt_out_flag_desc,
															'',
															if(l.status_desc='Dead','Y','N'),
															''}],myLayouts.layout_optout)(length(trim(optout_sitedesc,all))>1);
		self.taxids := dataset([{l.rawdemographicsfields.tax_id}],myLayouts.layout_taxid)(taxid<>'');
		self:=l; 
		self:=[];
	end;
	export myLayouts.layout_addressinfo doAMSBaseRecordAddrRollup(myLayouts.layout_addressinfo l,
																										DATASET(myLayouts.layout_addressinfo) allRows) := TRANSFORM
			tmpPhones := project(allRows, TRANSFORM( myLayouts.layout_addressphone, SELF := left));
			tmpPhonesOnly := dedup(tmpPhones(faxnumber=''),all);
			tmpFaxOnly := dedup(tmpPhones(phonenumber=''),all);
			tmpPhoneFaxBoth := dedup(tmpPhones(phonenumber<>'' and faxnumber<>''),all);
			uniquePhones:=join(tmpPhoneFaxBoth,tmpPhonesOnly,left.phonenumber=right.phonenumber,right only);
			uniqueFaxes:=join(tmpPhoneFaxBoth,tmpFaxOnly,left.faxnumber=right.faxnumber,right only);
			self.phones:= (tmpPhoneFaxBoth+uniquePhones+uniqueFaxes)(trim(phonenumber,all)<>'' or trim(faxnumber,all)<>'');
			self.phonenumber := '';//Blanked out as data s now in collection
			self.faxnumber := '';//Blanked out as data s now in collection
			self.last_seen := max(allRows,last_seen);
			self.addrSeq := min(allRows,addrSeq);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows,v_first_seen) <> '', min(allRows,v_first_seen),min(allRows,v_last_seen));
			self := l;
			self := [];
	end;
	export myLayouts.CombinedHeaderResults doAMSBaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := if(l.hcid <> 0, l.hcid,l.SrcId);
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.isHeaderResult := l.isHeaderResult;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doAMSBaseRecordAddrRollup(left,rows(left))),addrseq);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( myLayouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( myLayouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( myLayouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( myLayouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( myLayouts.layout_bdid, SELF := RIGHT	)	) );
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( myLayouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
		self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids, TRANSFORM( myLayouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
		self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( myLayouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
	end;

	//ING Base transforms
	Export myLayouts.CombinedHeaderResults build_ing_base(myLayouts.ing_base_with_input_plus_penalties l, UNSIGNED1 maxPenalty) := transform		
		self.acctno := if(l.namePenalty>maxPenalty or (l.isExactAddressMatch and l.addrPenalty>maxPenalty),skip,l.acctno);
		self.sources := dataset([{l.l_providerid,myConst.SRC_ING}],myLayouts.layout_SrcID);
		self.HCID := if(l.hid <> 0, l.hid,l.l_providerid);
		self.srcID := l.l_providerid;
		self.src := myConst.SRC_ING;
		self.names := dataset([{1,l.namePenalty,'',
													l.prov_clean_fname,
													l.prov_clean_mname,
													l.prov_clean_lname,
													l.prov_clean_name_suffix,
													l.prov_clean_title,
													l.gender}],myLayouts.layout_nameinfo);
		self.Addresses := dataset([{1,0,
													'',
													'',
													l.provideraddresstypecode,
													l.ProviderAddressVerificationStatusCode,
													l.ProviderAddressVerificationDate,
													l.addrPenalty,
													l.address,
													l.address2,
													l.prov_clean_prim_range,
													l.prov_clean_predir,
													l.prov_clean_prim_name,
													l.prov_clean_addr_suffix,
													l.prov_clean_postdir,
													l.prov_clean_unit_desig,
													l.prov_clean_sec_range,
													l.prov_clean_p_city_name,
													l.prov_clean_v_city_name,
													l.prov_clean_st,
													l.prov_clean_zip,
													l.prov_clean_zip4,
													l.dt_last_seen,
													l.dt_first_seen,
													l.dt_vendor_last_reported,
													l.dt_vendor_first_reported,
													l.prov_clean_geo_lat,
													l.prov_clean_geo_long,
													if(stringlib.StringToUpperCase(l.phonetype) = 'OFFICE PHONE',l.phonenumber,''),
													if(stringlib.StringToUpperCase(l.phonetype) = 'OFFICE FAX',l.phonenumber,'')}],myLayouts.layout_addressinfo);
		self.dobs := dataset([{l.birthdate}],myLayouts.layout_dob)(dob<>'');
		self.phones := dataset([{l.phonenumber,l.phonetype}],myLayouts.layout_phone)(phone<>'');
		self.dids := if((integer)l.did_score>myConst.DID_SCORE_THRESHOLD and (integer)l.did>0,dataset([{(integer)l.did}],myLayouts.layout_did));
		self.optouts := dataset([{l.OptOutSiteDescription,
															l.AffidavitReceivedDate,
															l.OptOutEffectiveDate,
															l.DateOptOutTerminationDate,
															l.OptOutStatus,
															l.LastUpdate,
															l.DeceasedIndicator,
															l.DeceasedDate}],myLayouts.layout_optout)(length(trim(optout_sitedesc,all))>1);
		self.taxids := dataset([{l.taxid}],myLayouts.layout_taxid)(taxid<>'');
		self:=l; 
		self:=[];
	END;
	Export myLayouts.layout_addressinfo doINGBaseRecordAddrRollup(myLayouts.layout_addressinfo l,DATASET(myLayouts.layout_addressinfo) allRows) := TRANSFORM
			self.phones:= sort(dedup(project(allRows, TRANSFORM( myLayouts.layout_addressphone, SELF := left))(phonenumber<>'' or faxnumber<>''),all),if(phonenumber<>'',1,2));
			self.phonenumber := '';//Blanked out as data s now in collection
			self.faxnumber := '';//Blanked out as data s now in collection
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows,v_first_seen) <> '', min(allRows,v_first_seen),min(allRows,v_last_seen));
			self := l;
			self := [];
	end;
	Export myLayouts.CombinedHeaderResults doINGBaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := if(l.hcid <> 0, l.hcid,l.SrcId);
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.isHeaderResult := l.isHeaderResult;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		//Need to apply rules from Kathy here to get the best addresses sorted correctly.
		self.Addresses     := rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doINGBaseRecordAddrRollup(left,rows(left)));
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( myLayouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dobs          := DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( myLayouts.layout_dob, SELF := RIGHT	)	), dob, ALL );
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( myLayouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( myLayouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( myLayouts.layout_bdid, SELF := RIGHT	)	) );
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( myLayouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
		self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids, TRANSFORM( myLayouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
		self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( myLayouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
	END;

	export buildAddress (string prim_range, string predir, string prim_name, string addr_suffix, string postdir, string unit_desig, string sec_range) := function
		addr1 := prim_range;
		addr2 := trim(addr1 + ' ' +predir,right);
		addr3 := trim(addr2 + ' ' +prim_name,right);
		addr4 := trim(addr3 + ' ' +addr_suffix,right);
		addr5 := trim(addr4 + ' ' +postdir,right);
		addr6 := trim(addr5 + ' ' +unit_desig,right);
		return trim(addr6+ ' ' +sec_range,right);
	end;

	Export myLayouts.CombinedHeaderResults build_Dea_base (myLayouts.dea_base_with_input l, UNSIGNED1 maxPenalty) := transform
		//Calc Penalty
		gm:=AutoStandardI.GlobalModule();
		tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
			EXPORT lastname       := l.Name_last;       // the 'input' last name
			EXPORT middlename     := l.Name_middle;     // the 'input' middle name
			EXPORT firstname      := l.Name_first;      // the 'input' first name
			EXPORT allow_wildcard := FALSE;
			EXPORT useGlobalScope := FALSE;									
			EXPORT lname_field    := l.rawdata.fname;			// matching record name information			                          
			EXPORT mname_field    := l.rawdata.mname; 
			EXPORT fname_field    := l.rawdata.fname;	
		END;	
	
		namePenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 
		namePenalty := if(l.isHeaderResult,0,if(l.comp_name <> '' and namePenalty_indv = 0,11,namePenalty_indv));

		tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
			EXPORT predir         := l.predir;
			EXPORT prim_name      := l.prim_name;
			EXPORT prim_range     := l.prim_range;
			EXPORT postdir        := l.postdir;
			EXPORT addr_suffix    := l.addr_suffix;
			EXPORT sec_range      := l.sec_range;
			EXPORT p_city_name    := l.p_city_name;
			EXPORT st             := l.st;
			EXPORT z5             := l.z5;											
			//	The address in the matching record:						
			EXPORT allow_wildcard  := FALSE;															
			EXPORT city_field      := l.rawdata.p_city_name;
			EXPORT city2_field     := '';										
			EXPORT pname_field     := l.rawdata.prim_name;									
			EXPORT prange_field    := l.rawdata.prim_range;										
			EXPORT postdir_field   := l.rawdata.postdir;																				
			EXPORT predir_field    := l.rawdata.predir;									
			EXPORT state_field     := l.rawdata.st;										
			EXPORT suffix_field    := l.rawdata.addr_suffix;										
			EXPORT zip_field       := l.rawdata.zip;											
			EXPORT sec_range_field := l.rawdata.sec_range;
			EXPORT useGlobalScope  := FALSE;
		end;
			
		addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
			
		self.acctno := if(namePenalty>maxPenalty or (l.isExactAddressMatch and addrPenalty>maxPenalty),skip,l.acctno);
		self.sources := dataset([{l.rawdata.dea_registration_number,myConst.SRC_DEA}],myLayouts.layout_SrcID);
		self.HCID := if(l.hid <> 0, l.hid,l.l_providerid);
		self.srcID := l.l_providerid;
		self.src := myConst.SRC_DEA;

		self.names := dataset([{1,namePenalty,'',
													l.rawdata.fname,
													l.rawdata.mname,
													l.rawdata.lname,
													l.rawdata.name_suffix,
													l.rawdata.title,
													''}],myLayouts.layout_nameinfo);
		self.Addresses := dataset([{1,0,
													'',
													'',
													'',
													'',
													'',
													addrPenalty,
													buildAddress(l.rawdata.prim_range,l.rawdata.predir,l.rawdata.prim_name,l.rawdata.addr_suffix,l.rawdata.postdir,l.rawdata.unit_desig,l.rawdata.sec_range),
													'',
													l.rawdata.prim_range,
													l.rawdata.predir,
													l.rawdata.prim_name,
													l.rawdata.addr_suffix,
													l.rawdata.postdir,
													l.rawdata.unit_desig,
													l.rawdata.sec_range,
													l.rawdata.p_city_name,
													l.rawdata.v_city_name,
													l.rawdata.st,
													l.rawdata.zip,
													l.rawdata.zip4,
													'',
													'',
													l.rawdata.date_last_reported,
													l.rawdata.date_first_reported,
													l.rawdata.geo_lat,
													l.rawdata.geo_long,
													'',
													''}],myLayouts.layout_addressinfo);

		self.dids := dataset([{(integer)l.rawdata.did}],myLayouts.layout_did)(did>0);
		self.bdids := dataset([{(integer)l.rawdata.bdid}],myLayouts.layout_bdid)(bdid>0);
		self.ssns := dataset([{l.rawdata.best_ssn}],myLayouts.layout_ssn)(ssn<>'');
		self.deas := dataset([{l.acctno,(string)l.rawdata.dea_registration_number,(string)l.rawdata.dea_registration_number,l.rawdata.expiration_date}],myLayouts.layout_dea)(dea<>'');
		self:=l; 
		self:=[];
	END;

	export myLayouts.layout_addressinfo doDEABaseRecordAddrRollup(myLayouts.layout_addressinfo l,
																										DATASET(myLayouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export myLayouts.CombinedHeaderResults doDEABaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := l.hcid;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( myLayouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dids          := processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( myLayouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( myLayouts.layout_bdid, SELF := RIGHT	)	) );
		self.deas	         := DEDUP(sort(NORMALIZE( allRows, LEFT.deas, TRANSFORM( myLayouts.layout_dea, SELF := RIGHT	)	), dea,-expiration_date),dea,expiration_date);
	end;

	Export myLayouts.CombinedHeaderResults build_npi_base (myLayouts.npi_base_with_input l, UNSIGNED1 maxPenalty) := transform
		//Calc Penalty
		gm:=AutoStandardI.GlobalModule();
		tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
			EXPORT lastname       := l.Name_last;       // the 'input' last name
			EXPORT middlename     := l.Name_middle;     // the 'input' middle name
			EXPORT firstname      := l.Name_first;      // the 'input' first name
			EXPORT allow_wildcard := FALSE;
			EXPORT useGlobalScope := FALSE;									
			EXPORT lname_field    := l.clean_name_provider.lname;			// matching record name information			                          
			EXPORT mname_field    := l.clean_name_provider.mname; 
			EXPORT fname_field    := l.clean_name_provider.fname;	
		END;	
	
		namePenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 
		namePenalty := if(l.isHeaderResult,0,if(l.comp_name <> '' and namePenalty_indv = 0,2,namePenalty_indv));

		tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
			EXPORT predir         := l.predir;
			EXPORT prim_name      := l.prim_name;
			EXPORT prim_range     := l.prim_range;
			EXPORT postdir        := l.postdir;
			EXPORT addr_suffix    := l.addr_suffix;
			EXPORT sec_range      := l.sec_range;
			EXPORT p_city_name    := l.p_city_name;
			EXPORT st             := l.st;
			EXPORT z5             := l.z5;											
			//	The address in the matching record:						
			EXPORT allow_wildcard  := FALSE;															
			EXPORT city_field      := l.clean_location_address.p_city_name;
			EXPORT city2_field     := '';										
			EXPORT pname_field     := l.clean_location_address.prim_name;									
			EXPORT prange_field    := l.clean_location_address.prim_range;										
			EXPORT postdir_field   := l.clean_location_address.postdir;																				
			EXPORT predir_field    := l.clean_location_address.predir;									
			EXPORT state_field     := l.clean_location_address.st;										
			EXPORT suffix_field    := l.clean_location_address.addr_suffix;										
			EXPORT zip_field       := l.clean_location_address.zip;											
			EXPORT sec_range_field := l.clean_location_address.sec_range;
			EXPORT useGlobalScope  := FALSE;
		end;
		tempaddrmod2 := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
			EXPORT predir         := l.predir;
			EXPORT prim_name      := l.prim_name;
			EXPORT prim_range     := l.prim_range;
			EXPORT postdir        := l.postdir;
			EXPORT addr_suffix    := l.addr_suffix;
			EXPORT sec_range      := l.sec_range;
			EXPORT p_city_name    := l.p_city_name;
			EXPORT st             := l.st;
			EXPORT z5             := l.z5;											
			//	The address in the matching record:						
			EXPORT allow_wildcard  := FALSE;															
			EXPORT city_field      := l.clean_mailing_address.p_city_name;
			EXPORT city2_field     := '';										
			EXPORT pname_field     := l.clean_mailing_address.prim_name;									
			EXPORT prange_field    := l.clean_mailing_address.prim_range;										
			EXPORT postdir_field   := l.clean_mailing_address.postdir;																				
			EXPORT predir_field    := l.clean_mailing_address.predir;									
			EXPORT state_field     := l.clean_mailing_address.st;										
			EXPORT suffix_field    := l.clean_mailing_address.addr_suffix;										
			EXPORT zip_field       := l.clean_mailing_address.zip;											
			EXPORT sec_range_field := l.clean_mailing_address.sec_range;
			EXPORT useGlobalScope  := FALSE;
		end;
			
		addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
		addrPenalty2:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod2);
			
		self.acctno := if(namePenalty>maxPenalty or (l.isExactAddressMatch and addrPenalty>maxPenalty),skip,l.acctno);
		self.sources := dataset([{l.npi,myConst.SRC_NPPES}],myLayouts.layout_SrcID);
		self.HCID := if(l.hid <> 0, l.hid,l.l_providerid);
		self.srcID := l.l_providerid;
		self.src := myConst.SRC_NPPES;
		self.names := dataset([{1,namePenalty,l.provider_organization_name,
													l.clean_name_provider.fname,
													l.clean_name_provider.mname,
													l.clean_name_provider.lname,
													l.clean_name_provider.name_suffix,
													l.clean_name_provider.title,
													''}],myLayouts.layout_nameinfo);
		self.Addresses := dataset([{1,0,
													'',
													'',
													'P',
													'',
													'',
													addrPenalty,
													l.location_prep_address1,
													'',
													l.clean_location_address.prim_range,
													l.clean_location_address.predir,
													l.clean_location_address.prim_name,
													l.clean_location_address.addr_suffix,
													l.clean_location_address.postdir,
													l.clean_location_address.unit_desig,
													l.clean_location_address.sec_range,
													l.clean_location_address.p_city_name,
													l.clean_location_address.v_city_name,
													l.clean_location_address.st,
													l.clean_location_address.zip,
													l.clean_location_address.zip4,
													l.dt_last_seen,
													l.dt_first_seen,
													l.dt_vendor_last_reported,
													l.dt_vendor_first_reported,
													l.clean_location_address.geo_lat,
													l.clean_location_address.geo_long,
													l.provider_business_practice_location_address_telephone_number,
													l.provider_business_practice_location_address_fax_number},
													{2,0,
													'',
													'',
													'B',
													'',
													'',
													addrPenalty2,
													l.mailing_prep_address1,
													'',
													l.clean_mailing_address.prim_range,
													l.clean_mailing_address.predir,
													l.clean_mailing_address.prim_name,
													l.clean_mailing_address.addr_suffix,
													l.clean_mailing_address.postdir,
													l.clean_mailing_address.unit_desig,
													l.clean_mailing_address.sec_range,
													l.clean_mailing_address.p_city_name,
													l.clean_mailing_address.v_city_name,
													l.clean_mailing_address.st,
													l.clean_mailing_address.zip,
													l.clean_mailing_address.zip4,
													l.dt_last_seen,
													l.dt_first_seen,
													l.dt_vendor_last_reported,
													l.dt_vendor_first_reported,
													l.clean_mailing_address.geo_lat,
													l.clean_mailing_address.geo_long,
													l.provider_business_mailing_address_telephone_number,
													l.provider_business_mailing_address_fax_number}],myLayouts.layout_addressinfo);
		self.dids := dataset([{(integer)l.did}],myLayouts.layout_did)(did>0);
		self.bdids := dataset([{(integer)l.bdid}],myLayouts.layout_bdid)(bdid>0);
		self.npis := dataset([{l.acctno,(string)l.npi,(string)l.npi}],myLayouts.layout_npi)(npi<>'');
		self:=l; 
		self:=[];
	END;
	export myLayouts.layout_addressinfo doNPIBaseRecordAddrRollup(myLayouts.layout_addressinfo l,
																										DATASET(myLayouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows,v_first_seen) <> '', min(allRows,v_first_seen),min(allRows,v_last_seen));
			self := l;
			self := [];
	end;
	export myLayouts.CombinedHeaderResults doNPIBaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := l.hcid;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doNPIBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.dids          := processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( myLayouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( myLayouts.layout_bdid, SELF := RIGHT	)	) );
		self.npis	         := DEDUP( NORMALIZE( allRows, LEFT.npis, TRANSFORM( myLayouts.layout_npi, SELF := RIGHT	)	), npi, All);
	end;

	Export myLayouts.CombinedHeaderResults build_ProfLic_base (myLayouts.proflic_base_with_input l, UNSIGNED1 maxPenalty) := transform
		//Calc Penalty
		gm:=AutoStandardI.GlobalModule();
		tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
			EXPORT lastname       := l.Name_last;       // the 'input' last name
			EXPORT middlename     := l.Name_middle;     // the 'input' middle name
			EXPORT firstname      := l.Name_first;      // the 'input' first name
			EXPORT allow_wildcard := FALSE;
			EXPORT useGlobalScope := FALSE;									
			EXPORT lname_field    := l.rawdata.fname;			// matching record name information			                          
			EXPORT mname_field    := l.rawdata.mname; 
			EXPORT fname_field    := l.rawdata.fname;	
		END;	
	
		namePenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 
		namePenalty := if(l.isHeaderResult,0,if(l.comp_name <> '' and namePenalty_indv = 0,11,namePenalty_indv));

		tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
			EXPORT predir         := l.predir;
			EXPORT prim_name      := l.prim_name;
			EXPORT prim_range     := l.prim_range;
			EXPORT postdir        := l.postdir;
			EXPORT addr_suffix    := l.addr_suffix;
			EXPORT sec_range      := l.sec_range;
			EXPORT p_city_name    := l.p_city_name;
			EXPORT st             := l.st;
			EXPORT z5             := l.z5;											
			//	The address in the matching record:						
			EXPORT allow_wildcard  := FALSE;															
			EXPORT city_field      := l.rawdata.p_city_name;
			EXPORT city2_field     := '';										
			EXPORT pname_field     := l.rawdata.prim_name;									
			EXPORT prange_field    := l.rawdata.prim_range;										
			EXPORT postdir_field   := l.rawdata.postdir;																				
			EXPORT predir_field    := l.rawdata.predir;									
			EXPORT state_field     := l.rawdata.st;										
			EXPORT suffix_field    := l.rawdata.suffix;										
			EXPORT zip_field       := l.rawdata.zip;											
			EXPORT sec_range_field := l.rawdata.sec_range;
			EXPORT useGlobalScope  := FALSE;
		end;
			
		addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);

		self.acctno := if(namePenalty>maxPenalty or (l.isExactAddressMatch and addrPenalty>maxPenalty),skip,l.acctno);
		self.sources := dataset([{l.rawdata.prolic_key,myConst.SRC_PROFLIC}],myLayouts.layout_SrcID);
		self.HCID := if(l.hid <> 0, l.hid,l.l_providerid);
		self.srcID := l.l_providerid;//DO NOT USE as it requires a number
		self.src := myConst.SRC_PROFLIC;

		self.names := dataset([{1,namePenalty,l.rawdata.company_name,
													l.rawdata.fname,
													l.rawdata.mname,
													l.rawdata.lname,
													l.rawdata.name_suffix,
													l.rawdata.title,
													''}],myLayouts.layout_nameinfo);
		self.Addresses := dataset([{1,0,
													'',
													'',
													'P',
													'',
													'',
													addrPenalty,
													if(l.rawdata.orig_addr_1<>'',l.rawdata.orig_addr_1,buildAddress(l.rawdata.prim_range,l.rawdata.predir,l.rawdata.prim_name,l.rawdata.suffix,l.rawdata.postdir,l.rawdata.unit_desig,l.rawdata.sec_range)),
													'',
													l.rawdata.prim_range,
													l.rawdata.predir,
													l.rawdata.prim_name,
													l.rawdata.suffix,
													l.rawdata.postdir,
													l.rawdata.unit_desig,
													l.rawdata.sec_range,
													l.rawdata.p_city_name,
													l.rawdata.v_city_name,
													l.rawdata.st,
													l.rawdata.zip,
													l.rawdata.zip4,
													l.rawdata.date_last_seen,
													l.rawdata.date_first_seen,
													'',
													'',
													l.rawdata.geo_lat,
													l.rawdata.geo_long,
													'',
													''}],myLayouts.layout_addressinfo);
		self.dids := dataset([{(integer)l.rawdata.did}],myLayouts.layout_did)(did>0);
		self.bdids := dataset([{(integer)l.rawdata.bdid}],myLayouts.layout_bdid)(bdid>0);
		self:=l; 
		self:=[];
	END;

	export myLayouts.layout_addressinfo doProfLicBaseRecordAddrRollup(myLayouts.layout_addressinfo l,
																										DATASET(myLayouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.first_seen := if(min(allRows,first_seen) <> '', min(allRows,first_seen),min(allRows,last_seen));
			self := l;
			self := [];
	end;
	export myLayouts.CombinedHeaderResults doProfLicBaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := l.hcid;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doProfLicBaseRecordAddrRollup(left,rows(left))),-last_seen,addrseq);
		self.dids          := processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( myLayouts.layout_did, SELF := RIGHT	)	) );
		self.bdids         := processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( myLayouts.layout_bdid, SELF := RIGHT	)	) );
	end;

	Export myLayouts.CombinedHeaderResults build_BocaHdr_base (myLayouts.bocahdr_base_with_input l, UNSIGNED1 maxPenalty) := transform
		//Calc Penalty
		gm:=AutoStandardI.GlobalModule();
		tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
			EXPORT lastname       := l.Name_last;       // the 'input' last name
			EXPORT middlename     := l.Name_middle;     // the 'input' middle name
			EXPORT firstname      := l.Name_first;      // the 'input' first name
			EXPORT allow_wildcard := FALSE;
			EXPORT useGlobalScope := FALSE;									
			EXPORT lname_field    := l.rawdata.lname;			// matching record name information			                          
			EXPORT mname_field    := l.rawdata.mname; 
			EXPORT fname_field    := l.rawdata.fname;	
		END;	
	
		namePenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 
		namePenalty := if(l.comp_name <> '' and namePenalty_indv = 0,11,namePenalty_indv);

		tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
			EXPORT predir         := l.predir;
			EXPORT prim_name      := l.prim_name;
			EXPORT prim_range     := l.prim_range;
			EXPORT postdir        := l.postdir;
			EXPORT addr_suffix    := l.addr_suffix;
			EXPORT sec_range      := l.sec_range;
			EXPORT p_city_name    := l.p_city_name;
			EXPORT st             := l.st;
			EXPORT z5             := l.z5;											
			//	The address in the matching record:						
			EXPORT allow_wildcard  := FALSE;															
			EXPORT city_field      := l.rawdata.city_name;
			EXPORT city2_field     := '';										
			EXPORT pname_field     := l.rawdata.prim_name;									
			EXPORT prange_field    := l.rawdata.prim_range;										
			EXPORT postdir_field   := l.rawdata.postdir;																				
			EXPORT predir_field    := l.rawdata.predir;									
			EXPORT state_field     := l.rawdata.st;										
			EXPORT suffix_field    := l.rawdata.suffix;										
			EXPORT zip_field       := l.rawdata.zip;											
			EXPORT sec_range_field := l.rawdata.sec_range;
			EXPORT useGlobalScope  := FALSE;
		end;
			
		addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);

		self.acctno := if(namePenalty>maxPenalty or (l.isExactAddressMatch and addrPenalty>maxPenalty),skip,l.acctno);
		self.sources := dataset([{l.rawdata.did,myConst.SRC_BOCA_PERSON_HEADER}],myLayouts.layout_SrcID);
		self.HCID := if(l.hid <> 0, l.hid,l.l_providerid);
		self.srcID := l.l_providerid;//DO NOT USE as it requires a number
		self.src := myConst.SRC_BOCA_PERSON_HEADER;

		self.names := dataset([{1,namePenalty,'',
													l.rawdata.fname,
													l.rawdata.mname,
													l.rawdata.lname,
													l.rawdata.name_suffix,
													l.rawdata.title,
													''}],myLayouts.layout_nameinfo);
		self.Addresses := dataset([{1,0,
													'',
													'',
													'',
													'',
													'',
													addrPenalty,
													buildAddress(l.rawdata.prim_range,l.rawdata.predir,l.rawdata.prim_name,l.rawdata.suffix,l.rawdata.postdir,l.rawdata.unit_desig,l.rawdata.sec_range),
													'',
													l.rawdata.prim_range,
													l.rawdata.predir,
													l.rawdata.prim_name,
													l.rawdata.suffix,
													l.rawdata.postdir,
													l.rawdata.unit_desig,
													l.rawdata.sec_range,
													l.rawdata.city_name,
													l.rawdata.city_name,
													l.rawdata.st,
													l.rawdata.zip,
													l.rawdata.zip4,
													l.rawdata.dt_last_seen,
													l.rawdata.dt_first_seen,
													l.rawdata.dt_vendor_last_reported,
													l.rawdata.dt_vendor_first_reported,
													'',
													'',
													l.rawdata.phone,
													''}],myLayouts.layout_addressinfo);
		self.dids := dataset([{(integer)l.rawdata.did}],myLayouts.layout_did)(did>0);
		self.ssns := if(l.rawdata.valid_ssn ='G',dataset([{l.rawdata.ssn}],Healthcare_Provider_Services.Layouts.layout_ssn)(ssn<>''));
		string8 tmpDob := (string)l.rawdata.dob;
		self.dobs := if(tmpDob <> '0' and tmpDob[5..8]<>'0000',dataset([{tmpDob}],Healthcare_Provider_Services.Layouts.layout_dob));
		self:=l; 
		self:=[];
	END;

	export DidVille.Layout_Did_OutBatch convertToDidvilleBatch(myLayouts.autokeyInput inRec, boolean ssnonly=false):= TRANSFORM
		self.seq := (integer)inRec.acctno;
		self.ssn := inRec.ssn;
		self.dob := if(ssnonly,'',inRec.dob);
		self.phone10 := if(ssnonly,'',inRec.homephone);
		self.fname := if(ssnonly,'',inRec.name_first);
		self.mname := if(ssnonly,'',inRec.name_middle);
		self.lname := if(ssnonly,'',inRec.name_last);
		self.prim_range := if(ssnonly,'',inRec.prim_range);
		self.predir := if(ssnonly,'',inRec.predir);
		self.prim_name := if(ssnonly,'',inRec.prim_name);
		self.addr_suffix := if(ssnonly,'',inRec.addr_suffix);
		self.postdir := if(ssnonly,'',inRec.postdir);
		self.unit_desig := if(ssnonly,'',inRec.unit_desig);
		self.sec_range := if(ssnonly,'',inRec.sec_range);
		self.p_city_name := if(ssnonly,'',inRec.p_city_name);
		self.st := if(ssnonly,'',inRec.st);
		self.z5 := if(ssnonly,'',inRec.z5);
		self:=[];  
	end;
	export myLayouts.CombinedHeaderResults doBocaHeaderBaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := l.hcid;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( myLayouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL );
		self.dids          := processDids( NORMALIZE( allRows, LEFT.dids, TRANSFORM( myLayouts.layout_did, SELF := RIGHT	)	) );
		self.dobs	         := DEDUP(sort(NORMALIZE( allRows, LEFT.dobs, TRANSFORM( myLayouts.layout_dob, SELF := RIGHT	)	),-dob),dob);
	end;

	export myLayouts.CombinedHeaderResults doBocaBusHeaderBaseRecordSrcIdRollup(myLayouts.CombinedHeaderResults l, 
																									DATASET(myLayouts.CombinedHeaderResults) allRows) := TRANSFORM
		SELF.acctno := l.acctno;
		self.HCID := l.hcid;
		self.SrcId := l.SrcId;
		self.Src := l.Src;
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( myLayouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := DEDUP( NORMALIZE( allRows, LEFT.Names, TRANSFORM( myLayouts.layout_nameinfo, SELF := RIGHT	)	), RECORD, ALL );
		self.Addresses     := sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																											TRANSFORM( myLayouts.layout_addressinfo, SELF := RIGHT	)),
																						prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),
																			 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doDEABaseRecordAddrRollup(left,rows(left))),addrseq);
		self.bdids         := processBDids( NORMALIZE( allRows, LEFT.bdids, TRANSFORM( myLayouts.layout_bdid, SELF := RIGHT	)	) );
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( myLayouts.layout_fein, SELF := RIGHT	)	), fein, all);
	end;

	export Business_Header_SS.Layout_BDID_InBatch convertToBusinessLookup(myLayouts.autokeyInput inRecs):= TRANSFORM
				self.seq := (integer)inRecs.acctno;
				self.company_name:= inRecs.comp_name;
				self.prim_range:= inRecs.prim_range;
				self.predir:= inRecs.predir;
				self.prim_name:= inRecs.prim_name;
				self.addr_suffix:= inRecs.addr_suffix;
				self.postdir:= inRecs.postdir;
				self.unit_desig:= inRecs.unit_desig;
				self.sec_range:= inRecs.sec_range;
				self.p_city_name:= inRecs.p_city_name;
				self.st:= inRecs.st;
				self.z5:= inRecs.z5;
				self.zip4:= inRecs.zip4;
				self.phone10:= if(inRecs.homephone <> '',inRecs.homephone,inRecs.workphone);
				self.fein:= inRecs.FEIN;
				self := [];
	end;

	export BatchServices.RollupBusiness_BatchService_Layouts.Input convertToBusinessRollup(myLayouts.searchKeyResults_plus_input inRecs):= TRANSFORM
				self.acctno := inRecs.acctno;
				self.comp_name:= inRecs.comp_name;
				self.prim_range:= inRecs.prim_range;
				self.predir:= inRecs.predir;
				self.prim_name:= inRecs.prim_name;
				self.addr_suffix:= inRecs.addr_suffix;
				self.postdir:= inRecs.postdir;
				self.unit_desig:= inRecs.unit_desig;
				self.sec_range:= inRecs.sec_range;
				self.p_city_name:= inRecs.p_city_name;
				self.st:= inRecs.st;
				self.z5:= inRecs.z5;
				self.zip4:= '';//Not currently supported
				self.mileradius:= '';//Not currently supported
				self.workphone:= '';//Not currently supported
				self.fein:= '';//Not currently supported
				self.bdid:= (qstring)inRecs.prov_id;//This is the value obtained from Business_Header_SS.MAC_BDID_Append
				self.max_results:= (qstring)myConst.MAX_BUSINESSROLLUP_RECS;
				self := [];
	end;
end;