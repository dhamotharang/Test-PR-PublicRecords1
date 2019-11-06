IMPORT  Risk_indicators,  address, VerificationOfOccupancy, Doxie, STD;

EXPORT Batch_Service() := FUNCTION

	// Can't have duplicate definitions of Stored with different default values, 
	// so add the default to #stored to eliminate the assignment of a default value.
	#stored('GLBPurpose',0);
	#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
	#constant('OnlyReturnSuccessfullyCleanedAddresses',true);

  batch_in  := dataset( [], VerificationOfOccupancy.Layouts.Layout_VOOBatchIn ) : stored('batch_in');
	unsigned1 dppa      								:= 0  : stored('DPPAPurpose');
	unsigned1 glba := 0 : stored('GLBPurpose');
	string5 	IndustryClassVal 					:= '' : stored('IndustryClass');
	string 	  DataRestriction 					:= risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string50 	DataPermission 						:= risk_indicators.iid_constants.default_DataPermission  : stored('DataPermissionMask');
	string9   AttributesVersionRequest	:= ''  : stored('AttributesVersionRequest'); 
	boolean   IncludeModel     					:= false  : stored('IncludeModel');
  unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
	string TransactionID := '' : STORED('_TransactionId');
	string BatchUID := '' : STORED('_BatchUID');
	unsigned6 GlobalCompanyId := 0 : STORED('_GCID');
	
	isUtility := Doxie.Compliance.isUtilityRestricted(STD.Str.ToUpperCase(IndustryClassVal)); 

	VOO_wseq := project( batch_in, transform( VerificationOfOccupancy.Layouts.Layout_VOOIn, self.seq := counter, self := left, self := [] ) );

  attributes := VerificationOfOccupancy.Search_Function(VOO_wseq, DataRestriction, glba, dppa, isUtility, AttributesVersionRequest, IncludeModel, DataPermission,LexIdSourceOptout := LexIdSourceOptout, 
	TransactionID := TransactionID, 
	BatchUID := BatchUID, 
	GlobalCompanyID := GlobalCompanyID).VOOReport;  

	VerificationOfOccupancy.Layouts.Layout_VOOBatchOutFlat addAcct(attributes le, VOO_wSeq ri) := transform
		self.AcctNo 																	:= ri.AcctNo;
		self.seq																			:= le.seq;
		self.LexID 																		:= if(le.attributes.version1.AddressReportingSourceIndex <> '', le.LexID, 0);
		self.v1_AddressReportingSourceIndex 					:= le.attributes.version1.AddressReportingSourceIndex;
		self.v1_AddressReportingHistoryIndex 					:= le.attributes.version1.AddressReportingHistoryIndex;
		self.v1_AddressSearchHistoryIndex 						:= le.attributes.version1.AddressSearchHistoryIndex;
		self.v1_AddressUtilityHistoryIndex	 					:= le.attributes.version1.AddressUtilityHistoryIndex;
		self.v1_AddressOwnershipHistoryIndex 					:= le.attributes.version1.AddressOwnershipHistoryIndex;
		self.v1_AddressPropertyTypeIndex 							:= le.attributes.version1.AddressPropertyTypeIndex;
		self.v1_AddressValidityIndex				 					:= le.attributes.version1.AddressValidityIndex;
		self.v1_RelativesConfirmingAddressIndex 			:= le.attributes.version1.RelativesConfirmingAddressIndex;
		self.v1_AddressOwnerMailingAddressIndex 			:= le.attributes.version1.AddressOwnerMailingAddressIndex;
		self.v1_PriorAddressMoveIndex				 					:= le.attributes.version1.PriorAddressMoveIndex;
		self.v1_PriorResidentMoveIndex			 					:= le.attributes.version1.PriorResidentMoveIndex;
		self.v1_AddressDateFirstSeen				 					:= le.attributes.version1.AddressDateFirstSeen;
		self.v1_AddressDateLastSeen					 					:= le.attributes.version1.AddressDateLastSeen;
		self.v1_OccupancyOverride						 					:= le.attributes.version1.OccupancyOverride;
		self.v1_InferredOwnershipTypeIndex	 					:= le.attributes.version1.InferredOwnershipTypeIndex;
		self.v1_OtherOwnedPropertyProximity 					:= le.attributes.version1.OtherOwnedPropertyProximity;
		self.v1_VerificationOfOccupancyScore 					:= le.attributes.version1.VerificationOfOccupancyScore;
	end;	
	
	with_acct := join(attributes, VOO_wSeq, 
								left.seq = right.seq,
								addAcct(left, right), left outer); 

  final := dedup(with_acct, seq);

/* ********************
 *  Debugging Section *
 **********************/

// OUTPUT(glba, NAMED('glba'));																					 
// OUTPUT(batch_in, NAMED('batch_in'));																					 
// OUTPUT(VOO_wseq, NAMED('VOO_wseq'));																					 
// OUTPUT(attributes, NAMED('attributes'));
																					 
RETURN OUTPUT(final, NAMED('Results'));																					 

END;

/*--SOAP--
<message name="Verification Of Occupancy Batch Service">
	<part name="batch_in"  type="tns:XmlDataSet" cols="80" rows="50"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="AttributesVersionRequest" type="xsd:string"/>
	<part name="IncludeModel" type="xsd:boolean"/>
	<part name="DataPermissionMask" type="xsd:string"/>
 </message>
*/
/*--INFO-- Verification Of Occupancy Batch Service*/
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;AcctNo&gt;&lt;/AcctNo&gt;
      &lt;LexID&gt;&lt;/LexID&gt;
      &lt;Name_First&gt;&lt;/Name_First&gt;
      &lt;Name_Middle&gt;&lt;/Name_Middle&gt;
      &lt;Name_Last&gt;&lt;/Name_Last&gt;
      &lt;Name_Suffix&gt;&lt;/Name_Suffix&gt;
      &lt;DOB&gt;&lt;/DOB&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;street_addr&gt;&lt;/street_addr&gt;
      &lt;City_name&gt;&lt;/City_name&gt;
      &lt;St&gt;&lt;/St&gt;
      &lt;Z5&gt;&lt;/Z5&gt;
      &lt;Phone&gt;&lt;/Phone&gt;
      &lt;AsOf&gt;&lt;/AsOf&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/