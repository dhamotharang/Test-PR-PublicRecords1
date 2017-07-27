/*--SOAP--
<message name="SearchServiceFCRA">
    <part name="FcraBenefitAssessSearchRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
    <part name="gateways" 								type="tns:XmlDataSet" cols="110" rows="4"/>
</message>
*/
/*--INFO--  Wrapper service around BenefitAssessment_Services.BenefitAssessment_BatchServiceFCRA
*/
IMPORT BenefitAssessment_Services,BatchShare, FCRA, iesp,  Gateway, Address, Risk_Indicators, Suppress, ut, WSInput;

// **************************************************************************************
// This service is "wrapper" around BenefitAssessment_Services.BatchRecords
// It job is to convert an iesp input request to the batch input request and 
// convert the batch output result into iesp output result.
// **************************************************************************************

EXPORT SearchServiceFCRA() := MACRO

  //The following macro defines the field sequence on WsECL page of query.  
	WSInput.MAC_BenefitAssessment_Services_SearchServiceFCRA();

	isFCRA := TRUE;    
	#STORED('Return_SSN', TRUE);
	#STORED('Return_DOC_Name', TRUE);
	nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
	rec_in := iesp.BenefitAssessment_fcra.t_FcraBenefitAssessSearchRequest;
	ds_in  := DATASET ([], rec_in) : STORED ('FcraBenefitAssessSearchRequest', FEW);
	first_row := ds_in[1] : independent;
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	BenefitAssessment_Services.IParam.SetInputSearchBy(first_row.searchBy);	
	BenefitAssessment_Services.IParam.SetInputSearchOptions(first_row.options);
  ds_batch_in := BenefitAssessment_Services.IParam.GetInput(first_row.searchBy);
		
//create batch service module of parameters to use.
	tempMod := BenefitAssessment_Services.IParam.getSearchModule(first_row.options, nss);		
		
//Get the associated DID's
	BatchShare.MAC_AppendPicklistDID(ds_batch_in (did=0), ds_batch_with_did, tempmod, isFCRA);	
	ds_batch_In_Shared := PROJECT(ds_batch_with_did, TRANSFORM( BenefitAssessment_Services.Layouts.Batch_In_Shared, SELF := LEFT)) + 
												PROJECT(ds_batch_in(did != 0), TRANSFORM( BenefitAssessment_Services.Layouts.Batch_In_Shared, SELF := LEFT));
	ds_batch_out := BenefitAssessment_Services.BatchRecords(tempmod, ds_batch_In_Shared, isFCRA, nss);

//Convert batch result record to ESDL result record
	outrecs :=	BenefitAssessment_Services.functions.convertBatchToESDL(ds_batch_out, first_row.searchBy);
 
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(outrecs,
	                                           results,
																						 iesp.benefitassessment_fcra.t_FcraBenefitAssessSearchResponse,
	                                           BenefitAssessRecords,
																						 FALSE,
																						 );
	output(results, NAMED('Results'));	

ENDMACRO;
