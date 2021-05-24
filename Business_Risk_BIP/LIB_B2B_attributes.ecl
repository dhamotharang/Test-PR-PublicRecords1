IMPORT _Control, Business_Risk_BIP, PublicRecords_KEL, PublicRecords_KEL_Queries, Risk_Indicators;
IMPORT KEL11 AS KEL;

boolean use_library := NOT _Control.LibraryUse.ForceOff_B2B_attributes;

EXPORT LIB_B2B_attributes (
            DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
            Business_Risk_BIP.LIB_B2B_options Options,
            SET OF STRING2 AllowedSourcesSet) :=
#IF(use_library)
  MODULE, LIBRARY (Business_Risk_BIP.LIB_B2B_interface)
#OPTION('foldStored', TRUE);
#ELSE
  MODULE (Business_Risk_BIP.LIB_B2B_interface (Shell, Options, AllowedSourcesSet))
#END
#OPTION('expandSelectCreateRow', TRUE);

  BHBuildDate := Risk_Indicators.get_Build_date('bip_build_version');
  allowMarketing := IF(Options.MarketingMode = 1, TRUE, FALSE);
  AllowDNBDMI := IF(Options.AllowedSources = Business_Risk_BIP.Constants.AllowDNBDMI, TRUE, FALSE);

  PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII busInput(Business_Risk_BIP.Layouts.Shell le) := TRANSFORM

      SELF.G_ProcBusUID := le.Seq;
      SELF.B_InpClnArchDt := Business_Risk_BIP.Common.todaysDate(BHBuildDate, le.Clean_Input.HistoryDate);
      SELF.B_LexIDLegal := (Integer)le.Verification.InputIDMatchSeleID;
      SELF.B_LexIDUlt := (Integer)le.Verification.InputIDMatchUltID; // UltID
      SELF.B_LexIDOrg := (Integer)le.Verification.InputIDMatchOrgID; // OrgID
      SELF.B_LexIDSite := (Integer)le.Verification.InputIDMatchPowID;// PowID
      SELF.B_LexIDLoc := (Integer)le.Verification.InputIDMatchProxID;// ProxID
      SELF := [];

  END;

  BusinessInput := PROJECT(Shell, busInput(LEFT));

  KEL_Options := MODULE(PublicRecords_KEL.Interface_Options)

    EXPORT Data_Restriction_Mask := Options.DataRestrictionMask;
    EXPORT Data_Permission_Mask := Options.DataPermissionMask;
    EXPORT GLBAPurpose := Options.glb;
    EXPORT DPPAPurpose := Options.dppa;
    EXPORT Override_Experian_Restriction := Options.OverrideExperianRestriction;
    AllowedSources := Options.AllowedSources;
    EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_NONFCRA;
    EXPORT DATA57 KEL_Permissions_Mask := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
            Options.DataRestrictionMask,
            Options.DataPermissionMask,
            Options.glb,
            Options.dppa,
            FALSE, /* IsFCRA */
            allowMarketing,
            AllowDNBDMI,
            Options.OverrideExperianRestriction,
            '', /* IntendedPurpose - For FCRA Products Only */
            Options.industry_class,
            PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile,
            FALSE, /*IsInsuranceProduct*/
            PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_NONFCRA);

    EXPORT isMarketing := IF(Options.MarketingMode = 1, TRUE, FALSE);


  END;


		//default setting for keys is false, turn on only what is needed for attributes		
	JoinFlags := MODULE(PublicRecords_KEL.Join_Interface_Options);

		EXPORT BOOLEAN DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := TRUE;
		EXPORT BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids := TRUE;
	end;
	
   // BusinessInput := PROJECT(Input,Transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII BS Input to ECL_Functions.Layouts.LayoutInputBII - pop seq# and bip IDs.

  FDCDataset := PublicRecords_KEL.Fn_MAS_FDC(DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII),
                  KEL_Options,
                  JoinFlags,
                  BusinessInput);

  Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

  RecordsWithSeleID := BusinessInput(B_LexIDLegal > 0);
  RecordsWithoutSeleID := BusinessInput(B_LexIDLegal <= 0);

	LayoutBusinessSeleIDAttributes := PublicRecords_KEL_Queries.B2B_KEL.L_Compile.Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic_Res0_Layout; //DPM

  BusinessSeleAttributes_Results := NOCOMBINE(JOIN(BusinessInput, FDCDataset,
                                              LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
                                              TRANSFORM({INTEGER G_ProcBusUID, LayoutBusinessSeleIDAttributes},
                                                        NonFCRABusinessSeleIDResults := PublicRecords_KEL.Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1_Dynamic(
                                                          LEFT.B_LexIDUlt,
                                                          LEFT.B_LexIDOrg,
                                                          LEFT.B_LexIDLegal,
                                                          DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII),
                                                          DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII),
                                                          (INTEGER)LEFT.B_InpClnArchDt[1..8],
                                                          KEL_Options.KEL_Permissions_Mask, 
                                                          DATASET(RIGHT)).res0;
                                                        SELF.G_ProcBusUID := LEFT.G_ProcBusUID;
                                                        SELF := NonFCRABusinessSeleIDResults[1]), 
                                              LEFT OUTER, ATMOST(1000), KEEP(1)));


  BusinessSeleIDAttributesRaw := KEL.Clean(BusinessSeleAttributes_Results, TRUE, TRUE, TRUE);

  BusinessAttributesWithSeleID := JOIN(RecordsWithSeleID, BusinessSeleIDAttributesRaw,
    LEFT.G_ProcBusUID = RIGHT.G_ProcBusUID,
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutB2B,

      ResultsFound := RIGHT.B_LexIDLegal > 0 AND RIGHT.B_LexIDLegalSeenFlag = '1';

      //Tradeline Attributes
      SELF.G_BuildB2BDt := Risk_Indicators.get_Build_date('cortera_build_version');
      SELF.BE_B2BCntEv := IF(ResultsFound, RIGHT.BE_B2BCntEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCnt2Y := IF(ResultsFound, RIGHT.BE_B2BCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrCnt2Y := IF(ResultsFound, RIGHT.BE_B2BCarrCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltCnt2Y := IF(ResultsFound, RIGHT.BE_B2BFltCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatCnt2Y := IF(ResultsFound, RIGHT.BE_B2BMatCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsCnt2Y := IF(ResultsFound, RIGHT.BE_B2BOpsCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthCnt2Y := IF(ResultsFound, RIGHT.BE_B2BOthCnt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BCarrPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BFltPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BMatPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BOpsPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthPct2Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BOthPct2Y,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOldDtEv := IF(ResultsFound,(STRING)RIGHT.BE_B2BOldDtEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOldMsncEv := IF(ResultsFound,RIGHT.BE_B2BOldMsncEv,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOldDt2Y := IF(ResultsFound,RIGHT.BE_B2BOldDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BNewDt2Y := IF(ResultsFound,RIGHT.BE_B2BNewDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOldMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOldMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BNewMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BNewMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCnt := IF(ResultsFound, RIGHT.BE_B2BActvCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrCnt := IF(ResultsFound, RIGHT.BE_B2BActvCarrCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltCnt := IF(ResultsFound, RIGHT.BE_B2BActvFltCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatCnt := IF(ResultsFound, RIGHT.BE_B2BActvMatCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsCnt := IF(ResultsFound, RIGHT.BE_B2BActvOpsCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthCnt := IF(ResultsFound, RIGHT.BE_B2BActvOthCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvCarrPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvFltPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvMatPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOpsPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOthPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvCarrCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvFltCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvMatCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvOpsCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthCntA1Y := IF(ResultsFound, RIGHT.BE_B2BActvOthCntA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvCarrCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvFltCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvMatCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOpsCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthCntGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActvOthCntGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvBalTot := IF(ResultsFound,RIGHT.BE_B2BActvBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrBalTot := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltBalTot := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatBalTot := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsBalTot := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthBalTot := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTot,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrBalTotPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvCarrBalTotPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvFltBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvMatBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOpsBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthBalPct := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOthBalPct,2),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvCarrBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvFltBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvMatBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvOpsBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvOthBalTotRnge := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotRnge,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvFltBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvMatBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthBalAvg := IF(ResultsFound,RIGHT.BE_B2BActvOthBalAvg,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthBalTotA1Y := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotA1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvCarrBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvCarrBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvFltBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvFltBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvMatBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvMatBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOpsBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOpsBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvOthBalTotGrow1Y := IF(ResultsFound,ROUND(RIGHT.BE_B2BActvOthBalTotGrow1Y,4),PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActvBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvCarrBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvCarrBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvFltBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvFltBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvMatBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvMatBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvOpsBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvOpsBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvOthBalTotGrowIndx1Y := IF(ResultsFound,RIGHT.BE_B2BActvOthBalTotGrowIndx1Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BCarrBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BFltBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BMatBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BOpsBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthBalMax2Y := IF(ResultsFound,(INTEGER)RIGHT.BE_B2BOthBalMax2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BCarrBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BCarrBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BFltBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BFltBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BMatBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BMatBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOpsBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOpsBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOthBalMaxDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOthBalMaxDt2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BCarrBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BFltBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BMatBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOpsBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthBalMaxMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOthBalMaxMsnc2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BBalMaxSegType2Y := IF(ResultsFound,RIGHT.BE_B2BBalMaxSegType2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvWorstPerfIndx,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvCarrWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvCarrWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvFltWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvFltWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvMatWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvMatWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvOpsWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvOpsWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActvOthWorstPerfIndx := IF(ResultsFound,(STRING)RIGHT.BE_B2BActvOthWorstPerfIndx, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BActv1pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv1pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv31pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv31pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv61pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv61pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv91pDpdCnt := IF(ResultsFound, RIGHT.BE_B2BActv91pDpdCnt, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv1pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv1pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv31pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv31pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv61pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv61pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv91pDpdPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv91pDpdPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv1pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv1pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv31pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv31pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv61pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv61pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv91pDpdBalTot := IF(ResultsFound, RIGHT.BE_B2BActv91pDpdBalTot, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv1pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv1pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv31pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv31pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv61pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv61pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv91pDpdBalTotPct := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv91pDpdBalTotPct, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv1pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv1pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv31pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv31pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv61pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv61pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv91pDpdBalTotA1Y := IF(ResultsFound, RIGHT.BE_B2BActv91pDpdBalTotA1Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv1pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv1pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv31pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv31pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv61pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv61pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BActv91pDpdBalTotGrow1Y := IF(ResultsFound, ROUND(RIGHT.BE_B2BActv91pDpdBalTotGrow1Y, 4), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BWorstPerfIndx2Y,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BCarrWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BCarrWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BFltWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BFltWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BMatWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BMatWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOpsWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOpsWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOthWorstPerfIndx2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOthWorstPerfIndx2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BWorstPerfDt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BCarrWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BCarrWorstPerfDt2Y, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BFltWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BFltWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BMatWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BMatWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOpsWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOpsWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOthWorstPerfDt2Y := IF(ResultsFound,(STRING)RIGHT.BE_B2BOthWorstPerfDt2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BCarrWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BFltWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BMatWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOpsWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthWorstPerfMsnc2Y := IF(ResultsFound,RIGHT.BE_B2BOthWorstPerfMsnc2Y ,PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BCarrCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BFltCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BMatCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BOpsCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthCnt24Mc := IF(ResultsFound, RIGHT.BE_B2BOthCnt24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BCarrRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BCarrRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BFltRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BFltRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BMatRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BMatRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOpsRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BOpsRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BOthRecFlagByMonStr24Mc := IF(ResultsFound, RIGHT.BE_B2BOthRecFlagByMonStr24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA);
      SELF.BE_B2BRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BCarrRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BFltRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BMatRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BOpsRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthRecFlagByMonSum24Mc := IF(ResultsFound, RIGHT.BE_B2BOthRecFlagByMonSum24Mc, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BCarrBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BCarrBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BFltBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BFltBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BMatBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BMatBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOpsBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BOpsBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);
      SELF.BE_B2BOthBalVol24Mc := IF(ResultsFound, ROUND(RIGHT.BE_B2BOthBalVol24Mc, 2), PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT);

      SELF := LEFT,
      SELF := [];
    ),LEFT OUTER, KEEP(1));

  // Assign special values to records with no SeleID
  BusinessAttributesWithoutSeleID := PROJECT(RecordsWithoutSeleID,
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutB2B,
      SELF.G_BuildB2BDt := Risk_Indicators.get_Build_date('cortera_build_version');
      SELF.BE_B2BCntEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthCnt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthPct2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOldDtEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOldMsncEv := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOldDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BNewDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOldMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BNewMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthCntA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthCntGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthBalPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvCarrBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvFltBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvMatBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvOpsBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvOthBalTotRnge := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthBalAvg := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvCarrBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvFltBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvMatBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOpsBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvOthBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActvBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvCarrBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvFltBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvMatBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvOpsBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvOthBalTotGrowIndx1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthBalMax2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BCarrBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BFltBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BMatBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOpsBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOthBalMaxDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthBalMaxMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BBalMaxSegType2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvCarrWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvFltWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvMatWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvOpsWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActvOthWorstPerfIndx := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BActv1pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv31pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv61pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv91pDpdCnt := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv1pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv31pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv61pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv91pDpdPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv1pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv31pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv61pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv91pDpdBalTot := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv1pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv31pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv61pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv91pDpdBalTotPct := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv1pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv31pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv61pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv91pDpdBalTotA1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv1pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv31pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv61pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BActv91pDpdBalTotGrow1Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BCarrWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BFltWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BMatWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOpsWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOthWorstPerfIndx2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BCarrWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BFltWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BMatWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOpsWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOthWorstPerfDt2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthWorstPerfMsnc2Y := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthCnt24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BCarrRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BFltRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BMatRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOpsRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BOthRecFlagByMonStr24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF.BE_B2BRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthRecFlagByMonSum24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BCarrBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BFltBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BMatBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOpsBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.BE_B2BOthBalVol24Mc := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;

      // Attribute from NonFCRABusinessSeleIDNoDatesAttributesV1 KEL query
      SELF.B_LexIDLegalRstdOnlyFlag := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
      SELF := LEFT;
      SELF := []));

  BusinessSeleIDAttributes := SORT(BusinessAttributesWithoutSeleID + BusinessAttributesWithSeleID, G_ProcBusUID);

  // OUTPUT(BusinessAttributesWithSeleID,NAMED('BusinessAttributesWithSeleID'));
  // OUTPUT(BusinessSeleIDAttributes,NAMED('BusinessSeleIDAttributes'));
  // OUTPUT(BusinessInput,NAMED('BusinessInput'));
  // OUTPUT(Shell,NAMED('Shell'));

  EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutB2B) Results := BusinessSeleIDAttributes;

END;
