/*--SOAP--
<message name="ABMS_SearchService_Batch">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
  <part name="includeCareer" 				type="xsd:boolean"/>
  <part name="includeEducation" 		type="xsd:boolean"/>
  <part name="includeProfessionalAssociations" type="xsd:boolean"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--INFO--
<pre>
This service will return a set of matching records for a set of ABMS records.

</pre>
*/

import Healthcare_Provider_Services;
EXPORT ABMS_SearchService_Batch := MACRO
	batch_interface := Healthcare_Provider_Services.ABMS_Layouts.batchInterface;
	export ds_batch_in_stored := DATASET([], batch_interface) : STORED('batch_in', FEW);
	export unsigned1 PenaltThreshold := 10 :	stored ('PenaltThreshold');	
	export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
	export unsigned1 GLBPurpose := 8 : stored('GLBPurpose');
	export boolean 	 batch_includeCareer := false : stored('includeCareer');
	export boolean 	 batch_includeEducation := false : stored('includeEducation');
	export boolean 	 batch_includeProfessionalAssociations := false : stored('includeProfessionalAssociations');
	ds_input := project(ds_batch_in_stored,transform(Healthcare_Provider_Services.ABMS_Layouts.autokeyInput, 
																										self.includeCareer:=batch_includeCareer;
																										self.includeEducation:=batch_includeEducation;
																										self.includeProfessionalAssociations:=batch_includeProfessionalAssociations;
																										self := left));
	recs := Healthcare_Provider_Services.ABMS_Records(GLBPurpose,DPPAPurpose,PenaltThreshold).getRecordsBatch(ds_input);	
	output(recs, named('Results'));

ENDMACRO;