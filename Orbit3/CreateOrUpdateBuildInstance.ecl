//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
IMPORT ORBIT3;
EXPORT CreateOrUpdateBuildInstance(STRING pdate
                                  ,STRING pMasterbuildname //CarrierDiscovery.Orbit3Constants().masterbuildname
                                  ,STRING pBuildname
                                  ,STRING bstatus = 'BUILD_AVAILABLE_FOR_USE'
                                  ,BOOLEAN runcreatebuild = FALSE
                                  ,DATASET(Orbit3.Layouts.OrbitPlatformUpdateLayout) platform = DATASET([], Orbit3.Layouts.OrbitPlatformUpdateLayout)
                                  ,BOOLEAN pExcludeFromScorecard = FALSE
                                  ,STRING pEmailList = 'DataDevelopment-Ins@lexisnexis.com;InsDataOps@risk.lexisnexis.com'
                                  ,STRING pFromEmail = 'Orbit3SOA.CreateOrUpdateBuildInstance@lexisnexisrisk.com'
                                  ,STRING pBuildView = ''
                                  ,BOOLEAN addComponentsToBuild = TRUE
                                  ) := FUNCTION
IMPORT STD, _control;
  wuid                   := WORKUNIT;
  tokenval               := Orbit3.GetToken():INDEPENDENT;
  startdate              := Orbit3.Constants().orbitreceivedate(pdate);

  createbuild1 := IF(COUNT(platform) > 0
                                ,Orbit3.CreateBuildV2( tokenval                               //pLoginToken
                                                      ,TRIM(pMasterbuildname,LEFT,RIGHT)      //pMasterBuild
                                                      ,TRIM(pBuildname,LEFT,RIGHT)            //pBuildName
                                                      ,pdate                                  //pBuildVersion
                                                      ,startdate                              //pStartDate
                                                      ,pExcludeFromScorecard                  //pExcludeFromScorecard
                                                      ,wuid                                   //pHPCCWorkunit
                                                      ,bstatus                                //pBuildStatus
                                                      ,1                                      //pNewCoverage
                                                      ,'N/A'                                  //pVolume
                                                      ,platform                               //pPlatform
                                                    )
                               ,Orbit3.CreateBuildV2(tokenval                                 //pLoginToken
                                                      ,TRIM(pMasterbuildname,LEFT,RIGHT)      //pMasterBuild
                                                      ,TRIM(pBuildname,LEFT,RIGHT)            //pBuildName
                                                      ,pdate                                  //pBuildVersion
                                                      ,startdate                              //pStartDate
                                                      ,pExcludeFromScorecard                  //pExcludeFromScorecard
                                                      ,wuid                                   //pHPCCWorkunit
                                                      ,bstatus                                //pBuildStatus
                                                      ,1                                      //pNewCoverage
                                                      ,'N/A'                                  //pVolume
                                                    )
                         ):INDEPENDENT;

   lGetBuildInstance    :=  Orbit3.GetBuildInstanceV2(tokenval,TRIM(pMasterbuildname,LEFT,RIGHT),pdate);

   GetBuildID           := IF(runcreatebuild,
                             (STRING)createbuild1.CreateBuildResponse.CreateBuildResult.Result.RecordResponseCreateBuild.Result.BuildID,
                             (STRING)lGetBuildInstance.BuildInstanceId);

   lCandidates          := Orbit3.GetBuildCandidates(pMasterbuildname,pdate,tokenval,(STRING)GetBuildID) : INDEPENDENT;
   lBuildCandidates     := lCandidates(ComponentType = 'BuildInstance');
   lReceiveCandidates   := lCandidates(ComponentType = 'ReceiveInstance');

   laddcomponents       :=    Orbit3.AddBuildInstanceComponents(tokenval                              //pLoginToken
                                                                ,TRIM(pBuildname,LEFT,RIGHT)  //pBuildName
                                                                ,pdate                        //pBuildVersion
                                                                ,(STRING)GetBuildID           //pBuildInstanceId
                                                                ,(STRING)pEmailList           //pEmailList
                                                                ,lReceiveCandidates           //For DATA builds that truly have datasets added to them.
                                                                ,lBuildCandidates             //For DATA builds that have builds added to them.
                                                                );
   //used to update roxie key
   lUpdateBuildInstanceNO := OUTPUT(Orbit3.UpdateBuildInstanceV2(tokenval
                                                                 ,TRIM(pBuildname,LEFT,RIGHT)
                                                                 , pdate
                                                                 , wuid
                                                                 , bstatus
                                                                 ));

  //named() on output would be nice here; but this can be called more than once in a build and needs a constant unique name per call.
  lUpdateBuildInstance    :=  OUTPUT(Orbit3.UpdateBuildInstanceV2(tokenval
                                                                  ,TRIM(pBuildname,LEFT,RIGHT)
                                                                  , pdate
                                                                  , wuid
                                                                  , bstatus
                                                                  , platform
                                                                 ));

  sendEmail := STD.System.Email.SendEmail ( (STRING)pEmailList
                                           , _control.ThisEnvironment.Name + ': ' + WORKUNIT + ' ' + TRIM(pMasterbuildname,ALL) + ' Orbit3 Create Build:'+ pdate +': Failed'
                                           , 'Orbit3 Create Build failed. Reason: ' + createbuild1.CreateBuildResponse.CreateBuildResult.Result.RecordResponseCreateBuild.Message
                                           , , , pFromEmail );

  getStat := createbuild1.CreateBuildResponse.CreateBuildResult.Status = 'Success';

 RETURN ORDERED(MAP( runcreatebuild  AND getStat AND addComponentsToBuild => ORDERED(OUTPUT(Dataset(createbuild1),NAMED('CreateBuildResults'), EXTEND),laddcomponents)
                    ,runcreatebuild  AND getStat   => OUTPUT(DATASET(createbuild1),NAMED('CreateBuildResults'), EXTEND)
                    ,runcreatebuild                => ORDERED(OUTPUT(DATASET([{'Create Build Failed'}],{STRING message}),NAMED('CreateBuildFailed'), EXTEND), sendEmail)
                    ,COUNT(platform) > 0           => lUpdateBuildInstance
                    ,lUpdateBuildInstanceNO)
                ,STD.System.Debug.Sleep(10000)); //10 seconds;
END;