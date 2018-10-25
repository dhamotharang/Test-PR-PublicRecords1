/*--SOAP--
<message name="SASearch">
	<!-- Search Criteria -->
	<part name="FacilityName"							type="xsd:string"/>
  <part name="ProviderFirstName"				type="xsd:string"/>
	<part name="ProviderKey"			 				type="xsd:string"/>
	<part name="ProviderLastName"	  			type="xsd:string"/>
	<part name="ProviderNPI"	      			type="xsd:string"/>
	<part name="GCID"			          			type="xsd:string"/>
	<part name="JOBID"			              type="xsd:string"/>
	<part name="InternalRoxieServiceUrl"  type="xsd:string"/>
</message>
*/
/*--INFO-- */

EXPORT MainSearch := FUNCTION
	IMPORT HIPIESA;
  #OPTION('soapTraceLevel', '8');

  STRING JOBID                    := '00000001' : STORED('JOBID');
	STRING GCID											:= '00000001' : STORED('GCID');
  STRING ServiceName              := 'hipiesa.search_' + gcid + '_' + JOBID;
  STRING XPathName                := ServiceName+'Response';
	//STRING InternalRoxieServiceUrl  := 'http://10.173.22.201:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Dev	
	// STRING InternalRoxieServiceUrl  := 'http://rampsroxieinternal.risk.regn.net:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Prod/DR DNS!
	// STRING InternalRoxieServiceUrl  := 'http://10.176.71.40:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //PROD IP
	// STRING InternalRoxieServiceUrl  := 'http://10.191.25.4:9876/roxie/' : STORED('InternalRoxieServiceUrl'); // DR IP
  STRING InternalRoxieServiceUrl  := 'http://10.173.22.132:9876/roxie/' : STORED('InternalRoxieServiceUrl'); //Cert
  
	STRING InputFacilityName 				:= ''	: STORED('FacilityName');
	STRING InputProviderKey 				:= ''	: STORED('ProviderKey');
	STRING InputProviderNPI					:= '' : STORED('ProviderNPI');
	STRING InputProviderFirstName		:= '' : STORED('ProviderFirstName');
	STRING InputProviderLastName		:= '' : STORED('ProviderLastName');
  
	SASearchInput := HIPIESa.Layouts.SASearchInput;
	SASearchOutput := HIPIESa.Layouts.SASearchOutput;

  SASearchOutput SetError (SASearchInput L) := transform
    SELF.soapcallerrorcode  := FAILCODE,
    SELF.soapcallerrordescription := FAILMESSAGE,
    SELF := L;
    SELF := [];
  end;

	SASearchInput tInput() := TRANSFORM
		SELF.FacilityName := InputFacilityName;
		SELF.ProviderKey:= InputProviderKey;
		SELF.ProviderNPI   := InputProviderNPI;
		SELF.ProviderFirstName  := InputProviderFirstName;
		SELF.ProviderLastName    := InputProviderLastName;
	END;
  dIn :=DATASET([tInput()]);
  
  dOut := SOAPCALL(dIn,InternalRoxieServiceUrl,ServiceName,{dIn},DATASET(SASearchOutput),ONFAIL(SetError(LEFT)), TIMEOUT(3), RETRY(1));

  RETURN OUTPUT(dOut, NAMED('Results'));
END;
