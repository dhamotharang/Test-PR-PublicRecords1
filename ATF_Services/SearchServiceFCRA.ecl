/*--SOAP--
<message name="SearchServiceFCRA">

	<part name="DID"                 type="xsd:string"/>
	<part name='NonSubjectSuppression' type = 'xsd:unsignedInt' default="2"/> <!-- [1,2,3] -->
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
  <part name="FcraFirearmSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
  


</message>
*/
/*--INFO-- This service returns FCRA version of ATF Firearms and Explosives search records.*/
import STD, WSInput;

EXPORT SearchServiceFCRA := MACRO

    //The following macro defines the field sequence on WsECL page of query.
		WSInput.MAC_ATF_Services_SearchServiceFCRA();   
		
    rec_in := iesp.firearm_fcra.t_FcraFirearmSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('FcraFirearmSearchRequest', FEW);
    first_row := ds_in[1] : independent;
		 
    //set options   
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		unsigned1 non_subject_suppression := global(first_row.User).NonSubjectSuppression; // def=2
    #stored('NonSubjectSuppression', non_subject_suppression);
		unsigned1 nonSS := ut.GetNonSubjectSuppression(Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
    //set main search criteria:
    search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
		
	
		//soap call for remote DIDs
		//------------------------------------------------------------------------------------
		// the only purpose of this macro is to produce a single DID, so in case DID is provided in the input
		// -- either in #stored or in ESDL -- this MACRO will necessarily bounced this DID back.
		FCRA.MAC_GetPickListRecords (ds_in, res_esdl);
		//------------------------------------------------------------------------------------

		rdid := res_esdl[1].Records[1].UniqueId;
	
    input_params := AutoStandardI.GlobalModule(true);
		tempmod := module(project(input_params,ATF_Services.IParam.search_params,opt))
			EXPORT string14 did := rdid;
			Export string32 applicationType	:= AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
			export unsigned1 non_subject_suppression := nonSS;
			export integer8 FFDOptionsMask := FFD.FFDMask.Get(first_row.options.FFDOptionsMask);	
			export integer FCRAPurpose := FCRA.FCRAPurpose.Get(first_row.options.FCRAPurpose);	
		end;
		
		atf_recs := ATF_Services.SearchService_Records.search(tempmod, true);

		input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, true, search_by);
		
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(atf_recs.Records, results, iesp.firearm_fcra.t_FcraFirearmSearchResponse);
																
		FFD.MAC.AppendConsumerAlertsAndStatements(results, results_new, atf_recs.Statements, atf_recs.ConsumerAlerts, input_consumer, iesp.firearm_fcra.t_FcraFirearmSearchResponse);	 
		
		output(results_new, named('Results'));	
		
ENDMACRO;