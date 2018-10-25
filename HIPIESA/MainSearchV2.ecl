/*--SOAP--
<message name="SASearch">
	<!-- Search Criteria -->
	<part name="GCID"			          			type="xsd:string"/>
	<part name="JOBID"			              type="xsd:string"/>
	<part name="FacilityName"							type="xsd:string"/>
	<part name="ProviderKey"			 				type="xsd:string"/>
	<part name="ProviderNPI"	      			type="xsd:string"/>
  <part name="ProviderFirstName"				type="xsd:string"/>
	<part name="ProviderLastName"	  			type="xsd:string"/>
	<part name="StreetAddress"	    			type="xsd:string"/>
	<part name="City"	    								type="xsd:string"/>
	<part name="State"	    							type="xsd:string"/>
	<part name="Zip"	    								type="xsd:string"/>
</message>
*/
/*--INFO-- */

EXPORT MainSearchV2 := FUNCTION
  #OPTION('soapTraceLevel', '8');

	STRING GCID											:= 'v2' 		: STORED('GCID');
  STRING JOBID                    := 'test' 	: STORED('JOBID');
  
	STRING InputFacilityName 				:= ''				: STORED('FacilityName');
	STRING InputProviderKey 				:= ''				: STORED('ProviderKey');
	STRING InputProviderNPI					:= '' 			: STORED('ProviderNPI');
	STRING InputProviderFirstName		:= '' 			: STORED('ProviderFirstName');
	STRING InputProviderLastName		:= '' 			: STORED('ProviderLastName');
	
  string InputStreetAddress 			:= ''				: STORED('StreetAddress');
  string InputCity 								:= ''				: STORED('City');
  string InputState 							:= ''				: STORED('State');
  string InputZip 								:= ''				: STORED('Zip');
  
	STRING ServiceName              := 'hipiesa.search_' + GCID + '_' + JOBID;
	//Dev
	STRING RoxieInternalServiceUrl  := 'http://10.173.22.201:9876/roxie/'; 												
  //Cert
	//STRING RoxieInternalServiceUrl  := 'http://10.173.22.132:9876/roxie/'; 										
	//Prod/DR DNS!
	//STRING RoxieInternalServiceUrl  := 'http://rampsroxieinternal.risk.regn.net:9876/roxie/'; 	
	//PROD IP
	//STRING RoxieInternalServiceUrl  := 'http://10.176.71.40:9876/roxie/'; 											
	//DR IP
	//STRING RoxieInternalServiceUrl  := 'http://10.191.25.4:9876/roxie/'; 											
  
  Layouts := HIPIESA.SearchV2Objects.Layouts;
	
	SASearchInput := Layouts.SASearchInput;
	SASearchOutput := Layouts.SASearchOutput;

  SASearchOutput SetError (SASearchInput L) := transform
    SELF.soapcallerrorcode  := FAILCODE,
    SELF.soapcallerrordescription := FAILMESSAGE,
    SELF := L;
    SELF := [];
  end;

	SASearchInput tInput() := TRANSFORM
		SELF.FacilityName      := InputFacilityName;
		SELF.ProviderKey       := InputProviderKey;
		SELF.ProviderNPI       := InputProviderNPI;
		SELF.ProviderFirstName := InputProviderFirstName;
		SELF.ProviderLastName  := InputProviderLastName;

		SELF.StreetAddress     := InputStreetAddress;
		SELF.City              := InputCity;
		SELF.State             := InputState;
		SELF.Zip               := InputZip;
	END;
  dIn := DATASET([tInput()]);
  
  dOut := SOAPCALL(dIn,RoxieInternalServiceUrl,ServiceName,{dIn},DATASET(SASearchOutput),ONFAIL(SetError(LEFT)), TIMEOUT(3), RETRY(1));

  RETURN OUTPUT(dOut, NAMED('Results'));
END;
