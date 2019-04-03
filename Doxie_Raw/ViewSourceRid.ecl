// A wrapper over Header.HeaderShowSources, to re-layout.
import Doxie, Doxie_crs, Header, atf, atf_services, Bankrupt, bankruptcyv2_services, Drivers, DriversV2, VehLic, 
       Dea, Prof_License, faa, watercraft, ak_perm_fund, emerges,
       govdata, property, utilfile, LN_TU, Doxie_LN, Doxie_Raw, liensv2_services
			 , suppress, mdr, DeaV2_Services, Foreclosure_Services, iesp,ExperianCred, 
			 Votersv2_services,TransunionCred;

export ViewSourceRid(
       dataset(Doxie.Layout_ref_rid) rids,
       doxie.IDataAccess mod_access,
			 set of string2 sources = ALL,
			 BankruptcyVersion = 0,
			 JudgmentLienVersion = 0,
			 DlVersion = 0,
			 VehicleVersion = 0,
			 VoterVersion = 0,
			 DeaVersion =0,
			 boolean IncludeNonRegulatedVehicleSources = false,
			 boolean IncludeNonRegulatedWatercraftSources = false
		) := FUNCTION

//values used in suppress.MAC_Mask:
ssn_mask_value := mod_access.ssn_mask;
dl_mask_value := mod_access.dl_mask>0;

headerSrc := header.HeaderShowSources(rids, mod_access, sources,
													IncludeNonRegulatedVehicleSources, IncludeNonRegulatedWatercraftSources);

Doxie.Layout_VehicleSearch vehOut(vehlic.Layout_Vehicles fileL) := TRANSFORM
    self.own_1_bdid := (unsigned6)fileL.own_1_bdid;
    self.own_2_bdid := (unsigned6)fileL.own_2_bdid;
    self.reg_1_bdid := (unsigned6)fileL.reg_1_bdid;
    self.reg_2_bdid := (unsigned6)fileL.reg_2_bdid;
    self := fileL;
    self := [];
END;

// #138824 is the reason for eq_child new layout 
fixEq(unsigned6 did_val, DATASET(header.Layout_Eq_src_dates)recs) :=
FUNCTION
  //need to distribute DID to the eq children before calling prune macro
	tmpRec := RECORD
	  unsigned6 did;
		header.Layout_Eq_src_dates;
	END;
	
	tmpRec addDid(header.Layout_Eq_src_dates l, unsigned6 didv) := TRANSFORM
	  SELF.did := didv;
		SELF := l;
	END;
	
	tmp := PROJECT(recs, addDid(LEFT,did_val));
	
	doxie.MAC_PruneOldSSNs(tmp, tmp_pruned, ssn, did);
  suppress.MAC_Mask(tmp_pruned, tmp_masked, ssn, blank, true, false);
	
	slim_tmp := PROJECT(tmp_masked, header.Layout_Eq_src_dates);
	RETURN slim_tmp;
END;




fixEN(unsigned6 did_val, DATASET(ExperianCred.Layouts.Layout_SourceDoc)recs) :=
FUNCTION
  //need to distribute DID to the eq children before calling prune macro
	tmpRec := RECORD
	  unsigned6 did;
		ExperianCred.Layouts.Layout_SourceDoc-did;
	END;
	
	tmpRec addDid(ExperianCred.Layouts.Layout_SourceDoc l, unsigned6 didv) := TRANSFORM
	  SELF.did := didv;
		SELF := l;
	END;
	
	tmp := PROJECT(recs, addDid(LEFT,did_val));
	
	 doxie.MAC_PruneOldSSNs(tmp, tmp_pruned,social_security_number , did);
   suppress.MAC_Mask(tmp, tmp_masked, social_security_number, blank, true, false);
	
	slim_tmp := PROJECT(tmp, ExperianCred.Layouts.Layout_SourceDoc);
	RETURN slim_tmp;
END;

