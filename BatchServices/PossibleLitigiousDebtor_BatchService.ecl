	/*--SOAP--
<message name="PossibleLitigiousDebtor_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="MaxResults"           type="xsd:unsignedInt"/>	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
// notes on this service:

// Fname, lname are required input along with optionaling a <CourtJurisdiction> field which acts like the <st> variable 
// But is not.  We dont have state autokeys built for this key only fname/lname autokeys 

// In the payload key the field st does not contain the information that we need to use to filter 
// on state later so we ignore it.  Contents of <courtJurisdiction> (2 char state abbrev value) XML tag 
// contains the filter value which is used to filter payload key if this XML tag exists in the input. 

// Also each input rec (acctno is unique remember) has 3 optional params 
// CasetypeSearchFDCPA, caseTypeSearchFCRA, caseTypeSearchTCPA
// Which if any are set to N on the input filter out any recs with that particular casetype.
// The field causecode in the payload key has either 1, 2, 3 in it and these #s correspond to 
// what particular category of case it is

// Based on these mappings:

// casetypeSearchFDCPA  --   1
// caseTypeSearchFCRA   --   2
// caseTypeSearchTCPA   --   3

// So to filter out all the CaseTypeSearchFCRA for a given acctno youd put N in the input XML like this:

      // <CaseTypeSearchFCRA>N</CaseTypeSearchFCRA>

// This can be differentiated for each particular <row> i.e. acctno

 
// The keys (autokey and the one payload key indexed on courtid and docketnumber are in the module CourtLink).



IMPORT BatchServices;

EXPORT PossibleLitigiousDebtor_BatchService(useCannedRecs = 'false') := 
	MACRO
		ds_batch_in_pld := BatchServices.PossibleLitigiousDebtor_BatchService_Functions.file_inPLDBatchMaster(useCannedRecs,forceSeq := FALSE); 
		results := BatchServices.PossibleLitigiousDebtor_BatchService_Records(ds_batch_in_pld);			
		ut.mac_TrimFields(results, 'results', result);
		OUTPUT(result, NAMED('Results'));
	ENDMACRO;	
	
