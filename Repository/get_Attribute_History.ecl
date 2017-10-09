EXPORT get_Attribute_History(

   string		pModuleName			= ''
  ,string		pAttributeName	= ''
  ,string		pEsp						= _Config().Esp
  ,string		pUrl						= _Config(pEsp).Url
  ,string		pFromDate     	= ''
  ,string		pToDate        	= ''
	
) := 
function

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
		unsigned4 Version         {xpath('Version'       )};
		unsigned4 Flags           {xpath('Flags'         )};
		unsigned4 Access          {xpath('Access'        )};
		string		ModifiedBy      {xpath('ModifiedBy'    )};
		string		ModifiedDate    {xpath('ModifiedDate'  )};
		string		Description     {xpath('Description'   )};
		string		Checksum        {xpath('Checksum'      )};
                           
	end;
	
	export InfoOutRecord :=
	record, maxlength(200000000)
	
		string exception_code{xpath('Exceptions/Exception/Code')};
		string exception_source{xpath('Exceptions/Exception/Source')};
		string exception_msg{xpath('Exceptions/Exception/Message')};
		
		dataset(eclResultLayout) results{xpath('outAttributes/ECLAttribute')};
	
	end;

  export InfoInRecord :=
  record, maxlength(500)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
    string FromDate     {xpath('FromDate'			)}	:= pFromDate   	  ;
    string ToDate       {xpath('ToDate'			  )}	:= pToDate     	  ;                                                     
  end;                
  
  url := 'http://' + pEsp + '/WsAttributes?ver_=1.21';
  
  results := 
    SOAPCALL(url,'GetAttributeHistory',InfoInRecord ,dataset(InfoOutRecord),xpath('GetAttributeHistoryResponse'))
    ;
		
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
		
		normit := distribute(normalize(results, left.results,tNormfiles(left,right)), random()) ;//: global;
		
		return sort(normit,modulename,attributename);
		

end;