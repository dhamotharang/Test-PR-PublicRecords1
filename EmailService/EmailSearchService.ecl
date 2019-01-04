/*--SOAP--
<message name="EmailSearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"         type="xsd:byte"/>
	<part name="DPPAPurpose"        type="xsd:byte"/>
	<part name="ApplicationType"   	type="xsd:string"/>
	
	<!-- ID NUMBERS -->
	<part name="EMAIL"          type="xsd:unsignedInt"/>
  <part name="DID"                type="xsd:unsignedInt"/>
	
	<!-- AUTOKEY SEARCH FIELDS -->
  <part name="SSN" 								type="xsd:string"/>
  <part name="UnParsedFullName"   				type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"   	 			type="xsd:string"/>
  <part name="Addr"	    	   			type="xsd:string"/>
  <part name="City"   	     			type="xsd:string"/>
  <part name="State"	       			type="xsd:string"/>
  <part name="Zip" 	        			type="xsd:string"/>
	
	<!-- AUTOKEY OPTIONS -->
	<part name="AllowNickNames" 		type="xsd:boolean"/>
	<part name="PhoneticMatch"  		type="xsd:boolean"/>
	<part name="ZipRadius"  				type="xsd:unsignedInt"/>

	
	<!-- ADDITIONAL OPTIONS -->
	<part name="PenaltThreshold"		type="xsd:unsignedInt"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>
  <part name="SSNMask"						type="xsd:string"/>
  <part name="DOB" 							  type="xsd:unsignedInt"/>
	
	<!-- RESULTS LIST MANAGEMENT -->
	<part name="MaxResults"					type="xsd:unsignedInt"/>
	<part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
	<part name="SkipRecords"				type="xsd:unsignedInt"/>

	<part name="AllowMultipleResults" 					type="xsd:boolean"/>
	<part name="SearchType" 			  type="xsd:string"/>
</message>
*/
/*--INFO-- Returns Email records.*/

import AutoStandardI, doxie, codes, Royalty, STD;

export EmailSearchService() := MACRO

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);

	boolean allow_mult_results := false : stored('AllowMultipleResults');

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,EmailService.EmailSearch.params,opt))
			export PenaltThreshold := 10 : stored('PenaltThreshold');
			string120	email_raw0 := '' :stored('email');
			string120 email_raw := if(STD.Str.Find(email_raw0,'@',1) = 0,
				trim(email_raw0) + '@',email_raw0);
			export email := trim(STD.Str.ToUppercase(email_raw),all);	
			export useGlobalScope := false;
			export mult_results := allow_mult_results;
			export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
			string _search_type := '' : stored('SearchType');
			export SearchType := trim(STD.Str.ToUppercase(_search_type),all);	
	end;
	
	_output_rec := EmailService.EmailSearch.Search(tempmod);
	
	output_rec := project(_output_rec, transform(EmailService.Assorted_Layouts.layout_search_out, 
		self.emails := project(left.emails, transform(EmailService.Assorted_Layouts.layout_emails,
			self.orig_email := if(allow_mult_results, '', left.orig_email);
			self := left;
		));
		self := left;
	));

	// reduce results to the page we care about
	MaxResults_val := AutoStandardI.InterfaceTranslator.MaxResults_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.MaxResults_val.params));
	SkipRecords_val := AutoStandardI.InterfaceTranslator.SkipRecords_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.SkipRecords_val.params));
	MaxResultsThisTime_val := AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.MaxResultsThisTime_val.params));
		
	doxie.MAC_Marshall_Results(output_rec,Email_marshalled);

	//output(EmailService.EmailSearch.Search(tempmod), named('Results'));
	output(Email_marshalled, named('Results'));
	
	Royalty.MAC_RoyaltyEmail(output_rec, royalties);
	if(~allow_mult_results, output(royalties, named('RoyaltySet')));


ENDMACRO;