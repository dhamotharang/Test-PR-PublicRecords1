IMPORT AutoheaderV2, AutoStandardI, BatchShare, doxie, header, ut;

EXPORT fn_getAdditionalPersons(DATASET(HomesteadExemptionV2_Services.Layouts.propIdRec) ds_srch_recs,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

  mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
    EXPORT unsigned1 glb := in_mod.GLBPurpose;
    EXPORT unsigned1 dppa := in_mod.DPPAPurpose;
    EXPORT boolean ln_branded := in_mod.lnbranded;
    EXPORT boolean probation_override := FALSE;
    EXPORT string5 industry_class := in_mod.industryclass;
    EXPORT boolean no_scrub := FALSE;
    EXPORT string ssn_mask := in_mod.ssnmask;
  END;

	// REQUIRED FOR MAC_GlbClean_Header()
	BOOLEAN checkRNA:=TRUE;
	UNSIGNED1 GLB_Purpose:=mod_access.glb; //MAC_GLB_DPPA_Clean_RNA
	UNSIGNED1	DPPA_Purpose:=mod_access.dppa; //MAC_GLB_DPPA_Clean_RNA
	BOOLEAN glb_ok:=mod_access.isValidGLB(checkRNA);
	BOOLEAN dppa_ok:=mod_access.isValidDPPA(checkRNA);

	AutoheaderV2.layouts.search srchRec(ds_srch_recs L) := TRANSFORM
		SELF.taddress.prim_range          := L.prim_range;
		SELF.taddress.prim_name           := ut.StripOrdinal(L.prim_name);
		SELF.taddress.sec_range           := L.sec_range;
		SELF.taddress.city                := L.p_city_name;
		SELF.taddress.state               := L.st;
		SELF.taddress.zip5                := L.z5;
		SELF.taddress.sec_range_fuzziness := AutoStandardI.Constants.SECRANGE.INCLUDES_ATOM;
		SELF.taddress.allow_dateseen      := TRUE;
		SELF.taddress.date_firstseen      := (UNSIGNED)(L.inputTaxYear+'01');
		SELF.taddress.date_lastseen       := (UNSIGNED)(L.inputTaxYear+'12');
	END;

	fetchAddlPrsns(HomesteadExemptionV2_Services.Layouts.propIdRec L, UNSIGNED1 max_persons) := FUNCTION

		// GET DIDS BY ADDRESS ONLY - FUZZY 2ND RANGE - DATE SEEN DATES
		ds_srch:=DATASET([srchRec(L)]);
		ds_dids:=PROJECT(AutoHeaderV2.fetch_address(ds_srch,AutoHeaderV2.Constants.SearchCode.NOFAIL),BatchShare.Layouts.ShareDid);
		ownDids:=PROJECT(L.dids(NOT isbdid),TRANSFORM(BatchShare.Layouts.ShareDid,SELF:=LEFT));
		// SUBTRACT CURRENT OWNER DIDS
		ds_join:=DEDUP(SORT(ds_dids-ownDids,did),did);

		// GET HEADER RECORDS BY DID FILTERED BY ADDR AND SEEN DATES
		ds_hdr_addr_dt:=JOIN(ds_join,doxie.Key_Header,
			KEYED(LEFT.did=RIGHT.s_did) AND
			RIGHT.prim_range=L.prim_range AND
			RIGHT.prim_name=L.prim_name AND
			RIGHT.sec_range=L.sec_range AND
			((RIGHT.city_name=L.p_city_name AND RIGHT.st=L.st) OR RIGHT.zip=L.z5) AND
			(RIGHT.dt_last_seen>=((UNSIGNED)(L.inputTaxYear+'01')) AND RIGHT.dt_first_seen<=((UNSIGNED)(L.inputTaxYear+'12'))) AND
			(RIGHT.dod=0 OR RIGHT.dod>=((UNSIGNED)(L.inputTaxYear+'0101'))),
			LIMIT(ut.limits.HEADER_PER_DID,SKIP));

		// APPLY DPPA AND GLB RESTRICTIONS AND DID SUPPRESSION
		header.MAC_GlbClean_Header(ds_hdr_addr_dt,ds_hdr_glb_cln, , , mod_access);
		header.MAC_GLB_DPPA_Clean_RNA(ds_hdr_glb_cln,ds_hdr_rna_cln);

		ds_hdr_sort:=SORT(ds_hdr_rna_cln,did,-dt_last_seen,-dt_first_seen);
		ds_addl_per:=PROJECT(DEDUP(ds_hdr_sort,did),TRANSFORM(HomesteadExemptionV2_Services.Layouts.addlPerRec,
			SELF.name_first:=LEFT.fname,
			SELF.name_middle:=LEFT.mname,
			SELF.name_last:=LEFT.lname,
			SELF:=LEFT));

		RETURN CHOOSEN(SORT(ds_addl_per,-dt_last_seen,-dt_first_seen),max_persons);
	END;

	RETURN PROJECT(ds_srch_recs,TRANSFORM(HomesteadExemptionV2_Services.Layouts.propAddlPerRec,
		SELF.additional_persons:=fetchAddlPrsns(LEFT,HomesteadExemptionV2_Services.Constants.MAX_PERSONS),SELF:=LEFT));
END;
