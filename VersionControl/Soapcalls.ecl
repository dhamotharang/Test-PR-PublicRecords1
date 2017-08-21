import _control;
#option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
export Soapcalls :=
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
		,string		pUserName     	= ''
		,string		pPattern      	= ''
		,string		pRegexp       	= ''
		,string		pChangedSince 	= ''
		,boolean	pSandboxed   		= false
		,boolean	pLocked      		= false
		,boolean	pCheckedOut  		= false
		,boolean	pOrphaned    		= false
		,boolean	pGetText   			= false
	
	) := 
	function
	
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
                                                     
		end;                
		
		
		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;
		esp				:= if(_Flags.IsDataland
										,'dataland'
										,'prod'
		);
		
		results := SOAPCALL(
				'http://' + userid + ':' + password + '@' + esp + '_esp:8145/WsAttributes'
			,'FindAttributes'
			,InfoInRecord
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
		,string		pFullnameRegex			= ''
		,string		pLockedByRegex     	= ''
		,string		pModifiedByRegex   	= ''
		,string		pModifiedDateRegex 	= ''
		,string		pDescriptionRegex  	= ''
		,string		pTextRegex         	= ''
		,string		pTextFind         	= ''
		,boolean	pIsLocked     			= false
		,boolean	pIsCheckedOut 			= false
		,boolean	pIsSandbox    			= false
		,boolean	pIsOrphaned   			= false
	            
	) := 
	function

		dgetattributes := fGetAttributes(
		  ,pGetText   			:= true   			
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
end;