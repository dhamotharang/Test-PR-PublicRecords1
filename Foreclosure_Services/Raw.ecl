import doxie,doxie_cbrs,Foreclosure_services,Property, iesp, Census_Data, Codes,UT,AutoStandardI, BIPV2;
	
export Raw := module
	 
		export params := interface(AutoStandardI.InterfaceTranslator.application_type_val.params)
			export string6 ssnmask;
			export string5 IndustryClass;
		end;
		
		export Layouts.FIDNumberPlus byDIDs(dataset(doxie.layout_references) in_dids, boolean isNodSearch=false) := function		
			deduped := dedup(sort(in_dids,did),did);
			keyDID := if(isNodSearch,Property.Key_NOD_DID,Property.Key_Foreclosure_DID);
			joinup := join(deduped,keyDID,keyed(left.did= right.did),transform(Layouts.FIDNumberPlus,
				self.fid := right.fid,
				self.did := right.did,
				self.bdid := 0,
				self := right), limit(ut.limits.Foreclosure_PER_DID, skip));
			return joinup;
		end;
				
		export Layouts.FIDNumberPlus byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids, boolean isNodSearch=false) := function
			deduped := dedup(sort(in_bdids,bdid),bdid);
			keyBDID := if(isNodSearch,Property.Key_NOD_BDID,Property.Key_Foreclosures_BDID);
			joinup := join(deduped,keyBDID,keyed(left.bdid = right.bdid),transform(Layouts.FIDNumberPlus,
				self.fid := right.fid,
				self.did := 0,
				self.bdid := right.bdid,
				self := right),limit(ut.limits.Foreclosure_PER_BDID, skip));
				
			return joinup;
		end;		
		
		export Layouts.FIDNumberPlus byBIDs(DATASET(BIPV2.IDlayouts.l_xlink_ids) link_ds = DATASET([], BIPV2.IDlayouts.l_xlink_ids), 
																					 STRING1 BusinessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID, 
																					 boolean isNodSearch=false) := function
				
			recs_LinkID := if (isNodSearch,
						Property.Key_nod_Linkids.kfetch(link_ds, BusinessIdFetchLevel),
						Property.Key_Foreclosure_Linkids.kfetch(link_ds, BusinessIdFetchLevel));
						
			recs := project(recs_LinkID, transform(Layouts.FIDNumberPlus,
				self.fid := left.foreclosure_id,
				self := left,
				self := []
				));
			return recs;
		end;		
		

	export Layouts.Rawrec GetRawRecs(dataset(Layouts.FIDNumberPlus) ids, boolean isNodSearch=false,
																																		string5 IndustryClass = '') :=function
																																		
			isCNSMR := IndustryClass = ut.IndustryClass.Knowx_IC;
			keyFID := if(isNodSearch,Property.Key_NOD_FID,Property.Key_Foreclosures_FID);
			recs_info := join(ids,keyFID,
		             keyed(left.fid =  right.fid),
											transform(Foreclosure_Services.Layouts.Rawrec,	
													 self.foreclosure_id :=left.fid,
																self:=right,  // set for use later.
																),limit(ut.limits.Foreclosure_MAX, skip));
																
			recs := if(~isCNSMR, recs_info);		
	return recs;
	end;
	
		export Layouts.FIDNumberPlus byforeclosureid(dataset(Layouts.FIDNumberPlus) in_foreclosure_id, boolean isNodSearch=false) := function
			deduped := dedup(sort(in_foreclosure_id,fid),fid);
			joinup := project(GetRawRecs(deduped,isNodSearch),transform(Layouts.FIDNumberPlus,														 
															 self.fid  := left.foreclosure_id,
															 self.bdid := 0,
															 self.did := 0));
													
			return joinup;
		end;

	// ================================================================
  // Returns data in the IESP format for report view 
  // ================================================================

	EXPORT REPORT_VIEW := MODULE

		shared format_rpt (dataset(Layouts.rawrec) recs, params in_mod) :=function
			in_mod_funct:=project(in_mod,functions.params);
			rpt_fmt := Foreclosure_Services.Functions.fnforeclosureReportval(recs,in_mod_funct);
			return rpt_fmt;
		end;
		
		export by_fid (dataset(Layouts.layout_fid) in_fids, params in_mod, boolean isNodSearch=false) := function
   fids_tmp:=project(in_fids,transform(Layouts.FIDNumberPlus,self:=left,self.did:=0,self.bdid:=0));
			recs:= GetRawRecs(byforeclosureid(fids_tmp,isNodSearch),isNodSearch);
			rpt:=format_rpt(recs,in_mod);
			return rpt;
    end;
		export by_did (dataset(doxie.layout_references) in_dids, params in_mod, boolean isNodSearch=false) := function
			recs:= GetRawRecs(byDIDs(in_dids,isNodSearch),isNodSearch, in_mod.IndustryClass);
			rpt:=format_rpt(recs,in_mod);
			return rpt;
		end;

  export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids, params in_mod, boolean isNodSearch=false) := function
   recs:= GetRawRecs(byBDIDs(in_bdids,isNodSearch),isNodSearch, in_mod.IndustryClass);
			rpt:=format_rpt(recs,in_mod);
			return rpt;
  end;
		
	END;

end;