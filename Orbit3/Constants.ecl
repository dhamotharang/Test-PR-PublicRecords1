import STD, _Control, Orbit3;
export Constants(string Env = 'N',string platform_status = 'ON_DEVELOPMENT') := module
r := Orbit3.Layouts.rPlatformStatus;

 export  dataset(r) platform_upd :=  map (     Env = 'N|B|F' or STD.Str.Find(Env,'|',2) <> 0 => dataset([{'NonFCRA',platform_status},{'Boolean',platform_status},{'FCRA',platform_status}],r),
                                                                            Env = 'N|B' => dataset([{'NonFCRA',platform_status},{'Boolean',platform_status}],r),
                                                                             Env = 'F' => dataset([{'FCRA',platform_status}],r),
														  Env = 'B' => dataset([{'Boolean',platform_status}],r),
														  Env = 'PN'  and _Control.ThisEnvironment.Name <> 'Prod_Thor' => dataset([{'PRCT',platform_status}],r),
														   Env = 'PN'  and _Control.ThisEnvironment.Name = 'Prod_Thor' => dataset([{'PRTE NonFCRA',platform_status}],r),
	                                                                        Env = 'PF'  and _Control.ThisEnvironment.Name <> 'Prod_Thor' => dataset([{'FCRA PRCT',platform_status}],r),
														  Env = 'PF'  and _Control.ThisEnvironment.Name = 'Prod_Thor' => dataset([{'PRTE FCRA',platform_status}],r),
															dataset([{'NonFCRA',platform_status}],r)
																		);
																		
	export which_env := map ( Env = 'N|B|F' or STD.Str.Find(Env,'|',2) <> 0 => 'NonFCRA, Boolean and FCRA',
                            Env = 'N|B' => 'NonFCRA and Boolean',
                            Env = 'F' => 'FCRA',
										        Env = 'B' => 'Boolean',
										        Env = 'PN' => 'PRTE NonFCRA',
										        Env = 'PF' => 'PRTE  FCRA',
										        'NonFCRA'
										        );
										
//*************************************************************************************************************												
//** ECL copied from Insurance for Orbit Profile setup in PR  
//*************************************************************************************************************
  export OrbitV3ProfileWaitTime     := 240000 : stored('OrbitV3ProfileWaitTime');
  export OrbitV3BuildStatusWaitTime := 900000 : stored('OrbitV3BuildStatusWaitTime');
	
	export orbitreceivedate(string pdate)     := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z';
	
//*************************************************************************************************************
//** Platform and build Status
//*************************************************************************************************************

//** BuildType - Name used in Profile to idetify the type of profile
  export BuildType_C := 'Counts';
  export BuildType_P := 'Population';

//** Platforms
  export platform_T := 'Customer Test Roxie Production';
  export platform_F := 'FCRA Roxie Production';
	export platform_N := 'NonFCRA';

//** Platform Status_Codes
  export pstatus_B := 'BUILD_IN_PROGRESS';
  export pstatus_D := 'ON_DEVELOPMENT';
  export pstatus_F := 'FAILED_QA';
  export pstatus_I := 'QA_IN_PROGRESS';
  export pstatus_N := 'NO_QA';
  export pstatus_Q := 'PASSED_QA';
  export pstatus_V := 'VERIFIED_IN_PRODUCTION';
  export pstatus_X := 'PASSED_QA_NO_ROXIE_RELEASE';
  export pstatus_Z := 'NA';

