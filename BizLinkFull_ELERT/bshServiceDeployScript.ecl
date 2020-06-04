//Use this script as a shell to deploy any needed services to the roxie services. 
/*
@echo off
echo *********** ELERT deployments
set "myEXEDirectory=C:\Program Files (x86)\HPCCSystems\6.4.2\clienttools\bin\"
set "myLogDirectory=C:\users\suffza01\deploy"
set /p what=Deploy What? 
echo Deploying %what%
set mytarget=roxie_149_dev
set /p mytarget="Which target roxie_149_dev, roxie_149_cert, roxie_149_uat, roxie_149_ct ([ENTER] for roxie_149_dev) "
set /p user=UserID? 
set /p psw=Password? 
set "myreload=--no-reload"
set /p "myreload=Reload Hit Spacebar and [ENTER] No Reload just press [ENTER] "
set "mydelete=--delete-prev"
set /p "mydelete=Keep Previous Hit Spacebar and [ENTER] Delete Previous just press [ENTER] "
set "myupdatesupers= "
set "myupdatesupers=--update-super-files"
set /p "myupdatesupers=Update Supers [ENTER] DO NOT UPDATE SUPERSFILES Hit Spacebar and press [ENTER] "
cd %myEXEDirectory%
if %what% == all goto all
echo *** Invalid selection 
goto end
:all
@echo on
ecl publish --target=%mytarget% --name=HealthCare_Provider_Header_ELERT.svcAppendOrigService --main=HealthCare_Provider_Header_ELERT.svcAppendOrigService --daliip=10.173.70.52 --server=10.173.149.22 --port=8011 --username=%user% --password=%psw% -v --wait=7200000 --allow-foreign %mydelete% >>%myLogDirectory%\Dev.log
ecl publish --target=%mytarget% --name=HealthCare_Provider_Header_ELERT.svcAppendNewService --main=HealthCare_Provider_Header_ELERT.svcAppendNewService --daliip=10.173.70.52 --server=10.173.149.22 --port=8011 --username=%user% --password=%psw% -v --wait=7200000 --allow-foreign %mydelete% >>%myLogDirectory%\Dev.log
ecl publish --target=%mytarget% --name=healthcare_provider_header_externallinking.meow_xlnpid_service --main=healthcare_provider_header_externallinking.meow_xlnpid_service --daliip=10.173.70.52 --server=10.173.149.22 --port=8011 --username=%user% --password=%psw% -v --wait=7200000 --allow-foreign %mydelete% >>%myLogDirectory%\Dev.log
ecl publish --target=%mytarget% --name=healthcare_provider_header_externallinking.xlnpid_header_service --main=healthcare_provider_header_externallinking.xlnpid_header_service --daliip=10.173.70.52 --server=10.173.149.22 --port=8011 --username=%user% --password=%psw% -v --wait=7200000 --allow-foreign %mydelete% >>%myLogDirectory%\Dev.log
ecl publish --target=%mytarget% --name=healthcare_provider_header_externallinking.meow_xlnpid_qa_service --main=healthcare_provider_header_externallinking.meow_xlnpid_qa_service --daliip=10.173.70.52 --server=10.173.149.22 --port=8011 --username=%user% --password=%psw% -v --wait=7200000 --allow-foreign %mydelete% >>%myLogDirectory%\Dev.log
ecl publish --target=%mytarget% --name=healthcare_provider_header_externallinking.xlnpid_header_qa_service --main=healthcare_provider_header_externallinking.xlnpid_header_qa_service --daliip=10.173.70.52 --server=10.173.149.22 --port=8011 --username=%user% --password=%psw% -v --wait=7200000 --allow-foreign %mydelete% >>%myLogDirectory%\Dev.log
@echo off
goto end
:end
 cd %myLogDirectory% 
*/
