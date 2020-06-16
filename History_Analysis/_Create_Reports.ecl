
Export _Create_Reports( string version) := Module


    Export Deltas := Output(Files.History_Analysis_SF, Named('updated_delta_report'));
    Export Delta_Stats := Output(Files.Delta_Statistics, Named('updated_delta_statistics')); 


    Export full_Report := Sequential(Parallel( Deltas, Delta_Stats ))
                                    : Success(Send_Email(version).build_success), Failure(Send_Email(version).build_failure);

End;