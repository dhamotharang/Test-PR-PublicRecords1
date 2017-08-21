import _control,VersionControl;

export Spray_CompID(
			string pVersion				=	Version
			,string pSourceDIR			=	'/hds_180/cid/weekly/in/'
			,string pTarget				=	'thor_data400::in::alpharetta::compid'
			,string pSourceIP			=	_Control.IPAddress.edata12
			,string pDestinationgroup	=	_Control.ThisCluster.GroupName
			) := function

	FilesToSpray := DATASET([

	 	{pSourceIP
	 	,pSourceDIR
	 	,'LN_*'
	 	,sizeof(compID.Layout_compID)
	 	,'~thor_data400::in::alpharetta::compid::@version@'
	 	,[{'~'+pTarget}]
	 	,pDestinationgroup
		,pVersion
	 	}

	], VersionControl.Layout_Sprays.Info);	
	
	fSpray:=VersionControl.fSprayInputFiles(FilesToSpray,,,,,,false);

	return sequential(
					Promote(pVersion,pTarget)._delete
					,Promote(pVersion,pTarget)._father
					,Promote(pVersion,pTarget)._prod
					,fSpray
					);

END;