fixTU(unsigned6 did_val, DATASET(LN_TU.Layout_In_Header_All)recs) :=
FUNCTION
  //need to distribute DID to the tu children before calling prune macro
	tmpRec := RECORD
	  unsigned6 did;
		LN_TU.Layout_In_Header_All;
	END;
	
	tmpRec addDid(LN_TU.Layout_In_Header_All l, unsigned6 didv) := TRANSFORM
	  SELF.did := didv;
		SELF := l;
	END;
	
	tmp := PROJECT(recs, addDid(LEFT,did_val));
	
	doxie.MAC_PruneOldSSNs(tmp, tmp_pruned, orig_ssn, did);
  suppress.MAC_Mask(tmp_pruned, tmp_masked, orig_ssn, orig_driver_license, true, true);
	
	slim_tmp := PROJECT(tmp_masked, LN_TU.Layout_In_Header_All);
	RETURN slim_tmp;
END;

fixTN(unsigned6 did_val, DATASET(TransunionCred.Layouts.base)recs) :=
FUNCTION
  //need to distribute DID to the tu children before calling prune macro
	TransunionCred.Layouts.base addDid(TransunionCred.Layouts.base l, unsigned6 didv) := TRANSFORM
	  SELF.did := didv;
		SELF := l;
	END;
	
	tmp := PROJECT(recs, addDid(LEFT,did_val));
	
	doxie.MAC_PruneOldSSNs(tmp, tmp_pruned, ssn, did);
  suppress.MAC_Mask(tmp_pruned, tmp_masked, ssn, blank, true, false);
	
	slim_tmp := PROJECT(tmp_masked, TransunionCred.Layouts.base);
	RETURN slim_tmp;
END;
fixMswork(unsigned6 did_val, DATASET(govdata.layout_ms_workers_comp_in) recs) := FUNCTION
  //need to distribute DID to the mswork children before calling prune macro
	tmpRec := RECORD
	  unsigned6 did;
		govdata.layout_ms_workers_comp_in;
	END;
	
	tmpRec addDid(govdata.layout_ms_workers_comp_in l, unsigned6 didv) := TRANSFORM
	  SELF.did := didv;
		SELF := l;
	END;
	
	tmp := PROJECT(recs, addDid(LEFT,did_val));

	doxie.MAC_PruneOldSSNs(tmp, tmp_pruned, claimant_ssn, did);
  suppress.MAC_Mask(tmp_pruned, tmp_masked, claimant_ssn, blank, true, false);
	
	slim_tmp := PROJECT(tmp_masked, govdata.layout_ms_workers_comp_in);
	RETURN slim_tmp;
END;

fixStateDeath(DATASET(header.Layout_State_Death) recs) := FUNCTION
  suppress.MAC_Mask(recs, recs_masked, ssn, blank, true, false);	
	RETURN PROJECT(recs_masked, TRANSFORM(Doxie_Raw.layout_state_death_Raw, SELF := LEFT, SELF := []));
END;

fixUtil(DATASET(utilfile.layout_utility_in) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_pruned, ssn, did);
  suppress.MAC_Mask(recs_pruned, recs_masked, ssn, drivers_license, true, true);
	RETURN recs_masked;
END;

fixFinder(DATASET(doxie_raw.layout_header_raw) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_pruned, ssn, did);
  suppress.MAC_Mask(recs_pruned, recs_masked, ssn, blank, true, false);
	RETURN PROJECT(recs_masked, TRANSFORM(Doxie_Raw.Layout_header_raw,self.prim_name := if(mdr.SourceTools.SourceIsDeath(left.src),'',left.prim_name), SELF := LEFT, SELF := []));
END;

fixEmerge(DATASET(emerges.layout_emerge_in) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_pruned, best_ssn, did_out);
  suppress.MAC_Mask(recs_pruned, recs_masked, best_ssn, blank, true, false);
	RETURN PROJECT(recs_masked, TRANSFORM(Doxie_Raw.Layout_emerge_raw, SELF := LEFT, SELF := []));
END;

fixDL(DATASET(drivers.layout_dl) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_1, ssn, did);
	doxie.MAC_PruneOldSSNs(recs_1, recs_pruned, ssn_safe, did);
  suppress.MAC_Mask(recs_pruned, recs_masked1, ssn, dl_number, true, true);
  suppress.MAC_Mask(recs_masked1, recs_masked2, ssn_safe, blank, true, false);
	RETURN PROJECT(recs_masked2, TRANSFORM(Doxie.Layout_DlSearch, SELF := LEFT, SELF := []));
