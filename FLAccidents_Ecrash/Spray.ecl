import VersionControl,_Control;

export Spray(

	 string		filedate
	,boolean	pIsTesting	= false
	,string		pServer			= _Control.IPAddress.edata12
	,string		pDir				= '/super_credit/ecrash/sample'
	,string		pGroupName	= _datasets().groupname 

) :=
function

	lfile(string pkeyword) := '~thor_data400::temp::ecrash::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::temp::ecrash::' + pkeyword;

	spry_raw:=DATASET([

		 {pServer,pDir,'*citation*csv' 			,0 ,lfile('citation'				),[{sfile('citation'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*commercial*csv' 		,0 ,lfile('commercial'			),[{sfile('commercial'	  )}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*incident*csv' 			,0 ,lfile('incident'				),[{sfile('incident'			)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*person.*csv' 			,0 ,lfile('person'					),[{sfile('person'				)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*vehicle*csv' 			,0 ,lfile('vehicle'				  ),[{sfile('vehicle'			  )}],pGroupName,filedate,'','VARIABLE'}

		 	], VersionControl.Layout_Sprays.Info);
	
	return VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting);
	
end;
