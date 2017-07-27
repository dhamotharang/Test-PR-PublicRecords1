IMPORT iesp, doxie, CriminalRecords_Services, AutoStandardI;
  
out_rec := iesp.criminal.t_CrimReportRecord;

EXPORT out_rec criminal_records (
  DATASET(doxie.layout_references) dids,
  input.criminal in_params = MODULE(input.criminal) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

  // An interface to crim report records requires a lot of values which are not relevant to
  // the purpose of "this" functionality (steaming mainly from from AutoStandardI/LIBIN.PenaltyI_Indv.base)
  // For now I don't have a better way of filling in these values other than from global module
  gm := AutoStandardI.GlobalModule (IsFCRA); // is compreport

  crim_mod := module (project (gm, CriminalRecords_Services.IParam.report, opt))
    export boolean IncludeAllCriminalRecords := in_params.IncludeAllCriminalRecords;
    export boolean IncludeSexualOffenses := in_params.IncludeSexualOffenses;
    export boolean AllowGraphicDescription := in_params.AllowGraphicDescription;
    export boolean Include_BestAddress := in_params.Include_BestAddress;

    // If there's need for more generality, then we can expand input.criminal with these:
    export string25 doc_number := '';
    export string60 offender_key := '';

    // these values need either renaming or translating (which must have been done at a higher level)
    export string14 did := (string) dids[1].did;
    export unsigned1 GLBPurpose := in_params.GLBPurpose;
    export unsigned1 DPPAPurpose := in_params.DPPAPurpose;
    export string32 ApplicationType := in_params.ApplicationType;
    export unsigned2 penalty_threshold := in_params.penalty_threshold;
    export boolean lnbranded := in_params.ln_branded;
    export string6 ssnmask := in_params.ssn_mask;
    // not used here; careful, if required:
    // export string6 dobmask // requires "backward" translation: defined as an integer in in_params.dob_mask;
  end;

	outRecs := project(CriminalRecords_Services.ReportService_Records.val (crim_mod).CriminalRecords, iesp.criminal.t_CrimReportRecord);
	
  RETURN outRecs;
END;
