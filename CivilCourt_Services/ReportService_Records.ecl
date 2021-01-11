IMPORT CivilCourt_Services,iesp;

EXPORT ReportService_Records := MODULE
  EXPORT params := INTERFACE
    EXPORT STRING60 caseID := '';
  END;

  EXPORT val(params in_mod) := FUNCTION
        
    partyDS := civilCourt_Services.raw.byCaseIDParty(in_mod.caseID);
    activityDS := civilCourt_Services.raw.byCaseIDActivity(in_mod.caseID);
    MatterDS := civilCourt_Services.raw.byCaseIDMatter(in_mod.caseID);
    
    // Format for output
    recs_fmt := Functions.fnCivilCourtReportval(partyDS, activityDS, matterDS);
    tempresults_slim := PROJECT(recs_fmt, iesp.civilcourt.t_CivilCourtReportRecord);
    // output(partyDS,named('RSR_partyDS'));
    // output(activityDS,named('RSR_activityDS'));
    // output(MatterDS,named('RSR_MatterDS'));
    RETURN tempresults_slim;
  END;
END;
