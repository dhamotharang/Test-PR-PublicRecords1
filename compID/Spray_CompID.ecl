import _control,VersionControl;

export Spray_CompID(
			string pVersion				=	Version
			,string pSourceDIR			=	'/hds_180/cid/'
			,string pTarget				=	'~thor_data400::in::alpharetta::compid'
			,string pSourceIP			=	_Control.IPAddress.edata12
			,string pDestinationgroup	=	_Control.ThisCluster.GroupName
			) := function

	clear_sf:=fileservices.clearsuperfile(pTarget);

	FilesToSpray := DATASET([

	 	{pSourceIP
	 	,pSourceDIR
	 	,'LN_*'
	 	,sizeof(compID.Layout_compID)
	 	,'~thor_data400::in::alpharetta::compid::@version@'
	 	,[{pTarget}]
	 	,pDestinationgroup
		,pVersion
	 	}

	], VersionControl.Layout_Sprays.Info);	
	
	fSpray:=VersionControl.fSprayInputFiles(FilesToSpray,,,,,,false);

	return sequential(
					clear_sf
					,fSpray
					);

END;