import $, doxie, doxie_cbrs, dx_property, UT, BIPV2, Suppress, MDR;

export Raw := module

    EXPORT params := INTERFACE
      EXPORT string5 industry_class := '';
      EXPORT string32 application_type := Suppress.Constants.ApplicationTypes.DEFAULT;
      EXPORT string ssn_mask := suppress.constants.ssn_mask_type.ALL;
    END;

    export $.Layouts.FIDNumberPlus byDIDs(dataset(doxie.layout_references) in_dids, boolean isNodSearch=false) := function
      deduped := dedup(sort(in_dids,did),did);
      keyDID := if(isNodSearch,dx_Property.Key_NOD_DID,dx_Property.Key_Foreclosure_DID);
      joinup := join(deduped,keyDID,keyed(left.did= right.did),transform($.Layouts.FIDNumberPlus,
        self.fid := right.fid,
        self.did := right.did,
        self.bdid := 0,
        self := right), limit(ut.limits.Foreclosure_PER_DID, skip));
      return joinup;
    end;

    export $.Layouts.FIDNumberPlus byBDIDs(dataset(doxie_cbrs.layout_references) in_bdids, boolean isNodSearch=false) := function
      deduped := dedup(sort(in_bdids,bdid),bdid);
      keyBDID := if(isNodSearch,dx_Property.Key_NOD_BDID,dx_Property.Key_Foreclosures_BDID);
      joinup := join(deduped,keyBDID,keyed(left.bdid = right.bdid),transform($.Layouts.FIDNumberPlus,
        self.fid := right.fid,
        self.did := 0,
        self.bdid := right.bdid,
        self := right),limit(ut.limits.Foreclosure_PER_BDID, skip));

      return joinup;
    end;

    export $.Layouts.FIDNumberPlus byBIDs(DATASET(BIPV2.IDlayouts.l_xlink_ids) link_ds = DATASET([], BIPV2.IDlayouts.l_xlink_ids),
                                           STRING1 BusinessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID,
                                           boolean isNodSearch=false) := function

      recs_LinkID := if (isNodSearch,
            dx_Property.Key_nod_Linkids.kfetch(link_ds, BusinessIdFetchLevel),
            dx_Property.Key_Foreclosure_Linkids.kfetch(link_ds, BusinessIdFetchLevel));

      recs := project(recs_LinkID, transform($.Layouts.FIDNumberPlus,
        self.fid := left.foreclosure_id,
        self := left,
        self := []
        ));
      return recs;
    end;


  export $.Layouts.Rawrec GetRawRecs(dataset($.Layouts.FIDNumberPlus) ids,
                                   string5 IndustryClass,
                                   boolean isNodSearch=false,
                                   boolean includeBlackKnight=false) :=function

      isCNSMR := IndustryClass = ut.IndustryClass.Knowx_IC;
      keyFID := if(isNodSearch,dx_Property.Key_NOD_FID,dx_Property.Key_Foreclosures_FID);

      codes := $.Functions.getCodes(includeBlackKnight);

      recs_info := join(ids,keyFID,
                 keyed(left.fid =  right.fid) AND
                 right.source IN codes,
                      transform($.Layouts.Rawrec,
                                self.foreclosure_id :=left.fid,
                                self:=right,  // set for use later.
                                ),limit(ut.limits.Foreclosure_MAX, skip));

      recs := if(~isCNSMR, recs_info);
  return recs;
  end;

 export $.Layouts.FIDNumberPlus byforeclosureid(dataset($.Layouts.FIDNumberPlus) in_foreclosure_id,
                                                boolean isNodSearch=false,
                                                boolean includeBlackKnight=false) := function
         deduped := dedup(sort(in_foreclosure_id,fid),fid);
         joinup := project(GetRawRecs(deduped,'',isNodSearch,includeBlackKnight),
                          transform($.Layouts.FIDNumberPlus,
                                  self.fid  := left.foreclosure_id,
                                  self.bdid := 0,
                                  self.did := 0));

         return joinup;
       end;
 
 export $.Layouts.FIDNumberPlus byApn(dataset(Layouts.layout_apn) apn_in, boolean isNodSearch=false, boolean includeBlackKnight=false) := function
     deduped := dedup(sort(apn_in,apn),apn);
     joinup := join(deduped, dx_Property.Key_Foreclosure_ParcelNum, keyed(left.apn = right.parcel_number_parcel_id),transform(Layouts.FIDNumberPlus,
            self.fid := right.fid,
            self.did := 0,
            self.bdid := 0));
   return joinup;
 end;

  // ================================================================
  // Returns data in the IESP format for report view
  // ================================================================

  EXPORT REPORT_VIEW := MODULE

    shared format_rpt (dataset($.Layouts.rawrec) recs, params in_mod) :=function
      in_mod_funct:=project(in_mod,$.Functions.params);
      rpt_fmt := $.Functions.fnforeclosureReportval(recs,in_mod_funct);
      return rpt_fmt;
    end;

     export by_fid (dataset($.Layouts.layout_fid) in_fids, params in_mod, boolean isNodSearch=false,
                                          boolean includeBlackKnight=false) := function
      fids_tmp:=project(in_fids,transform($.Layouts.FIDNumberPlus,self:=left,self.did:=0,self.bdid:=0));
         recs:= GetRawRecs(byforeclosureid(fids_tmp,isNodSearch,includeBlackKnight),
                          in_mod.industry_class,isNodSearch,includeBlackKnight);
         rpt:=format_rpt(recs,in_mod);
         return rpt;
       end;

		export by_did (dataset(doxie.layout_references) in_dids, params in_mod, boolean isNodSearch=false, boolean includeBlackKnight=false) := function
		 //No need for includeVendorSourceB in the call to byDIDs
			recs:= GetRawRecs(byDIDs(in_dids,isNodSearch),in_mod.industry_class, isNodSearch,  includeBlackKnight);
			rpt:=format_rpt(recs,in_mod);
			return rpt;
		end;

  export by_bdid (dataset(doxie_cbrs.layout_references) in_bdids, params in_mod, boolean isNodSearch=false) := function
   recs:= GetRawRecs(byBDIDs(in_bdids,isNodSearch), in_mod.industry_class, isNodSearch);
      rpt:=format_rpt(recs,in_mod);
      return rpt;
  end;

  END;

end;
