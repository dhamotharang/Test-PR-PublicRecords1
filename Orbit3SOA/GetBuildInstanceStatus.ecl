//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
/**
* == Will return a status of the Orbit Build Instance ==
* 'A', //Build Instance Completed, Available  to process, exists in orbit;
* 'B', //Build Instance Available , Continue with Restart, exists in orbit;
* 'R', //Build Instance Review, Check Orbit Profiles, Reset Build Instance before continuing
* 'D', //date, build instance does not exist;
* 'U') //Build Instance UnAvailable , Do not continue with build;
*/
EXPORT GetBuildInstanceStatus(string Bld_dt,string masterBuildName, string emailme = '')  := function
Import Orbit3, _control;

local tokenval 		          := Orbit3.GetToken():independent;
local lGetBuildInstance     := Orbit3.GetBuildInstanceV2(tokenval,trim(masterBuildName,left,right),Bld_dt);

local buildInsName          := (string)lGetBuildInstance.BuildName;  
local buildInsStatus        := (string)lGetBuildInstance.Status; 
local buildInsVersion       := (string)lGetBuildInstance.BuildVersion; 

local OrbitSubjectINS       := _control.ThisEnvironment.Name + ': ' + 'Build Instance for Build: ' + buildInsName  + ' Build Version: ' + (string) buildInsVersion + ' Status: ' + buildInsStatus;

local OrbitBodyR           := 'The Workunit is ' + WORKUNIT + '\n\n' 
                            + 'Build: ' + buildInsName + ' Build Version: ' + buildInsVersion + ' Status: ' + buildInsStatus + '\n'
                            + 'Build Instance Status is set to ' +  buildInsStatus + ' the build was halted.' + '\n'
                            + 'You can NOT run ' + buildInsName + ' build until the alert profile(s) have been reviewed and approved.' + '\n'
                            + 'Once approved the build instance must be reset in Orbit to BUILD_IN_PROGRESS or BUILD_AVAILABLE_FOR_USE' + '\n'
                            + 'NOTE: The Build Date MUST be the same as previous step' + '\n';
                            
local OrbitBodyU           := 'The Workunit is ' + WORKUNIT + '\n\n' 
                            + 'Build: ' + buildInsName + ' Build Version: ' + buildInsVersion + ' Status: ' + buildInsStatus + '\n'
                            + 'Build Instance Status is set to ' +  buildInsStatus + ' the build is UNAVAILABLE.' + '\n'
                            + 'You can NOT run ' + buildInsName + ' build with Build Version ' + buildInsVersion + '.' + '\n'
                            + 'Check Orbit for a valid build instance or create a new build instance before continuing' + '\n';

local OrbitBodyD            := 'The Workunit is ' + WORKUNIT + '\n\n'                             
                            + 'Build: ' + buildInsName + ' Build Version: ' + buildInsVersion + '\n' 
                            + 'was submitted with an invalid build Date, the date MUST be the same as existing ' + buildInsName + ' Build.' + '\n';

local OrbitFromEmail        := 'Orbit3@GetBuildInstanceStatus.com';

local STRING1 inspass       := MAP(buildInsVersion != Bld_dt => Orbit3.Constants().StatusDateIssue, //D
                                    buildInsStatus IN ['BUILD_REQ_REVIEW','FAILED_QA']                                      => Orbit3.Constants().StatusNeedReview ,   //'R', //Review
                                    buildInsStatus IN ['BUILD_AVAILABLE_FOR_USE','PASSED_QA','PRODUCTION','QA_IN_PROGRESS'] => Orbit3.Constants().StatusBuildComplete, //'A', //Available  
                                    buildInsStatus IN ['BUILD_IN_PROGRESS']                                                 => Orbit3.Constants().StatusInProgress,    //'B', //Continue Restart
                                    Orbit3.Constants().StatusUnknowIssue); //'U'

SendEmail :=  map(inspass = Orbit3.Constants().StatusNeedReview  => Fileservices.Sendemail(emailme , OrbitSubjectINS, OrbitBodyR,,,OrbitFromEmail)
                 ,inspass = Orbit3.Constants().StatusUnknowIssue => Fileservices.Sendemail(emailme , OrbitSubjectINS, OrbitBodyU,,,OrbitFromEmail)
                 ,inspass = Orbit3.Constants().StatusDateIssue   => Fileservices.Sendemail(emailme , OrbitSubjectINS, OrbitBodyD,,,OrbitFromEmail));
                 
return when(inspass,
            parallel(if(length(trim(emailme, all)) > 0,
                        SendEmail),
                     )
            );  

END;