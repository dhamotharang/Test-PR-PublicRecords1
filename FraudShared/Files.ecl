import tools,Data_Services,Inquiry_AccLogs, hygenics_search;

export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	export Input := module
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.Mbs                   ,Layouts.Input.Mbs                    ,Mbs 										, 'CSV'		,,'|\n','|\t|'  	,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MbsNewGcIdExclusion   ,Layouts.Input.MbsNewGcIdExclusion    ,MbsNewGcIdExclusion  	, 'CSV'		,,'|\n','|\t|'  	,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MbsIndTypeExclusion 	,Layouts.Input.MbsIndTypeExclusion    ,MbsIndTypeExclusion  	, 'CSV'		,,'|\n','|\t|'  	,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MbsProductInclude   	,Layouts.Input.MbsProductInclude      ,MbsProductInclude    	, 'CSV'		,,'|\n','|\t|'   	,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSSourceGcExclusion	,Layouts.Input.MBSSourceGcExclusion   ,MBSSourceGcExclusion , 'CSV'		  ,,'|\n','|\t|'    ,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSFdnIndType       	,Layouts.Input.MBSFdnIndType          ,MBSFdnIndType    			, 'CSV'		,,'|\n','|\t|'    ,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSFdnCCID       			,Layouts.Input.MBSFdnCCID             ,MBSFdnCCID    					, 'CSV'		,,'\n');
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSFdnHHID       			,Layouts.Input.MBSFdnHHID             ,MBSFdnHHID    					, 'CSV'		,,'|\n','|\t|'    ,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSTableCol       		  ,Layouts.Input.MBSTableCol            ,MBSTableCol    				, 'CSV'		,,'|\n','|\t|'    ,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSColValDesc       	,Layouts.Input.MBSColValDesc          ,MBSColValDesc    			, 'CSV'		,,'|\n','|\t|'    ,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MBSmarketAppend     	,Layouts.Input.MBSmarketAppend        ,MBSmarketAppend    		, 'CSV'		,,['\n','\r\n','\n\r'],['|','\t']    ,,,true );
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MbsFdnMasterIDIndTypeInclusion ,Layouts.Input.MbsFdnMasterIDIndTypeInclusion      , MbsFdnMasterIDIndTypeInclusion , 'CSV'		,,'|\n','|\t|'  	,,,true ); 
	  tools.mac_FilesInput(Filenames(pversion,pUseProd).Input.MbsVelocityRules 			,Layouts.Input.MbsVelocityRules       ,MbsVelocityRules  			, 'CSV'		,,'|\n','|\t|'  	,,,true ); 

		end;
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	export Base := module
	  tools.mac_FilesBase(Filenames(pversion,pUseProd).Base.Main               ,Layouts.Base.Main                   ,Main                );
	end;

end;