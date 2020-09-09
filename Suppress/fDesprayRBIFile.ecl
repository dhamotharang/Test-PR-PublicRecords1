
// CCPA-1058
// This attribute concatenates daily Opt Out input file with Minors file
// and despray it to where Opt Out file is dropped of by cdtools
IMPORT	tools,	_control,InsuranceHeader_Incremental;

EXPORT fDesprayRBIFile(String pVersion, string pHostname, string pTarget, string pContact ='\' \'') := FUNCTION 
                       //STRING pServerIP   = $.Constants.serverIP,
                       //STRING pDirectory  = $.Constants.OptOut().Directory) := FUNCTION

    ds_optout       := Suppress.Files.OptOut.Input_Raw(entry_type<>'ROWCOUNT');
    minor_file      := InsuranceHeader_Incremental.Files.Minors_Current_DS(entry_type<>'ROWCOUNT'); 

    Suppress.Layout_OptOut_In tx(minor_file L) := TRANSFORM
        SELF.STATE_ACT			:= L.State;
        SELF.DATE_OF_REQUEST	:= L.Date;
        SELF 					:= L;	
    END;

    // Transform Minor file to Opt Out format
    ds_minors       := PROJECT(minor_file, tx(LEFT));

    //Combined file for RBI
    rbi_file        := ds_optout  & ds_minors &
                       DATASET([{'ROWCOUNT',count(ds_optout)+count(ds_minors),'','',''}],
                                Suppress.Layout_OptOut_In) ;

    rbi_file_srt    := SORT(DISTRIBUTE(rbi_file,HASH(entry_type,lexid)),entry_type,LOCAL);
    thorFileName    := $.FileNames(pVersion).OptOut.OutFileToRBI;
    lzFileName      := pTarget+'/'+$.Constants.OptOut(pVersion).FileNameForRBI;
 
    // Create RBI output file on THOR
    out_rbi_file    := OUTPUT(rbi_file_srt,,thorFileName,CSV(HEADING(single), SEPARATOR('|'), QUOTE('')),OVERWRITE,COMPRESSED);

	despray_rbi_file := fileservices.Despray(thorFileName, pHostname, lzFileName,,,,TRUE);		

	RETURN SEQUENTIAL(
                out_rbi_file;
                despray_rbi_file;
                );

END;		
