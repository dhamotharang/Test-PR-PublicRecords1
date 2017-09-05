EXPORT get_Attributes :=
module

// --------------------------------------------
	export matched_lines_layout :=
	record
		unsigned4 LineNumber	{xpath('LineNumber'	)};
		string		LineText		{xpath('LineText'		)};
	end;
	export eclResultLayout :=
	record, maxlength(5000000)
	
		string		ModuleName			{xpath('ModuleName'		 )};
		string		attributename   {xpath('Name'          )};
		string		attributeType   {xpath('Type'          )};
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

  /////////////////////////////////////////////
  // -- fGetAttributes
  /////////////////////////////////////////////
	export GetAttributes(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pEsp						= Repository._Config().Esp
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
    ,set of string  pTypes = ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']  //// esdl, xslt, kel, dud, cmp
	
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
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset([{'ECL'}],item_layout);
                                                     
		end;                
		
		export InfoInRecord2 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['SALT'],item_layout);
                                                     
		end;                

		export InfoInRecord3 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['ESDL'],item_layout);
                                                     
		end;                

		export InfoInRecord4 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['XSLT'],item_layout);
                                                     
		end;                

		export InfoInRecord5 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['KEL'],item_layout);
                                                     
		end;                

		export InfoInRecord6 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['DUD'],item_layout);
                                                     
		end;                

		export InfoInRecord7 :=
		record, maxlength(500)
   		string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
   		string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
			string UserName     {xpath('UserName'			)}	:= pUserName     	;
			string Pattern      {xpath('Pattern'			)}	:= pPattern      	;
			string Regexp       {xpath('Regexp'				)}	:= pRegexp       	;	
			string ChangedSince {xpath('ChangedSince'	)}	:= pChangedSince 	;
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) TypeList{xpath('TypeList')} := dataset(['CMP'],item_layout);
                                                     
		end;                
// esdl, xslt, kel, dud, cmp
// ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']
    url := 'http://' + pEsp + '/WsAttributes?ver_=1.21';
    
		results := 
      if('ECL'  in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord ,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
		+ if('SALT' in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord2,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
		+ if('ESDL' in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord3,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
		+ if('XSLT' in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord4,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
		+ if('KEL'  in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord5,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
		+ if('DUD'  in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord6,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
		+ if('CMP'  in pTypes  ,SOAPCALL(url,'FindAttributes',InfoInRecord7,dataset(InfoOutRecord),xpath('FindAttributesResponse')) ,dataset([],InfoOutRecord) )
    ;
		return results;
		
	end;
  /////////////////////////////////////////////
  // -- fNormResults
  /////////////////////////////////////////////
	export NormResults(
	
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
		
		normit := distribute(normalize(pInfoOut, left.results,tNormfiles(left,right)), random()) ;//: global;
		
		return normit;
	
	end;

  /////////////////////////////////////////////
  // -- fFindAttributes
  /////////////////////////////////////////////
	export FindAttributes(
	
		 string		pModuleNameRegex		= ''
		,string		pattributenameRegex	= ''
		,string		pEsp								= Repository._Config().Esp
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
	  ,boolean  pShouldIncludeHistory     = false      
    ,set of string  pAttribute_Types      = ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']  //// esdl, xslt, kel, dud, cmp
	) := 
	function
		dgetattributes := GetAttributes(
			 pModuleNameRegex
			,
			,pEsp
			,pPattern					:= pPattern
			,pRegexp 					:= pRegexp 
		  ,pGetText   			:= pGetText   
			,pSandboxed				:= pIsSandbox
      ,pIncludeHistory  := pShouldIncludeHistory
      ,pTypes           := pAttribute_Types
		);                   
		  
		dnormresults := NormResults(dgetattributes);
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
		
		return sort(dnormresults/*(filter)*/,modulename,attributename);
		
	end;

/*  Gets all attributes for specified module
tools.fun_GetAttributes(
	 pModuleName          := 'oldmod'
	,pAttributeNamesRegex	:= ''   
	,pSandboxed				    := false 
);
*/
export Get_All(

	 string		      pModuleName
	,string 	      pAttributeNamesRegex	= ''    //filter for specific attributes
	,boolean	      pSandboxed				    = false 
  ,boolean        pGetHistory           = false
  ,set of string  pAttributeTypes       = ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']  //// esdl, xslt, kel, dud, cmp
	,string		      pEsp								  = Repository._Config().Esp
  ,boolean        pAddImportText        = true
) :=
function
  

	datts     := FindAttributes(pModuleName,pAttributeNamesRegex,pEsp,,pSandboxed,pShouldIncludeHistory := pGetHistory,pAttribute_Types := pAttributeTypes) ;//: independent;
	
	datts_proj := project(datts, transform(
	{string modulename,string attributename,string fullname,string ModifiedBy,string ModifiedDate,string Description,string attributeType, string importtext {maxlength(1000000)}, string actualtext {maxlength(1000000)}}
	,attname := left.fullname;
	
	 self.importtext 		:= 		if(pAddImportText = true,
                            '//Import:'       + attname           + '\n'
                          + '//ModifiedBy:'   + left.ModifiedBy   + '\n'
                          + '//ModifiedDate:' + left.ModifiedDate + '\n'
                          + '//Description:'  + left.Description  + '\n'
                          + '//attributeType:'+ left.attributeType+ '\n'
                          ,'')
													+ left.text
													;
	 self.actualtext 		:= left.text;
	 self.fullname 		  := attname;
	 self.attributename	:= left.attributename;
	 self.modulename   	:= pModuleName;
   self.attributeType := left.attributeType;
   self               := left;
	));
  
  dresult := datts_proj;	

  return dresult;
  	
end;
end;