IMPORT banko;
/*--SOAP--
<message name="AdditionalEventsBatchService">
	<part name="IsCaseCourtSearch" 	type="xsd:boolean"/>
	<part name="IsCaseIdSearch"     type="xsd:boolean"/>
	<part name="IsTMSIdSearch"     	type="xsd:boolean"/>	
	<part name="ReturnUncategorizedEvents" type="xsd:boolean"/>
	<part name="batch_in"           type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

/*--INFO--
Bankruptcy Additional Events neutral batch query.
*/

/*--HELP-- 
use batch_in with appropriate box checked 
*/
       	        
EXPORT AdditionalEventsBatchService(useCannedRecs = 'FALSE') := MACRO

	BOOLEAN isCaseCourtSearch	:= FALSE 	: STORED('IsCaseCourtSearch');
	BOOLEAN isCaseIdSearch	  := FALSE 	: STORED('IsCaseIdSearch');
	BOOLEAN isTMSIdSearch	    := FALSE 	: STORED('IsTMSIdSearch');	
	BOOLEAN returnUncategorizedEvents	:= FALSE  : STORED('ReturnUncategorizedEvents');
	
	/*	determine search type	*/
	search_type := MAP(
									isCaseCourtSearch	=> Banko.Constants.search_type_code.CaseCourt,
									isCaseIdSearch		=> Banko.Constants.search_type_code.Caseid,
									isTMSIdSearch			=> Banko.Constants.search_type_code.TmsId,
									banko.Constants.search_type_code.CaseCourt);
			
	/*	input recs 	*/
	ds_in 		:= dataset([], Banko.layout_bkevents_in) : stored('batch_in', few);
	
	/*	test recs		*/
	ds_canned := banko._Sample_Records.Addtl_Events.ds_sample_input;
	
	ds := if(not useCannedRecs, ds_in, ds_canned);
	
	boolean isFCRA := false;

	output(Banko.AdditionalEvents_BatchService_Records(ds, isFCRA, search_type, returnUncategorizedEvents), NAMED('Results'));
	
ENDMACRO;

// banko.AdditionalEventsBatchService();	