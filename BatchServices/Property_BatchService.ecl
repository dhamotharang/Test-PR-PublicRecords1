
/*--SOAP--
<message name="Property_BatchService">
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
	<part name="Run_Deep_Dive"        type="xsd:boolean"/>
	<part name="Return_Assessments"   type="xsd:boolean"/>
	<part name="Return_Deeds"         type="xsd:boolean"/>
	<part name="Return_Mortgages"     type="xsd:boolean"/>
	<part name="Return_Current_Only"  type="xsd:boolean"/>
	<part name="Return_Unformatted_Values"  type="xsd:boolean"/>
  <part name="Skip_Dedup"           type="xsd:boolean"/>
	
	<part name="Return_Owners"  type="xsd:boolean"/>	
	<part name="Return_Borrower"  type="xsd:boolean"/>	
	<part name="Return_Seller"  type="xsd:boolean"/>	
	<part name="Return_Care_Of"  type="xsd:boolean"/>	
	<part name="Return_Property"  type="xsd:boolean"/>	
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
	<part name="BIPFetchLevel"        type="xsd:string"/>

</message>
*/
import Royalty;

EXPORT Property_BatchService(useCannedRecs = 'false') := 
	MACRO
  #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);	
		STRING1 BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID	 : STORED('BIPFetchLevel');
    	//non-subject suppression
    nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.doNothing);
		ds_in		:= DATASET([], LN_PropertyV2_Services.layouts.batch_in_plus_date_filter) : STORED('batch_in', FEW);
		result := BatchServices.Property_BatchCommon(false, nss, useCannedRecs,ds_in,STD.Str.touppercase(BIPFetchLevel));
		returnDetailedRoyalties	:= false : stored('ReturnDetailedRoyalties');	
		royalties := Royalty.RoyaltyFares.GetBatchRoyaltySet(result.Records,,returnDetailedRoyalties);
		
		OUTPUT(result.Records, NAMED('Results'));
		OUTPUT(royalties, NAMED('RoyaltySet'));
	
	ENDMACRO;	