END;

fixATF(DATASET(atf.layout_firearms_explosives_in) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs,recs_pruned, best_ssn, did_out);
  suppress.MAC_Mask(recs_pruned, recs_masked, best_ssn, blank, true, false);
	RETURN PROJECT(recs_masked, TRANSFORM(atf_services.layouts.firearms_out, SELF := LEFT, SELF := []));
END;

fixBKDebtors(DATASET(doxie.layout_bk_child) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_pruned, debtor_ssn, debtor_DID);
  suppress.MAC_Mask(recs_pruned, recs_masked, debtor_ssn, blank, true, false);
	RETURN recs_masked;
END;

doxie.layout_bk_output fixBKRecs(doxie.Layout_BK_output l) := TRANSFORM
	SELF.debtor_records := fixBKDebtors(l.debtor_records);
	SELF := l;
END;

fixBK(DATASET(doxie.Layout_BK_output) recs) := FUNCTION
	recs_masked := PROJECT(recs, fixBKRecs(LEFT));
	RETURN recs_masked;
END;

fixPL(DATASET(prof_license.layout_proflic_out) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs,recs_pruned, best_ssn, did);
  suppress.MAC_Mask(recs_pruned, recs_masked, best_ssn, blank, true, false);
	RETURN Project(recs_masked,transform(prof_license.layout_doxie,self := left,self:=[]));
END;

fixAirc(DATASET(faa.layout_aircraft_registration_out_slim) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs,recs_pruned, best_ssn, did_out);
  suppress.MAC_Mask(recs_pruned, recs_masked, best_ssn, blank, true, false);
	RETURN PROJECT(recs_masked, TRANSFORM(Doxie_crs.layout_Faa_Aircraft_records, SELF := LEFT, SELF := []));
END;	

fixAirm(DATASET(faa.layout_airmen_data_out) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs,recs_pruned, best_ssn, did_out);
  suppress.MAC_Mask(recs_pruned, recs_masked, best_ssn, blank, true, false);
	RETURN PROJECT(recs_masked, TRANSFORM(Doxie_crs.layout_pilot_records, SELF := LEFT, SELF := []));
END;

fixWatercraft(DATASET(watercraft.Layout_Watercraft_Full) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_pruned, ssn, did);
  suppress.MAC_Mask(recs_pruned, recs_masked, ssn, blank, true, false);
	RETURN PROJECT(recs_masked, TRANSFORM(Doxie_crs.layout_watercraft_report, SELF := LEFT, SELF := []));
END;

fixFor(DATASET(Property.Layout_Fares_Foreclosure) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_1, name1_ssn, name1_did);
	doxie.MAC_PruneOldSSNs(recs_1, recs_2, name2_ssn, name2_did);
	doxie.MAC_PruneOldSSNs(recs_2, recs_3, name3_ssn, name3_did);
	doxie.MAC_PruneOldSSNs(recs_3, recs_4, name4_ssn, name4_did);
  suppress.MAC_Mask(recs_4, recs_masked1, name1_ssn, blank, true, false);
  suppress.MAC_Mask(recs_masked1, recs_masked2, name2_ssn, blank, true, false);
  suppress.MAC_Mask(recs_masked2, recs_masked3, name3_ssn, blank, true, false);
  suppress.MAC_Mask(recs_masked3, recs_masked4, name4_ssn, blank, true, false);
	RETURN recs_masked4;
END;	

fixLien(DATASET(bankrupt.Layout_Liens) recs) := FUNCTION
	doxie.MAC_PruneOldSSNs(recs, recs_1, orig_ssn, did);
	doxie.MAC_PruneOldSSNs(recs_1, recs_pruned, ssn_appended, did);
  suppress.MAC_Mask(recs_pruned, recs_masked1, orig_ssn, blank, true, false);
  suppress.MAC_Mask(recs_masked1, recs_masked2, ssn_appended, blank, true, false);
	RETURN recs_masked2;
END;

