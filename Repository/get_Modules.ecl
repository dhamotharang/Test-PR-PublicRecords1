EXPORT get_Modules :=
module

  export ECLModule  :=
  record
    string  Name     {xpath('Name'     )}	;
    integer Flags    {xpath('Flags'    )}	;
    integer Access   {xpath('Access'   )}	;
    integer Timestamp{xpath('Timestamp')}	;
  end;                

  export GetModulesResponse :=
  record, maxlength(200000000)
  
    string exception_code   {xpath('Exceptions/Exception/Code')};
    string exception_source {xpath('Exceptions/Exception/Source')};
    string exception_msg    {xpath('Exceptions/Exception/Message')};
    
    dataset(ECLModule) results{xpath('outModules/ECLModule')};
  
  end;

  /////////////////////////////////////////////
  // -- fGetAttributes
  /////////////////////////////////////////////
	export GetModules(
	
		 string		pModifiedSince	= ''
		,string		pIncludeDeleted	= ''
		,string		pGetChecksum   	= ''
		,string		pLabel         	= ''
		,string		pEarMark       	= ''
		,string		pEsp						= Repository._Config().Esp
	) := 
	function

		export GetModulesRequest :=
		record, maxlength(500)
   		string ModifiedSince	{xpath('ModifiedSince'	)}	:= pModifiedSince	 ;
   		string IncludeDeleted {xpath('IncludeDeleted' )}	:= pIncludeDeleted ;
			string GetChecksum    {xpath('GetChecksum'    )}	:= pGetChecksum    ;
			string Label          {xpath('Label'          )}	:= pLabel          ;
			string EarMark        {xpath('EarMark'        )}	:= pEarMark        ;	
                                                     
		end;                

    url := 'http://' + pEsp + '/WsAttributes?ver_=1.21';
    
		results := SOAPCALL(
				url
			,'GetModules'
			,GetModulesRequest
			,dataset(GetModulesResponse)
			,xpath('GetModulesResponse')
		); 

		return results;
		
	end;

  /////////////////////////////////////////////
  // -- fNormResults
  /////////////////////////////////////////////
	export NormModules(
	
		 dataset(GetModulesResponse) pInfoOut
	
	) :=
	function

		ECLModule tNormfiles(GetModulesResponse l, ECLModule r) :=
		transform
			self := r;
			// self.fullname := r.modulename + '.' + r.attributename;
		end;
		
		normit := distribute(normalize(pInfoOut, left.results,tNormfiles(left,right)), random()) : global;
		
		return normit;
	
	end;

  /////////////////////////////////////////////
  // -- fFindAttributes
  /////////////////////////////////////////////
	export Get_All(
	
		 string		pModifiedSince	= ''
		,string		pIncludeDeleted	= ''
		,string		pGetChecksum   	= ''
		,string		pLabel         	= ''
		,string		pEarMark       	= ''
		,string		pEsp						= Repository._Config().Esp
	) := 
	function
		dgetmodules := GetModules(
			 pModifiedSince	
			,pIncludeDeleted	
			,pGetChecksum   	
			,pLabel         	
			,pEarMark       	
		  ,pEsp						
		);                   
		  
		dnormresults := NormModules(dgetmodules);
		
		return sort(dnormresults(regexfind('^[[:alnum:]_]+$',name,nocase), flags = 0),name);
		
	end;
  
end;