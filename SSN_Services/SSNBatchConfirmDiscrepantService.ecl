/*--SOAP--
<message name="SSNBatchConfirmDiscrepantService">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="searchType" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/
//import doxie_raw;
export SSNBatchConfirmDiscrepantService() := macro

String5 searchType := '' : stored('searchType');

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

rec_out := ssn_services.layout_SSNBatchCD_output;

boolean isConfirmBatch := stringlib.StringToUpperCase(searchType) = 'AC4C';
boolean isDiscrepantBatch := not isConfirmBatch and stringlib.StringToUpperCase(searchType) = 'AC4B';
boolean hasNoSearchType := not isConfirmBatch and not isDiscrepantBatch;

ds_in := group(doxie.file_inBatchMaster(true)(ssn <> ''), seq);

//****** GET THE DIDS
forfun := project(ds_in, ssn_services.transform_SSNBatchCDInputToSSN(left));

dids := ssn_services.fun_GetDIDsBySSN(forfun);

//****** GET HEADER RECS FOR DIDS
forhead := join(ds_in, dids, 
								left.seq = right.seq,
								ssn_services.transform_SSNForHead(left, right, mod_access.dppa, mod_access.glb), many lookup);
								
head := doxie_raw.Header_Raw_batch(forhead)(prim_name[1..4]<>'DOD ');

//****** DETERMINE CONFIRM OR DESCREPENT FOR HEADER RECORDS

mrkd := ssn_services.fun_MarkConfirmDiscrepant(ds_in, head, isConfirmBatch, isDiscrepantBatch);


//****** APPEND WHITE PAGES AND DEMOGRAPHICS
wdemo := ssn_services.fun_AppendDemoCDBatch(mrkd, mod_access);

if(hasNoSearchType, fail('No searchType given.'), output(wdemo, named('Result')));

endmacro;