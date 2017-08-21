import Versioncontrol, _Control;

export ConsumerProfile_Spray(

	 string		filedate
	,boolean	pIsTesting	= false
	,string		pServer			= _Control.IPAddress.edata12
	,string		pDir				= '/hds_2/testseed/consumerprofile/build/'+filedate+'/' 
	,string		pGroupName	= 'thor400_30' 

) :=
function

	flfile(string pkeyword) := '~thor_data400::in::consumerprofile::'+filedate+'::'+pkeyword;
  fsfile(string pkeyword) := '~thor_data400::in::consumerprofile::'+pkeyword;
	spry_raw:=DATASET([

		 {pServer,pDir,'FCRA_CPR_AddrHist*.csv' 								,0 ,flfile('addresshistory'								),[{fsfile('addresshistory')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'FCRA_CPR_AKA*.csv' 					        	,0 ,flfile('akas'				        		),[{fsfile('akas')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'FCRA_CPR_Report*.csv' 						,0 ,flfile('report'						),[{fsfile('report')}],pGroupName,filedate,'','VARIABLE'}
	


	], VersionControl.Layout_Sprays.Info);
	
mac_seedfile_spray('~thor_data400::in::consumerprofile::addresshistory',out);
mac_seedfile_spray('~thor_data400::in::consumerprofile::akas',out1);
mac_seedfile_spray('~thor_data400::in::consumerprofile::report',out2);

								 
sf := parallel(out,out1,out2);
								 
	
	return Sequential(sf,VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting));
	
end;