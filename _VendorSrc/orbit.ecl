import misc, ut, lib_fileservices, _Control, Orbit3SOA;



export OutputRecordFFD := record
	 
		string    item_id                       {xpath('d[k="819"]/v')};       // Legacy Id 
		string    item_name                     {xpath('d[k="21"]/v')};        // Dataset Name                   
		string    item_description              {xpath('d[k="15"]/v')};        // Dataset Description                              
		string    status_name                   {xpath('d[k="24"]/v')};        // Dataset Status                
		string    item_source_code              {xpath('d[k="721"]/v')};       // Dataset Source Codes         
		string    source_id                     {xpath('d[k="821"]/v')};       // Company Id - from Dataset Id - 18                  
		string    source_name                   {xpath('d[k="709"]/v')};       // Company Name                    
		string    source_address1               {xpath('d[k="701"]/v')};       // Company Address                  
		string    source_address2               {xpath('d[k="703"]/v')};       // Company Address 2            
		string    source_city                   {xpath('d[k="705"]/v')};       // Company City                  
		string    source_state                  {xpath('d[k="715"]/v')};       // Company State            
		string    source_zip                    {xpath('d[k="719"]/v')};       // Company Zip                     
		string    source_phone                  {xpath('d[k="711"]/v')};       // Company Phone 
		string    source_website                {xpath('d[k="717"]/v')};       // Company Website   
		string    unused_source_sourceCodes     := ''; //{xpath('d[k="713"]/v')};       // Company Source Codes - 607?
		// The following are blank fields but are necessary for the recordset 
		string    unused_fcra                   := ''; // xpath('d[k="619"]/v')};       // Restriction FCRA Use Permitted  
		string    unused_fcra_comments          := ''; // xpath('d[k="651"]/v')};       // Restriction Comment FCRA Use Permitted        
		string    market_restrict_flag          {xpath('d[k="607"]/v')};       // Restriction Marketing Restrictions - 599     
		string    unused_market_comments        := ''; // xpath('d[k="631"]/v')};       // Restriction Comment Marketing Restrictions    
		string    unused_contact_category_name  := ''; // xpath('d[k="723"]/v')};       // Contact Info
		string    unused_contact_name           := ''; // xpath('d[k="723"]/v')};       // Contact Info          
		string    unused_contact_phone          := ''; // xpath('d[k="723"]/v')};       // Contact Info       
		string    unused_contact_email          := ''; // xpath('d[k="723"]/v')};       // Contact Info 
end;

export       InputRecord := record
				string   token {xpath('token')}           := Orbit3SOA.GetToken('Prod');
				integer  offset {xpath('offset')}         := 0;
				integer  count {xpath('count')}           := 1000000; 
				string   reportName {xpath('reportName')} := 'Dataset';
				string   viewType {xpath('viewName')}     := 'FFD No Filters';
		end;

soapReturn := soapcall(
		Orbit3SOA.EnvironmentVariables.serviceurlprod,
		'GetDataViewData',
		InputRecord,
		dataset(OutputRecordFFD),
		xpath('GetDataViewDataResponse/GetDataViewDataResult/DataRows/DataRow/RowData'),
		namespace(Orbit3SOA.EnvironmentVariables.namespace),
		literal,
		soapaction(Orbit3SOA.EnvironmentVariables.soapactionprefix + 'GetDataViewData')
		);
				
p:=project(soapReturn, _VendorSrc2.layouts.Riskview_FFD);
p;


//_VendorSrc2.StandardizeInputFile(filedate, pUseProd).ORBIT;

