/*--SOAP--
<message name="SearchService">
   
	<part name="TaxRefundInvestigativeRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO-- TRIS single search query. Optimal output is got when atleast first name, last name , SSN and address fields are input to the query. More input the better 
*/

import TaxRefundIS_Service, iesp, AutoStandardI;

EXPORT SearchService := MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
  #onwarning(4207, ignore);
//b. Receive input 
		rec_in := iesp.taxrefundinvestigation.t_TaxRefundInvestigativeRequest;
		
// "FEW" keyword set to make data read more efficient
		ds_in  := DATASET ([], rec_in) : STORED ('TaxRefundInvestigativeRequest', FEW);
		
/* independent" service keyword used here to make statement atomic and a signal to 
		code generator to not combine it with other lines of code. It is evaluated at a global scope. */
		first_row := ds_in[1] : independent;
		
// Why does this need to be global ?  		
		search_by := global (first_row.SearchBy);
		
/*	Each of these functions take each aspect of the input 
		and & make it available via #stored    		
*/
    #stored('SSNMask','');//first_row.User.SSNMask);
		#stored('DOBMask','');//first_row.User.DOBMask);
    
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		//iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputName (search_by.Name,true);
		iesp.ECL2ESP.SetInputDate(search_by.DOB,'DOB');
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
		

/* #stored the ones that did not make it to #stored so far , but will be useful in 
			1) doxie.MAC_Header_Field_Declare 
			2) Other sub-services whose records attribute 
				 BatchServices.TaxRefundIS_BatchService_Records  
         is calling.
 */
    //Don't apply SSN or DOB masking until just prior to returning results.
		
		
		#stored('IRSState',first_row.options.IRSState);
	  #stored('SSN', search_by.SSN); 
		#stored('IncludeBlankDOD',first_row.options.IncludeBlankDOD); // Death needs this
		#stored('BestSSNScoreMin',first_row.options.BestSSNScoreMin);
		#stored('BestNameScoreMin',first_row.options.BestNameScoreMin);
		#stored('SSNScoreMin',first_row.options.SSNScoreMin);
		#stored('NAMEScoreMin',first_row.options.NameScoreMin);
		#stored('ModelName',first_row.options.ModelName);        
		#stored('NPIThreshold',first_row.options.NPIThreshold); // 0 - 999 are valid values
		#stored('FilterRule',first_row.options.FilterRule);
		#stored('DataRestrictionMask',first_row.User.DataRestrictionMask);
			
	
/* This takes most the #stored and gives it as usable variables. 
   It also deals with seeing to it that all the default values are considired.	*/
		doxie.MAC_Header_Field_Declare();
		
//c.	Do name parsing and input (SSN and Phones) data cleaning  
	  dsCleanName 		:= Address.CleanNameFields(Address.CleanPersonFML73(unparsed_fullname_value));
		CleanSSN  			:= TaxRefundIS_Service.functions.fn_CleanSSN (ssn_value );
		CleanHomePhone	:= Address.CleanPhone(search_by.HomePhone);
		CleanWorkPhone	:= Address.CleanPhone(search_by.WorkPhone);
		

//d.	Convert the Input to Batch format: 
	 BatchServices.Layouts.TaxRefundIS.batch_in fillBatchIn() :=  TRANSFORM
			self.acctno 		 := '1';
			self.seq 				 := 0;
			self.name_suffix := dsCleanName.name_suffix;
			self.name_first  := dsCleanName.fname;
			self.name_middle := dsCleanName.mname; 
			self.name_last   := dsCleanName.lname; 
			self.ssn 			   := CleanSSN;
			self.dob         := (string8) dob_val; 
			self.address     := addr_line_first + ' '+ addr_line_second;
			self.prim_name   := pname_value; 
			self.addr_suffix := addr_suffix_value; 
			self.prim_range  := prange_value; 
			self.predir      := predir_value; 
			self.postdir     := postdir_value;
			STRING10 UnitDesignation  := search_by.Address.UnitDesignation;		
			self.unit_desig  := UnitDesignation;
			self.sec_range 	 := sec_range_value;
			self.p_city_name := city_value; 
			self.st 				 := state_value;
			self.z5          := zip_val;
			STRING4 Zip4		 := search_by.Address.zip4; 
			self.zip4    		 := Zip4;
			self.county_name := county_value;
			self.homephone   := CleanHomePhone;
			self.workphone   := CleanWorkPhone;
			self 						 := [];
	END;
										
		ds_batch_in	 := dataset([fillBatchIn()]);
	
	// module here inherits the interface& (acts asif it) overrides it
 args := MODULE (BatchServices.TaxRefundIS_BatchService_Interfaces.Input)
			EXPORT string32 ApplicationType  		:= application_type_value;
			EXPORT unsigned1 DPPAPurpose 				:= DPPA_Purpose;
			EXPORT unsigned1 GLBPurpose  				:= GLB_Purpose;      
			EXPORT string5 IndustryClass				:= industry_class_value;
			EXPORT boolean IncludeBlankDOD			:= false : stored('IncludeBlankDOD');
			EXPORT boolean PhoneticMatch		    := phonetics; 
			EXPORT boolean AllowNickNames				:= nicknames; 
			EXPORT string50 DataRestriction     := '' : stored('DataRestrictionMask');
			EXPORT string120 append_l           := 'BEST_ALL, BEST_EDA'; //Append allows all Best Info to return
			EXPORT string120 verify_l           := 'BEST_ALL';
			EXPORT string2 input_state          := '' : stored('IRSState');
		  EXPORT unsigned2 BestSSNScoreMin    := 0 : stored('BestSSNScoreMin');
		  EXPORT unsigned2 BestNameScoreMin   := 0 : stored('BestNameScoreMin');
		  EXPORT unsigned2 SSNScoreMin        := 0 : stored('SSNScoreMin');
		  EXPORT unsigned2 NAMEScoreMin       := 0 : stored('NAMEScoreMin');
		  EXPORT string20  ModelName          := '' : stored('ModelName');        
		  EXPORT string3   NPIThreshold       := '' : stored('NPIThreshold'); // 0 - 999 are valid values
		  EXPORT string30  FilterRule         := '' : stored('FilterRule');
			EXPORT string10	DataPermission 			:= AutoStandardI.GlobalModule().DataPermissionMask;
