/*--SOAP--
<message name="STR_BatchService">
	<part name="batch_in" 						type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" 					type="xsd:byte"/>
	<part name="GLBPurpose"  					type="xsd:byte"/>
	<part name="DataRestrictionMask" 	type="xsd:string" default="00000000000"/>
	<part name="DataPermissionMask" 	type="xsd:string" default="00000000000"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="ShortTermThreshold" 	type="xsd:unsignedInt"/>	
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>
	<part name="ExcludeDropIndCheck"  type="xsd:boolean"/>  
	<part name="PenaltThreshold" 		 	type="xsd:unsignedInt"/>	
  <part name="SSNMask"					   	type="xsd:string"/>
  <part name="SkipDeceasedSubjects" type="xsd:boolean"/>
  <part name="IncludeMinors"        type="xsd:boolean"/>
	<part name="GetSSNBest"           type="xsd:boolean"/>
</message>
*/

/*--INFO--
<pre>
Short Term Rental Indicator:
A batch service to identify possible short term rental properties.

This service will search property records to find owners, sales and tax information 
   for a given address or APN.
It will also find residency information associated with the property address by
   searching header records, drivers licenses, motor vehicles and voter registration.
It will then set indicators (hit flags) based on residency date ranges for residents 
   or property owners.
It will return those indicators along with the best information available for both
   property owners and residents.

Hit Flags:

  LT - Long Term Resident
  ST - Short Term Resident
  OO - Owner Occupied
  O  - Current Owner
  PO - Previous Owner
  NO - No Hit

----------------------------------------------------------------------------
<pre>
*/

IMPORT BatchServices;

EXPORT STR_BatchService := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#CONSTANT('TwoPartySearch', FALSE);

base_batch := BatchShare.IParam.getBatchParams();
in_mod := module (PROJECT(base_batch, BatchServices.Interfaces.str_config, OPT))
	export unsigned2 	PenaltThreshold 		:= BatchServices.STR_Constants.Defaults.PENALT_THRESHOLD : stored('PenaltThreshold'); // different from base default value
	export unsigned2 	ShortTermThreshold 	:= BatchServices.STR_Constants.Defaults.SHORT_TERM_THRESHOLD : stored('ShortTermThreshold');
	export boolean 		ExcludeDropIndCheck := false : stored('ExcludeDropIndCheck');
	boolean 					SkipDeceased 				:= false : STORED('SkipDeceasedSubjects');
	export boolean 		ReturnDeceased 			:= ~SkipDeceased; // will return deceased subjects by default to keep backward compatibility.
	export boolean    show_minors         := false : STORED('IncludeMinors'); // may be different from base value
	export boolean    GetSSNBest          := true  : STORED('GetSSNBest');
	export unsigned8  MaxResultsPerAcct		:= BatchServices.STR_Constants.Defaults.MaxResults_Per_Acct : STORED('Max_Results_Per_Acct');
end;

batch_in := DATASET([], BatchServices.STR_Layouts.batch_in) : STORED('batch_in', FEW);

recs := BatchServices.STR_Records(batch_in, in_mod);

output(recs, NAMED('Results'));

ENDMACRO;
//BatchServices.STR_BatchService();
