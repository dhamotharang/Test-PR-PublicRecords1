import lib_fileservices,_control;
export despray(	 string pSourceIP
				,string pDestinationFile
				,string pThorFilename
				,string pGroupName		= 'thor400_84'
) := function	

SourceIP:=map (
				pSourceIP='edata11' => _Control.IPAddress.edata11
				,pSourceIP='edata12' => _Control.IPAddress.edata12
				,pSourceIP='edata14' => _Control.IPAddress.edata14
				,_Control.IPAddress.edata10
				);

return lib_fileservices.fileservices.Despray(pThorFilename,SourceIP,pDestinationFile,,,,TRUE);

end;