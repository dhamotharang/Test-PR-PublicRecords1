IMPORT Address, BatchShare, didville, Header, Relationship;

EXPORT fn_getRelatives(DATASET(HomesteadExemptionV2_Services.Layouts.propIdRec) ds_srch_recs,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	relSlimRec:=RECORD
		Relationship.layout_output.titled.did1;
		Relationship.layout_output.titled.did2;
		Relationship.layout_output.titled.type;
		Relationship.layout_output.titled.confidence;
		Relationship.layout_output.titled.total_score;
		Relationship.layout_output.titled.title;
	END;

	HomesteadExemptionV2_Services.Layouts.relativeRec setAddrMatch(HomesteadExemptionV2_Services.Layouts.relativeRec L,
		HomesteadExemptionV2_Services.Layouts.addrMin propAddr) := TRANSFORM
			bestAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.hasAddrMatch:=HomesteadExemptionV2_Services.Functions.compare2Addresses(bestAddr,propAddr);
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propRelativeRec relativeRecords(HomesteadExemptionV2_Services.Layouts.propIdRec L,DATASET(relSlimRec) R) := TRANSFORM
		ownDids:=PROJECT(L.dids(NOT isbdid),TRANSFORM(BatchShare.Layouts.ShareDid,SELF:=LEFT));
		less_owner_recs:=R(did2 NOT IN SET(ownDids,did));
		relative_recs:=CHOOSEN(SORT(less_owner_recs,-total_score),HomesteadExemptionV2_Services.Constants.MAX_RELATIVES);
		best_in:=PROJECT(relative_recs,TRANSFORM(DidVille.Layout_Did_OutBatch,SELF.did:=LEFT.did2,SELF:=[]));
		didville.MAC_BestAppend(best_in,'BEST_NAME BEST_ADDR','BEST_NAME BEST_ADDR',0,in_mod.isValidGlb(),
			best_out,FALSE,in_mod.DataRestrictionMask,,,,,'',IndustryClass_val:=in_mod.industry_class);
		best_addr:=JOIN(best_out,relative_recs,LEFT.did=RIGHT.did2,
			TRANSFORM(HomesteadExemptionV2_Services.Layouts.relativeRec,
				CLN:=Address.CleanFields(Address.GetCleanAddress(LEFT.best_addr1,
					TRIM(LEFT.best_city)+' '+TRIM(LEFT.best_state)+' '+LEFT.best_zip,
					Address.Components.Country.US).str_addr);
				SELF.title:=Header.relative_titles.fn_get_str_title(RIGHT.title),
				SELF.name_first :=LEFT.best_fname,
				SELF.name_middle:=LEFT.best_mname,
				SELF.name_last  :=LEFT.best_lname,
				SELF.name_suffix:=LEFT.best_name_suffix,
				SELF.prim_range :=CLN.prim_range,
				SELF.predir     :=CLN.predir,
				SELF.prim_name  :=CLN.prim_name,
				SELF.addr_suffix:=CLN.addr_suffix,
				SELF.postdir    :=CLN.postdir,
				SELF.unit_desig :=CLN.unit_desig,
				SELF.sec_range  :=CLN.sec_range,
				SELF.p_city_name:=CLN.p_city_name,
				SELF.st         :=CLN.st,
				SELF.z5         :=CLN.zip,
				SELF.zip4       :=CLN.zip4,
				SELF:=LEFT,SELF:=RIGHT),LEFT OUTER,LIMIT(0));
		propAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.relatives:=PROJECT(best_addr,setAddrMatch(LEFT,propAddr));
		SELF:=L;
	END;

	search_dids:=PROJECT(ds_srch_recs,TRANSFORM(Relationship.layout_GetRelationship.DIDs_layout,SELF:=LEFT));
	ds_rel_recs:=Relationship.proc_GetRelationship(search_dids,RelativeFlag:=TRUE,doSkip:=TRUE).result;
	ds_1st_recs:=PROJECT(ds_rel_recs(title IN Header.relative_titles.set_FirstDegreeRelative),TRANSFORM(relSlimRec,SELF:=LEFT));

	RETURN DENORMALIZE(ds_srch_recs,ds_1st_recs,LEFT.did=RIGHT.did1,GROUP,relativeRecords(LEFT,ROWS(RIGHT)));
END;
