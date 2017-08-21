import mdr;
export fCheckSources(

		 dataset(Layout_Business_Header_base			) pBusinessHeader		= files().base.business_headers.built
		,dataset(Layout_Business_Contact_Full_new	)	pBusinessContact	= files().base.business_contacts.built

) :=
module

	export fBusinessHeader(
		
		boolean		pShouldReturnGoodSources	= true
	) :=
	function
	
		//Get unique source codes from file
		dUniqueSources := table(pBusinessHeader	, {source, string description := mdr.sourceTools.translatesource(source)}	,source ,few);
		
		dGoodSources	:= dUniqueSources(trim(description[1]) != '?');
		dBadSources		:= dUniqueSources(trim(description[1]) = '?');
		
		
		return if(pShouldReturnGoodSources = true
			,dGoodSources
			,dBadSources
		);

	end;

	export fBusinessContacts(
		
		boolean		pShouldReturnGoodSources	= true
	) :=
	function
	
		//Get unique source codes from file
		dUniqueSources := table(pBusinessContact	, {source, string description := mdr.sourceTools.translatesource(source)
																			}	,source ,few);
		
		dGoodSources	:= dUniqueSources(trim(description[1]) != '?');
		dBadSources		:= dUniqueSources(trim(description[1]) = '?');
		
		
		return if(pShouldReturnGoodSources = true
			,dGoodSources
			,dBadSources
		);

	end;
	
	export All := 
	parallel(
	
		 output(fBusinessHeader		(				), named('BusinessHeaderValidSources'			), all)
		,output(fBusinessHeader		(false	), named('BusinessHeaderNotFoundSources'	), all)
		,output(fBusinessContacts	(				), named('BusinessContactsValidSources'		), all)
		,output(fBusinessContacts	(false	), named('BusinessContactsNotFoundSources'), all)
	
	);

end;