import AutoStandardI,Foreclosure_Services,doxie,iesp,suppress;

export ReportService_Records := module
	export params := interface(
		Foreclosure_Services.ReportService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params)
		EXPORT string6 ssnmask;
	end;
	export val(params in_mod, boolean isNodSearch=false, boolean includeBlackKnight=false) := function
		

		ids := Foreclosure_services.ReportService_IDs.val(in_mod,isNodSearch);
		
		Suppress.MAC_Suppress(ids,ids_tmp,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
		
		recs:= project(ids_tmp,Layouts.layout_fid);
		added_in_mod := project(in_mod, raw.params);
        recs_fmt := Foreclosure_Services.Raw.REPORT_VIEW.by_fid(recs,added_in_mod,isNodSearch,includeBlackKnight);

		recs_sort := sort(recs_fmt, -recordingdate.year, -recordingdate.month, -recordingdate.day,record);
  		tempresults_slim := project(recs_sort, iesp.foreclosure.t_ForeclosureReportRecord); 
	 
		return if(not doxie.DataRestriction.Fares,tempresults_slim,tempresults_slim(VendorSource!=Foreclosure_services.Constants('').src_Fares));
		
		end;
end;
