EXPORT Score_RVT2004_1_0(fullDebugOutput=FALSE,landingZoneIP='Constants.LandingZoneIP',lzFilePathFolder='\'/data/LUCI/RVT2004_1_0/\'',
                    fileLayout='\'rvt2004_1_0.z_layouts\'',CSVSprayFile='\'RVT2004_1_0_luci_validationfile.csv\'',CSVSprayHeaderLine=1,CSVSpraySeparator='\'|\'',
                    CSVSprayQuote='\'"\'',isCSVFile=FALSE,preSprayed=FALSE,sprayedFile='\'\'',deSpray=TRUE,deSpraySuffix='\'\'') := FUNCTIONMACRO
 Score_Model := MODULE
    IMPORT STD;
    SHARED Constants := rvt2004_1_0.Constants;
    SHARED Layouts := #EXPAND(fileLayout);
    SHARED FNValidation := rvt2004_1_0.FNValidationWithRC;

    /******************************************************************************\
    |**************************Step 0 - Spray Input File***************************|
    \******************************************************************************/
    SHARED ModelName      := 'RVT2004_1_0';
    SHARED lzFilePath     := lzFilePathFolder + CSVSprayFile;
    #IF(sprayedFile)
    SHARED SprayCSVName 	:= sprayedFile; // Will set up by user if test file is a logical file.
    #ELSE
    SHARED SprayCSVName   := '~rvt2004_1_0::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv';
    #END
    #IF(~preSprayed)
    EXPORT inputFileSprayed := rvt2004_1_0.FNSpray(landingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
    #END
    /******************************************************************************\
    |**************************Step 1a - Load Input File***************************|
    \******************************************************************************/
    FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, CSVSprayHeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote, FALSE);
    EXPORT RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVT2004_1_0 := TRUE, SELF := LEFT));
    EXPORT OutInputSet := OUTPUT(RawInputSet,,NAMED('RawInput'));

    /******************************************************************************\
    |**************************Step 2 - Score Model********************************|
    \******************************************************************************/
    #IF(fullDebugOutput)
    EXPORT LUCIresults := rvt2004_1_0.AppendAll_Debug(RawInputSet,do_RVT2004_1_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropevercount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    #ELSE
    EXPORT LUCIresults := rvt2004_1_0.AppendAll(RawInputSet,do_RVT2004_1_0,addrchangecount60month,addrcurrentownershipindex,addronfilecount,addrprevioustimeoldest,alertregulatorycondition,assetpropevercount,bankruptcystatus,confirmationsubjectfound,evictioncount,inquiryauto12month,inquirybanking12month,inquirycollections12month,inquiryshortterm12month,lienjudgmentcount,shorttermloanrequest,sourcenonderogcount,sourcenonderogcount06month,ssndeceased,subjectdeceased,subjectrecordtimeoldest);
    #END
    EXPORT OutResultSet := OUTPUT(CHOOSEN(LUCIresults, 100), NAMED('LUCIResults'));

    /******************************************************************************\
    |**************************Step 3 - Transform Results**************************|
    \******************************************************************************/
    #IF(deSpray)
    flatRCLayout := RECORD
        RECORDOF(LUCIresults) AND NOT [RVT2004_1_0_Reasons #IF(fullDebugOutput), RVT2004_1_0_SCORECARD_model110_Reasons #END];
        #IF(fullDebugOutput)
        STRING5 RVT2004_1_0_SCORECARD_model110_Reason_1;
        STRING5 RVT2004_1_0_SCORECARD_model110_Reason_2;
        STRING5 RVT2004_1_0_SCORECARD_model110_Reason_3;
        STRING5 RVT2004_1_0_SCORECARD_model110_Reason_4;
        STRING5 RVT2004_1_0_SCORECARD_model110_Reason_5;

        #END
        STRING5 RVT2004_1_0_Reason_1;
        STRING5 RVT2004_1_0_Reason_2;
        STRING5 RVT2004_1_0_Reason_3;
        STRING5 RVT2004_1_0_Reason_4;
        STRING5 RVT2004_1_0_Reason_5;

    END;

    flatRCLayout flattenRCs(LUCIresults le) := TRANSFORM
        #IF(fullDebugOutput)
        SELF.RVT2004_1_0_SCORECARD_model110_Reason_1 := le.RVT2004_1_0_SCORECARD_model110_Reasons[1];
        SELF.RVT2004_1_0_SCORECARD_model110_Reason_2 := le.RVT2004_1_0_SCORECARD_model110_Reasons[2];
        SELF.RVT2004_1_0_SCORECARD_model110_Reason_3 := le.RVT2004_1_0_SCORECARD_model110_Reasons[3];
        SELF.RVT2004_1_0_SCORECARD_model110_Reason_4 := le.RVT2004_1_0_SCORECARD_model110_Reasons[4];
        SELF.RVT2004_1_0_SCORECARD_model110_Reason_5 := le.RVT2004_1_0_SCORECARD_model110_Reasons[5];

        #END
        SELF.RVT2004_1_0_Reason_1 := le.RVT2004_1_0_Reasons[1];
        SELF.RVT2004_1_0_Reason_2 := le.RVT2004_1_0_Reasons[2];
        SELF.RVT2004_1_0_Reason_3 := le.RVT2004_1_0_Reasons[3];
        SELF.RVT2004_1_0_Reason_4 := le.RVT2004_1_0_Reasons[4];
        SELF.RVT2004_1_0_Reason_5 := le.RVT2004_1_0_Reasons[5];

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
    DesprayLUCIResult := rvt2004_1_0.FNDesprayCSV(LUCIresultsFlat, TempLogical('~LUCI::ScoreResultsFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ScoreResultsFile'));
    #END

    EXPORT runScore := SEQUENTIAL(
                                #IF(~preSprayed) inputFileSprayed, #END
    							OutInputSet
    							,OutResultSet
    							#IF(deSpray), OutResultFlatSet, DesprayLUCIResult #END);
 END;
 RETURN Score_Model;
ENDMACRO;
