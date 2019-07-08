This document explains the steps in generating the necessary alerting queries via the ESP monitoring platform


1) first you will need to get the latest version of a 7.2.22+ client tools which includes the latest monitoring command line tools used below.

2) add the cassandra plugin to your plugin folder in the client tools - https://github.com/hpcc-systems/HPCC-Platform/blob/master/plugins/cassandra/cassandra.ecllib

3)	Pull the latest ESP SCAPPS branch from GitLab HERE - https://gitlab.ins.risk.regn.net/ESPTeam/scapps.
    This will include the wsm_personslimreport.ecm and all its dependencies.

*******************GENERATE ECL Layout from ESDL ********************

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

C:\Users\abitda01\Desktop\repository\alerts\run>"C:\Program Files\HPCCSystems\7.0.10\clienttools\bin\esdl.exe" monitor-template ws_accurint.ecm WsAccurint PersonSlimReport  -I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\scm -I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\services\ws_gateway\scm -I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\services\ws_gatewayEx\scm -I C:\Users\abitda01\Desktop\repository\alerts\run\cmd\scapps\esp\services\ws_distrix\scm

Loading XML ESDL definition: ws_accurint.ecm
Time taken for adding XML ESDL definition: 226201383 cycles (226M) = 75 msec
Time taken for EsdlDefinition::getDependencies: 3111621 cycles (3M) = 1 msec
Time taken for serializing EsdlObjects to XML: 11868004 cycles (11M) = 3 msec
Writing to file .\monitor_template_PersonSlimReport.xml
.
.
.
This will create monitor_template_PersonSlimReport.xml which needs to be filled out accordingly by selecting virtual ID's for each dataset
in the diffmatch='' xml attributes and diffmonitor='' for the fields being monitored.
The virtual ID's represent the uniqueness of each record in the dataset
see the xml template used here - https://gitlab.ins.risk.regn.net/risk-engineering/PublicRecords/tree/RoxieProd/PersonSlimReport_Services

*******************GENERATE QUERIES********************

6) Finally, to generate the alerting queries, run the following command 
FORMAT - 
esdl     monitor       <esdlSourcePath>    <serviceName>        <methodName>         <diffTemplate>
esdl     monitor       ws_accurint.ecm       WsAccurint        PersonSlimReport    monitor_template_PersonSlimReport.xml
-I cmd\scapps\esp\scm\
-I cmd\scapps\esp\services\ws_gateway\scm\
-I cmd\scapps\esp\services\ws_gatewayEx\scm\
-I cmd\scapps\esp\services\ws_distrix\scm\

-----
C:\Users\abitda01\Desktop\repository\alerts\run>"C:\Program Files\HPCCSystems\7.2.22\clienttools\bin\esdl.exe" monitor ws_accurint.ecm WsAccurint PersonSlimReport ..\gen_ecl\monitor_template_PersonSlimReport.xml -I cmd\scapps\esp\scm -I cmd\scapps\esp\services\ws_gateway\scm -I cmd\scapps\esp\services\ws_gatewayEx\scm -I cmd\scapps\esp\services\ws_distrix\scm

Loading XML ESDL definition: ws_accurint.ecm
Time taken for adding XML ESDL definition: 248479425 cycles (248M) = 82 msec
Time taken for EsdlDefinition::getDependencies: 4483216 cycles (4M) = 1 msec
Time taken for EsdlDefinition::getDependencies: 247256 cycles (0M) = 0 msec
Time taken for serializing EsdlObjects to XML: 694772 cycles (0M) = 0 msec
Time taken for serializing EsdlObjects to XML: 8405782 cycles (8M) = 2 msec
Writing to file .\esdl_rollup_monitor_PersonSlimReport.xml
Writing to file .\PersonSlimReport_preprocess.xml
Writing to file .\Monitor_ActiveTemplate_PersonSlimReport.ecl
Writing to file .\MonitorRoxie_create_PersonSlimReport.ecl
Writing to file .\MonitorESP_create_PersonSlimReport.ecl
Writing to file .\MonitorRoxie_run_PersonSlimReport.ecl
Writing to file .\MonitorESP_run_PersonSlimReport.ecl
Writing to file .\MonitorRoxie_demo_PersonSlimReport.ecl
Writing to file .\MonitorESP_demo_PersonSlimReport.ecl
Writing to file .\Compare_PersonSlimReport.ecl

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
 
