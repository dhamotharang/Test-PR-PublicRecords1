 /*--SOAP--
<message name="Firmographics_batch_service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataRestrictionMask"	type="xsd:string"/>	
	<part name="max_results_per_acct" type="xsd:unsignedInt"/>	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchServices;
/*

Batch service Firmographics:

Pretty straightforward.  Uses standard batch input to hit business header in order to get a bdid
if no bdid is in input. 

Hits corp, dca and ebr (experian) keys to obtain various information about a company and returns
results back. Added some sorting and rollups in order to try and capture and populate the most inforamation
from various keys.  

Have stubbed out how to use the DataRestrictionMask in joins to various key
from knowledge on BIP project.  Not needed a lot in this
batch service but it is available for future expansion if needed	

NOTE : the input is not part of the final output in this batch service.  In otherwords the input values
are not echoed in the output

*/
EXPORT Firmographics_BatchService(useCannedRecs = 'false') := 
	MACRO
	
	 tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '' : stored('DataRestrictionMask');
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;	
	
	results := BatchServices.Firmographics_BatchService_Records(useCannedRecs, tempmod).Results;		
    OUTPUT( results, NAMED('Results'));				
	ENDMACRO;
		