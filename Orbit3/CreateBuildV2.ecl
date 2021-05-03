//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
IMPORT ORBIT3;
EXPORT CreateBuildV2( STRING      pLoginToken,
                      STRING      pMasterBuild,
                      STRING      pBuildName,
                      STRING      pBuildVersion,
                      STRING      pStartDate,
                      BOOLEAN     pExcludeFromScorecard = TRUE,
                      STRING      pHPCCWorkunit,
                      STRING      pBuildStatus         =  'BUILD_IN_PROGRESS', //see warning
                      INTEGER1    pNewCoverage         =  1,
                      STRING      pVolume              =  'N/A',
                      DATASET(Orbit3.Layouts.OrbitPlatformUpdateLayout)  pPlatform    = DATASET([], Orbit3.Layouts.OrbitPlatformUpdateLayout),
                      BOOLEAN     isThemeConventional  = TRUE
                    ) := FUNCTION

/////WARNING////////WARNING//////WARNING////WARNING//////WARNING//////WARNING///////WARNING//////WARNING//////WARNING///////
//*******Non Conventinal builds can not pass in a build status you must call UpdateBuildInstance to set build to BAFU******/
/////WARNING////////WARNING//////WARNING////WARNING//////WARNING//////WARNING///////WARNING//////WARNING//////WARNING///////

  rRequestParms :=  RECORD
    STRING              ActualStartDate                        {xpath('ActualStartDate')};          // :=  pStartDate;
    STRING              BuildName                              {xpath('BuildName')};                // :=  pBuildName;
    STRING              BuildStatus                            {xpath('BuildStatus')};             //  :=  pBuildStatus;
		STRING              BuildVersion                           {xpath('BuildVersion')};            //  :=  pBuildVersion;
    BOOLEAN             ExcludeFromScorecard                   {xpath('ExcludeFromScorecard')};    //  :=  pExcludeFromScorecard;
    STRING              HpccWorkUnit                           {xpath('HpccWorkUnit')};            //  :=  pHpccWorkUnit;
    STRING              MasterBuildName                        {xpath('MasterBuildName')};          // :=  pMasterBuild;
    INTEGER1            NewCoverageArea                        {xpath('NewCoverageArea')};          // :=  pNewCoverage;
    DATASET(Orbit3.Layouts.OrbitPlatformUpdateLayout)Platforms {xpath('Platforms/RecordRequestCreateBuildPlatform')};   //:= pPlatform;
    BOOLEAN              SkippedBuild                          {xpath('SkippedBuild')}                 :=  FALSE;
  END;

 rout := PROJECT(DATASET([{pStartDate,pBuildName,pBuildStatus,pBuildVersion,pExcludeFromScorecard,
                           pHpccWorkUnit,pMasterBuild,pNewCoverage,pPlatform,FALSE}],rRequestParms), TRANSFORM(LEFT));
 pRequest := PROJECT(rout, rRequestParms);

  rCreateBuildReq := RECORD
    rRequestParms   RecordRequestCreateBuild {xpath('RecordRequestCreateBuild')} := pRequest[1];
  END;

  rOrbitRequest :=
  RECORD
    STRING            LoginToken             {xpath('Token'),              maxlength(36)}    :=  pLoginToken;
    rCreateBuildReq   OrbRequest             {xpath('Request')};
  END;

  rRequestCapsule  :=
  RECORD
    #IF(((__ECL_VERSION_MAJOR__ = 7) AND (__ECL_VERSION_MINOR__ >= 8)) or  (__ECL_VERSION_MAJOR__ > 7)) // 7.8 Tightened up the checking of the namespace in SOAP calls, it doesn't support multiple ones so this is in as a workaround until that is available. Unfortunately the workaround doesn't work on 7.6 hence the conditional here.
       $.Layouts.AdditionalNamespacesLayout;
    #END
    rOrbitRequest     request                       {xpath('request')};
  END;

/////////////////////////////////////////////////////////////////////////////
  rCreateBuildResultFields  := RECORD
    INTEGER4          BuildId                       {xpath('BuildId')};
    STRING            BuildName                     {xpath('BuildName')};
    STRING            BuildStatus                   {xpath('BuildStatus')};
    STRING            BuildVersion                  {xpath('BuildVersion')};
    STRING            HpccWorkUnit                  {xpath('HpccWorkUnit')};
    STRING            MasterBuildId                 {xpath('MasterBuildId')};
    STRING            MasterBuildName               {xpath('MasterBuildName')};
    STRING            ServerInfo                    {xpath('ServerInfo')};
  END;

  rResult2  := RECORD
    rCreateBuildResultFields    Result              {xpath('Result')};
    STRING                  Status                  {xpath('Status')};
    STRING                  Message                 {xpath('Message')};
  END;

  rCreateBuildResult  := RECORD
    rResult2          RecordResponseCreateBuild     {xpath('RecordResponseCreateBuild')};
  END;

  rResult  :=  RECORD
    rCreateBuildResult  Result                      {xpath('Result')};
    STRING            Status                        {xpath('Status')};
  END;

  rCreateBuildResponseResult :=  RECORD
    rResult            CreateBuildResult            {xpath('CreateBuildResult'),        maxlength(4096)};
  END;

  rFault  :=  RECORD
    STRING             FaultCode                    {xpath('faultcode')};
    STRING              FaultString                 {xpath('faultstring')};
  END;

  rSOAPResponse  :=   RECORD
    rFault                     FaultRecord          {xpath('Fault')};
    rCreateBuildResponseResult  CreateBuildResponse {xpath('CreateBuildResponse'),     maxlength(300000)};
  END;


//Show Input
 // output(pPlatform);
 // outputXML := TOXML(pRequest[1]);
 // output(outputXML);
 // output(pRequest);
env_URL := IF(isThemeConventional, Orbit3.EnvironmentVariables.ServiceURL, Orbit3.EnvironmentVariables.PRServiceURL);

/////////////////////////////////////////////////////////////////////////////
  rSOAPResponse lOrbitResponse  :=  SOAPCALL(env_URL,
                                            'CreateBuild',
                                            rRequestCapsule,
                                            rSOAPResponse,
                                            namespace(Orbit3.EnvironmentVariables.NameSpace),
                                            literal,
                                            soapaction(Orbit3.EnvironmentVariables.SoapActionPrefix +  'PR/CreateBuild'),
                                            LOG
                                            );

  RETURN IF(orbit3.EnvironmentVariables.updateme = 'yes', lOrbitResponse);
END;
