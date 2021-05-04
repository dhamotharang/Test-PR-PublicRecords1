//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
export mod_Soapcalls :=
module
	export matched_lines_layout :=
	record
		unsigned4 LineNumber	{xpath('LineNumber'	)};
		string		LineText		{xpath('LineText'		)};
	end;
	export eclResultLayout :=
	record, maxlength(5000000)
	
		string		ModuleName			{xpath('ModuleName'		 )};
		string		attributename   {xpath('Name'          )};
		string		Type            {xpath('Type'          )};
		unsigned4 Version         {xpath('Version'       )};
		unsigned4 LatestVersion   {xpath('LatestVersion' )};
		unsigned4 SandboxVersion  {xpath('SandboxVersion')};
		unsigned4 Flags           {xpath('Flags'         )};
		unsigned4 Access          {xpath('Access'        )};
		boolean		IsLocked        {xpath('IsLocked'      )};
		boolean		IsCheckedOut    {xpath('IsCheckedOut'  )};
		boolean		IsSandbox       {xpath('IsSandbox'     )};
		boolean		IsOrphaned      {xpath('IsOrphaned'    )};
		unsigned4 ResultType      {xpath('ResultType'    )};
		string		LockedBy        {xpath('LockedBy'      )};
		string		ModifiedBy      {xpath('ModifiedBy'    )};
		string		ModifiedDate    {xpath('ModifiedDate'  )};
		string		Description     {xpath('Description'   )};
		string		Checksum        {xpath('Checksum'      )};
		string		Text            {xpath('Text'          )};
		dataset(matched_lines_layout) MatchedLines{xpath('MatchedLines/Line')};
                           
	end;
	
	export InfoOutRecord :=
	record, maxlength(200000000)
	
		string exception_code{xpath('Exceptions/Exception/Code')};
		string exception_source{xpath('Exceptions/Exception/Source')};
		string exception_msg{xpath('Exceptions/Exception/Message')};
		
		dataset(eclResultLayout) results{xpath('outAttributes/ECLAttribute')};
	
	end;
	export fGetAttributes(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pEsp						
		,string		pUserName     	= ''
		,string		pPattern      	= ''
		,string		pRegexp       	= ''
		,string		pChangedSince 	= ''
		,boolean	pSandboxed   		= false
		,boolean	pLocked      		= false
		,boolean	pCheckedOut  		= false
		,boolean	pOrphaned    		= false
		,boolean	pGetText   			= true
		,boolean	pIncludeHistory = false
	
	) := 
	function
		export item_layout :=
		record
			string		Item		{xpath('Item'		)};
		end;
		export InfoInRecord :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) Items{xpath('TypeList')} := dataset(['ECL'],item_layout);
                                                     
		end;                
		
		export InfoInRecord2 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) Items{xpath('TypeList')} := dataset(['SALT'],item_layout);
                                                     
		end;                
				
		results := SOAPCALL(
				'http://' + pEsp + '/WsAttributes'
			,'FindAttributes'
			,InfoInRecord
			,dataset(InfoOutRecord)
			,xpath('FindAttributesResponse')
		) 
		+
		SOAPCALL(
				'http://' + pesp + '/WsAttributes'
			,'FindAttributes'
			,InfoInRecord2
			,dataset(InfoOutRecord)
			,xpath('FindAttributesResponse')
		);
		return results;
		
	end;
	export fNormResults(
	
		 dataset(InfoOutRecord) pInfoOut
	
	) :=
	function
	resultlayout := 
	record, maxlength(5000000)
	
		eclResultLayout;
		string fullname;
	
	end;
		resultlayout tNormfiles(InfoOutRecord l, eclResultLayout r) :=
		transform
			self := r;
			self.fullname := r.modulename + '.' + r.attributename;
		end;
		
		normit := distribute(normalize(pInfoOut, left.results,tNormfiles(left,right)), random()) : global;
		
		return normit;
	
	end;
	export fFindAttributes(
	
		 string		pModuleNameRegex		= ''
		,string		pattributenameRegex	= ''
		,string		pEsp								= ''
		,boolean	pGetText   					= true
		,boolean	pIsSandbox    			= false
		,string		pFullnameRegex			= ''
		,string		pLockedByRegex     	= ''
		,string		pModifiedByRegex   	= ''
		,string		pModifiedDateRegex 	= ''
		,string		pDescriptionRegex  	= ''
		,string		pTextRegex         	= ''
		,string		pTextFind         	= ''
		,string		pPattern         		= ''
		,string		pRegexp          		= ''
		,boolean	pIsLocked     			= false
		,boolean	pIsCheckedOut 			= false
		,boolean	pIsOrphaned   			= false
	            
	) := 
	function
		dgetattributes := fGetAttributes(
			 pModuleNameRegex
			,
			,pEsp
			,pPattern					:= pPattern
			,pRegexp 					:= pRegexp 
		  ,pGetText   			:= pGetText   
			,pSandboxed				:= pIsSandbox
		);                   
		  
		dnormresults := fNormResults(dgetattributes);
		filter := 
				if(pModuleNameRegex			!= ''		,regexfind(pModuleNameRegex			,dnormresults.ModuleName		,nocase)	,true)
		and if(pattributenameRegex	!= ''		,regexfind(pattributenameRegex	,dnormresults.attributename ,nocase)	,true)
		and if(pFullnameRegex				!= ''		,regexfind(pFullnameRegex				,dnormresults.fullname 			,nocase)	,true)
		and if(pLockedByRegex     	!= ''		,regexfind(pLockedByRegex     	,dnormresults.LockedBy      ,nocase)	,true)
  	and if(pModifiedByRegex   	!= ''		,regexfind(pModifiedByRegex   	,dnormresults.ModifiedBy    ,nocase)	,true)
		and if(pModifiedDateRegex 	!= ''		,regexfind(pModifiedDateRegex 	,dnormresults.ModifiedDate  ,nocase)	,true)
		and if(pDescriptionRegex  	!= ''		,regexfind(pDescriptionRegex  	,dnormresults.Description   ,nocase)	,true)
		and if(pTextRegex         	!= ''		,regexfind(pTextRegex         	,dnormresults.Text          ,nocase)	,true)
		and if(pTextFind         		!= ''		,stringlib.stringfind(dnormresults.Text,pTextFind,1) != 0							,true)
		and if(pIsLocked     				 = true	,dnormresults.IsLocked 																								,true)
    and if(pIsCheckedOut				 = true ,dnormresults.IsCheckedOut																						,true)
    and if(pIsSandbox   			 	 = true ,dnormresults.IsSandbox   																						,true)
    and if(pIsOrphaned  				 = true ,dnormresults.IsOrphaned  																						,true)
    ;
		
		return sort(dnormresults(filter),modulename,attributename);
		
	end;
	export fSaveAttribute(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pText					 	= ''
		,string		pEsp						= ''
		,string		pFlags     			= ''
		,string		pResultType    	= ''
		,string		pDescription   	= ''
	
	) := 
	function
	
		export AttributeRecord :=
		record, maxlength(100000)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string Flags     		{xpath('Flags'				)}	:= pFlags     		;
			string ResultType   {xpath('ResultType'		)}	:= pResultType   	;
			string Description  {xpath('Description'	)}	:= pDescription  	;	
			string Text 				{xpath('Text'					)}	:= pText					;
		end;                
		export SaveAttRequestRecord :=
		record, maxlength(100000)
			dataset(AttributeRecord) Fields{xpath('SaveAttributeRequest')} := dataset([{pModuleName,pAttributeName,pFlags,pResultType,pDescription,pText}],AttributeRecord);
		end;
		export AttributesIn :=
		record, maxlength(100000)
			dataset(SaveAttRequestRecord) SaveAttRequests{xpath('Attributes')} := dataset([{dataset([{pModuleName,pAttributeName,pFlags,pResultType,pDescription,pText}],AttributeRecord)}],SaveAttRequestRecord);
		end;
		
		results := SOAPCALL(
				'http://' + pEsp + '/WsAttributes'
			,'SaveAttributes'
			,AttributesIn
			,dataset(InfoOutRecord)
			,xpath('UpdateAttributesResponse')
		);
		return results;
		
	end;
	export fRollbackAttribute(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pEsp						= ''
	
	) := 
	function
	
		export AttributeRecord :=
		record, maxlength(100000)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
		end;                
		export SaveAttRequestRecord :=
		record, maxlength(100000)
			dataset(AttributeRecord) Fields{xpath('RollbackAttributeRequest')} := dataset([{pModuleName,pAttributeName}],AttributeRecord);
		end;
		export AttributesIn :=
		record, maxlength(100000)
			dataset(SaveAttRequestRecord) SaveAttRequests{xpath('Attributes')} := dataset([{dataset([{pModuleName,pAttributeName}],AttributeRecord)}],SaveAttRequestRecord);
		end;
				
		results := SOAPCALL(
				'http://'+ pesp + '/WsAttributes'
			,'RollbackAttributes'
			,AttributesIn
			,dataset(InfoOutRecord)
			,xpath('UpdateAttributesResponse')
		);
		return results;
		
	end;
