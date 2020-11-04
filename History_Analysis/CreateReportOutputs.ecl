
// Instead of building a whole report and adding any more subfiles to your superfile...  
// The user can simply run individual reports using this module

Export CreateReportOutputs( string pVersion ) := Module

    Export deltas      := output(History_Analysis.Files(pVersion).counted_deltas, named('updated_delta_report'));
    Export delta_stats := output(History_Analysis.Files(pVersion).delta_statistics, named('updated_delta_statistics')); 


    Export full_Report := parallel( deltas, delta_stats )
                                    : Success(Send_Email(pVersion).build_success), Failure(Send_Email(pVersion).build_failure);

End;