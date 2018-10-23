/*--SOAP--
<message name="FAP_CountRecs" wuTimeout="300000">
  <part name="did" type = "xsd:string" />
	<part name="bdid" type = "xsd:string" />
	<part name="Jurisdiction" type="xsd:string" />
	<part name="GLBPurpose"   type="xsd:byte" />
	<part name="DPPAPurpose"  type="xsd:byte" />
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="NoDeepDive"   type="xsd:boolean"/>
	<part name="NewStyle" type="xsd:boolean"/>
	<part name="PartyTypeBK" type="xsd:string"/>
</message>
*/
/*--INFO-- FAP StateWide Service
Returns the Number of Records 
available IN and OUTSIDE the Jurisdiction
.*/



EXPORT CountService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
// #constant('SearchGoodSSNOnly',true)
// #constant('SearchIgnoresAddressOnly',true)
// #constant('getBdidsbyExecutive',FALSE)

string14 theDID  := '' : STORED('did');
string theBDID   := '' : STORED('bdid');

// OP := FAP_StateWide.FAP_countRecs.count_records();

OP := IF( theDID <> '',
          FAP_StateWide.FAP_countRecs.count_records(),
					IF ( theBDID <> '',
					      FAB_StateWide.FAB_countRecs.count_records(),
							 DATASET( [ {'NONE', 0, 0} ], Statewide_Services.layout_CountRecs)
							)
				 );


OUTPUT(OP, NAMED('RecordCounts'));

ENDMACRO;