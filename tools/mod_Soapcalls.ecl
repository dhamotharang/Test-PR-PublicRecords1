import _control;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
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

  /////////////////////////////////////////////
  // -- fGetAttributes
  /////////////////////////////////////////////
	export fGetAttributes(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pEsp						= if(_Constants.IsDataland
																	,'10.241.12.207:8145'	//oss is 242,infiniband is '10.241.3.242'
																	,'uspr-prod-thor-esp.risk.regn.net:8145'
																)
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
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
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
			boolean Sandboxed   {xpath('Sandboxed'		)}	:= false;//pSandboxed   	;
			boolean Locked      {xpath('Locked'				)}	:= pLocked      	;
			boolean CheckedOut  {xpath('CheckedOut'		)}	:= pCheckedOut  	;
			boolean Orphaned    {xpath('Orphaned'			)}	:= pOrphaned    	;
			boolean GetText   	{xpath('GetText'			)}	:= pGetText   		;
			boolean IncludeHistory   	{xpath('IncludeHistory'			)}	:= pIncludeHistory   		;
			dataset(item_layout) Items{xpath('TypeList')} := dataset(['SALT'],item_layout);
                                                     
		end;                

		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;

		// userid_prod 	:= _control.MyInfo.UserID_prod;
		// password_prod	:= _control.MyInfo.Password_prod;

    url1 := 'http://' + pEsp + '/WsAttributes';
    // url2 := 'http://' + userid      + ':' + password      + '@' + pEsp + '/WsAttributes';
    // url3 := 'http://' + userid_prod + ':' + password_prod + '@' + pEsp + '/WsAttributes';
    // url := map(
       // _Constants.IsDataland = true  and pEsp = '10.241.12.207:8145'  => url1
      // ,_Constants.IsDataland = true  and pEsp = '10.173.84.202:8145' => url3
      // ,_Constants.IsDataland = false and pEsp = '10.173.84.202:8145' => url1
      // ,_Constants.IsDataland = false and pEsp = '10.241.12.207:8145'  => url2
      // ,''
    // );
    url := url1;
    
		results := SOAPCALL(
				url
			,'FindAttributes'
			,InfoInRecord
			,dataset(InfoOutRecord)
			,xpath('FindAttributesResponse')
		) 
		+
		SOAPCALL(
				url
			,'FindAttributes'
			,InfoInRecord2
			,dataset(InfoOutRecord)
			,xpath('FindAttributesResponse')
		);
		return results;
		
	end;
  /////////////////////////////////////////////
  // -- fNormResults
  /////////////////////////////////////////////
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

  /////////////////////////////////////////////
  // -- fFindAttributes
  /////////////////////////////////////////////
	export fFindAttributes(
	
		 string		pModuleNameRegex		= ''
		,string		pattributenameRegex	= ''
		,string		pEsp								= if(_Constants.IsDataland
																		,'10.241.12.207:8145'	//oss is 242,infiniband is '10.241.12.207'
																		,'uspr-prod-thor-esp.risk.regn.net:8145'
																	)
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
      ,pIncludeHistory  := pShouldIncludeHistory
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


  /////////////////////////////////////////////
  // -- fSaveAttribute
  /////////////////////////////////////////////
	export fSaveAttribute(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pText					 	= ''
		,string		pEsp						= if(_Constants.IsDataland
																	,'10.241.12.207:8145'	//oss is 242,infiniband is '10.241.12.207'
																	,'uspr-prod-thor-esp.risk.regn.net:8145'
																)
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
		
		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;

		// userid_prod 	:= _control.MyInfo.UserID_prod;
		// password_prod	:= _control.MyInfo.Password_prod;

    url1 := 'http://' + pEsp + '/WsAttributes';
    // url2 := 'http://' + userid      + ':' + password      + '@' + pEsp + '/WsAttributes';
    // url3 := 'http://' + userid_prod + ':' + password_prod + '@' + pEsp + '/WsAttributes';
/*
    url := map(
       _Constants.IsDataland = true  and pEsp = '10.241.12.207:8145'  => url1
      ,_Constants.IsDataland = true  and pEsp = '10.173.84.202:8145' => url3
      ,_Constants.IsDataland = false and pEsp = '10.173.84.202:8145' => url1
      ,_Constants.IsDataland = false and pEsp = '10.241.12.207:8145'  => url2
      ,''
    );
*/
    url := url1;
    
		results := SOAPCALL(
				url
			,'SaveAttributes'
			,AttributesIn
			,dataset(InfoOutRecord)
			,xpath('UpdateAttributesResponse')
		);
		return results;
		
	end;

  /////////////////////////////////////////////
  // -- fRenameAttribute
  /////////////////////////////////////////////
	export fRenameAttribute(
	
		 string		pModuleName			    = ''
		,string		pAttributeName	    = ''
		,string		pNewModuleName			= ''
		,string		pNewAttributeName	  = ''
		,string		pEsp						    = if(_Constants.IsDataland
                                      ,'10.241.12.207:8145'	//oss is 242,infiniband is '10.241.12.207'
                                      ,'uspr-prod-thor-esp.risk.regn.net:8145'
                                    )
	
	) := 
	function
	
		export AttributeRecord :=
		record, maxlength(100000)
   		string ModuleName		    {xpath('ModuleName'		    )}	:= pModuleName		  ;
   		string AttributeName    {xpath('AttributeName'    )}	:= pAttributeName	  ;
   		string NewModuleName		{xpath('NewModuleName'		)}	:= pNewModuleName		;
   		string NewAttributeName {xpath('NewAttributeName' )}	:= pNewAttributeName;
		end;                

		export RenameAttributeRequest :=
		record, maxlength(100000)

			dataset(AttributeRecord) RenameAttributeRequest{xpath('RenameAttributeRequest')} := dataset([{pModuleName,pAttributeName,pNewModuleName,pNewAttributeName}],AttributeRecord);

		end;

		export Attributes :=
		record, maxlength(100000)

			dataset(RenameAttributeRequest) Attributes{xpath('Attributes')} := dataset([{dataset([{pModuleName,pAttributeName,pNewModuleName,pNewAttributeName}],AttributeRecord)}],RenameAttributeRequest);

		end;

		export RenameAttributesRequest :=
		record, maxlength(100000)

			dataset(Attributes) RenameAttributesRequest{xpath('RenameAttributesRequest')} := dataset([{dataset([{dataset([{pModuleName,pAttributeName,pNewModuleName,pNewAttributeName}],AttributeRecord) }],RenameAttributeRequest) }],Attributes);

		end;
		
		// userid 		:= _control.MyInfo.UserID;
		// password	:= _control.MyInfo.Password;

		// userid_prod 	:= _control.MyInfo.UserID_prod;
		// password_prod	:= _control.MyInfo.Password_prod;

    url1 := 'http://' + pEsp + '/WsAttributes';
    // url2 := 'http://' + userid      + ':' + password      + '@' + pEsp + '/WsAttributes';
    // url3 := 'http://' + userid_prod + ':' + password_prod + '@' + pEsp + '/WsAttributes';
    // url := map(
       // _Constants.IsDataland = true  and pEsp = '10.241.12.207:8145'  => url1
      // ,_Constants.IsDataland = true  and pEsp = '10.173.84.202:8145' => url3
      // ,_Constants.IsDataland = false and pEsp = '10.173.84.202:8145' => url1
      // ,_Constants.IsDataland = false and pEsp = '10.241.12.207:8145'  => url2
      // ,''
    // );
    url := url1;
		results := SOAPCALL(
				url
			,'RenameAttributes'
			,Attributes
			,dataset(InfoOutRecord)
			,xpath('UpdateAttributesResponse')
		);
		return results;
		
	end;

	export fRollbackAttribute(
	
		 string		pModuleName			= ''
		,string		pAttributeName	= ''
		,string		pEsp						= if(_Constants.IsDataland
																	,'10.241.12.207:8145'	//oss is 242,infiniband is '10.241.12.207'
																	,'uspr-prod-thor-esp.risk.regn.net:8145'
																)
	
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
//////////////submit stuff

// ------------------------------------------------------------------------------------------------
export  string  fSubmitNewWorkunit(string pECLText, string pCluster, string pQueue, string pTargetESPIP, string pTargetESPPort)  :=
function

  // ------------------------------------------------------------------------------------------------
  string fWUCreateAndUpdate(string pECLText)  :=
  function
    rWUCreateAndUpdateRequest  :=
    record
      string                    QueryText{xpath('QueryText'),maxlength(20000)}                :=  pECLText;
    end;

    rESPExceptions  :=
    record
      string    Code{xpath('Code'),maxlength(10)};
      string    Audience{xpath('Audience'),maxlength(50)};
      string    Source{xpath('Source'),maxlength(30)};
      string    Message{xpath('Message'),maxlength(200)};
    end;

    rWUCreateAndUpdateResponse  :=
    record
      string                     Wuid{xpath('Workunit/Wuid'),maxlength(20)};
      dataset(rESPExceptions)    Exceptions{xpath('Exceptions/ESPException'),maxcount(110)};
    end;

    dWUCreateAndUpdateResult  :=  soapcall('http://' + pTargetESPIP + ':' + pTargetESPPort + '/WsWorkunits',
                                           'WUUpdate',
                                           rWUCreateAndUpdateRequest,
                                           rWUCreateAndUpdateResponse,
                                           xpath('WUUpdateResponse')
                                          );

    return  dWUCreateAndUpdateResult.WUID;
  end;

  // ------------------------------------------------------------------------------------------------
  fWUSubmit(string pWUID, string pCluster, string pQueue)  :=
  function
    rWUSubmitRequest  :=
    record
      string                    WUID{xpath('Wuid'),maxlength(20)}                    :=  pWUID;
      string                    Cluster{xpath('Cluster'),maxlength(30)}              :=  pCluster;
      string                    Queue{xpath('Queue'),maxlength(30)}                  :=  pQueue;
      string                    Snapshot{xpath('Snapshot'),maxlength(10)}            :=  '';
      string                    MaxRunTime{xpath('MaxRunTime'),maxlength(10)}        :=  '0';
      string                    Block{xpath('BlockTillFinishTimer'),maxlength(10)}   :=  '0';
    end;

    rWUSubmitResponse  :=
    record
      string                    Code{xpath('Code'),maxlength(10)};
      string                    Audience{xpath('Audience'),maxlength(50)};
      string                    Source{xpath('Source'),maxlength(30)};
      string                    Message{xpath('Message'),maxlength(200)};
    end;

    dWUSubmitResult  :=  soapcall('http://' + pTargetESPIP + ':' + pTargetESPPort + '/WsWorkunits',
                                  'WUSubmit',
                                  rWUSubmitRequest,
                                  rWUSubmitResponse,
                                  xpath('WUSubmitResponse/Exceptions/Exception')
                                 );

    return  dWUSubmitResult;
  end;

  string  lWUIDCreated   :=  fWUCreateAndUpdate(pECLText);
  dExceptions            :=  fWUSubmit(lWUIDCreated, pCluster, pQueue);
  string  ReturnValue    :=  if(dExceptions.Code = '',
                                lWUIDCreated,
                                ''
                               );
  return  ReturnValue;
  
//pass in attribute, do soapcall to get ecl text from that attribute.  do regexreplaces if necessary to change iteration # or version, etc
//create & submit workunit, then watch it.
//when completes successfully, email & kick off next one, incrementing the iteration# and whatever else in the ecl text.
//once all iterations are done, email completion, & fail meta job.
//if any workunits created fail, email and fail meta job, specifying which workunit failed and which iteration it was on, etc
 
  
/*	output(tools.mod_Soapcalls.fSubmitNewWorkunit(
	 pECLText				:= 'output(\'Hi, I am a workunit.  I just got created by a soapcall\');'
	,pCluster				:= 'thor5_241_10a'
	,pQueue					:= 'thor5_241_10a'
	,pTargetESPIP		:= '10.241.12.207'
	,pTargetESPPort	:= '8010'
));
	*/
end;
/*
http://dataland_esp:8010/WsWorkunits/WUPushEvent?EventNam
http://dataland_esp:8010/WsDFU/
http://10.173.3.6:8010/?inner=../WsDFU/DFUSearchData															-- view data file(roxie)
http://10.173.3.6:8010/?inner=../WsSMC/Activity																		-- dfu workunits
http://10.173.3.6:8010/?inner=../WsTopology/TpServiceQuery%3FType%3DALLSERVICES		-- system servers , target clusters
http://10.173.3.6:8010/?inner=../FileSpray/DFUWUSearch														-- view data file
http://10.173.3.6:8010/?inner=../WsRoxieQuery/RoxieFileSearch											-- search roxie files(by cluster and type(super/non-super))
http://10.173.3.6:8010/?inner=../WsRoxieQuery/RoxieQuerySearch										-- search roxie query(by cluster and suspended/non-suspended)
zz_cemtemp.BWR_CheckServiceSyntax -- might be able to use one of these new soapcalls to get all files used in queries
*/

end;
