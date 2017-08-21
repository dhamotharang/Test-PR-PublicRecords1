import VersionControl,_Control,ut;

export Spray(

	 //string		filedate,
	 boolean	pIsTesting	= false
	,string		pServer			= _Control.IPAddress.edata12
	,string		pDir				= '/super_credit/ecrash/'
	,string		pGroupName	= _datasets().groupname 

) :=
function

	lfile(string pkeyword) := '~thor_data400::in::ecrash::' + pkeyword + '.@version@.csv';
	sfile(string pkeyword) := '~thor_data400::in::ecrash::' + pkeyword;

	spry_raw:=DATASET([

		 {pServer,pDir,'*.citation.*.csv' 			,0 ,lfile('citation'				),[{sfile('citation'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir,'*.commercial.*.csv' 		,0 ,lfile('commercial'			),[{sfile('commercial'	  )}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir,'*.incident.*.csv' 			,0 ,lfile('incident'				),[{sfile('incident'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir,'*.person.*.csv' 			  ,0 ,lfile('person'					),[{sfile('person'				)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir,'*.vehicle.*.csv' 			  ,0 ,lfile('vehicle'				  ),[{sfile('vehicle'			  )}],pGroupName,'','[0-9]{12}','VARIABLE'}
		,{pServer,pDir,'*.service.*.csv' 			  ,0 ,lfile('service'				  ),[{sfile('service'			  )}],pGroupName,'','[0-9]{8}','VARIABLE'}
		,{pServer,pDir,'*.state.*.csv' 			    ,0 ,lfile('state'				    ),[{sfile('state'			    )}],pGroupName,'','[0-9]{8}','VARIABLE'}

		,{pServer,'/thor_back5/agency/'
									,'*ecrash_agency*'+(string)((unsigned)ut.GetDate-1)+'.txt'
																						,0 ,lfile('agency'				  ),[{sfile('agency'			  )}],pGroupName,'','[0-9]{8}','VARIABLE'}
		 	], VersionControl.Layout_Sprays.Info);
	
	return VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting);
	
end;
