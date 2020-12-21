﻿EXPORT Score_RVG2005_0_1(fullDebugOutput=FALSE,landingZoneIP='Constants.LandingZoneIP',lzFilePathFolder='\'/data/LUCI/RVG2005_0_1/\'',
                    fileLayout='\'RVG2005_0_1.z_layouts\'',CSVSprayFile='\'RVG2005_0_1_luci_validationfile.csv\'',CSVSprayHeaderLine=1,CSVSpraySeparator='\'|\'',
                    CSVSprayQuote='\'"\'',isCSVFile=FALSE,preSprayed=FALSE,sprayedFile='\'\'',deSpray=TRUE,deSpraySuffix='\'\'') := FUNCTIONMACRO
 Score_Model := MODULE
    IMPORT STD;
    SHARED Constants := RVG2005_0_1.Constants;
    SHARED Layouts := #EXPAND(fileLayout);
    SHARED FNValidation := RVG2005_0_1.FNValidationWithRC;

    /******************************************************************************\
    |**************************Step 0 - Spray Input File***************************|
    \******************************************************************************/
    SHARED ModelName      := 'RVG2005_0_1';
    SHARED lzFilePath     := lzFilePathFolder + CSVSprayFile;
    #IF(sprayedFile)
    SHARED SprayCSVName 	:= sprayedFile; // Will set up by user if test file is a logical file.
    #ELSE
    SHARED SprayCSVName   := '~RVG2005_0_1::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv';
    #END
    #IF(~preSprayed)
    EXPORT inputFileSprayed := RVG2005_0_1.FNSpray(landingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
    #END
    /******************************************************************************\
    |**************************Step 1a - Load Input File***************************|
    \******************************************************************************/
    FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, CSVSprayHeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote, FALSE);
    EXPORT RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_RVG2005_0_1 := TRUE, SELF := LEFT));
    EXPORT OutInputSet := OUTPUT(RawInputSet,,NAMED('RawInput'));

    /******************************************************************************\
    |**************************Step 2 - Score Model********************************|
    \******************************************************************************/
    #IF(fullDebugOutput)
    EXPORT LUCIresults := RVG2005_0_1.AppendAll_Debug(RawInputSet,do_RVG2005_0_1,ADDRCHANGECOUNT03MONTH,ADDRCHANGECOUNT06MONTH,ADDRCHANGECOUNT12MONTH,ADDRCHANGECOUNT24MONTH,ADDRCHANGECOUNT60MONTH,ADDRCURRENTAVMVALUE,ADDRCURRENTDEEDMAILING,ADDRCURRENTDWELLTYPE,ADDRCURRENTDWELLTYPEINDEX,ADDRCURRENTLENGTHOFRES,ADDRCURRENTOWNERSHIPINDEX,ADDRCURRENTSUBJECTOWNED,ADDRCURRENTTAXMARKETVALUE,ADDRCURRENTTAXVALUE,ADDRINPUTAVMVALUE,ADDRINPUTDEEDMAILING,ADDRINPUTDWELLTYPE,ADDRINPUTLENGTHOFRES,ADDRINPUTMATCHINDEX,ADDRINPUTOWNERSHIPINDEX,ADDRINPUTPHONESERVICE,ADDRINPUTSUBJECTCOUNT,ADDRINPUTTAXMARKETVALUE,ADDRINPUTTAXVALUE,ADDRSTABILITYINDEX,ALERTREGULATORYCONDITION,ASSETPROPCURRENTCOUNT,ASSETPROPCURRENTTAXTOTAL,ASSETPROPEVERCOUNT,ASSETPROPPURCHASETIMEOLDEST,BANKRUPTCYCOUNT,BANKRUPTCYCOUNT24MONTH,BANKRUPTCYTIMENEWEST,CADCSAP_IBK_A1_D1095_DAYSLR,CADCSAP_IBK_A1_D1095_DAYSMR,CADCSAP_IBK_A1_D1095_NUM,CADCSAP_IBK_A1_D120_DAYSMR,CADCSAP_IBK_A1_D365_DAYSLR,CADCSAP_IBK_A1_D365_DAYSMR,CADCSAP_IBK_A1_D365_NUM,CADCSAP_IBK_A1_D90_DAYSMR,CADCSAP_IBK_P1_D1095_DAYSLR,CADCSAP_IBK_P1_D1095_DAYSMR,CADCSAP_IBK_P1_D365_DAYSLR,CADCSAP_IBK_PX_D1095_DAYSLR,CADCSAP_IBK_PX_D1095_DAYSMR,CADCSAP_IBK_PX_D1095_NUM,CADCSAP_IBK_PX_D365_DAYSLR,CADCSAP_IBK_PX_D365_DAYSMR,CADCSAP_IBK_S1_D1095_DAYSLR,CADCSAP_IBK_S1_D1095_DAYSMR,CADCSAP_IBK_S1_D120_DAYSMR,CADCSAP_IBK_S1_D365_DAYSLR,CADCSAP_IBK_S1_D365_DAYSMR,CADCSAP_IBK_S1_D365_NUM,CADCSAP_IPD_A1_D1095_DAYSLR,CADCSAP_IPD_A1_D1095_DAYSMR,CADCSAP_IPD_A1_D1095_NUM,CADCSAP_IPD_A1_D120_DAYSLR,CADCSAP_IPD_A1_D120_DAYSMR,CADCSAP_IPD_A1_D365_DAYSLR,CADCSAP_IPD_A1_D365_NUM,CADCSAP_IPD_A1_D90_DAYSLR,CADCSAP_IPD_A1_D90_DAYSMR,CADCSAP_IPD_P1_D1095_DAYSLR,CADCSAP_IPD_P1_D120_DAYSMR,CADCSAP_IPD_P1_D365_DAYSMR,CADCSAP_IPD_P1_D365_UADD,CADCSAP_IPD_P1_D90_DAYSMR,CADCSAP_IPD_PX_D1095_DAYSLR,CADCSAP_IPD_PX_D1095_DAYSMR,CADCSAP_IPD_PX_D1095_NUM,CADCSAP_IPD_PX_D1095_UADD,CADCSAP_IPD_PX_D120_DAYSLR,CADCSAP_IPD_PX_D120_DAYSMR,CADCSAP_IPD_PX_D120_NUM,CADCSAP_IPD_PX_D365_DAYSLR,CADCSAP_IPD_PX_D365_DAYSMR,CADCSAP_IPD_PX_D365_NUM,CADCSAP_IPD_PX_D365_UADD,CADCSAP_IPD_PX_D90_DAYSLR,CADCSAP_IPD_PX_D90_DAYSMR,CADCSAP_IPD_PX_D90_UADD,CADCSAP_IPD_S1_D1095_DAYSLR,CADCSAP_IPD_S1_D1095_DAYSMR,CADCSAP_IPD_S1_D1095_NUM,CADCSAP_IPD_S1_D1095_UADD,CADCSAP_IPD_S1_D120_DAYSLR,CADCSAP_IPD_S1_D120_DAYSMR,CADCSAP_IPD_S1_D120_NUM,CADCSAP_IPD_S1_D365_DAYSLR,CADCSAP_IPD_S1_D365_DAYSMR,CADCSAP_IPD_S1_D365_NUM,CADCSAP_IPD_S1_D90_DAYSLR,CADCSAP_IPD_S1_D90_DAYSMR,CADCSAP_IX_A1_D1095_DAYSLR,CADCSAP_IX_A1_D1095_DAYSMR,CADCSAP_IX_A1_D1095_NUM,CADCSAP_IX_A1_D120_DAYSLR,CADCSAP_IX_A1_D120_DAYSMR,CADCSAP_IX_A1_D120_NUM,CADCSAP_IX_A1_D365_DAYSLR,CADCSAP_IX_A1_D365_DAYSMR,CADCSAP_IX_A1_D365_NUM,CADCSAP_IX_A1_D90_DAYSLR,CADCSAP_IX_A1_D90_DAYSMR,CADCSAP_IX_P1_D1095_DAYSMR,CADCSAP_IX_P1_D1095_NUM,CADCSAP_IX_P1_D120_DAYSLR,CADCSAP_IX_P1_D120_NUM,CADCSAP_IX_P1_D365_DAYSLR,CADCSAP_IX_P1_D365_DAYSMR,CADCSAP_IX_P1_D90_DAYSMR,CADCSAP_IX_PX_D1095_DAYSLR,CADCSAP_IX_PX_D1095_DAYSMR,CADCSAP_IX_PX_D1095_NUM,CADCSAP_IX_PX_D1095_UADD,CADCSAP_IX_PX_D120_DAYSLR,CADCSAP_IX_PX_D120_DAYSMR,CADCSAP_IX_PX_D120_NUM,CADCSAP_IX_PX_D120_UADD,CADCSAP_IX_PX_D365_DAYSLR,CADCSAP_IX_PX_D365_DAYSMR,CADCSAP_IX_PX_D365_NUM,CADCSAP_IX_PX_D365_UADD,CADCSAP_IX_PX_D90_DAYSLR,CADCSAP_IX_PX_D90_DAYSMR,CADCSAP_IX_PX_D90_NUM,CADCSAP_IX_PX_D90_UADD,CADCSAP_IX_S1_D1095_DAYSLR,CADCSAP_IX_S1_D1095_DAYSMR,CADCSAP_IX_S1_D1095_NUM,CADCSAP_IX_S1_D1095_UADD,CADCSAP_IX_S1_D120_DAYSLR,CADCSAP_IX_S1_D120_DAYSMR,CADCSAP_IX_S1_D120_NUM,CADCSAP_IX_S1_D365_DAYSLR,CADCSAP_IX_S1_D365_DAYSMR,CADCSAP_IX_S1_D365_NUM,CADCSAP_IX_S1_D90_DAYSLR,CADCSAP_IX_S1_D90_DAYSMR,CADCSAP_IX_S1_D90_NUM,CONFIRMATIONINPUTADDRESS,CONFIRMATIONINPUTDOB,CONFIRMATIONINPUTSSN,CONFIRMATIONSUBJECTFOUND,CRIMINALNONFELONYCOUNT,CRIMINALNONFELONYTIMENEWEST,DEROGCOUNT,DEROGCOUNT12MONTH,DEROGTIMENEWEST,EDUCATIONATTENDANCE,EDUCATIONEVIDENCE,EDUCATIONINSTITUTIONPRIVATE,EDUCATIONINSTITUTIONRATING,EVICTIONCOUNT12MONTH,INPUTPROVIDEDPHONE,INPUTPROVIDEDSTREETADDRESS,INPUT_HOMEPHONE,INPUT_SSN,INPUT_STREETADDRESS,INQUIRYBANKING12MONTH,LIENJUDGMENTCOUNT,LIENJUDGMENTDOLLARTOTAL,LIENJUDGMENTTIMENEWEST,PHONEINPUTPROBLEMS,PROFLICTYPECATEGORY,SHORTTERMLOANREQUEST12MONTH,SOURCECREDHEADERTIMEOLDEST,SOURCENONDEROGCOUNT,SOURCENONDEROGCOUNT03MONTH,SOURCENONDEROGCOUNT06MONTH,SOURCENONDEROGCOUNT12MONTH,SSNPROBLEMS,SUBJECTRECORDTIMEOLDEST,SUBJECTSSNCOUNT);
    #ELSE
    EXPORT LUCIresults := RVG2005_0_1.AppendAll(RawInputSet,do_RVG2005_0_1,ADDRCHANGECOUNT03MONTH,ADDRCHANGECOUNT06MONTH,ADDRCHANGECOUNT12MONTH,ADDRCHANGECOUNT24MONTH,ADDRCHANGECOUNT60MONTH,ADDRCURRENTAVMVALUE,ADDRCURRENTDEEDMAILING,ADDRCURRENTDWELLTYPE,ADDRCURRENTDWELLTYPEINDEX,ADDRCURRENTLENGTHOFRES,ADDRCURRENTOWNERSHIPINDEX,ADDRCURRENTSUBJECTOWNED,ADDRCURRENTTAXMARKETVALUE,ADDRCURRENTTAXVALUE,ADDRINPUTAVMVALUE,ADDRINPUTDEEDMAILING,ADDRINPUTDWELLTYPE,ADDRINPUTLENGTHOFRES,ADDRINPUTMATCHINDEX,ADDRINPUTOWNERSHIPINDEX,ADDRINPUTPHONESERVICE,ADDRINPUTSUBJECTCOUNT,ADDRINPUTTAXMARKETVALUE,ADDRINPUTTAXVALUE,ADDRSTABILITYINDEX,ALERTREGULATORYCONDITION,ASSETPROPCURRENTCOUNT,ASSETPROPCURRENTTAXTOTAL,ASSETPROPEVERCOUNT,ASSETPROPPURCHASETIMEOLDEST,BANKRUPTCYCOUNT,BANKRUPTCYCOUNT24MONTH,BANKRUPTCYTIMENEWEST,CADCSAP_IBK_A1_D1095_DAYSLR,CADCSAP_IBK_A1_D1095_DAYSMR,CADCSAP_IBK_A1_D1095_NUM,CADCSAP_IBK_A1_D120_DAYSMR,CADCSAP_IBK_A1_D365_DAYSLR,CADCSAP_IBK_A1_D365_DAYSMR,CADCSAP_IBK_A1_D365_NUM,CADCSAP_IBK_A1_D90_DAYSMR,CADCSAP_IBK_P1_D1095_DAYSLR,CADCSAP_IBK_P1_D1095_DAYSMR,CADCSAP_IBK_P1_D365_DAYSLR,CADCSAP_IBK_PX_D1095_DAYSLR,CADCSAP_IBK_PX_D1095_DAYSMR,CADCSAP_IBK_PX_D1095_NUM,CADCSAP_IBK_PX_D365_DAYSLR,CADCSAP_IBK_PX_D365_DAYSMR,CADCSAP_IBK_S1_D1095_DAYSLR,CADCSAP_IBK_S1_D1095_DAYSMR,CADCSAP_IBK_S1_D120_DAYSMR,CADCSAP_IBK_S1_D365_DAYSLR,CADCSAP_IBK_S1_D365_DAYSMR,CADCSAP_IBK_S1_D365_NUM,CADCSAP_IPD_A1_D1095_DAYSLR,CADCSAP_IPD_A1_D1095_DAYSMR,CADCSAP_IPD_A1_D1095_NUM,CADCSAP_IPD_A1_D120_DAYSLR,CADCSAP_IPD_A1_D120_DAYSMR,CADCSAP_IPD_A1_D365_DAYSLR,CADCSAP_IPD_A1_D365_NUM,CADCSAP_IPD_A1_D90_DAYSLR,CADCSAP_IPD_A1_D90_DAYSMR,CADCSAP_IPD_P1_D1095_DAYSLR,CADCSAP_IPD_P1_D120_DAYSMR,CADCSAP_IPD_P1_D365_DAYSMR,CADCSAP_IPD_P1_D365_UADD,CADCSAP_IPD_P1_D90_DAYSMR,CADCSAP_IPD_PX_D1095_DAYSLR,CADCSAP_IPD_PX_D1095_DAYSMR,CADCSAP_IPD_PX_D1095_NUM,CADCSAP_IPD_PX_D1095_UADD,CADCSAP_IPD_PX_D120_DAYSLR,CADCSAP_IPD_PX_D120_DAYSMR,CADCSAP_IPD_PX_D120_NUM,CADCSAP_IPD_PX_D365_DAYSLR,CADCSAP_IPD_PX_D365_DAYSMR,CADCSAP_IPD_PX_D365_NUM,CADCSAP_IPD_PX_D365_UADD,CADCSAP_IPD_PX_D90_DAYSLR,CADCSAP_IPD_PX_D90_DAYSMR,CADCSAP_IPD_PX_D90_UADD,CADCSAP_IPD_S1_D1095_DAYSLR,CADCSAP_IPD_S1_D1095_DAYSMR,CADCSAP_IPD_S1_D1095_NUM,CADCSAP_IPD_S1_D1095_UADD,CADCSAP_IPD_S1_D120_DAYSLR,CADCSAP_IPD_S1_D120_DAYSMR,CADCSAP_IPD_S1_D120_NUM,CADCSAP_IPD_S1_D365_DAYSLR,CADCSAP_IPD_S1_D365_DAYSMR,CADCSAP_IPD_S1_D365_NUM,CADCSAP_IPD_S1_D90_DAYSLR,CADCSAP_IPD_S1_D90_DAYSMR,CADCSAP_IX_A1_D1095_DAYSLR,CADCSAP_IX_A1_D1095_DAYSMR,CADCSAP_IX_A1_D1095_NUM,CADCSAP_IX_A1_D120_DAYSLR,CADCSAP_IX_A1_D120_DAYSMR,CADCSAP_IX_A1_D120_NUM,CADCSAP_IX_A1_D365_DAYSLR,CADCSAP_IX_A1_D365_DAYSMR,CADCSAP_IX_A1_D365_NUM,CADCSAP_IX_A1_D90_DAYSLR,CADCSAP_IX_A1_D90_DAYSMR,CADCSAP_IX_P1_D1095_DAYSMR,CADCSAP_IX_P1_D1095_NUM,CADCSAP_IX_P1_D120_DAYSLR,CADCSAP_IX_P1_D120_NUM,CADCSAP_IX_P1_D365_DAYSLR,CADCSAP_IX_P1_D365_DAYSMR,CADCSAP_IX_P1_D90_DAYSMR,CADCSAP_IX_PX_D1095_DAYSLR,CADCSAP_IX_PX_D1095_DAYSMR,CADCSAP_IX_PX_D1095_NUM,CADCSAP_IX_PX_D1095_UADD,CADCSAP_IX_PX_D120_DAYSLR,CADCSAP_IX_PX_D120_DAYSMR,CADCSAP_IX_PX_D120_NUM,CADCSAP_IX_PX_D120_UADD,CADCSAP_IX_PX_D365_DAYSLR,CADCSAP_IX_PX_D365_DAYSMR,CADCSAP_IX_PX_D365_NUM,CADCSAP_IX_PX_D365_UADD,CADCSAP_IX_PX_D90_DAYSLR,CADCSAP_IX_PX_D90_DAYSMR,CADCSAP_IX_PX_D90_NUM,CADCSAP_IX_PX_D90_UADD,CADCSAP_IX_S1_D1095_DAYSLR,CADCSAP_IX_S1_D1095_DAYSMR,CADCSAP_IX_S1_D1095_NUM,CADCSAP_IX_S1_D1095_UADD,CADCSAP_IX_S1_D120_DAYSLR,CADCSAP_IX_S1_D120_DAYSMR,CADCSAP_IX_S1_D120_NUM,CADCSAP_IX_S1_D365_DAYSLR,CADCSAP_IX_S1_D365_DAYSMR,CADCSAP_IX_S1_D365_NUM,CADCSAP_IX_S1_D90_DAYSLR,CADCSAP_IX_S1_D90_DAYSMR,CADCSAP_IX_S1_D90_NUM,CONFIRMATIONINPUTADDRESS,CONFIRMATIONINPUTDOB,CONFIRMATIONINPUTSSN,CONFIRMATIONSUBJECTFOUND,CRIMINALNONFELONYCOUNT,CRIMINALNONFELONYTIMENEWEST,DEROGCOUNT,DEROGCOUNT12MONTH,DEROGTIMENEWEST,EDUCATIONATTENDANCE,EDUCATIONEVIDENCE,EDUCATIONINSTITUTIONPRIVATE,EDUCATIONINSTITUTIONRATING,EVICTIONCOUNT12MONTH,INPUTPROVIDEDPHONE,INPUTPROVIDEDSTREETADDRESS,INPUT_HOMEPHONE,INPUT_SSN,INPUT_STREETADDRESS,INQUIRYBANKING12MONTH,LIENJUDGMENTCOUNT,LIENJUDGMENTDOLLARTOTAL,LIENJUDGMENTTIMENEWEST,PHONEINPUTPROBLEMS,PROFLICTYPECATEGORY,SHORTTERMLOANREQUEST12MONTH,SOURCECREDHEADERTIMEOLDEST,SOURCENONDEROGCOUNT,SOURCENONDEROGCOUNT03MONTH,SOURCENONDEROGCOUNT06MONTH,SOURCENONDEROGCOUNT12MONTH,SSNPROBLEMS,SUBJECTRECORDTIMEOLDEST,SUBJECTSSNCOUNT);
    #END
    EXPORT OutResultSet := OUTPUT(CHOOSEN(LUCIresults, 100), NAMED('LUCIResults'));

    /******************************************************************************\
    |**************************Step 3 - Transform Results**************************|
    \******************************************************************************/
    #IF(deSpray)
    flatRCLayout := RECORD
        RECORDOF(LUCIresults) AND NOT [RVG2005_0_1_Reasons #IF(fullDebugOutput), RVG2005_0_1_OVERALL_Reasons #END];
        #IF(fullDebugOutput)
        STRING5 RVG2005_0_1_OVERALL_Reason_1;
        STRING5 RVG2005_0_1_OVERALL_Reason_2;
        STRING5 RVG2005_0_1_OVERALL_Reason_3;
        STRING5 RVG2005_0_1_OVERALL_Reason_4;
        STRING5 RVG2005_0_1_OVERALL_Reason_5;

        #END
        STRING5 RVG2005_0_1_Reason_1;
        STRING5 RVG2005_0_1_Reason_2;
        STRING5 RVG2005_0_1_Reason_3;
        STRING5 RVG2005_0_1_Reason_4;
        STRING5 RVG2005_0_1_Reason_5;

    END;

    flatRCLayout flattenRCs(LUCIresults le) := TRANSFORM
        #IF(fullDebugOutput)
        SELF.RVG2005_0_1_OVERALL_Reason_1 := le.RVG2005_0_1_OVERALL_Reasons[1];
        SELF.RVG2005_0_1_OVERALL_Reason_2 := le.RVG2005_0_1_OVERALL_Reasons[2];
        SELF.RVG2005_0_1_OVERALL_Reason_3 := le.RVG2005_0_1_OVERALL_Reasons[3];
        SELF.RVG2005_0_1_OVERALL_Reason_4 := le.RVG2005_0_1_OVERALL_Reasons[4];
        SELF.RVG2005_0_1_OVERALL_Reason_5 := le.RVG2005_0_1_OVERALL_Reasons[5];

        #END
        SELF.RVG2005_0_1_Reason_1 := le.RVG2005_0_1_Reasons[1];
        SELF.RVG2005_0_1_Reason_2 := le.RVG2005_0_1_Reasons[2];
        SELF.RVG2005_0_1_Reason_3 := le.RVG2005_0_1_Reasons[3];
        SELF.RVG2005_0_1_Reason_4 := le.RVG2005_0_1_Reasons[4];
        SELF.RVG2005_0_1_Reason_5 := le.RVG2005_0_1_Reasons[5];

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
    DesprayLUCIResult := RVG2005_0_1.FNDesprayCSV(LUCIresultsFlat, TempLogical('~LUCI::ScoreResultsFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ScoreResultsFile'));
    #END

    EXPORT runScore := SEQUENTIAL(
                                #IF(~preSprayed) inputFileSprayed, #END
    							OutInputSet
    							,OutResultSet
    							#IF(deSpray), OutResultFlatSet, DesprayLUCIResult #END);
 END;
 RETURN Score_Model;
ENDMACRO;