fixVotersV2(DATASET(Votersv2_services.layouts.SourceOutput) recs) := FUNCTION
	// apply SSN compliance logic
	doxie.MAC_PruneOldSSNs(recs, recs_pruned, ssn, did);
  suppress.MAC_Mask(recs_pruned, recs_masked, ssn, blank, true, false);
	// RETURN recs_masked;
	
	// STUB - We need to disable voter lookups by rid until the vtid field in
	//        the VotersV2 build is made persistent.  See bug 48580 for detail.
	RETURN DATASET([], Votersv2_services.layouts.SourceOutput);
END;

//Atf: atf.layout_firearms_explosives_out: Missing premise_fips_County_name.
//Bankrupt.Layout_BK_Source has extra bankrupt.Layout_BK_Search_v8.
Doxie_Raw.Layout_crs_raw getChildren(headerSrc fileL) := transform
    self.death_child       := fileL.death_child;
    self.state_death_child := fixStateDeath(fileL.state_death_child);
    self.atf_child         := fixATF(fileL.atf_child);
    self.bk_child          := if(BankruptcyVersion in [0,1],fixBK(fileL.bk_child)); 
		self.bk_V2_child       := if(BankruptcyVersion in [0,2],fileL.bk_V2_child);   // FIX : Need to fix for Pruning?
    self.lien_child        := if(JudgmentLienVersion in [0,1],fixLien(fileL.lien_child));
    self.lien_V2_child     := if(JudgmentLienVersion in [0,2],fileL.lien_V2_child);  // FIX : Need to fix for Pruning?
    self.dl_child          := if(DLVersion in [0,1],fixDL(fileL.dl_child));
    self.dl2_child         := if(DLVersion in [0,2],fileL.dl2_child);   // FIX: need to determine where pruning should occur
    self.proflic_child     := fixPL(fileL.proflic_child);
    self.veh_child         := if(VehicleVersion in [0,1], fileL.veh_child);
    self.veh_v2_child      := if(VehicleVersion in [0,2], fileL.veh_v2_child);
    self.dea_child         := if(DLVersion in [0,1],project(fileL.dea_child, TRANSFORM(Doxie_Raw.Layout_Dea_Raw, SELF := LEFT, SELF := [])));
		self.dea_v2_child      := if(DLVersion in [0,2],fileL.dea_v2_child);
    self.airc_child        := fixAirc(fileL.airc_child);
    self.pilot_child       := fixAirm(fileL.airm_child);
    self.watercraft_child  := fixWatercraft(fileL.watercraft_child);
    self.ak_child          := fileL.ak_child;
		self.emerge_child      := fixEmerge(fileL.emerge_child);
		self.voters_v2_child   := if(VoterVersion in [0,2], fixVotersV2(fileL.voters_v2_child));
    self.mswork_child      := fixMswork(fileL.did,fileL.mswork_child);
    self.util_child        := fixUtil(fileL.util_child);
    self.eq_child          := fixEq(fileL.did,fileL.eq_child);		
    self.en_child          := fixEN(fileL.did, fileL.EN_child);
    self.boater_child      := fileL.boater_child;
    self.deed_child        := project(fileL.deeds_child, TRANSFORM(doxie_ln.layout_deed_records, SELF := LEFT, SELF := []));
    self.assessor_child    := project(fileL.asses_child, TRANSFORM(Doxie_LN.layout_assessor_records, SELF := LEFT, SELF := []));
    self.deed2_child       := fileL.deeds2_child;
    self.assessor2_child   := fileL.asses2_child;
    self.for_child         := fixFor(fileL.for_child);
    self.nod_child         := iesp.transform_NOD(project(fileL.nod_child,Foreclosure_Services.Layouts.Layout_Foreclosure_out));
    self.tu_child          := fixTu(fileL.did, fileL.tu_child);
    self.tn_child          := fixTn(fileL.did, fileL.tn_child);
    self.finder_child      := fixFinder(fileL.finder_child);
    self.targ_child        := fileL.targ_child;
    self.FBNv2_child       := iesp.transform_FBN(fileL.FBNv2_child);
    self.did               := fileL.did;
	  self.rid               := fileL.rid;
	  self.uid               := fileL.uid;
	  self.src               := fileL.src;
    self                   := [];
end;

dsOut := project(headerSrc, getChildren(left));
return dsOut;
END;