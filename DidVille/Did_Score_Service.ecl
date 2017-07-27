/*--SOAP--
<message name="DidScoreService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"         type="xsd:byte"/>
	<part name="DPPAPurpose"        type="xsd:byte"/>

	<!-- NAME FIELDS -->
  <part name="UnParsedFullName"  	type="xsd:string"/>
  <part name="FirstName" 					type="xsd:string"/>
  <part name="LastName" 					type="xsd:string"/>
  <part name="MiddleName" 				type="xsd:string"/>
  <part name="NameSuffix" 				type="xsd:string"/>
	
	<!-- ADDRESS FIELDS -->	
  <part name="Addr"	    	   			type="xsd:string"/>
  <part name="City"   	     			type="xsd:string"/>
  <part name="State"	       			type="xsd:string"/>
  <part name="Dl_State"	       			type="xsd:string"/>
  <part name="Z5" 	        			type="xsd:string"/>	
  <part name="predir"	       		type="xsd:string"/>
  <part name="postdir"	       		type="xsd:string"/>
  <part name="prim_name"	   		type="xsd:string"/>
  <part name="prim_range"	   		type="xsd:string"/>
  <part name="Suffix" 						type="xsd:string"/>
  <part name="sec_range"	   		type="xsd:string"/>
	
  <part name="DOB" 							  type="xsd:unsignedInt"/>
	
	<!-- ID NUMBERS -->	 
	<part name="DID"								type="xsd:string"/>
  <part name="DriversLicense"			type="xsd:string"/>	
	
	<!-- OTHER OPTIONS -->
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="ScoreThreshold" 		type="xsd:unsignedInt"/>

</message>
*/	
/*--INFO-- Return scores based on Header records.*/


export Did_Score_Service() := MACRO

Scores_from_func := Didville.Did_Score();

output(Scores_from_func,NAMED('Results'));


ENDMACRO;

