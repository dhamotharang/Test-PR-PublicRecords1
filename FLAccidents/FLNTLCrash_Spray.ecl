import VersionControl,_Control;

export FLNTLCrash_Spray(

	 string		filedate
	,boolean	pIsTesting	= false
	,string		pServer			= _Control.IPAddress.edata12
	,string		pDir				= '/super_credit/flcrash/alpharetta/build/'+filedate+'/' 
	,string		pGroupName	= _dataset().groupname 

) :=
function

	flfile(string pkeyword) := '~thor_data400::in::flcrash::alpharetta::' + pkeyword + '.@version@.csv';
	fsfile(string pkeyword) := '~thor_data400::in::flcrash::alpharetta::' + pkeyword;

	spry_raw:=DATASET([

		 {pServer,pDir,'*int_order*csv' 								,0 ,flfile('int_order'								),[{fsfile('int_order'								)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*client*csv' 					        	,0 ,flfile('client'				        		),[{fsfile('client'						        )}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*order_version*csv' 						,0 ,flfile('order_version'						),[{fsfile('order_version'						)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*result*csv' 										,0 ,flfile('result'										),[{fsfile('result'										)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*vehicle.*csv' 									,0 ,flfile('vehicle'									),[{fsfile('vehicle'									)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*vehicle_incident*csv' 					,0 ,flfile('vehicle_incident'					),[{fsfile('vehicle_incident'					)}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*vehicle_insurance_carrier*csv' ,0 ,flfile('vehicle_insurance_carrier'),[{fsfile('vehicle_insurance_carrier')}],pGroupName,filedate,'','VARIABLE'}
		,{pServer,pDir,'*vehicle_party*csv' 						,0 ,flfile('vehicle_party'						),[{fsfile('vehicle_party'						)}],pGroupName,filedate,'','VARIABLE'}

	], VersionControl.Layout_Sprays.Info);
	
	return VersionControl.fSprayInputFiles(spry_raw,pIsTesting := pIsTesting);
	
end;