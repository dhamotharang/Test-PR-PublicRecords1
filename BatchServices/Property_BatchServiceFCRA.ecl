
/*--SOAP--
<message name="Property_BatchServiceFCRA">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="Phonetics"            type="xsd:boolean"/>
	<part name="Nicknames"            type="xsd:boolean"/>
	
	<part name="DataRestrictionMask"  type="xsd:STRING"/>
	<part name="IgnoreFares"          type="xsd:boolean"/>
	<part name="IgnoreFidelity"       type="xsd:boolean"/>
	<part name="LnBranded"            type="xsd:boolean"/>
		
	<part name="Match_Name"           type="xsd:boolean"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_City"           type="xsd:boolean"/>
	<part name="Match_State"          type="xsd:boolean"/>
	<part name="Match_Zip"            type="xsd:boolean"/>
	<part name="Match_SSN"            type="xsd:boolean"/>
	<part name="Match_LinkID"            type="xsd:boolean"/>
		
	<part name="MaxResults"           type="xsd:unsignedInt"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="Max_Results_Per_Acct" type="xsd:byte"/>

	<part name="Return_Assessments"   type="xsd:boolean"/>
	<part name="Return_Deeds"         type="xsd:boolean"/>
	<part name="Return_Mortgages"     type="xsd:boolean"/>
	<part name="Return_Current_Only"  type="xsd:boolean"/>
	<part name="Return_Unformatted_Values"  type="xsd:boolean"/>
  <part name="Skip_Dedup"           type="xsd:boolean"/>
	<part name="NonSubjectSuppression"  			type="xsd:unsignedInt"/>
	<part name="Return_Owners"  type="xsd:boolean"/>	
	<part name="Return_Borrower"  type="xsd:boolean"/>	
	<part name="Return_Seller"  type="xsd:boolean"/>	
	<part name="Return_Care_Of"  type="xsd:boolean"/>	
	<part name="Return_Property"  type="xsd:boolean"/>	
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
	<part name="FFDOptionsMask" 	      type="xsd:string"/>	
	<part name="FCRAPurpose"      type="xsd:string"/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="8"/>
</message>
*/
import Royalty;

EXPORT Property_BatchServiceFCRA(useCannedRecs = 'false') := 
	MACRO
		
    	//non-subject suppression
    nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);
		ds_in		:= DATASET([], LN_PropertyV2_Services.layouts.batch_in_plus_date_filter) : STORED('batch_in', FEW);
		prop := BatchServices.Property_BatchCommon(true, nss, useCannedRecs,ds_in);
		result := prop.Records; 
		returnDetailedRoyalties	:= false : stored('ReturnDetailedRoyalties');	
		royalties := Royalty.RoyaltyFares.GetBatchRoyaltySet(result,,returnDetailedRoyalties);
		
		OUTPUT(result, NAMED('Results'));
		OUTPUT(royalties, NAMED('RoyaltySet'));
		OUTPUT(prop.Statements, NAMED('CSDResults'));
		

	ENDMACRO;	