/*--SOAP--
<message name="BankruptcySearchService">
  <!-- Indexed Directly -->
  <part name="TMSID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>

  <!-- Indexed by Autokey -->
  <part name="PartyType" type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name='SSN' type='xsd:string'/>
  <part name="FEIN" type="xsd:string"/>
  
  <!-- CaseNumber -->
  <part name="CaseNumber" type="xsd:string"/>
  
  <part name="FilingJurisdiction" type='xsd:string'/>
  
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="NoDeepDive" type="xsd:boolean"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" row="3"/>
  <part name="StrictMatch" type="xsd:boolean"/>
  <part name="IncludeCriminalIndicators" type="xsd:boolean"/>

 <!-- Business Bankrupcty Only -->
  <part name="ChapterChoice" type="xsd:unsignedInt"/>
  <part name="BusinessOnly" type="xsd:boolean"/>


</message>
*/
/*--INFO-- This service searches the Bankruptcyv2 files.*/

IMPORT doxie,Text_Search;

EXPORT BankruptcySearchService() := MACRO
  #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_BankruptcyV2_Services_SearchService();
  
  doxie.MAC_Selection_Declare()
  doxie.MAC_Header_Field_Declare()
  
  UNSIGNED ChapterChoice := 0 : STORED('ChapterChoice');
  BOOLEAN BusinessOnly := FALSE : STORED('BusinessOnly');

  #CONSTANT('SearchIgnoresAddressOnly',TRUE);
  #STORED('ScoreThreshold',10);
  #STORED('PenaltThreshold',10);
  #CONSTANT('DisplayMatchedParty',TRUE);
  #CONSTANT('isFCRA', FALSE);

  recs := bankruptcyv2_Services.bankruptcy_raw().search_view(
    in_ssn_mask := ssn_mask_value,
    in_party_type := Party_Type,
    in_filing_jurisdiction := FilingJurisdiction_value,
    in_includeCriminalIndicators := IncludeCriminalIndicators
  );

  
    // If needed filter out chapters
  bankrecs_chp := MAP(
    ChapterChoice = 1 => recs(Chapter = '11'),
    ChapterChoice = 2 => recs(Chapter = '7'),
    ChapterChoice = 3 => recs(Chapter IN ['11','7']),
    ChapterChoice NOT IN [1,2,3] AND BusinessOnly => recs(Chapter IN ['11','7']),
    recs);
                                          
  // Classify the Bankruptcy record
  bankrecs_classified := BLJ_V2_Services.fnSupressPeople(bankrecs_chp);
  bankrecs_unclassified := PROJECT(bankrecs_chp,
    TRANSFORM(RECORDOF(bankrecs_classified),
      SELF.BKRecordType := 3, // no classification
      SELF := LEFT));
                                
  bankrecs_final := IF(BusinessOnly,bankrecs_classified(BKRecordType <> 0),bankrecs_unclassified);
                                                            
  orec := RECORD
    RECORDOF(recs);
    Text_Search.Layout_ExternalKey;
    // added
    BOOLEAN DebtorsSuppressed;
  END;
  
  orec addExt(bankrecs_final l) := TRANSFORM
    SELF.ExternalKey := l.TMSID;
    SELF.DebtorsSuppressed := l.BKRecordType = 2; // added
    SELF := l;
  END;
  
  recs2 := PROJECT(bankrecs_final, addext(LEFT));
  
  doxie.MAC_Marshall_Results(recs2, recs_marshalled);
        //output(recs, named('recs'));
  OUTPUT(recs_marshalled, NAMED('Results'));
ENDMACRO;
