import misc, ut, lib_fileservices, _Control, Orbit3SOA;

export OrbitDataHandling := module

    // Output record definition for the xml response - the first part of the xpath is explicit.
    // <a:RowNumber>X</a:RowNumber> and <a:RowData> are implicit (effectively caught up in the record
    // structure). The /d[k="XX"]/v signifies to retrieve the data value at the designated key.
    // The keys are defined upfront for the various fields in the record.
    // Record layout for Riskview_FFD - mirrors Layout_VendorSrc.Riskview_FFD 
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

    // Define the record layout for the next view name here

    // Make the soap call as a function macro to allow different types
    // Input Parameters:
    //     outputRecord   - the record layout for the soap data return
    //     projectRecord  - the actual layout as defined in the attribute. We need to project
    //                      on a one for one basis to remove the {xpath} details in the file
    //     OutputFileName - the name of the infile in the repository
    //     SuperfileName  - the superfile where the output file will reside
    //     pVersion       - the date suffix for the output file
    export soapCallForView(outputRecord, projectRecord, OutputFileName, SuperfileName, pVersion) := functionmacro
          // Make the soapcall into the system
        soapReturn := soapcall(
            // To eliminate issues with accessing different databases, we now only access the Production database
            Orbit3SOA.EnvironmentVariables.serviceurlprod,
            'GetDataViewData',
            InputRecord,
            dataset(outputRecord),
            // This defines the path past the <s:/Envelope> <s:Header /> and <s:Body> levels
            xpath('GetDataViewDataResponse/GetDataViewDataResult/DataRows/DataRow/RowData'),
            namespace(Orbit3SOA.EnvironmentVariables.namespace),
            literal,
            soapaction(Orbit3SOA.EnvironmentVariables.soapactionprefix + 'GetDataViewData'));
            
        // Now project the return into the actual layout for storage purposes
        projectedFile := project(soapReturn, projectRecord);
 
        // Write the file back to the repository
        output(projectedFile,, OutputFileName + pVersion, compressed, overwrite);
  
        // Add it to the superfile
        FileServices.AddSuperFile(SuperfileName, OutputFileName + pVersion);

        return true;
   
    endmacro;
    
     // Main handling function - the view name directs the soapcall to the proper 
    export Orbit3GetDataViewData(string inputViewName, string pVersion) := function
        // Input record definition for the xml request - This represents the following XML request:
        // <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
        //     <s:Header>
        //         <Action s:mustUnderstand="1" xmlns="http://schemas.microsoft.com/ws/2005/05/addressing/none">http://lexisnexis.com/IOrbitService/GetDataViewData</Action>
        //     </s:Header>
        //     <s:Body>
        //         <GetDataViewData xmlns="http://lexisnexis.com/">
        //             <token>555779f6-39e1-4299-aaa1-477d1132aa27</token>
        //             <offset>0</offset>
        //             <count>100000</count>
        //             <reportName>Dataset</reportName>
        //             <viewName>FFD No Filters</viewName>
        //         </GetDataViewData>
        //     </s:Body>
        // </s:Envelope>    
        InputRecord := record
            // To eliminate issues with accessing different databases, we now only access the Production database
            string   token {xpath('token')}           := Orbit3SOA.GetToken('Prod');
            integer  offset {xpath('offset')}         := 0;
            integer  count {xpath('count')}           := 1000000; 
            string   reportName {xpath('reportName')} := 'Dataset';
            string   viewType {xpath('viewName')}     := inputViewName;
        end;

        // This code is designed to be expandable based upon the view name. The developer should:
        // - Define the record structure with the appropriate keynames above
        // - Add the appropriate map name to the list below
        retval := map(inputViewName = 'FFD No Filters' => soapCallForView(OutputRecordFFD, misc.Layout_VendorSrc.Riskview_FFD,
                                                              '~thor_data400::in::vendor_src::riskview_ffd_', 
                                                              '~thor_data400::in::vendor_src_info_load', pVersion),       
                      soapCallForView(OutputRecordFFD, misc.Layout_VendorSrc.Riskview_FFD,
                          '~thor_data400::in::vendor_src::riskview_ffd_', 
                          '~thor_data400::in::vendor_src_info_load', pVersion));       
       
        return retval;
    end;
end;