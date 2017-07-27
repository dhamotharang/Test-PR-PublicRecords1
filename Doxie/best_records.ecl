import doxie, ut, suppress, SSNBest_Services, Header;

export best_records(DATASET(doxie.layout_references) di,
										boolean use_global     = true,
										DPPA_override          = 0,
										GLB_override           = 0,
										boolean get_valid_ssn  = false, //deprecated
										boolean IsFCRA         = false,
										boolean doSuppress     = true,
										boolean doTimeZone     = true,
										boolean useNonBlankKey = false,
										boolean checkRNA       = false,
										boolean includeDOD     = false,
										boolean include_minors = false,
										boolean getSSNBest     = false
                  ):=FUNCTION

doxie.mac_header_field_declare()

d := IF(use_global,ut.dppa_ok(DPPA_Purpose,checkRNA),ut.dppa_ok(dppa_override,checkRNA));
g := IF(use_global,ut.glb_ok(GLB_Purpose,checkRNA),ut.glb_ok(glb_override,checkRNA));

DRM := doxie.DataRestriction.fixed_DRM;

doxie.mac_best_records(di,did,o,d,g,useNonBlankKey,DRM,,,,includeDOD);

	
ssnBestParams := SSNBest_Services.IParams.setSSNBestParams(GLB_override,DPPA_override,DRM,application_type_value
													                                 ,industry_class_value,ssn_mask_value,include_minors
																									         ,suppress_and_mask_:=FALSE //since suppression is done later by all services that currently call getSSNBest
																									         ,checkRNA_:= checkRNA);
//we hit the BestSSN key to get the 'best ssn' - this will return the same SSN 'most' of the time
with_bestSSNs := SSNBest_Services.Functions.fetchSSNs_generic(o,ssnBestParams,ssn,did,fromADL:=true);
	
outfile_ := if(getSSNBest, with_bestSSNs, o);

doxie.MAC_PruneOldSSNs(outfile_,recs,ssn,did);

suppress.MAC_Mask(recs,out_mskd,ssn,dl_number,true,true, false, true);
//*** when no best (or if called at FCRA-side), get a header record

hfat_1 := doxie.mod_header_records(
	/*DoSearch:=*/false,											
	/*include_dailies:=*/true, 					
	/*allow_wildcard:=*/false,	
	dateVal,
	dppa_purpose,
	glb_purpose,
	ln_branded_value,
	/*include_gong*/,
	probation_override_value,
	industry_class_value, 
	no_scrub).results(project(di, doxie.layout_references_hh));

Header.MAC_GLB_DPPA_Clean_RNA(hfat_1,hfat_rna)

hfat := if (checkRNA,hfat_rna,hfat_1);

doxie.layout_best likebest(hfat l) := transform
	self.dod := (qstring)l.dod;
	self.age := if ( l.dob = 0, 0, ut.age (l.dob) );
	self.valid_ssn := L.valid_ssn;
	self := l;
end;

h := project(topn(hfat,1,-dt_last_seen,-ssn,-rid), likebest(left));

suppress.mac_mask(h, h_mskd, ssn, dl_number, true, true, false, true);

best_masked_decided := IF(doSuppress, out_mskd, recs);
header_masked_decided := IF(doSuppress, h_mskd, h);

// enforce "on-the-fly" calculation at FCRA-side.
bests0 := IF (exists(out_mskd) AND ~IsFCRA, best_masked_decided, header_masked_decided);	//only one will exist

ut.getTimeZone(bests0,phone,timezone,bests_w_timezone)

bests := if(doTimeZone,bests_w_timezone,bests0);

RETURN bests;

END;