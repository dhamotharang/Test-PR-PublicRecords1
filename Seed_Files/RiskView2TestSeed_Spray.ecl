import STD,Versioncontrol, _Control;
   DaliIp           := std.system.Thorlib.DaliServer();
  GroupName 			 := map(//DaliIp = '10.241.3.242:7070'  => 'thor5_241_10a', // Dataland 1 
                          DaliIp = '10.241.12.201:7070' => 'thor50_dev02', // Dataland 2 
                          DaliIp = '10.241.20.205:7070' => 'thor400_30',   // Boca Production   
                          'thor400_30');           
export RiskView2TestSeed_Spray(

	 string		filedate
	,boolean	pIsTesting	= false
	,string		pServer			= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12 ,  _control.IPAddress.bctlpedata11 )
	,string		pDir				= '/data/hds_2/testseed/riskviewreport/build/'+filedate+'/' 
	,string		pGroupName	= GroupName

) :=
function

	flfile(string pkeyword) := '~thor_data400::in::riskview2report::'+filedate+'::'+pkeyword;
  fsfile(string pkeyword) := '~thor_data400::in::riskview2report::'+pkeyword;
	spry_raw:=DATASET([

		 {pServer,pDir,'RiskView2_Report_addresshistory*.csv' 								,0 ,flfile('addresshistory'								),[{fsfile('addresshistory')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_bankruptcy*.csv' 					        	,0 ,flfile('bankruptcy'				        		),[{fsfile('bankruptcy')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_businessassoc*.csv' 						,0 ,flfile('businessassociation'						),[{fsfile('businessassociation')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_criminal*.csv' 										,0 ,flfile('criminal'										),[{fsfile('criminal')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_creditinquiry*.csv' 									,0 ,flfile('creditinquiry'									),[{fsfile('creditinquiry')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_filing*.csv' 					,0 ,flfile('filing'					),[{fsfile('filing')}], pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_education*.csv' ,0 ,flfile('education'),[{fsfile('education')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_loanoffer*.csv' 						,0 ,flfile('loanoffer'						),[{fsfile('loanoffer')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_license*.csv' 						,0 ,flfile('license'						),[{fsfile('license')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_personalproperty*.csv' 						,0 ,flfile('personalproperty'						),[{fsfile('personalproperty')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_summary*.csv' 						,0 ,flfile('summary'						),[{fsfile('summary')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'RiskView2_Report_realproperty*.csv' 						,0 ,flfile('realproperty'						),[{fsfile('realproperty')}],pGroupName,filedate,'','VARIABLE'}
    ,{pServer,pDir,'RiskView2_Report_purchase*.csv' 						,0 ,flfile('purchase'						),[{fsfile('purchase')}],pGroupName,filedate,'','VARIABLE'}


	], VersionControl.Layout_Sprays.Info);
	
mac_seedfile_spray('~thor_data400::in::riskview2report::addresshistory',out);
mac_seedfile_spray('~thor_data400::in::riskview2report::bankruptcy',out1);
mac_seedfile_spray('~thor_data400::in::riskview2report::businessassociation',out2);
mac_seedfile_spray('~thor_data400::in::riskview2report::criminal',out3);
mac_seedfile_spray('~thor_data400::in::riskview2report::creditinquiry',out4);
mac_seedfile_spray('~thor_data400::in::riskview2report::filing',out5);
mac_seedfile_spray('~thor_data400::in::riskview2report::education',out6);
mac_seedfile_spray('~thor_data400::in::riskview2report::loanoffer',out7);
mac_seedfile_spray('~thor_data400::in::riskview2report::license',out8);
mac_seedfile_spray('~thor_data400::in::riskview2report::personalproperty',out9);
mac_seedfile_spray('~thor_data400::in::riskview2report::summary',out10);
mac_seedfile_spray('~thor_data400::in::riskview2report::realproperty',out11);
mac_seedfile_spray('~thor_data400::in::riskview2report::purchase',out12);

								 
sf := parallel(out,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12);
								 
	
	return Sequential(sf,VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting));
	
end;