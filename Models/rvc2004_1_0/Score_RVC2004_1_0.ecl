EXPORT Score_RVC2004_1_0(fullDebugOutput=FALSE,landingZoneIP='Constants.LandingZoneIP',lzFilePathFolder='\'/data/LUCI/RVC2004_1_0/\'',
                    fileLayout='\'rvc2004_1_0.z_layouts\'',CSVSprayFile='\'RVC2004_1_0_luci_validationfile.csv\'',CSVSprayHeaderLine=1,CSVSpraySeparator='\'|\'',
                    CSVSprayQuote='\'"\'',isCSVFile=FALSE,preSprayed=FALSE,sprayedFile='\'\'',deSpray=TRUE,deSpraySuffix='\'\'') := FUNCTIONMACRO
 Score_Model := MODULE
    IMPORT STD;
    SHARED Constants := rvc2004_1_0.Constants;
    SHARED Layouts := #EXPAND(fileLayout);
    SHARED FNValidation := rvc2004_1_0.FNValidationWithRC;

    /******************************************************************************\
    |**************************Step 0 - Spray Input File***************************|
    \******************************************************************************/
    SHARED ModelName      := 'RVC2004_1_0';
    SHARED lzFilePath     := lzFilePathFolder + CSVSprayFile;
    #IF(sprayedFile)
    SHARED SprayCSVName 	:= sprayedFile; // Will set up by user if test file is a logical file.
    #ELSE
    SHARED SprayCSVName   := '~rvc2004_1_0::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv';
    #END
    #IF(~preSprayed)
    EXPORT inputFileSprayed := rvc2004_1_0.FNSpray(landingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
    #END
    /******************************************************************************\
    |**************************Step 1a - Load Input File***************************|
    \******************************************************************************/
    FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, CSVSprayHeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote, FALSE);
    EXPORT RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVC2004_1_0 := TRUE, SELF := LEFT));
    EXPORT OutInputSet := OUTPUT(RawInputSet,,NAMED('RawInput'));

    /******************************************************************************\
    |**************************Step 2 - Score Model********************************|
    \******************************************************************************/
    #IF(fullDebugOutput)
    EXPORT LUCIresults := rvc2004_1_0.AppendAll_Debug(RawInputSet,do_RVC2004_1_0,ChargeOffAmount,CollateralStatus,LoanType,OutOfStatuteIndicator,addrcurrentphoneservice,addrinputmatchindex,addrinputsubjectowned,addrprevioussubjectowned,addrprevioustimeoldest,confirmationsubjectfound,dayssince_OpenDate,dayssince_ReceivedDate,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    #ELSE
    EXPORT LUCIresults := rvc2004_1_0.AppendAll(RawInputSet,do_RVC2004_1_0,ChargeOffAmount,CollateralStatus,LoanType,OutOfStatuteIndicator,addrcurrentphoneservice,addrinputmatchindex,addrinputsubjectowned,addrprevioussubjectowned,addrprevioustimeoldest,confirmationsubjectfound,dayssince_OpenDate,dayssince_ReceivedDate,sourcecredheadertimeoldest,ssndeceased,subjectdeceased);
    #END
    EXPORT OutResultSet := OUTPUT(CHOOSEN(LUCIresults, 100), NAMED('LUCIResults'));

    /******************************************************************************\
    |**************************Step 3 - Transform Results**************************|
    \******************************************************************************/
    #IF(deSpray)
    flatRCLayout := RECORD
        RECORDOF(LUCIresults) AND NOT [RVC2004_1_0_Reasons #IF(fullDebugOutput), RVC2004_1_0_SCORECARD_model6_Reasons #END];
        #IF(fullDebugOutput)
        STRING5 RVC2004_1_0_SCORECARD_model6_Reason_1;
        STRING5 RVC2004_1_0_SCORECARD_model6_Reason_2;
        STRING5 RVC2004_1_0_SCORECARD_model6_Reason_3;
        STRING5 RVC2004_1_0_SCORECARD_model6_Reason_4;
        STRING5 RVC2004_1_0_SCORECARD_model6_Reason_5;

        #END
        STRING5 RVC2004_1_0_Reason_1;
        STRING5 RVC2004_1_0_Reason_2;
        STRING5 RVC2004_1_0_Reason_3;
        STRING5 RVC2004_1_0_Reason_4;
        STRING5 RVC2004_1_0_Reason_5;

    END;

    flatRCLayout flattenRCs(LUCIresults le) := TRANSFORM
        #IF(fullDebugOutput)
        SELF.RVC2004_1_0_SCORECARD_model6_Reason_1 := le.RVC2004_1_0_SCORECARD_model6_Reasons[1];
        SELF.RVC2004_1_0_SCORECARD_model6_Reason_2 := le.RVC2004_1_0_SCORECARD_model6_Reasons[2];
        SELF.RVC2004_1_0_SCORECARD_model6_Reason_3 := le.RVC2004_1_0_SCORECARD_model6_Reasons[3];
        SELF.RVC2004_1_0_SCORECARD_model6_Reason_4 := le.RVC2004_1_0_SCORECARD_model6_Reasons[4];
        SELF.RVC2004_1_0_SCORECARD_model6_Reason_5 := le.RVC2004_1_0_SCORECARD_model6_Reasons[5];

        #END
        SELF.RVC2004_1_0_Reason_1 := le.RVC2004_1_0_Reasons[1];
        SELF.RVC2004_1_0_Reason_2 := le.RVC2004_1_0_Reasons[2];
        SELF.RVC2004_1_0_Reason_3 := le.RVC2004_1_0_Reasons[3];
        SELF.RVC2004_1_0_Reason_4 := le.RVC2004_1_0_Reasons[4];
        SELF.RVC2004_1_0_Reason_5 := le.RVC2004_1_0_Reasons[5];

        SELF := le;
    END;

    EXPORT LUCIresultsFlat := PROJECT(LUCIresults, flattenRCs(LEFT));
    EXPORT OutResultFlatSet := OUTPUT(CHOOSEN(LUCIresultsFlat, 100), NAMED('LUCIResultsFlat'));
    #END
    #IF(deSpray)
    /******************************************************************************\
    |*************************Step5 - Despray the Results**************************|
    \******************************************************************************/
    dateString := (STRING)STD.Date.Today() + ''; //CYNDY: Using " + '' " to control version
    TempLogical(String LogicalName) := LogicalName + WORKUNIT;
    desprayName(STRING desprayNamePre) := desprayNamePre + dateString + deSpraySuffix + '.csv';
    lzDesprayFilePath(STRING desprayNamePre) := lzFilePathFolder + desprayName(desprayNamePre);
    DesprayLUCIResult := rvc2004_1_0.FNDesprayCSV(LUCIresultsFlat, TempLogical('~LUCI::ScoreResultsFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ScoreResultsFile'));
    #END

    EXPORT runScore := SEQUENTIAL(
                                #IF(~preSprayed) inputFileSprayed, #END
    							OutInputSet
    							,OutResultSet
    							#IF(deSpray), OutResultFlatSet, DesprayLUCIResult #END);
 END;
 RETURN Score_Model;
ENDMACRO;
