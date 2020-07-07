IMPORT iesp, doxie, CriminalRecords_Services, AutoStandardI;
  
out_rec := iesp.criminal.t_CrimReportRecord;

EXPORT out_rec criminal_records (
  DATASET(doxie.layout_references) dids,
  $.IParam.criminal in_params = MODULE($.IParam.criminal) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

  // An interface to crim report records requires a lot of values which are not relevant to
  // the purpose of "this" functionality (steaming mainly from from AutoStandardI/LIBIN.PenaltyI_Indv.base)
  // For now I don't have a better way of filling in these values other than from global module
  gm := AutoStandardI.GlobalModule (IsFCRA); // is compreport

  crim_mod := module (project (gm, CriminalRecords_Services.IParam.report, opt))
    doxie.compliance.MAC_CopyModAccessValues(in_params);  
    export boolean IncludeAllCriminalRecords := in_params.IncludeAllCriminalRecords;
    export boolean IncludeSexualOffenses := in_params.IncludeSexualOffenses;
    export boolean AllowGraphicDescription := in_params.AllowGraphicDescription;
    export boolean Include_BestAddress := in_params.Include_BestAddress;

    // If there's need for more generality, then we can expand IParam.criminal with these:
    export string25 doc_number := '';
    export string60 offender_key := '';

    export string14 did := (string) dids[1].did;
    export unsigned2 penalty_threshold := in_params.penalty_threshold;
  end;

	outRecs := project(CriminalRecords_Services.ReportService_Records.val (crim_mod).CriminalRecords, iesp.criminal.t_CrimReportRecord);
	
  RETURN outRecs;
END;