END;
	
	
//e.	Make a (single batch input) call (TaxRefundIS_Service.functions.callTRISbatch)
			BatchResults :=  BatchServices.TaxRefundIS_BatchService_Records(ds_batch_in, args) ;
	

//inf, outf, ssn_field, dl_field, isassn, isadl,
	// batch=false, useUnmasked=false, unmasked_field='ssn_unmasked', maskVal='ssn_mask_value'
	    input_ssn_mask_value := stringlib.stringtouppercase(first_row.User.SSNMask);
	    input_dob_mask_value := suppress.date_mask_math.MaskIndicator (first_row.User.DOBMask);
//f.	Apply  SSN Masking : (TaxRefundIS_Service.functions.applyMasking or call to the masking functions directly)
    	Suppress.MAC_Mask(BatchResults,BatchResults1,Best_SSN,blank,true,false,,,,input_ssn_mask_value);
    	Suppress.MAC_Mask(BatchResults1,BatchResults2,DOC_SSN_1,blank,true,false,,,,input_ssn_mask_value);
    	Suppress.MAC_Mask(BatchResults2,BatchResultsPostSSNMasking,DOC_SSN_1_BestSSN,blank,true,false,,,,input_ssn_mask_value);


//g.	Convert batch result record to ESDL result record & do DOB Masking:
			//Results :=	TaxRefundIS_Service.functions.ConvertTRIS_BatchToESDL(BatchResultsPostSSNMasking, dob_mask_value);
		
			Results :=	TaxRefundIS_Service.functions.ConvertTRIS_BatchToESDL(BatchResultsPostSSNMasking, input_dob_mask_value);

 
 //i. Give back Results
 
/*DEBUG : 
output(BatchResults,named('BatchResults'));	
*/

output(Results,named('Results'));
ENDMACRO;

/*
For testing/debugging: 
1. In the "TaxRefundInvestigativeRequest" xml text area, use the sample xml input below 
   filling in:
   a. The appropriate input/search data fields, 
   b. Some of the values have a default value, feel free to use them or modify them based on your needs. 
   c. The fields that contain PII data has been XXXXed out.  


<TaxRefundIS_Service.SearchService>
      <UseStagingRoxie>1</UseStagingRoxie>
      <TaxRefundInvestigativeRequest>
         <Row>
            <User>
               <GLBPurpose>1</GLBPurpose>
               <DLPurpose>1</DLPurpose>
               <SSNMask>NONE</SSNMask>
               <DOBMask>NONE</DOBMask>
               <DataRestrictionMask>00000000000000000000000</DataRestrictionMask>
            </User>
            <Options>
               <IRSState>SC</IRSState>
               <BestSSNScoreMin>100</BestSSNScoreMin>
               <BestNameScoreMin>100</BestNameScoreMin>
               <SSNScoreMin>100</SSNScoreMin>
               <NameScoreMin>100</NameScoreMin>
               <ModelName>FP1210_1</ModelName>
               <NPIThreshold>500</NPIThreshold>
               <FilterRule>v2_1Filter</FilterRule>
            </Options>
            <SearchBy>
               <Name>
                  <FIRST>xxxxxxx</FIRST>
                  <LAST>xxxxxxxx</LAST>
                  <SSN>xxxxxxxxxx</SSN>
                  <DOB>
                     <Year />
                     <Month />
                     <Day />
                  </DOB>
               </Name>
               <Address>
                  <StreetAddress1>xxxxxxxxxxxxxxx</StreetAddress1>
                  <StreetAddress2 />
                  <City>xxxxxxxxxx</City>
                  <State>xx</State>
                  <Zip5>xxxxx</Zip5>
               </Address>
            </SearchBy>
         </Row>
      </TaxRefundInvestigativeRequest>
   </TaxRefundIS_Service.SearchService>
*/
