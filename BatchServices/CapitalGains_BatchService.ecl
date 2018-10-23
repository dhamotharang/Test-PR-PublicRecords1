/*--SOAP--
<message name="CapitalGains_BatchService">
	<part name="DPPAPurpose"               type="xsd:byte"/>
	<part name="GLBPurpose" 					     type="xsd:byte" />
	<part name="DataRestrictionMask" 	     type="xsd:string"/>
	<part name="DataPermissionMask" 	     type="xsd:string"/>
	<part name="ApplicationType"     	     type="xsd:string"/>
  <part name="IncludeMinors"             type="xsd:boolean"/>
	<part name="SSNMask"					       	 type="xsd:string"/>
	<part name="Run_Deep_Dive"             type="xsd:boolean"/>
	<part name="AppendBest"  					     type="xsd:boolean"/>
	<part name="AppendPhone"  				     type="xsd:boolean"/>
	<part name="AppendDeceased"				     type="xsd:boolean"/>
	<part name="Return_Unformatted_Values" type="xsd:boolean"/>
	<part name="Skip_Dedup"                type="xsd:boolean"/>
	<part name="GetSSNBest"                type="xsd:boolean"/>
	<part name="batch_in"                  type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/


IMPORT BatchServices;

EXPORT CapitalGains_BatchService(useCannedRecs = 'false') := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);		
	batch_in_layout := BatchServices.CapitalGains_BatchService_Layouts.batch_in;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	ds_batch_in := IF( NOT useCannedRecs, 
										 ds_batch_in_stored, 
										 PROJECT(BatchServices._Sample_inBatchMaster('CapitalGains'), transform(batch_in_layout, self := left, self := [])) 
								  );				
	
	recs := BatchServices.CapitalGains_BatchService_Records(ds_batch_in);
	
	output(recs, named('Results'));		
				
ENDMACRO;	
	