/////
	export mac_FindAttributes(
	
		 pModuleNameRegex			= ''
		,pattributenameRegex	= ''
		,pFullnameRegex				= ''
		,pLockedByRegex     	= ''
		,pModifiedByRegex   	= ''
		,pModifiedDateRegex 	= ''
		,pDescriptionRegex  	= ''
		,pTextRegex         	= ''
		,pTextFind         		= ''
		,pPattern         		= ''
		,pRegexp          		= ''
		,pIsLocked     				= false
		,pIsCheckedOut 				= false
		,pIsSandbox    				= false
		,pIsOrphaned   				= false
		,pGetText   					= true
	            
	) := 
	functionmacro
		dgetattributes := fGetAttributes(
			 pModuleNameRegex
			,pPattern					:= pPattern
			,pRegexp 					:= pRegexp 
		  ,pGetText   			:= pGetText   			
		);                   
		  
		dnormresults := fNormResults(dgetattributes);
		filter := 
				if(pModuleNameRegex			!= ''		,regexfind(pModuleNameRegex			,dnormresults.ModuleName		,nocase)	,true)
		and if(pattributenameRegex	!= ''		,regexfind(pattributenameRegex	,dnormresults.attributename ,nocase)	,true)
		and if(pFullnameRegex				!= ''		,regexfind(pFullnameRegex				,dnormresults.fullname 			,nocase)	,true)
		and if(pLockedByRegex     	!= ''		,regexfind(pLockedByRegex     	,dnormresults.LockedBy      ,nocase)	,true)
  	and if(pModifiedByRegex   	!= ''		,regexfind(pModifiedByRegex   	,dnormresults.ModifiedBy    ,nocase)	,true)
		and if(pModifiedDateRegex 	!= ''		,regexfind(pModifiedDateRegex 	,dnormresults.ModifiedDate  ,nocase)	,true)
		and if(pDescriptionRegex  	!= ''		,regexfind(pDescriptionRegex  	,dnormresults.Description   ,nocase)	,true)
		and if(pTextRegex         	!= ''		,regexfind(pTextRegex         	,dnormresults.Text          ,nocase)	,true)
		and if(pTextFind         		!= ''		,stringlib.stringfind(dnormresults.Text,pTextFind,1) != 0							,true)
		and if(pIsLocked     				 = true	,dnormresults.IsLocked 																								,true)
    and if(pIsCheckedOut				 = true ,dnormresults.IsCheckedOut																						,true)
    and if(pIsSandbox   			 	 = true ,dnormresults.IsSandbox   																						,true)
    and if(pIsOrphaned  				 = true ,dnormresults.IsOrphaned  																						,true)
    ;
		
		return sort(dnormresults(filter),modulename,attributename);
		
	endmacro;
end;
