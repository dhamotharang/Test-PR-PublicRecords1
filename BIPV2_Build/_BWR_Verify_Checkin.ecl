/*
  make sure to run BIPV2_Build.Promote2QA before this so that the xlink keys are in the correct superfiles(QA).
*/
ECL_Biz_Header_Service    := '#workunit(\'name\',\'bizlinkfull.Biz_Header_Service_2\');\n'                 + 'bizlinkfull.Biz_Header_Service_2();'                 ;
ECL_svcWheelCity          := '#workunit(\'name\',\'bizlinkfull.svcWheelCity\');\n'                         + 'bizlinkfull.svcWheelCity();'                         ;
ECL_svcBatch              := '#workunit(\'name\',\'bizlinkfull.svcBatch\');\n'                             + 'bizlinkfull.svcBatch();'                             ;
ECL_BusinessSearch        := '#workunit(\'name\',\'TopBusiness_Services.BusinessSearch\');\n'              + 'TopBusiness_Services.BusinessSearch();'              ;
ECL_BusinessReportComp    := '#workunit(\'name\',\'TopBusiness_Services.BusinessReportComprehensive\');\n' + 'TopBusiness_Services.BusinessReportComprehensive();' ;
ECL_sourcecountservice    := '#workunit(\'name\',\'topbusiness_services.sourcecountservice\');\n'          + 'topbusiness_services.sourcecountservice();'          ;
ECL_sourceservice         := '#workunit(\'name\',\'topbusiness_services.sourceservice\');\n'               + 'topbusiness_services.sourceservice();'               ;
ECL_LGID3CompareService   := '#workunit(\'name\',\'BIPV2_LGID3.LGID3CompareService\');\n'                  + 'BIPV2_LGID3.LGID3CompareService();'                  ;
ECL_ProxidCompareService  := '#workunit(\'name\',\'BIPV2_ProxID.ProxidCompareService\');\n'                + 'BIPV2_ProxID.ProxidCompareService();'                ;

cluster := if(tools._Constants.IsDataland ,'infinband_hthor','hthor');

Kick_Biz_Header_Service    := wk_ut.CreateWuid(ECL_Biz_Header_Service  ,cluster);
Kick_svcWheelCity          := wk_ut.CreateWuid(ECL_svcWheelCity        ,cluster);
Kick_svcBatch              := wk_ut.CreateWuid(ECL_svcBatch            ,cluster);
Kick_BusinessSearch        := wk_ut.CreateWuid(ECL_BusinessSearch      ,cluster);
Kick_BusinessReportComp    := wk_ut.CreateWuid(ECL_BusinessReportComp  ,cluster);
Kick_sourcecountservice    := wk_ut.CreateWuid(ECL_sourcecountservice  ,cluster);
Kick_sourceservice         := wk_ut.CreateWuid(ECL_sourceservice       ,cluster);
Kick_LGID3CompareService   := wk_ut.CreateWuid(ECL_LGID3CompareService ,cluster);
Kick_ProxidCompareService  := wk_ut.CreateWuid(ECL_ProxidCompareService,cluster);

setwuids := [
   Kick_Biz_Header_Service  
  ,Kick_svcWheelCity        
  ,Kick_svcBatch            
  ,Kick_BusinessSearch      
  ,Kick_BusinessReportComp  
  ,Kick_sourcecountservice  
  ,Kick_sourceservice       
  ,Kick_LGID3CompareService 
  ,Kick_ProxidCompareService
];

Wait4Threads    := wk_ut.Wait4Workunits(setwuids,'1',bipv2.KeySuffix,'Wait4Wuids');

dInput:=CHOOSEN(BIPV2_Testing.files.xlink,100);

Business_Header_SS.MAC_Match_Flex(dInput,['A','F','P'],company_name,company_prim_range,company_prim_name,company_zip,company_sec_range,company_state,company_phone,company_fein,bdid,RECORDOF(dInput),FALSE,BDID_score,dOutput,,0,,,[BIPV2.IDconstants.xlink_version_BIP],,email_address,company_city,fname,mname,lname,,src,src_rcid);

CheckProd := sequential(
   BIPV2_Build.BIPV2FullKeys_Package().outputpackage
  ,BIPV2_Build.BIPV2WeeklyKeys_Package().outputpackage
  ,output(Debt_Settlement.Append_Ids.fAppendBdid(dataset([],Debt_Settlement.Layouts.Base)),named('BuildMacroTest')) //check syntax here
  ,BIPV2_Testing.proc_Xlink_Sample()
  ,output(dinput,named('Files_Xlink'))
  ,output(dOutput,named('MAC_Match_Flex_Example'))
  ,Wait4Threads
);

CheckDataland := sequential(
   BIPV2_Build.DatalandKeys_Package().outputpackage
  ,output(Debt_Settlement.Append_Ids.fAppendBdid(dataset([],Debt_Settlement.Layouts.Base)),named('BuildMacroTest')) //check syntax here
  ,BIPV2_Testing.proc_Xlink_Sample()
  ,output(dinput,named('Files_Xlink'))
  ,output(dOutput,named('MAC_Match_Flex_Example'))
  ,Wait4Threads

);

CheckQA := sequential(
  BIPV2_Build.BIPV2FullKeys_Package().outputpackage
  //Wait4Threads
);


map( tools._Constants.IsDataland     => CheckDataland
    ,tools._Constants.IsBocaProd     => CheckProd
    ,tools._Constants.IsBocaQaRoxie  => CheckQA
    ,                                   output('No recognized environment, doing nothing')
);


/*
1)	BIPV2_Build.BIPV2FullKeys_Package().outputpackage; //run in QA and Prod repos, but not dataland

2)	Check syntax of a couple of builds using our business_header_ss.mac_match_flex (or whatever its called) //run in prod only

3)	Compile or run this ECL to check the syntax of the services 
    (should be pretty obvious whether any issue is ours or part of the service itself) //run in all 3

bizlinkfull.Biz_Header_Service_2();
export aaaa := 0;
bizlinkfull.svcWheelCity();
export bbbb := 0;
// bizlinkfull.svcWheelCompanyName();
bizlinkfull.svcBatch();
export cccc := 0;
TopBusiness_Services.BusinessSearch();
export dddd := 0;
TopBusiness_Services.BusinessReportComprehensive();
export eeee := 0;
topbusiness_services.sourcecountservice();
export ffff := 0; 
topbusiness_services.sourceservice();
export gggg := 0; 
BIPV2_LGID3.LGID3CompareService();
export hhhh := 0; 
BIPV2_ProxID.ProxidCompareService();

4)	Run the BIPV2_Testing.BWR_XLink_Sample (or whatever its called) to make sure it actually runs and hits keys and glance at but donâ€™t agonize over results //run in prod and dataland only
*/