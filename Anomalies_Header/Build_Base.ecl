

Import _Control, VersionControl;

Export Build_Base( String pversion, Boolean pUseProd, 
                    pBaseFile = Files.Header ) := Module 

    Export build_base := _Create_Reports.complete_header_reports;



    Export full_build := Sequential(
        build_base,
        Promote( pversion, pUseProd ).buildFiles.New2Built
    ) : Success(Send_Email(pversion).buildsuccess), Failure(Send_Email(pversion).buildfailure);


    Export Run_All := if( 
                    VersionControl.IsValidVersion(pversion),
                    full_build,
                    Output('No Valid version parameter passed, skipping build')
                    );


End;