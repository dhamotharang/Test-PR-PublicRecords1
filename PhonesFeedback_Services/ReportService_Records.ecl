import AutoStandardI,PhonesFeedback,doxie,atf,iesp;

export ReportService_Records := module
	export params := interface(
		PhonesFeedback_Services.ReportService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base)
		// ,
		// AutoStandardI.InterfaceTranslator.glb_purpose.params,
		// AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		// AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)
	end;
	export val(params in_mod) := function
	
		ids := PhonesFeedback_Services.ReportService_IDs.val(in_mod);
																 
		recs_fmt := PhonesFeedback_Services.Functions.fnSearchval(ids);
		
		tempresults_slim := dedup(sort(project(recs_fmt, iesp.phonesfeedback.t_PhonesFeedbackReportResponse),record),record); 

		return tempresults_slim;
		
		end;
		
end;


