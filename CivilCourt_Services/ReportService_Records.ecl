import AutoStandardI,civil_court,CivilCourt_Services,doxie,iesp;

export ReportService_Records := module
	export params := interface
		export string60 caseID := '';
	end;

	export val(params in_mod) := function
				
		partyDS :=     civilCourt_Services.raw.byCaseIDParty(in_mod.caseID);
		activityDS :=  civilCourt_Services.raw.byCaseIDActivity(in_mod.caseID);
		MatterDS :=    civilCourt_Services.raw.byCaseIDMatter(in_mod.caseID);
		
		// Format for output
		added_in_mod := project(in_mod, functions.params);
		recs_fmt := Functions.fnCivilCourtReportval(partyDS, activityDS, 
		                                            matterDS, added_in_mod);
    tempresults_slim := project(recs_fmt, iesp.civilcourt.t_CivilCourtReportRecord); 
		// output(partyDS,named('RSR_partyDS'));
		// output(activityDS,named('RSR_activityDS'));
		// output(MatterDS,named('RSR_MatterDS'));
		return tempresults_slim;
	end;
end;