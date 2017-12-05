﻿/*
  Checkout_Attribute()
    Checks out an attribute
*/
EXPORT Checkout_Attribute(

   string		pModuleName			= ''
  ,string		pAttributeName	= ''
  ,string		pEsp						= _Config().Esp
  ,string		pUrl						= _Config(pEsp).Url

) := 
function

  export AttributeRecord :=
  record, maxlength(100000)
    string ModuleName		{xpath('ModuleName'		)}	:= pModuleName		;
    string AttributeName{xpath('AttributeName')}	:= pAttributeName	;
  end;                

  export CheckoutAttributeRequestRecord :=
  record, maxlength(100000)

    dataset(AttributeRecord) Fields{xpath('CheckoutAttributeRequest')} := dataset([{pModuleName,pAttributeName}],AttributeRecord);

  end;

  export AttributesIn :=
  record, maxlength(100000)

    dataset(CheckoutAttributeRequestRecord) CheckoutAttributeRequests{xpath('Attributes')} := dataset([{dataset([{pModuleName,pAttributeName}],AttributeRecord)}],CheckoutAttributeRequestRecord);

  end;

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
	
		string exception_code   {xpath('Exceptions/Exception/Code'    )};
		string exception_source {xpath('Exceptions/Exception/Source'  )};
		string exception_msg    {xpath('Exceptions/Exception/Message' )};
		
		dataset(eclResultLayout) results{xpath('outAttributes/ECLAttribute')};
	
	end;
    
  results := SOAPCALL(
      pUrl
    ,'CheckoutAttributes'
    ,AttributesIn
    ,dataset(InfoOutRecord)
    ,xpath('UpdateAttributesResponse')
  );
  
  return results;
  
end;