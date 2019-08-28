This document explains the steps in generating the necessary alerting queries via the ESP monitoring platform


1) first you will need to get the latest version of a 7.4.11+ client tools which includes the latest monitoring command line tools used below.

2) add the cassandra plugin to your plugin folder in the client tools - https://github.com/hpcc-systems/HPCC-Platform/blob/master/plugins/cassandra/cassandra.ecllib

3)	Pull the latest ESP SCAPPS branch from GitLab HERE - https://gitlab.ins.risk.regn.net/ESPTeam/scapps.
clone the repo - https://gitlab.ins.risk.regn.net/ESPTeam/scapps.git
    This will include the wsm_personslimreport.ecm and all its dependencies.

*******************GENERATE ECL Layout from ESDL ******************** 
this only needs to be done if you don't yet have your personslimreport iesp layout

4) Generate a valid iesp ECL layout from the ESDL.
Note that you can edit the ESDL manually to tweak according to your needs before generating ECL layout via command below	

C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\scm>"C:\Program Files\HPCCSystems\7.0.10\clienttools\bin\esdl.exe" ecl wsm_personslimreport.ecm C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\scm --includes --ecl-imports iesp --utf8-
Converting ESDL file wsm_personslimreport.ecm to XML
Processing ESDL definition: wsm_personslimreport.ecm
.
.
.
This will create iesp.personslimreport.ecl which is used in PersonSlimReport_Services.ReportService

*******************GENERATE XML TEMPLATE********************

5) Next, generate an XML template used as the base for all monitoring queries (I added all the relevant include paths –I to avoid lacking ECM/ESDL file errors)

*Important note, the final comparison is done by comparing the ESP response to the cassandra response. This means that the fields selected as virtual IDs in the xml template must NOT be deprecated in ESP response.. see ECM files to make sure - https://gitlab.ins.risk.regn.net/ESPTeam/scapps/blob/17.1/esp/scm

C:\Users\abitda01>
"C:\Program Files (x86)\HPCCSystems\7.4.11\clienttools\bin\esdl.exe" monitor-template ws_accurint.ecm WsAccurint PersonSlimReport -I C:\Users\abitda01\Desktop\repository\scapps\esp\scm -I C:\Users\abitda01\Desktop\repository\scapps\esp\services\ws_gateway\scm -I C:\Users\abitda01\Desktop\repository\scapps\esp\services\ws_gatewayEx\scm -I C:\Users\abitda01\Desktop\repository\scapps\esp\services\ws_distrix\scm --outdir=C:\Users\abitda01\Desktop\repository

Loading XML ESDL definition: ws_accurint.ecm
Time taken for adding XML ESDL definition: 230622298 cycles (230M) = 76 msec
Time taken for EsdlDefinition::getDependencies: 2931409 cycles (2M) = 0 msec
Time taken for serializing EsdlObjects to XML: 10317123 cycles (10M) = 3 msec
Writing to file C:\Users\abitda01\Desktop\repository\monitor_template_PersonSlimReport.xml
.
.
.
This will create monitor_template_PersonSlimReport.xml which needs to be filled out accordingly by selecting virtual ID's for each dataset
in the diffmatch='' xml attributes and diffmonitor='' for the fields being monitored.
The virtual ID's represent the uniqueness of each record in the dataset
see the xml template used here - https://gitlab.ins.risk.regn.net/risk-engineering/PublicRecords/tree/RoxieProd/PersonSlimReport_Services

you will need to manually add the import statemtns to the template 

at top
<ResultMonitoringTemplate>
  <ECL>
    <Import>iesp as iesp</Import>
    <Import>iesp.constants as constants</Import>
  </ECL>
  <PersonSlimReportResponse>

*******************GENERATE QUERIES********************

