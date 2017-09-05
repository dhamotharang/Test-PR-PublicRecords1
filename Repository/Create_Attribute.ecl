/*
  Create_Attribute()
    Creates an attribute in the repository.
    Createattribute can't create salt attributes, only ecl attributes.  but this can create any type of attribute
    soapcall gets a "socket not opened" error.  might be a soapcall shared object error.
*/
EXPORT Create_Attribute(
	
   string		pModuleName			= ''
  ,string		pAttributeName	= ''
  ,string		pType    	      = ''
  ,string		pEsp						= _Config().Esp
  ,string		pUrl						= _Config(pEsp).Url

) := 
function

  export AttributeRecord :=
  record, maxlength(100000)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
    string AttributeType{xpath('AttributeType'				  )}	:= pType     		  ;
  end;                

  export CreateAttRequestRecord :=
  record, maxlength(100000)

    dataset(AttributeRecord) Fields{xpath('CreateAttributeRequest')} := dataset([{pModuleName,pAttributeName,pType}],AttributeRecord);

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
                           
	end;

	export InfoOutRecord :=
	record, maxlength(200000000)
	
		string exception_code   {xpath('Exceptions/Exception/Code'    )};
		string exception_source {xpath('Exceptions/Exception/Source'  )};
		string exception_msg    {xpath('Exceptions/Exception/Message' )};
		
		// dataset(eclResultLayout) results{xpath('AttributeInfo')};
	
	end;
    
  results := SOAPCALL(
      pUrl
    // ,'CreateAttribute'
    ,'CreateAttribute'
    // ,'SaveAttributes'
    ,CreateAttRequestRecord
    ,dataset(InfoOutRecord)
    ,xpath('CreateAttributeResponse')
    // ,literal
  );
  
  return results;
  
end;
