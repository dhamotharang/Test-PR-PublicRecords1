﻿EXPORT Score_FIWN12103_0_NOSSN(fullDebugOutput=FALSE,landingZoneIP='Constants.LandingZoneIP',lzFilePathFolder='\'/data/LUCI/FIWN12103_0_NOSSN/\'',
                    fileLayout='\'fiwn12103_0_nossn.z_layouts\'',CSVSprayFile='\'FIWN12103_0_NOSSN_luci_validationfile.csv\'',CSVSprayHeaderLine=1,CSVSpraySeparator='\'|\'',
                    CSVSprayQuote='\'"\'',isCSVFile=FALSE,preSprayed=FALSE,sprayedFile='\'\'',deSpray=TRUE,deSpraySuffix='\'\'') := FUNCTIONMACRO
 Score_Model := MODULE
    IMPORT STD;
    SHARED Constants := fiwn12103_0_nossn.Constants;
    SHARED Layouts := #EXPAND(fileLayout);
    SHARED FNValidation := fiwn12103_0_nossn.FNValidationWithRC;

    /******************************************************************************\
    |**************************Step 0 - Spray Input File***************************|
    \******************************************************************************/
    SHARED ModelName      := 'FIWN12103_0_NOSSN';
    SHARED lzFilePath     := lzFilePathFolder + CSVSprayFile;
    #IF(sprayedFile)
    SHARED SprayCSVName 	:= sprayedFile; // Will set up by user if test file is a logical file.
    #ELSE
    SHARED SprayCSVName   := '~fiwn12103_0_nossn::' + (STRING)STD.Date.Today() + '::' + ModelName +'_from_csv';
    #END
    #IF(~preSprayed)
    EXPORT inputFileSprayed := fiwn12103_0_nossn.FNSpray(landingZoneIP, lzFilePath, SprayCSVName, CSVSpraySeparator, CSVSprayQuote);
    #END
    /******************************************************************************\
    |**************************Step 1a - Load Input File***************************|
    \******************************************************************************/
    FNValidation.MAC_inputFile(SprayCSVName, RawInputSet0, Layouts.Input_Layout, CSVSprayHeaderLine, isCSVFile, CSVSpraySeparator, CSVSprayQuote, FALSE);
    EXPORT RawInputSet := PROJECT(RawInputSet0, TRANSFORM(Layouts.Input_Layouts, SELF.do_FIWN12103_0_NOSSN := TRUE, SELF := LEFT));
    EXPORT OutInputSet := OUTPUT(RawInputSet,,NAMED('RawInput'));

    /******************************************************************************\
    |**************************Step 2 - Score Model********************************|
    \******************************************************************************/
    #IF(fullDebugOutput)
    EXPORT LUCIresults := fiwn12103_0_nossn.AppendAll_Debug(RawInputSet,do_FIWN12103_0_NOSSN,ADDRCHANGEDISTANCE,ADDRCHANGEECONTRAJECTORYINDEX,ADDRESSTYPE,ASSOCCOUNT,ASSOCDISTANCECLOSEST,ASSOCRISKLEVEL,COMPONENTCHARRISKLEVEL,CORRADDRDOBCT,CORRELATIONADDRNAMECOUNT,CORRELATIONPHONELASTNAMECOUNT,CORRELATIONRISKLEVEL,CORRNAMEDOBCT,CORRSEARCHNAMEPHONECT,CORRSEARCHVERNAMEPHONECT,CURRADDRAGEOLDEST,CURRADDRLENOFRES,CURRADDRSTATUS,C_ID1095_A1_NUMSSNVALID,C_ID10_D1_DEF,C_ID10_D1_UHP,C_ID120_A1_UHP,C_ID120_N1_UHP,C_ID120_P1_USSN,C_ID180_P1_NUMHPCELL,C_ID1825_A1_NUMADDSINGLE,C_ID1825_A1_NUMHPCELL,C_ID1825_A1_NUMHPLANDLINE,C_ID1825_A1_NUMSSNUNISSD,C_ID1825_D1_NUMHPCELL,C_ID1825_P1_NUMHPLANDLINE,C_ID1825_P1_NUMSSNVALID,C_ID30_A1_NUMHPLANDLINE,C_ID30_D1_NUMSSNVALID,C_ID3_D1_USSN,C_N0_D0_A0_PX_ID120_MR,C_N0_D0_A1_PX_ID1095_OD121_MR,C_N0_DX_AX_P0_ID1825_OD121_MR,C_N1_DX_AX_P0_ID30_DEF,C_NX_A1_P0_EX_ID1095_OD121_MR,C_NX_A1_P1_EX_ID1825_OD121_MR,C_NX_A1_PX_EX_ID1825_OD121_LR,C_NX_A1_PX_EX_ID1825_OD121_MR,C_NX_AX_PX_E0_ID1095_OD121_LR,C_NX_AX_PX_E0_ID120_LR,C_NX_AX_PX_E0_ID1825_OD121_LR,C_NX_AX_PX_E0_ID1825_OD121_MR,C_NX_AX_PX_E1_ID120_LR,C_NX_AX_PX_E1_ID1825_OD121_LR,C_NX_AX_PX_E1_ID1825_OD121_MR,C_NX_AX_PX_EX_ID365_OD121_LR,C_NX_D0_A0_PX_ID365_OD121_DEF,C_NX_D0_AX_PX_ID1095_OD121_LR,C_NX_D0_AX_PX_ID1825_OD121_MR,C_NX_D1_AX_P1_ID1825_OD121_MR,C_NX_DX_A1_P0_ID1095_OD121_LR,C_NX_DX_A1_P0_ID1825_OD121_LR,C_NX_DX_A1_P1_ID1095_OD121_DEF,C_NX_DX_AX_PX_ID1095_OD121_LR,C_NX_DX_AX_PX_ID30_NUM,C_SX_N0_AX_PX_ID1825_OD121_MR,C_SX_N0_D0_PX_IDANY_NUM,C_SX_N0_DX_PX_ID730_LR,C_SX_N1_AX_PX_ID1095_OD121_LR,C_SX_N1_AX_PX_ID1825_OD121_MR,C_SX_N1_D1_PX_IDANY_LR,C_SX_N1_DX_P1_ID730_LR,C_SX_N1_DX_P1_IDANY_LR,C_SX_N1_DX_PX_ID365_LR,C_SX_NX_A0_PX_ID1825_OD121_MR,C_SX_NX_A1_P0_ID120_LR,C_SX_NX_A1_PX_ID1095_OD121_LR,C_SX_NX_AX_P0_ID1825_OD121_MR,C_SX_NX_AX_PX_ID120_LR,C_SX_NX_AX_PX_ID120_MR,C_SX_NX_AX_PX_ID1825_OD121_MR,C_SX_NX_AX_PX_ID30_LR,C_SX_NX_AX_PX_ID365_OD121_MR,C_SX_NX_D0_P0_ID730_LR,C_SX_NX_D0_P1_IDANY_NUM,C_SX_NX_D0_PX_ID365_LR,C_SX_NX_D0_PX_ID730_LR,C_SX_NX_D1_P0_ID10_NUM,C_SX_NX_D1_P0_ID30_DEF,C_SX_NX_D1_P0_IDANY_LR,C_SX_NX_D1_P1_FIRSTIND,C_SX_NX_D1_P1_IDANY_LR,C_SX_NX_D1_PX_ID365_LR,C_SX_NX_D1_PX_ID730_LR,C_SX_NX_D1_PX_IDANY_LR,C_SX_NX_DX_P0_ID730_LR,C_SX_NX_DX_P1_ID365_LR,C_SX_NX_DX_P1_ID730_LR,C_SX_NX_DX_P1_IDANY_LR,C_SX_NX_DX_PX_ID365_NUM,C_SX_NX_DX_PX_ID730_LR,C_SX_NX_DX_PX_IDANY_LR,C_SX_NX_DX_PX_IDANY_NUM,DIVADDRIDENTITYCOUNT,DIVADDRIDENTITYMSOURCECOUNT,DIVADDRPHONECOUNT,DIVADDRSSNCOUNT,DIVADDRSSNMSOURCECOUNT,DIVPHONEIDENTITYCOUNT,DIVPHONEIDENTITYMSOURCECOUNT,EMAILCONTAINSPIIOFPERC,EMAILHOST,EMAILHOSTEXTENSION,EMAILLENGTH,EMAILPERCDIGIT,FRAUDA_CONFIRMEDFRAUD_NUM,FRAUDE_CONFIRMEDFRAUD_NUM,FRAUDP_CONFIRMEDFRAUD_NUM,IDENTITYAGEOLDEST,IDENTITYRECORDCOUNT,IDENTITYSOURCECOUNT,IDVERADDRCREDITBUREAUCOUNT,IDVERADDRESS,IDVERADDRESSASSOCCOUNT,IDVERADDRESSMATCHESCURRENT,IDVERADDRESSMATCHESCURRENTV2,IDVERADDRESSNOTCURRENT,IDVERADDRESSSOURCECOUNT,IDVERDOB,IDVERDOBSOURCECOUNT,IDVERPHONE,IDVERRISKLEVEL,INPUTADDRAGENEWEST,INPUTADDRAGEOLDEST,INPUTADDRDWELLTYPE,INPUTADDROCCUPANTOWNED,INPUTPHONETYPE,IPAREACODE,NINPDISTHPHZIP,NINPHPHIPDIST,NINPHPHZIPFLAG,NINPZIPIPDISTDEF,PREVADDRAGEOLDEST,PREVADDRLENOFRES,PRIMARYPH3,PRIMARYPH4,PRIMARYPHONETYPE,SEARCHADDRSEARCHCOUNT,SEARCHBANKINGSEARCHCOUNT,SEARCHCOUNT,SEARCHFRAUDSEARCHCOUNT,SEARCHHIGHRISKSEARCHCOUNT,SEARCHLOCATESEARCHCOUNT,SEARCHNONBANKSEARCHCTRECENCY,SEARCHPHONESEARCHCOUNT,SEARCHSSNBESTSEARCHCT,SOURCECREDITBUREAU,SOURCECREDITBUREAUAGECHANGE,SOURCECREDITBUREAUAGEOLDEST,SOURCECREDITBUREAUFSAGE,SOURCEDRIVERSLICENSE,SOURCEPROPERTY,SOURCEPUBLICRECORDCOUNT,SOURCERISKLEVEL,SOURCETYPECREDENTIALAGEOLDEST,SOURCETYPEOTHERAGEOLDEST,VALIDATIONPHONEPROBLEMS,VARIATIONADDRCHANGEAGE,VARIATIONIDENTITYCOUNT,VARIATIONLASTNAMECOUNT,VARIATIONRISKLEVEL,VARIATIONSEARCHSSNCOUNT,email_name_addr_verification,email_verification,emailpop,ipaddr,ipaddrpop,iptype,phone_ver_bureau,rc_disthphoneaddr,truedid);
    #ELSE
    EXPORT LUCIresults := fiwn12103_0_nossn.AppendAll(RawInputSet,do_FIWN12103_0_NOSSN,ADDRCHANGEDISTANCE,ADDRCHANGEECONTRAJECTORYINDEX,ADDRESSTYPE,ASSOCCOUNT,ASSOCDISTANCECLOSEST,ASSOCRISKLEVEL,COMPONENTCHARRISKLEVEL,CORRADDRDOBCT,CORRELATIONADDRNAMECOUNT,CORRELATIONPHONELASTNAMECOUNT,CORRELATIONRISKLEVEL,CORRNAMEDOBCT,CORRSEARCHNAMEPHONECT,CORRSEARCHVERNAMEPHONECT,CURRADDRAGEOLDEST,CURRADDRLENOFRES,CURRADDRSTATUS,C_ID1095_A1_NUMSSNVALID,C_ID10_D1_DEF,C_ID10_D1_UHP,C_ID120_A1_UHP,C_ID120_N1_UHP,C_ID120_P1_USSN,C_ID180_P1_NUMHPCELL,C_ID1825_A1_NUMADDSINGLE,C_ID1825_A1_NUMHPCELL,C_ID1825_A1_NUMHPLANDLINE,C_ID1825_A1_NUMSSNUNISSD,C_ID1825_D1_NUMHPCELL,C_ID1825_P1_NUMHPLANDLINE,C_ID1825_P1_NUMSSNVALID,C_ID30_A1_NUMHPLANDLINE,C_ID30_D1_NUMSSNVALID,C_ID3_D1_USSN,C_N0_D0_A0_PX_ID120_MR,C_N0_D0_A1_PX_ID1095_OD121_MR,C_N0_DX_AX_P0_ID1825_OD121_MR,C_N1_DX_AX_P0_ID30_DEF,C_NX_A1_P0_EX_ID1095_OD121_MR,C_NX_A1_P1_EX_ID1825_OD121_MR,C_NX_A1_PX_EX_ID1825_OD121_LR,C_NX_A1_PX_EX_ID1825_OD121_MR,C_NX_AX_PX_E0_ID1095_OD121_LR,C_NX_AX_PX_E0_ID120_LR,C_NX_AX_PX_E0_ID1825_OD121_LR,C_NX_AX_PX_E0_ID1825_OD121_MR,C_NX_AX_PX_E1_ID120_LR,C_NX_AX_PX_E1_ID1825_OD121_LR,C_NX_AX_PX_E1_ID1825_OD121_MR,C_NX_AX_PX_EX_ID365_OD121_LR,C_NX_D0_A0_PX_ID365_OD121_DEF,C_NX_D0_AX_PX_ID1095_OD121_LR,C_NX_D0_AX_PX_ID1825_OD121_MR,C_NX_D1_AX_P1_ID1825_OD121_MR,C_NX_DX_A1_P0_ID1095_OD121_LR,C_NX_DX_A1_P0_ID1825_OD121_LR,C_NX_DX_A1_P1_ID1095_OD121_DEF,C_NX_DX_AX_PX_ID1095_OD121_LR,C_NX_DX_AX_PX_ID30_NUM,C_SX_N0_AX_PX_ID1825_OD121_MR,C_SX_N0_D0_PX_IDANY_NUM,C_SX_N0_DX_PX_ID730_LR,C_SX_N1_AX_PX_ID1095_OD121_LR,C_SX_N1_AX_PX_ID1825_OD121_MR,C_SX_N1_D1_PX_IDANY_LR,C_SX_N1_DX_P1_ID730_LR,C_SX_N1_DX_P1_IDANY_LR,C_SX_N1_DX_PX_ID365_LR,C_SX_NX_A0_PX_ID1825_OD121_MR,C_SX_NX_A1_P0_ID120_LR,C_SX_NX_A1_PX_ID1095_OD121_LR,C_SX_NX_AX_P0_ID1825_OD121_MR,C_SX_NX_AX_PX_ID120_LR,C_SX_NX_AX_PX_ID120_MR,C_SX_NX_AX_PX_ID1825_OD121_MR,C_SX_NX_AX_PX_ID30_LR,C_SX_NX_AX_PX_ID365_OD121_MR,C_SX_NX_D0_P0_ID730_LR,C_SX_NX_D0_P1_IDANY_NUM,C_SX_NX_D0_PX_ID365_LR,C_SX_NX_D0_PX_ID730_LR,C_SX_NX_D1_P0_ID10_NUM,C_SX_NX_D1_P0_ID30_DEF,C_SX_NX_D1_P0_IDANY_LR,C_SX_NX_D1_P1_FIRSTIND,C_SX_NX_D1_P1_IDANY_LR,C_SX_NX_D1_PX_ID365_LR,C_SX_NX_D1_PX_ID730_LR,C_SX_NX_D1_PX_IDANY_LR,C_SX_NX_DX_P0_ID730_LR,C_SX_NX_DX_P1_ID365_LR,C_SX_NX_DX_P1_ID730_LR,C_SX_NX_DX_P1_IDANY_LR,C_SX_NX_DX_PX_ID365_NUM,C_SX_NX_DX_PX_ID730_LR,C_SX_NX_DX_PX_IDANY_LR,C_SX_NX_DX_PX_IDANY_NUM,DIVADDRIDENTITYCOUNT,DIVADDRIDENTITYMSOURCECOUNT,DIVADDRPHONECOUNT,DIVADDRSSNCOUNT,DIVADDRSSNMSOURCECOUNT,DIVPHONEIDENTITYCOUNT,DIVPHONEIDENTITYMSOURCECOUNT,EMAILCONTAINSPIIOFPERC,EMAILHOST,EMAILHOSTEXTENSION,EMAILLENGTH,EMAILPERCDIGIT,FRAUDA_CONFIRMEDFRAUD_NUM,FRAUDE_CONFIRMEDFRAUD_NUM,FRAUDP_CONFIRMEDFRAUD_NUM,IDENTITYAGEOLDEST,IDENTITYRECORDCOUNT,IDENTITYSOURCECOUNT,IDVERADDRCREDITBUREAUCOUNT,IDVERADDRESS,IDVERADDRESSASSOCCOUNT,IDVERADDRESSMATCHESCURRENT,IDVERADDRESSMATCHESCURRENTV2,IDVERADDRESSNOTCURRENT,IDVERADDRESSSOURCECOUNT,IDVERDOB,IDVERDOBSOURCECOUNT,IDVERPHONE,IDVERRISKLEVEL,INPUTADDRAGENEWEST,INPUTADDRAGEOLDEST,INPUTADDRDWELLTYPE,INPUTADDROCCUPANTOWNED,INPUTPHONETYPE,IPAREACODE,NINPDISTHPHZIP,NINPHPHIPDIST,NINPHPHZIPFLAG,NINPZIPIPDISTDEF,PREVADDRAGEOLDEST,PREVADDRLENOFRES,PRIMARYPH3,PRIMARYPH4,PRIMARYPHONETYPE,SEARCHADDRSEARCHCOUNT,SEARCHBANKINGSEARCHCOUNT,SEARCHCOUNT,SEARCHFRAUDSEARCHCOUNT,SEARCHHIGHRISKSEARCHCOUNT,SEARCHLOCATESEARCHCOUNT,SEARCHNONBANKSEARCHCTRECENCY,SEARCHPHONESEARCHCOUNT,SEARCHSSNBESTSEARCHCT,SOURCECREDITBUREAU,SOURCECREDITBUREAUAGECHANGE,SOURCECREDITBUREAUAGEOLDEST,SOURCECREDITBUREAUFSAGE,SOURCEDRIVERSLICENSE,SOURCEPROPERTY,SOURCEPUBLICRECORDCOUNT,SOURCERISKLEVEL,SOURCETYPECREDENTIALAGEOLDEST,SOURCETYPEOTHERAGEOLDEST,VALIDATIONPHONEPROBLEMS,VARIATIONADDRCHANGEAGE,VARIATIONIDENTITYCOUNT,VARIATIONLASTNAMECOUNT,VARIATIONRISKLEVEL,VARIATIONSEARCHSSNCOUNT,email_name_addr_verification,email_verification,emailpop,ipaddr,ipaddrpop,iptype,phone_ver_bureau,rc_disthphoneaddr,truedid);
    #END
    EXPORT OutResultSet := OUTPUT(CHOOSEN(LUCIresults, 100), NAMED('LUCIResults'));

    /******************************************************************************\
    |**************************Step 3 - Transform Results**************************|
    \******************************************************************************/
    #IF(deSpray)
    flatRCLayout := RECORD
        RECORDOF(LUCIresults) AND NOT [FIWN12103_0_NOSSN_Reasons #IF(fullDebugOutput), FIWN12103_0_NOSSN_OVERALL_Reasons #END];
        #IF(fullDebugOutput)
        STRING5 FIWN12103_0_NOSSN_OVERALL_Reason_1;
        STRING5 FIWN12103_0_NOSSN_OVERALL_Reason_2;
        STRING5 FIWN12103_0_NOSSN_OVERALL_Reason_3;
        STRING5 FIWN12103_0_NOSSN_OVERALL_Reason_4;
        STRING5 FIWN12103_0_NOSSN_OVERALL_Reason_5;
        STRING5 FIWN12103_0_NOSSN_OVERALL_Reason_6;

        #END
        STRING5 FIWN12103_0_NOSSN_Reason_1;
        STRING5 FIWN12103_0_NOSSN_Reason_2;
        STRING5 FIWN12103_0_NOSSN_Reason_3;
        STRING5 FIWN12103_0_NOSSN_Reason_4;
        STRING5 FIWN12103_0_NOSSN_Reason_5;
        STRING5 FIWN12103_0_NOSSN_Reason_6;

    END;

    flatRCLayout flattenRCs(LUCIresults le) := TRANSFORM
        #IF(fullDebugOutput)
        SELF.FIWN12103_0_NOSSN_OVERALL_Reason_1 := le.FIWN12103_0_NOSSN_OVERALL_Reasons[1];
        SELF.FIWN12103_0_NOSSN_OVERALL_Reason_2 := le.FIWN12103_0_NOSSN_OVERALL_Reasons[2];
        SELF.FIWN12103_0_NOSSN_OVERALL_Reason_3 := le.FIWN12103_0_NOSSN_OVERALL_Reasons[3];
        SELF.FIWN12103_0_NOSSN_OVERALL_Reason_4 := le.FIWN12103_0_NOSSN_OVERALL_Reasons[4];
        SELF.FIWN12103_0_NOSSN_OVERALL_Reason_5 := le.FIWN12103_0_NOSSN_OVERALL_Reasons[5];
        SELF.FIWN12103_0_NOSSN_OVERALL_Reason_6 := le.FIWN12103_0_NOSSN_OVERALL_Reasons[6];

        #END
        SELF.FIWN12103_0_NOSSN_Reason_1 := le.FIWN12103_0_NOSSN_Reasons[1];
        SELF.FIWN12103_0_NOSSN_Reason_2 := le.FIWN12103_0_NOSSN_Reasons[2];
        SELF.FIWN12103_0_NOSSN_Reason_3 := le.FIWN12103_0_NOSSN_Reasons[3];
        SELF.FIWN12103_0_NOSSN_Reason_4 := le.FIWN12103_0_NOSSN_Reasons[4];
        SELF.FIWN12103_0_NOSSN_Reason_5 := le.FIWN12103_0_NOSSN_Reasons[5];
        SELF.FIWN12103_0_NOSSN_Reason_6 := le.FIWN12103_0_NOSSN_Reasons[6];

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
    DesprayLUCIResult := fiwn12103_0_nossn.FNDesprayCSV(LUCIresultsFlat, TempLogical('~LUCI::ScoreResultsFile::' + ModelName), LandingZoneIP, lzDesprayFilePath('LUCI_' + ModelName + '_ScoreResultsFile'));
    #END

    EXPORT runScore := SEQUENTIAL(
                                #IF(~preSprayed) inputFileSprayed, #END
    							OutInputSet
    							,OutResultSet
    							#IF(deSpray), OutResultFlatSet, DesprayLUCIResult #END);
 END;
 RETURN Score_Model;
ENDMACRO;