6) Finally, to generate the alerting queries, run the following command 
FORMAT - 
esdl     monitor       <esdlSourcePath>    <serviceName>        <methodName>         <diffTemplate>
esdl     monitor       ws_accurint.ecm       WsAccurint        PersonSlimReport    monitor_template_PersonSlimReport.xml
//Include paths - 
-I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\scm\
-I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\services\ws_gateway\scm\
-I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\services\ws_gatewayEx\scm\
-I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\services\ws_distrix\scm\
//output directory 
--outdir=C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services
// cassandra DB config value purposely left blank after =
--cassandra-consistency=

-----
C:\Users\abitda01>
"C:\Program Files (x86)\HPCCSystems\7.4.11\clienttools\bin\esdl.exe" monitor ws_accurint.ecm WsAccurint PersonSlimReport C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\monitor_template_PersonSlimReport.xml -I C:\Users\abitda01\Desktop\repository\scapps\esp\scm -I C:\Users\abitda01\Desktop\repository\scapps\esp\services\ws_gateway\scm -I C:\Users\abitda01\Desktop\repository\scapps\esp\services\ws_gatewayEx\scm -I C:\Users\abitda01\Desktop\repository\scapps\esp\services\ws_distrix\scm --outdir=C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services --cassandra-consistency=

Loading XML ESDL definition: ws_accurint.ecm
Time taken for adding XML ESDL definition: 224771849 cycles (224M) = 74 msec
Time taken for EsdlDefinition::getDependencies: 2640861 cycles (2M) = 0 msec
Time taken for EsdlDefinition::getDependencies: 178226 cycles (0M) = 0 msec
Time taken for serializing EsdlObjects to XML: 453908 cycles (0M) = 0 msec
Time taken for serializing EsdlObjects to XML: 8658169 cycles (8M) = 2 msec
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\esdl_rollup_monitor_PersonSlimReport.xml
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\PersonSlimReport_preprocess.xml
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\Monitor_ActiveTemplate_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\MonitorRoxie_create_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\MonitorESP_create_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\MonitorRoxie_run_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\MonitorESP_run_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\MonitorRoxie_demo_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\MonitorESP_demo_PersonSlimReport.ecl
Writing to file C:\Users\abitda01\Desktop\repository\PublicRecords\PersonSlimReport_Services\Compare_PersonSlimReport.ecl

***************DEPLOY QUERIES******************************

7) deploy queries using digit- first copy them to your repo. Then Digit will execute -  
"<C:\Program Files\HPCCSystems\7.2.14\clienttools\bin\ecl.exe>" publish --target=roxie_160 --server=10.173.160.101 --delete-prev  --no-reload   --fastsyntax --nostdinc --no-files --wait=7200000 -v -legacy -u dabittan -pw ******* C:\Users\abitda01\Desktop\repository\PublicRecords\personslimreport_services\monitorroxie_create_personslimreport.ecl --name=personslimreport_services.monitorroxie_create_personslimreport --comment="Published from DiGiT -V-1.6.7<BR> " -I  "C:\Users\abitda01\Desktop\repository\PublicRecords" 

- note you may need to play around with 6.0+ and 7.0+ versions of compiler to get each query published... see below comment...

I was able to deploy most of them using compiler version 6.4+ but 2 of them only worked using 7.0+ compilers.
In case you run into this error – 
eclcc: W20190523-164710(0,0): Error C3000:  Compile/Link failed for W20190523-164710 (see '//10.173.154.101/var/lib/HPCCSystems/eclccserver/eclcc.log' for details)
eclcc: (0,0): Warning C0: 
eclcc: (0,0): Warning C0: ---------- compiler output --------------
eclcc: (0,0): Warning C0: g++: internal compiler error: Killed (program cc1plus)
eclcc: (0,0): Warning C0: Please submit a full bug report,
eclcc: (0,0): Warning C0: with preprocessed source if appropriate.
eclcc: (0,0): Warning C0: See <http://bugzilla.redhat.com/bugzilla> for instructions.
eclcc: (0,0): Warning C0: g++: error: W20190523-164710.cpp.o: No such file or directory
eclcc: (0,0): Warning C0: 
eclcc: (0,0): Warning C0: --------- end compiler output -----------
1 error(s), 9 warning(s) 
 
