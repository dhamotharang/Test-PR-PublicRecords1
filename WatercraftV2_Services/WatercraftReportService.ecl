/*--SOAP--
<message name="WatercraftReportService">
	  
	<part name="DID"                 type="xsd:string"/>
	<part name="BDID"                type="xsd:string"/>
  <part name="HullNumber"          type="xsd:string"/>
  <part name="VesselName"          type="xsd:string"/>
	<part name="GLBPurpose"	         type="xsd:byte"/>
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="DataRestrictionMask" type='xsd:string'/>
	<part name="ApplicationType"     type="xsd:string"/>
  <part name="SSNMask"             type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->

  <part name="Watercraftkey" type="xsd:string"/>
  <part name="SequenceKey"   type="xsd:string"/>
  <part name="State"         type="xsd:string"/>

  <part name="UnParsedFullName" type="xsd:string"/>	
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="AllowNicknames"   type="xsd:boolean"/>
	<part name="PhoneticMatch"    type="xsd:boolean"/>
	<part name="CompanyName"      type="xsd:string"/>
	<part name="FEIN"             type="xsd:string"/>
	<part name="Addr"             type="xsd:string"/>
	<part name="City"             type="xsd:string"/>
  <part name="DOB" 						  type="xsd:unsignedInt"/>
	
	<part name="Zip" 	            type="xsd:string"/>
  <part name="County"           type="xsd:string"/>

  <part name="ZipRadius"      type="xsd:unsignedInt"/>
  <part name="NoDeepDive"     type="xsd:boolean"/>
  <part name="Summarize"      type="xsd:boolean"/>

  <part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns one watercraft Record.*/

export WatercraftReportService := macro
	
	gm := AutoStandardI.GlobalModule();
	params := module(project(gm, WatercraftV2_Services.Interfaces.report_params, opt))
		export string30  wk       := ''  		                                     : stored('Watercraftkey');
		string30  h_num         	:= ''                                          : stored('HullNumber');
		export string30  hull_num	:= stringlib.stringtouppercase(h_num);
		export string32  seqk			:= ''                                          : stored('SequenceKey');
		string2   st_pass					:= ''                                          : stored('State');
		export string2   st 			:= stringlib.stringtouppercase(st_pass);
		export string14  DID     	:= ''                                          : stored('DID');
		export string		 BDID     := ''                                          : stored('BDID');
		string    ssn_mask_pass 	:= 'NONE'                                      : stored('SSNMask');
		export string6   ssn_mask	:= stringlib.stringtouppercase(ssn_mask_pass);
		string50  v_name	      	:= ''	                                         : stored('VesselName');
		export string50  vesl_nam	:= stringlib.stringtouppercase(v_name);
		export unsigned2 pt 			:= 10	                                         : stored('PenaltThreshold');	
		export boolean   summarize:= false																			 : stored('Summarize');
		export boolean include_non_regulated_sources := false										 : stored('IncludeNonRegulatedWatercraftSources');
	END;
	
	report_recs := watercraftV2_Services.WatercraftReport(params);
	
	output(report_recs.Records, named('Results'));

endmacro;
