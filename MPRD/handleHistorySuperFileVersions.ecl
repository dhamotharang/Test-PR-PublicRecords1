export handleHistorySuperFileVersions(inputHistorySuperFile, inputInFileSuperFile, pUseProd) := functionmacro
// this chunk of code is taken directly from Enclarity.Build_All - it seems to be working, but can be
// cleaned up a bit to make use of existing macros - DataServices, for instance.  
    /*=========================================================================================
    | Function: handleHistorySuperFileVersions
    |     This functionality is implemented as a functionmacro to account for the fact that
    |     ECL may get confused with multiple instances of local variables (even though this 
    |     is run in the context of a sequential list). A functionmacro inherently treats the
    |     the local variables as UNIQUENAMES.      
    |     This replaces the previous FileServices.AddSuperFile which blindly copied 
    |     the InFiles to the corresponding History Superfile. The requirement now is to restrict 
    |     the number of files in the history SuperFile to the current file and the last file 
    |     entered into the history SuperFile (i.e a maximum of two files). The current file 
    |     will be cleared from the corresponding 'in' SuperFile after the addition.
    |     As of today, there is no bounding on the number of files being entered into the 
    |     history SuperFile, so this processing assumes that there can be multiple (i.e. greater
    |     than two) current entries in the history SuperFile.
    |     The processing has to account for 0, 1, 2 and > 2 files currently resident in the 
    |     history SuperFile. Thus, it is possible that the file names could be an empty strings.
    |     
    | Preconditions:
    |     None
    |
    | Tokens:
    |     inputHistorySuperFile - the fully qualified name of the History SuperFile to
    |         be processed
    |     inputInFileSuperFile - the fully qualified name of the InFile SuperFile to 
    |         be processed
    |     pUseProd - a flag to alert the processing (really only on Dataland) as to
    |         whether or not to use the Production files. As a practical matter, attempting 
    |         to process Production files from Dataland will cause the program to crash.
    |
    | Return:
    |     true - a dummy return since the functionmacro requires a return.
    |
    | Notes:
    | [1] We are expecting that the files entered into the History SuperFile have been added
    |     in chronological order (i.e. the last one entered will show up as the last file in
    |     the list). 
    | [2] If you try to add a NULL file name to the SuperFile, it will store the qualifier
    |     for the cluster that you are operating on (for example, 'thor5_241_10a::')
    |
    +========================================================================================*/
    LoggingRecord := record
        string      Description;
        string      Text;
    end;

    export logMessage(string _Description, string _Text, string LogName) := 
            output(dataset([{_Description, _Text}], LoggingRecord), named (LogName), extend);

        // Determine the prefix to use for the superfile and subfile - this is really only
        // for when we are dealing with files on production and running on Dataland. 
        // Otherwise, the default is local ('~')
        filePrefix := if(pUseProd = true,
                         VersionControl.foreign_prod,
                         '~');

        // InFile SuperFile Housekeeping
        // There should be only one file in the list
        inFileFileList   := nothor(FileServices.SuperFileContents(inputInFileSuperFile));
        inputLogicalFile := inFileFileList[1].name;

        // History SuperFile Housekeeping 
        // There can be 0 to a large multiple number of files in the SuperFile
        historyFileList := nothor(FileServices.SuperFileContents(inputHistorySuperFile));
       
        // Save the last file added to the list - if there is no file, the call will
        // return a NULL string
        historyFileIndex := nothor(FileServices.GetSuperFileSubCount(inputHistorySuperFile));
        lastHistoryFile  := historyFileList[historyFileIndex].name;
        
        // Now save the next file in line for the case of a NULL LogicalFile input
        nextHistoryFile  := if(historyFileIndex > 1,
            historyFileList[historyFileIndex - 1].name,
            '');
        
        // ================== Debug information -  can be deleted later ============================
        output(historyFileList);

        if(lastHistoryFile = '',
             logMessage(inputHistorySuperFile, 'Last History File Is Null', 'LogOutput'),
             logMessage(inputHistorySuperFile, 'Last History File: ' + lastHistoryFile, 'LogOutput'));

        if(nextHistoryFile = '',
             logMessage(inputHistorySuperFile, 'Next History File Is Null', 'LogOutput'),
             logMessage(inputHistorySuperFile, 'Next History File: ' +  nextHistoryFile, 'LogOutput'));
        // ================================ End Debug Info =========================================
        
        // The system seems to know enough to ignore a NULL file, but it will 
        // bark if we don't qualify the proper path
        FileServices.RemoveSuperFile(inputHistorySuperFile, if(lastHistoryFile = '', lastHistoryFile, filePrefix + lastHistoryFile));
        FileServices.RemoveSuperFile(inputHistorySuperFile, if(nextHistoryFile = '', nextHistoryFile, filePrefix + nextHistoryFile));
       
        // Now kill all of the remaining files - this could be one or more
        FileServices.ClearSuperFile(inputHistorySuperFile, true);
        
        // Add the first file back (if it exists) and the new file to the Superfile list
        // Check if there is a valid input logical file        
        if(inputLogicalFile != '',
            // If there is a second history file that we saved, we should delete it            
            if(nextHistoryFile != '',
                FileServices.DeleteLogicalFile(filePrefix + nextHistoryFile)),
            // Since there is no valid input file, if there is a second file, we should 
            // add it back to the History SuperFile
            if(nextHistoryFile != '',
                FileServices.AddSuperFile(inputHistorySuperFile, filePrefix + nextHistoryFile)));
          
        // If the last file exists, add it to the SuperFile
        if(not lastHistoryFile = '', FileServices.AddSuperFile(inputHistorySuperFile, filePrefix + lastHistoryFile));
        
        // Finally, if the logical input file exists, add it to the SuperFile
        if(inputLogicalFile != '', FileServices.AddSuperFile(inputHistorySuperFile, filePrefix + inputLogicalFile));
        return true;      
    endmacro;