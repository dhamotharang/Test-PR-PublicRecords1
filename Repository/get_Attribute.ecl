export get_Attribute(
	
   string		pModuleName			  = ''
  ,string		pAttributeName	  = ''
  ,unsigned	pVersion        	= 1
  ,boolean	pGetSandbox       = false
  ,boolean	pGetText          = true
  ,string		pEsp						  = _Config().Esp
  ,string		pUrl						  = _Config(pEsp).Url
  ,string		pType         	  = ''
  ,string		pLabel       	    = ''
  ,boolean	pSandboxForLabel  = false
	
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
		string		ModifiedBy      {xpath('ModifiedBy'    )};
		string		ModifiedDate    {xpath('ModifiedDate'  )};
		string		Description     {xpath('Description'   )};
		string		Checksum        {xpath('Checksum'      )};
		string		Text            {xpath('Text'          )};
                           
	end;	
	export InfoOutRecord :=
	record, maxlength(200000000)
	
		string exception_code{xpath('Exceptions/Exception/Code')};
		string exception_source{xpath('Exceptions/Exception/Source')};
		string exception_msg{xpath('Exceptions/Exception/Message')};
		
		dataset(eclResultLayout) results{xpath('outAttribute')};
	
	end;

  export InfoInRecord :=
  record, maxlength(500)
    string   ModuleName		  {xpath('ModuleName'		  )}	:= pModuleName		  ;
    string   AttributeName  {xpath('AttributeName'  )}	:= pAttributeName	  ;
    string   Type         	{xpath('Type'         	)}	:= pType         	  ;
    unsigned Version        {xpath('Version'        )}	:= pVersion         ;                                                     
    boolean  GetSandbox     {xpath('GetSandbox'     )}	:= pGetSandbox      ;
    boolean  GetText        {xpath('GetText'        )}	:= pGetText         ;
    string   Label       	  {xpath('Label'       	  )}	:= pLabel       	  ;
    boolean  SandboxForLabel{xpath('SandboxForLabel')}	:= pSandboxForLabel ;                                                     
  end;                
  
  
  results := 
    SOAPCALL(pUrl,'GetAttribute',InfoInRecord ,dataset(InfoOutRecord),xpath('GetAttributeResponse'))
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