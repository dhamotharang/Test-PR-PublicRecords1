/***
 ** Module to filter/transform Header records into desired format for Relatives and Associates
***/

import doxie, doxie_crs, iesp, ut, DeathV2_Services, Risk_Indicators, Address, header, DidVille, AutoStandardI;

//Relatives and associates for IDM services.
int_rec := iesp.identitymanagementreport.t_IdmReportRNASlim;
export RARecords (IdentityManagement_Services.IParam._report in_params, dataset (doxie.layout_references) dids) :=	MODULE

  // Get values missing from the input from global.
  // Can't project from {input} because of different type of ssn_mask (string vs. string6);
  gmod := AutoStandardI.GlobalModule ();
  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (gmod))
    EXPORT unsigned1 glb := in_params.glbpurpose;
    EXPORT unsigned1 dppa := in_params.dppapurpose;
    EXPORT string DataPermissionMask := in_params.DataPermissionMask;
    EXPORT string DataRestrictionMask := in_params.DataRestrictionMask;
    EXPORT boolean ln_branded := in_params.ln_branded;
    EXPORT string5 industry_class := in_params.industryclass;
    EXPORT string32 application_type := in_params.applicationtype;
    EXPORT unsigned3 date_threshold := in_params.dateVal;
    EXPORT string ssn_mask := in_params.ssn_mask;
  END;

		//Doxie files used are - doxie.relative_summary & doxie.Comp_Addresses
		layout_comp_names := record
			doxie_crs.layout_comp_names; // [did; fname; mname; lname; ssn; ssn_unmasked; dob; age;]
			string6 title;
		END;
		
		identity_exp_slim := record
			unsigned6 did;
			string1 Deceased;
			string DeathVerificationCode;
			iesp.identitymanagementreport.t_IdmIdentity; // [UniqueID, Name, DOB, Age]
		END;
		
		rel_exp := record (int_rec)
			boolean is_relative;
			string12 UniqueId;
		END;
		
		rel_exp_slim := record (int_rec)
			boolean is_relative;
		END;

		slim_addr_rec := record 
			iesp.identitymanagementreport.t_IdmReportAddressSlim;
			unsigned6 did;  // this is for linking...
			string5 county; // need these to get census, if required - county "number"
			string7	geo_blk;
		end;
		
		record_addr_did_slim := record
			unsigned6 did;
			dataset (iesp.identitymanagementreport.t_IdmReportAddressSlim) addresses {maxcount(iesp.Constants.IDM.MaxRNA_Address)};
		END;
		
		record_aka_did_slim := record
			unsigned6 did;
			dataset(iesp.share.t_Name) AKAs {xpath('AKAs/Name'), MAXCOUNT(iesp.Constants.IDM.MaxAKAs)};
		end;
		
		//Get best records for relatives:
		relative_src := doxie.relative_summary;
		rel_dids := dedup (sort(project(ungroup(relative_src),transform (doxie.layout_references, 
																				      Self.did := Left.person2)),did),did);
		
		// Format AKAs
		iesp.share.t_Name FormatThisPersonAKA (relative_src L) := TRANSFORM
			string full_name 	:= StringLib.StringCleanSpaces (L.fname + ' ' + L.mname + ' ' + L.lname);
			self.Full    		 	:= full_name;
			Self.First 				:= L.fname;
			Self.Middle 			:= L.mname;
			Self.Last 				:= L.lname;
			self 							:= [];
		END;

		record_aka_did_slim SetAKAName (relative_src L) := transform
			self.did := L.person2;
			self.akas := project (l, FormatThisPersonAKA (Left));
		end;
		
		// sort and group by DID
		grp_aka_ready := project(group(dedup(sort (relative_src, person2, lname, fname, mname), person2, lname, fname, mname), person2), SetAKAName (left));

		record_aka_did_slim RollAKAName (record_aka_did_slim L, dataset (record_aka_did_slim) R):=transform
			self.AKAs := choosen (R.AKAs, iesp.Constants.IDM.MaxAKAs);
			self.did := L.did;
		END;
		
		// roll up aka names that belong to same DID
		akas_name_ready := rollup (grp_aka_ready, group, RollAKAName (Left, rows (Left)));
		
		// best_akas := doxie.best_records (rel_dids, , in_params.DPPAPurpose, in_params.GLBPurpose, true, , , , true,header.constants.checkRNA);
    best_akas := doxie.best_records (rel_dids, , , , true, header.constants.checkRNA, modAccess := mod_access);

		unsigned1 GetAge (integer4 dob) := IF (dob<>0, ut.GetAge((string8) dob),0); //Quick function to get age
		
		// defenestrate relative if ssn matches subject ssn, or the name is not complete
		// whilst projecting best aliases into proper layout and calculate age
				// Get a set of SSNs associated with Subject as person might have more than one SSN
		subject_ssn_ds:= JOIN(dids, DidVille.key_did_ssn, keyed(left.did = right.did),
													limit(0), keep(IdentityManagement_Services.Constants.MaxSSNperDID));
		subject_ssn_set := set(subject_ssn_ds, ssn);

		aka_src := project (best_akas(~(ssn_unmasked IN subject_ssn_set)  // toss for matching SSN
		                              OR fname = '' OR lname = ''         // toss for partial name
		                              ), transform (layout_comp_names,  
																							 Self.age := GetAge (Left.dob);
																							 Self:=Left));
		
		identity_exp_slim ToIdentity(layout_comp_names L):=transform
			Self.did := L.did;
			Self.UniqueID := (String)L.did;
			Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, '');
			Self.DOB := iesp.ECL2ESP.toDate (L.dob);
			Self.Age := L.age;
			Self.ssn := L.ssn;
			Self.gender := iesp.ECL2ESP.GetGender (L.title);
			Self := []; // clear a couple of fields
		END;
		
		aka := project(aka_src, ToIdentity(left));

		//Mark dead people
		identity_exp_slim GetDead (identity_exp_slim L, recordof(doxie.key_death_masterV2_ssa_DID) R):=transform
				// there can be different DOB in key_death_masterV2_DID and source dataset (for example: DID=002644313020),
				// thus it is safer to take DOB from the left side
				left_dob := (string4) L.DOB.year + intformat (L.DOB.month, 2, 1) + intformat (L.DOB.day, 2, 1);
				Self.DeathVerificationCode := r.vorp_code; //death_code in header index
				self.Deceased := if ( r.l_did != 0 , 'Y','N');
				self.Age := if( r.l_did != 0,ut.GetAgeI_asOf((unsigned8)left_dob, (unsigned8)R.dod8), L.Age); //if dead, get age at death
				Self := L; // copy about 25 fields
		END;

		rna_glb_ok := mod_access.isValidGLB(header.constants.checkRNA);
		death_params := DeathV2_Services.IParam.GetDeathRestrictions(gmod);

		rel_w_d_pre := JOIN (aka, doxie.key_death_masterV2_ssa_DID, 
                            keyed (Left.did = Right.l_did)
														and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, rna_glb_ok, death_params),
                            GetDead (Left, Right),
                            left outer, 
														limit (0), keep (1));
												
		issuance_w_d_info := dedup (sort (rel_w_d_pre, did, record, if (DeathVerificationCode<>'',0,1)),
                                   did, record, except DeathVerificationCode);

		// fetch relatives and associates (dedup by DID, 1st degree relatives goes atop)
		// Exclude Associates with Too Small a Cohabit Score (but that's not considered for relatives)
		_rel_assoc := choosen (dedup (sort (relative_src(relative OR number_cohabits >= IdentityManagement_Services.Constants.MinAssociateCohabits 
		                                               ), person2, depth, ~relative), person2), iesp.Constants.IDM.MaxRNA);

		rel_depth := min(max(in_params.relative_depth, 1), 3);
		rel_assoc := _rel_assoc (~relative OR depth <= rel_depth); // Exclude Relatives using relative depth(but not considered for associates)
		
		// get relatives info
		iesp.share.t_RiskIndicator SetAddressRiskIndicators (Risk_Indicators.Layout_Desc L) := transform
			Self.RiskCode := L.hri;
			Self.Description := L.desc;
		end;

		rel_exp GetRelativesInfo (doxie_crs.layout_relative_summary L, identity_exp_slim R) := transform
			self.UniqueId := (String)R.did;
			Self.is_relative := L.relative;
			self.Confidence := L.number_cohabits;
			Self.Identity := R; 
			self.Deceased := R.deceased;
			           // filter Person if dead, near-dead or un-dead
			self.filtered := ((R.deceased = 'Y') OR (R.Age > IdentityManagement_Services.Constants.MaxAgeNearDeath));
			Self :=[]; //addresses and addres_seq_no blank
		END;

		// join with death info
		akas_w_death := join (rel_assoc, issuance_w_d_info, 
                          (unsigned6) Left.person2 = Right.did,  
                          GetRelativesInfo (Left, Right), 
													limit(0), keep(1));  //Match 1:1
		
		with_akas := join(akas_w_death, akas_name_ready,
			(unsigned)left.UniqueId = right.did
			and left.is_relative, //so far we only want to return AKAs for Relatives
			transform(rel_exp,
				self.Identity.AKAs := right.AKAs,
				self := left),
			limit(0), keep(1),
			left outer);
			
		//Get addresses for relatives
		slim_addr_rec ProjAddr (doxie.Layout_Comp_Addresses L) := transform
			Self.did := L.did;
			Self.county := L.county;
			Self.geo_blk := L.geo_blk;
			ri := project (L.hri_address, SetAddressRiskIndicators (Left));
			Self.Address := iesp.ECL2ESP.SetAddressEx (
				L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, L.sec_range, 
				L.city_name, L.st, L.zip, L.zip4, L.county_name, '',
				Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range),
				'',
				Address.Addr2FromComponents(l.city_name, l.st, l.zip), HRIs := ri);
			Self.DateLastSeen  := iesp.ECL2ESP.toDate ((unsigned4) (L.dt_last_seen + '00'));
			Self.DateFirstSeen := iesp.ECL2ESP.toDate ((unsigned4) (L.dt_first_seen + '00'));
			Self._Shared := (L.shared_address='S');
			// filter Address if not shared with subject, or if first and last in same month
			Self.filtered := stringlib.stringtouppercase(L.shared_address) <> 'S' OR L.dt_first_seen = L.dt_last_seen;
		end;
		
		// defenestrate any "PO BOX" before deduping into the "ready" address
		addr_ready := dedup(project(doxie.Comp_Addresses(stringlib.stringtouppercase(prim_name[1..6]) <> 'PO BOX'),
                              ProjAddr (Left)), record); 

		// Format rel/assoc addresses
		iesp.identitymanagementreport.t_IdmReportAddressSlim FormatThisPersonAddressSlim (slim_addr_rec L) := TRANSFORM
			Self.Address := L.Address;
			Self.DateLastSeen := L.DateLastSeen;
			Self.DateFirstSeen := L.DateFirstSeen;
			Self._Shared := L._Shared;
			Self.Filtered := False; // innocent until proven guilty
		END;

		record_addr_did_slim SetAddressSlim (slim_addr_rec L) := transform
			self.did := L.did;
			self.addresses := project (l, FormatThisPersonAddressSlim (Left));
		end;
		
		// sort and group by DID
		grp_addr_ready := project(group(sort (addr_ready, did), did), SetAddressSlim (left));

		record_addr_did_slim RollAddressSlim (record_addr_did_slim L, dataset (record_addr_did_slim) R):=transform
			self.addresses := choosen (R.Addresses, iesp.Constants.IDM.MaxRNA_Address);
			self.did := L.did;
		END;
		
		// roll up addresses that belong to same DID
		roll_addrs_ready := rollup (grp_addr_ready, group, RollAddressSlim (Left, rows (Left)));

		rel_exp_slim GetFullRelativesSlim (rel_exp L, record_addr_did_slim R):=transform
			self.addresses := sort (choosen (R.Addresses, iesp.Constants.IDM.MaxRNA_Address), -DateLastSeen);
			// filter relatives who have never shared an address with subject
			self.filtered := L.filtered OR (L.is_relative AND (COUNT(R.Addresses(_Shared)) <= 0));
			self := L; // copy about 30 fields
		END;

		//Combine relatives and associates with their respective addresses
		shared all_recs := JOIN (with_akas, roll_addrs_ready,
												 (Integer6) left.uniqueid = right.did,
												 GetFullRelativesSlim (left,right),left outer, 
												 limit(0), keep(1)); //Match 1:1
		
		// Extract relatives that are not dead (known as "living", or sometimes "zombies")
		EXPORT relatives := choosen(PROJECT (all_recs (is_relative), int_rec),iesp.Constants.IDM.MaxRelatives);
		
		// remove relatives from the "all_recs", leaving associates
		assocs_wo_flag := PROJECT (all_recs (~is_relative), int_rec);
		
		EXPORT associates := choosen(PROJECT(assocs_wo_flag, int_rec),iesp.Constants.IDM.MaxAssociates);

END;