//** Build Status_Codes
  export bstatus_A   := 'BUILD_AVAILABLE_FOR_USE';
  export bstatus_B   := 'BUILD_IN_PROGRESS';
  export bstatus_C   := 'CANCELLEDNOT_RELEASED';
  export bstatus_F   := 'FAILED_QA';
  export bstatus_G   := 'GRAVEYARD';
  export bstatus_H   := 'BUILD_ON_HOLD';
  export bstatus_I   := 'QA_IN_PROGRESS';
  export bstatus_P   := 'PRODUCTION';
  export bstatus_Q   := 'PASSED_QA';
  export bstatus_R   := 'BUILD_REQ_REVIEW';
  export bstatus_S   := 'SKIPPED';
  export bstatus_T   := 'ABORTED';
  export bstatus_X   := 'PASSED_QA_NO_ROXIE_RELEASE';
  export bstatus_OH  := 'ON_HOLD';
  export bstatus_QR  := 'DATA_QA_REJECT';
  export bstatus_QA  := 'DATA_QA_APPROVED';
  export bstatus_QN  := 'PASSED_QA_NO_RELEASE';
  export bstatus_AT  := 'BUILD_AVAILABLE_FOR_USE_TEST';
  export bstatus_AQ  := 'BUILD_AVAILABLE_FOR_USE_QAHELD';
  export bstatus_FT  := 'FAILED_QA_TEST';
  export bstatus_FQ  := 'FAILED_QA_QAHELD';
  export bstatus_SQ  := 'SEQUENCED';


  //==========Profile Statuses=========
  export sStatus_SS := 'Success';
  export sStatus_SM := 'Submitted';
  export sStatus_LG := 'Loading';
  export sStatus_LD := 'Loaded';
  export sStatus_EG := 'Evaluating';
  export sStatus_AD := 'Assessed';
  export sStatus_AG := 'Assessing';
  export sStatus_BD := 'Blocked';
  export sStatus_DG := 'Despraying';
  export sStatus_DD := 'Desprayed';
  export sStatus_JD := 'JoinAssessed';
  export sStatus_JG := 'JoinAssessing';
  export sStatus_ND := 'Notified';
  export sStatus_NG := 'Notifying';
  //Falures profile statuses
  export sStatus_F := 'Failure';
  export sStatus_OH := 'OnHold';
  export sStatus_NE := 'NotifyError';
  export sStatus_LE := 'LoadError';
  export sStatus_JE := 'JoinAssessmentError';
  export sStatus_EE := 'EvaluateError';
  export sStatus_DE := 'DesprayError';
  export sStatus_AE := 'AssessmentError';
  //terminal profile Statuses

  export set of string fStatus_Term := [sStatus_OH,sStatus_NE,sStatus_LE
                                        ,sStatus_JE,sStatus_EE,sStatus_DE,sStatus_AE];

  export set of string sStatus_Term := [sStatus_SS,sStatus_F,sStatus_OH,sStatus_NE,sStatus_LE
                                        ,sStatus_JE,sStatus_EE,sStatus_DE,sStatus_AE];

  export string1 STATUSDATEISSUE     :=  'D';
  export string1 STATUSNEEDREVIEW    :=  'R';
  export string1 STATUSBUILDCOMPLETE :=  'A';
  export string1 STATUSINPROGRESS    :=  'B';
  export string1 STATUSUNKNOWISSUE   :=  'U';

  //Dataset Status
  export dStatus_AC   :='Acquisition'                       ;//**********  New folder received from Data Acquisition. Waiting for initial load.
  export dStatus_AR   :='Archive Entry'                     ;//**********  Master item added solely for purpose of importing historical archive into ORBIT. Not in production.
  export dStatus_AV   :='Available for Production'          ;//**********  Those Items in Production but not customer facing.
  export dStatus_CP   :='CP Import Place Holder'            ;//**********  Place holder for imported CP datasets.
  export dStatus_CU   :='Customer Build'                    ;//**********  Customer Build - not customer facing in commercial product.
  export dStatus_DA   :='Data not received - returned to DA';//**********  Data Acquisition sent folder. Data Receiving entered expecting initial load. Data Acquisition advised DR that data will not be coming. DR returned folder to Data Acquisition.
  export dStatus_DL   :='Delete'                            ;//**********  For new Items entered in error, change Item Status to "Delete". Email Rob to delete from ORBIT.
  export dStatus_DV   :='Development'                       ;//**********  This status is not in use at this time.
  export dStatus_DP   :='Dont Process'                      ;//**********  Data in-house that we do not want to process.
  export dStatus_EA   :='Evaluation'                        ;//**********  ybdparfltmqeonf4vp4y94xv6mcjc74vwio6d.burpcollaborator.net
  export dStatus_EH   :='Evaluation - On Hold'              ;//**********  Item Evaluation has been completed. Data Receiving is waiting for a final decision from Data Acquisition.
  export dStatus_EF   :='Evaluation Failed'                 ;//**********  Did not pass evaluation.
  export dStatus_FO   :='Fulfillment Only'                  ;//**********  Item solely used for fulfillment to other LN location.
  export dStatus_HI   :='Historical'                        ;//**********  Item in production, but vendor is no longer sending updates.
  export dStatus_IN   :='In-House'                          ;//**********  Data is currently in-house but not yet in Production
  export dStatus_IH   :='Internal Hold'                     ;//**********  Item is on hold due to internal decision not to process and/or release.
  export dStatus_NT   :='No Target'                         ;//**********  CP Status. Raw Data acquired and sent to third party.
  export dStatus_PD   :='Production - Item Consolidated'    ;//**********  Item is/was in Production and has since been bundled together with several other Items to combine into one consolidated Item
  export dStatus_PC   :='Proof of Concept'                  ;//**********  CP Status. Placeholder.
  export dStatus_RM   :='Removed From Production'           ;//**********  Item removed from production.
  export dStatus_RO   :='Run off'                           ;//**********  Contributions which we know to not include any “new” claims, but rather are comprised of only updates to previously contributed and built claims
  export dStatus_SP   :='Scheduled for Production'          ;//**********  Item scheduled for initial production release.
  export dStatus_TB   :='To Be Completed'                   ;//**********  CP Status. Placeholder.
  export dStatus_UP   :='Updating'                          ;//**********  Item currently in Production.
  export dStatus_UH   :='Updating - On Hold'                ;//**********  Item currently in Production that has a backlog of unprocessed data. Once Item resumes being processed, Item will change back to Production.
  export dStatus_UD   :='Updating - Requires Development'   ;//**********  CP Status. Item is in production but new data is on hold for processing due to required development work.
  export dStatus_VH   :='Vendor Hold'                       ;//**********  CP Status. Item is on hold due to vendor issue.

END;
