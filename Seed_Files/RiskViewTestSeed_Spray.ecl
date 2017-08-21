import Versioncontrol, _Control;

export RiskViewTestSeed_Spray(

	 string		filedate
	,boolean	pIsTesting	= false
	,string		pServer			= _Control.IPAddress.edata12
	,string		pDir				= '/hds_2/testseed/riskviewreport/build/'+filedate+'/' 
	,string		pGroupName	= 'thor400_30' 

) :=
function

	flfile(string pkeyword) := '~thor_data400::in::riskviewreport::'+filedate+'::'+pkeyword;
  fsfile(string pkeyword) := '~thor_data400::in::riskviewreport::'+pkeyword;
	spry_raw:=DATASET([

		 {pServer,pDir,'rvr_addresshistory*.csv' 								,0 ,flfile('addresshistory'								),[{fsfile('addresshistory')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_bankruptcy*.csv' 					        	,0 ,flfile('bankruptcy'				        		),[{fsfile('bankruptcy')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_businessassociation*.csv' 						,0 ,flfile('businessassociation'						),[{fsfile('businessassociation')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_criminal*.csv' 										,0 ,flfile('criminal'										),[{fsfile('criminal')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_creditinquiry*.csv' 									,0 ,flfile('creditinquiry'									),[{fsfile('creditinquiry')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_filing*.csv' 					,0 ,flfile('filing'					),[{fsfile('filing')}], pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_education*.csv' ,0 ,flfile('education'),[{fsfile('education')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_loanoffer*.csv' 						,0 ,flfile('loanoffer'						),[{fsfile('loanoffer')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_license*.csv' 						,0 ,flfile('license'						),[{fsfile('license')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_personalproperty*.csv' 						,0 ,flfile('personalproperty'						),[{fsfile('personalproperty')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_summary*.csv' 						,0 ,flfile('summary'						),[{fsfile('summary')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'rvr_realproperty*.csv' 						,0 ,flfile('realproperty'						),[{fsfile('realproperty')}],pGroupName,filedate,'','VARIABLE'}


	], VersionControl.Layout_Sprays.Info);
	
mac_seedfile_spray('~thor_data400::in::riskviewreport::addresshistory',out);
mac_seedfile_spray('~thor_data400::in::riskviewreport::bankruptcy',out1);
mac_seedfile_spray('~thor_data400::in::riskviewreport::businessassociation',out2);
mac_seedfile_spray('~thor_data400::in::riskviewreport::criminal',out3);
mac_seedfile_spray('~thor_data400::in::riskviewreport::creditinquiry',out4);
mac_seedfile_spray('~thor_data400::in::riskviewreport::filing',out5);
mac_seedfile_spray('~thor_data400::in::riskviewreport::education',out6);
mac_seedfile_spray('~thor_data400::in::riskviewreport::loanoffer',out7);
mac_seedfile_spray('~thor_data400::in::riskviewreport::license',out8);
mac_seedfile_spray('~thor_data400::in::riskviewreport::personalproperty',out9);
mac_seedfile_spray('~thor_data400::in::riskviewreport::summary',out10);
mac_seedfile_spray('~thor_data400::in::riskviewreport::realproperty',out11);
								 
sf := parallel(out,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11);
								 
	
	return Sequential(sf,VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting));
	
end;