//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
﻿IMPORT ORBIT3;
//pVersion    := '20200310' or 20200310aj or 20200310184728
//dsProfiles  := Dataset([ {'consol_prefix_distribute_file_view','ConsolidatedBuilds'}],Orbit3.Layouts.RequestGetProfileLayout)
//masterbuildname := 'Build Name Non-FCRA'
//ResultOutputPrefix := 'ProfileRunRun'

EXPORT GetBuildStatusPostProfileSeverity(STRING pVersion, Dataset(Orbit3.Layouts.RequestGetProfileLayout) dsProfiles, STRING masterbuildname, STRING ResultOutputPrefix,
                                         BOOLEAN moreToDo = true,
                                         DATASET(Orbit3.Layouts.OrbitPlatformUpdateLayout) pPlatform = DATASET([], Orbit3.Layouts.OrbitPlatformUpdateLayout),
                                         BOOLEAN pExcludeFromScorecard = FALSE  ) :=  FUNCTION
IMPORT STD,Orbit3,Orbit4SOA;

waitforit       := STD.System.Debug.Sleep(Orbit3.Constants().OrbitV3ProfileWaitTime);    //4 minutes
buildStatusWait := STD.System.Debug.Sleep(Orbit3.Constants().OrbitV3BuildStatusWaitTime);    //15 minutes JOIN assessment often gets backlogged

GetProfiles  := Orbit4SOA.GetProfileDS(dsProfiles);

profileFetchComplete   := GetProfiles(ProfileStatus IN Orbit3.Constants().sStatus_Term);
profileFetch           := profileFetchComplete(ProfileVersion = pVersion);
profileErroredOut      := profileFetchComplete(ProfileVersion = pVersion AND ProfileStatus IN Orbit3.Constants().fStatus_Term);

BOOLEAN IsStatusTerm   :=  COUNT(profileFetchComplete)      = COUNT(dsProfiles);
BOOLEAN IsStatusTermDt :=  COUNT(profileFetch)              = COUNT(dsProfiles);
BOOLEAN aProfileFailed :=  COUNT(profileErroredOut) > 0;

BOOLEAN Req_Review     :=  Trim(Orbit4SOA.GetBuildInstanceStatus(pVersion,masterbuildname),ALL) = Orbit3.Constants().StatusNeedReview;
//Check Conventinal build results where Orbit has already passed the build.
BOOLEAN BAFU           :=  Trim(Orbit4SOA.GetBuildInstanceStatus(pVersion,masterbuildname),ALL) = Orbit3.Constants().STATUSBUILDCOMPLETE;

SetOrbitToBAFU         :=  Orbit3.CreateOrUpdateBuildInstance( pVersion
                                                               ,masterbuildname
                                                               ,masterbuildname
                                                               ,Orbit3.Constants().bstatus_A
                                                               ,FALSE
                                                               ,pPlatform
                                                               ,pExcludeFromScorecard
                                                              );

Statout            := OUTPUT(GetProfiles   ,NAMED(ResultOutputPrefix + '_Returned_ProfileStatuses'),OVERWRITE);


get_Orbit3_Status := MAP( Req_Review     => fail(505,'Build Instance Requires Review - FAILED ON ' + ResultOutputPrefix + ' FILES - See Orbit Email(s)'),
                          aProfileFailed => fail(506,'OrbitV3 had a profile error during assesment - FAILED ON ' + ResultOutputPrefix + ' FILES - See Orbit Profile Email For Details'),
                          output(dataset([{'Notification : ORBIT UPDATE COMPLETE; ALL ' + ResultOutputPrefix + ' PROFILE STATUSES TERMINAL'}],{string message}),named('Orbit3_Notes'),extend)
                        );

//Where there is only one profile sometimes orbit can beat HPCC ininterrogating the profiles.Conventinal builds set a build to BAFU or Failed QA Once all profiles are assessed.
Small_Conventional_Build := parallel(Statout, output(dataset([{'Notification : ORBIT UPDATE COMPLETE; ALL ' + ResultOutputPrefix + ' PROFILE STATUSES TERMINAL; ORBIT SET BUILD TO BAFU'}],{string message}),named('Orbit3_Notes'),extend));

sleepAndCheckAgain := IF(NOT Req_Review, sequential(waitforit, IsStatusTerm));

Run_3_Checks       :=  MAP( NOT IsStatusTermDt AND IsStatusTerm =>  ORDERED(Statout,FAIL(501, 'Orbit3 GetProfileDS is returning the wrong build instance. Orbit4SOA.GetBuildStatusPostProfileSeverity will resubmit up to three times'))
                          , NOT IsStatusTermDt                  =>  ORDERED(Statout,FAIL(502, 'Orbit3 GetProfileDS is still processing. Orbit4SOA.GetBuildStatusPostProfileSeverity will resubmit up to three times'))
                          , BAFU                                =>  Small_Conventional_Build
                          , moreToDo                            =>  Statout //just output the results
                          , output(dataset([{'Notification : ORBIT SUCCESSFULLY UPDATED ALL PROFILES; CHECKING' + ResultOutputPrefix + '  BUILD INSTANCE STATUS'}],{string message}),named('Orbit3_Notes'),extend)
                          ): recovery(sleepAndCheckAgain,3);

FINAL_STATUS_CHECK := IF(NOT moreToDo, SEQUENTIAL(buildStatusWait //Wait for Orbits join assessment to update build status if needed.
                                                 ,parallel(Statout, get_Orbit3_Status)
                                                 ,SetOrbitToBAFU));

//Only allow update of build that are in Progress, however, for conventional builds we have to check the profile status even if the build is in BAFU.
// because Orbit can't prevent profile services from setting a build to BAFU after all profiles are assessed. Nothing else is restartable.
Valid_build_status := Trim(Orbit4SOA.GetBuildInstanceStatus(pVersion,masterbuildname,'DataDevelopment-Ins@lexisnexis.com'),ALL) IN [Orbit3.Constants().StatusInProgress,Orbit3.Constants().STATUSBUILDCOMPLETE]  : INDEPENDENT;

Exec_Check         := IF(Valid_build_status, ORDERED(Run_3_Checks,FINAL_STATUS_CHECK),
                         FAIL(500, masterbuildname + ' Build Instance:' + pVersion +
                            ' is not in Build_IN_PROGRESS\n~~~ Orbit4SOA.GetBuildStatusPostProfileSeverity ~~~\nCheck ' + ResultOutputPrefix + ' Profiles\n' +
                            ' Conventional builds set to Failed QA are equivalent to "Build Instance Requires Review"\n' +
                            ' except there were likely set by Orbit "Automatic update through profile test settings".\n' +
                            ' See serperate email Subject ~ "Build Instance for Build ' + masterbuildname +'" for details on status'));

RETURN Exec_Check;
END;