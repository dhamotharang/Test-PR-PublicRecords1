/*--SOAP--
<message name="BusinessInView_BatchService">
  <part name="DPPAPurpose"                            type="xsd:byte"/>
	<part name="GLBPurpose"                             type="xsd:byte"/> 
  <part name="Includebusinesscreditrisk"              type="xsd:boolean" default="false"/>
  <part name="Includebusinessfailurerisklevel"        type="xsd:boolean" default="false"/>
  <part name="Includecustombcir"                      type="xsd:boolean" default="false"/>
  <part name="PenaltThreshold"	                      type="xsd:unsignedInt"/>  
	<part name="Max_Results_Per_Acct"                   type="xsd:byte"/>	
	<part name="batch_in"                               type="tns:XmlDataSet" cols="80" rows="30"/>
  <part name="gateways"                               type="tns:XmlDataSet" cols="110" rows="10"/>
</message>
*/
// idea here is to use input information to go against the busines header rollup batch service to hit the bus header 
// and return a bdid value and the best input obtained from the business header for the input for the EFX gateway.// then use that best
// The EFX (iesp.gateway_inviewerport) AKA equifax gateway will then return a lot of information about the
// particular company.   This data returned from gateway is then restructured into a flat layout and presented as the final result.
//
// The 3 booleans indicating what specific reports to return are in the options above and are used
// as options for the gateway return information.
//  	boolean includebusinesscreditrisk       -- a simple score showing a credit risk gauge for the company
//    boolean includebusinessfailurerisklevel -- a simple score showing a failure gauge for the company 
//    boolean includecustombcir               -- a larger report containing lots of information
// 
// 
//
import Gateway;

export BusinessInView_BatchService := macro

  EXPORT Defaults := MODULE
		EXPORT UNSIGNED1 DPPAPURPOSE      := 0;
		EXPORT UNSIGNED1 GLBPURPOSE       := 8;
		EXPORT UNSIGNED1 FUZZINESSDIAL    := 0;
		EXPORT UNSIGNED1 MAXRESULTSPERROW := 5;
		EXPORT UNSIGNED1 PENALTTHRESHOLD  := 20;	
		//
		                             // 20110602 Increased the penalty default to 20
		                             // because with the default at 10 and the penalties
															   // all added together we were missing hits (for example: 
															   // input address has phone, unit_desig & sec_range.  Our hit
															   // didn't have the unit_desig or sec_range (all other addr 
															   // fields matched except the z4) and had a different phone.  
															   // The addr_penalt was 11, phone was 9. Input record: 
  														      // Alltell 1 Allied Dr, Little Rock, AZ 72202-2099
																		// another example is related to RQ bug # : 107337
	END; 
  // need to declare this cause its used as an interface when calling rollup business search batch service
	// which is used later in this service to retrieve the 'best' information and provide counts
	// for the derog services.
	//
	// For now the maximum mile radius value on input is 5.
	args := MODULE(BatchServices.RollupBusiness_BatchService_Interfaces.Input)
		EXPORT DPPAPurpose := defaults.DPPAPURPOSE : STORED('DPPAPurpose');
		EXPORT GLBPurpose := defaults.GLBPURPOSE : STORED('GLBPurpose');
		EXPORT FuzzinessDial := defaults.FUZZINESSDIAL : STORED('FuzzinessDial');
		EXPORT PenaltThreshold := defaults.PENALTTHRESHOLD : STORED('PenaltThreshold');
		EXPORT MaxResultsPerRow := defaults.MAXRESULTSPERROW : STORED('Max_Results_Per_Acct');
	END;

	gateway_cfg  := Gateway.Configuration.get()(Gateway.Configuration.IsEquifax(servicename))[1];		
	results := BatchServices.BusinessInView_BatchService_Records.setInput(gateway_cfg, args);    
	output(results,named('Results'));

endmacro;