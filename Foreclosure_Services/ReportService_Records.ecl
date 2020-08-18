import AutoStandardI, Foreclosure_Services, doxie, iesp, suppress;

export ReportService_Records := module
	export params := interface(
		Foreclosure_Services.ReportService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base)
	end;
	export val(params in_mod, doxie.IDataAccess mod_access, boolean isNodSearch=false, boolean includeBlackKnight=false) := function

		ids := Foreclosure_services.ReportService_IDs.val(PROJECT(in_mod,Foreclosure_services.ReportService_IDs.params), isNodSearch);
		
		Suppress.MAC_Suppress(ids,ids_tmp,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
		
		recs:= project(ids_tmp,Layouts.layout_fid);
		added_in_mod := project(mod_access, Foreclosure_Services.raw.params);
		recs_fmt := Foreclosure_Services.Raw.REPORT_VIEW.by_fid(recs,added_in_mod,isNodSearch,includeBlackKnight);
		
		recs_sort := sort(recs_fmt, -recordingdate.year, -recordingdate.month, -recordingdate.day,record);
  		tempresults_slim := project(recs_sort, iesp.foreclosure.t_ForeclosureReportRecord); 
	 
	 return tempresults_slim;
		
		end;
end;
