export Layouts := module
Import Worldcheck_Bridger;

export input := 
module
export crAddresses	:=
		record,maxlength(15000)
			string	address1				{xpath('address1')};
			string	address2				{xpath('address2')};
			string	city						{xpath('city')};
			string	state_abbr_us		{xpath('state')};			
			string	state_name_us		{xpath('stateName')};			
			string	country_code		{xpath('country')};			
			string	country_name		{xpath('countryName')};			
			string	province				{xpath('province')};			
			string	postal_code			{xpath('postalCode')};			
		end;	
		
export crAlias	:=
		record,maxlength(20000)
			string	alias_cat				{xpath('@category')};
			string	alias_type			{xpath('@type')};
			string	alias						{xpath('')};
		end;			
		
export crCitizenship	:=
		record
			string	citizenship			{xpath('')};
		end;	
		
export crDOB	:=
		record
			string	dob							{xpath('')};
		end;
		
export crGroup	:=
		record,maxlength(28480)
			string	entity_id				{xpath('')};
			string	add_date				{xpath('@addDate')};
			string	list_id					{xpath('@list')};								
		end;	
		
export crIdentifications	:=
		record
			string	other_info			{xpath('@otherInfo')};
			string	id_type					{xpath('@type')};
			string	id							{xpath('')};
		end;
		
export crNationality	:=
		record
			string	nationality			{xpath('')};
		end;	
		
export crOtherIDs	:=
		record
			string	child_id	 			{xpath('')};
		end;
		
export crPOB	:=
		record
			string	pob							{xpath('')};
		end;	
	
export crPrograms :=
		record
			string	program_type		{xpath('@type')};
			string	program_desc		{xpath('')};
		end;
		
export crRoutingCode	:=
		record
			string	routing_type		{xpath('@type')};
			string	routing_code		{xpath('')};
		end;		

export crSupplemental	:=
		record
			string	sdf_name				{xpath('@name')};
			string	sdf_value				{xpath('')};
		end;
		
export crTitles :=
		record
			string	title						{xpath('')};
		end;				
		
					
export rEntity :=
	RECORD,maxlength(100000)
		string	id					      {xpath('@id')};
		string	version						{xpath('@version')};
		string	full_name					{xpath('name')};
		string	list_id						{xpath('listId')};
		string	list_code					{xpath('listCode')};
		string	type				      {xpath('entityType')};
		string	listed_date				{xpath('createdDate')};
		string	last_updated			{xpath('lastUpdateDate')};
		string	source						{xpath('source')};
		string	original_source		{xpath('OriginalSource')};		
		dataset(crDOB)										DOBs								{xpath('dobs/dob')};
		dataset(crPOB)										POBs								{xpath('pobs/pob')};
		dataset(crCitizenship)						Citizenships				{xpath('citizenships/citizenship')};
		dataset(crNationality)						Nationalities 			{xpath('nationalities/nationality')};
		dataset(crAlias)									AKAs    						{xpath('aliases/alias')};
		dataset(crIdentifications)				Identifications   	{xpath('ids/id')};
		dataset(crRoutingCode)						RoutingCodes  			{xpath('routingCodes/routingCode')};
		dataset(crPrograms)								Programs     				{xpath('programs/program')};
		dataset(crTitles)									Titles  						{xpath('titles/title')};
		dataset(crSupplemental)						Additional_Info     {xpath('sdfs/sdf')}; 
		dataset(crAddresses)							Addresses   				{xpath('addresses/address')}; 
		dataset(crOtherIDs)								OtherIDs						{xpath('otherIds/childId')};
	end;
		
export rGroups	:=
		record,maxlength(50000)
			string	group_id										{xpath('@id')};	
			dataset(crGroup)			Entity				{xpath('entity-id')};						
		end;	
		
export rSrccode := 
	record
		string LIST_ID												{xpath('LIST_ID')};
		string SOURCE_NAME										{xpath('SOURCE_NAME')};
		string SOURCE_CODE										{xpath('SOURCE_CODE')};
		string FILE_TYPE											{xpath('FILE_TYPE')};
		string FILE_SOURCE_CODE								{xpath('FILE_SOURCE_CODE')};
		string LAST_UPDATE_DATE								{xpath('LAST_UPDATE_DATE')};
	end;
	
export asBridger := 
module
export iuser_info_clientID := record
		string ClientID{xpath('ClientID')};
	end;

export ioutputType:= record
		string OutputType{xpath('OutputType')};
	end;
	
export ilistInfo := record
		string Type			{xpath('Type')}; 
		string ID			{xpath('ID')}; 
		string name			{xpath('Name')}; 
		string description	{xpath('Description')};
		string speciallistid{xpath('SpecialListID')};
		string encrypt		{xpath('Encrypt')}; 
		string publication	{xpath('Publication')};
		//dataset(Layout_country_rollup1) SearchCriteria;
	end;

end;
end;
end;


	
