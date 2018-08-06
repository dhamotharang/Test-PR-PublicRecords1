/*--SOAP--
<message name="Bankruptcy_BatchServiceFCRA">
  <part name="DPPAPurpose"          type="xsd:byte"/>
  <part name="GLBPurpose"           type="xsd:byte"/> 
  <part name="ApplicationType"     type="xsd:string"/>

  <part name="Phonetics"            type="xsd:boolean"/>
  <part name="Nicknames"            type="xsd:boolean"/>
  <part name="SSNMask"              type="xsd:string"/>
  
  <part name="Match_Name"           type="xsd:boolean"/>
  <part name="Match_Comp_Name"      type="xsd:boolean"/>
  <part name="Match_Street_Address" type="xsd:boolean"/>
  <part name="Match_City"           type="xsd:boolean"/>
  <part name="Match_State"          type="xsd:boolean"/>
  <part name="Match_Zip"            type="xsd:boolean"/>
  <part name="Match_Phone"          type="xsd:boolean"/>
  <part name="Match_SSN"            type="xsd:boolean"/>
  <part name="Match_FEIN"           type="xsd:boolean"/>
  <part name="Match_DOB"            type="xsd:boolean"/>
    
  <part name="IsDeepDive"           type="xsd:boolean"/>
  <part name="IsFCRA"                type="xsd:boolean"/>
  <part name="MatchCode_ADL_Append" type="xsd:boolean"/>
  
    <part name="PenaltThreshold"    type="xsd:unsignedInt"/>
  <part name="MaxResults"           type="xsd:unsignedInt"/>
  <part name="Max_Results_Per_Acct" type="xsd:byte"/>  
  
  <part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>  
  
  <part name="Match_Attorneys"      type="xsd:boolean"/>
  <part name="Match_Creditors"      type="xsd:boolean"/>
  <part name="Match_Debtors"        type="xsd:boolean"/>
  
  <part name="MatchCode_Includes"    type="xsd:string"/>
  <part name="Chapter_Includes"      type="xsd:string"/>
  <part name="DCode_Includes"        type="xsd:string"/>
  
  <part name="DaysBack"               type="xsd:unsignedInt"/>  
  <part name="DID_Score_Threshold"  type="xsd:unsignedInt"/>
  <part name="BDID_Score_Threshold" type="xsd:unsignedInt"/>
  <part name="BIPFetchLevel"         type="xsd:string"/>
  <part name="BIPSkipMatch"         type="xsd:boolean"/>

  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/>
  <part name="FFDOptionsMask"       type="xsd:string"/>
  <part name="FCRAPurpose"          type="xsd:string"/>
  <part name="UseNameSSNLast4"      type="xsd:boolean"/>
</message>
*/
IMPORT AutoStandardI, BatchServices, BankruptcyV3_Services, FFD, UT;

export Bankruptcy_BatchServiceFCRA(useCannedRecs = 'false') := 
  MACRO
  
    #OPTION('optimizeProjects', TRUE);
    
    // Imitate in part the constants and stored variables found in the bankruptcy search service.
    #constant('SearchIgnoresAddressOnly',true);
    #stored('ScoreThreshold',10);
    #stored('PenaltThreshold',20);
    
    #constant('DisplayMatchedParty',true);
    #constant('isFCRA', true);
    #constant('noDeepDive', true);
    
    BOOLEAN isFCRA           := true    : STORED('IsFCRA');
    BOOLEAN isDeepDive         := false  : STORED('IsDeepDive');
    STRING7 in_ssn_mask        := 'NONE'  : STORED('SSNMask');
    
    // 1. Build party_type set.
    BOOLEAN match_attorneys        := FALSE  : STORED('Match_Attorneys');
    BOOLEAN match_creditors        := FALSE   : STORED('Match_Creditors');
    BOOLEAN match_debtors          := TRUE   : STORED('Match_Debtors');
    
    boolean use_namessnlast4      := true   : stored('UseNameSSNLast4');
    
    STRING1 BIPFetchLevel    := 'S'   : STORED('BIPFetchLevel');
    BOOLEAN BIPSkipMatch    := true  : STORED('BIPSkipMatch');
    
    BOOLEAN suppress_withdrawn_bankruptcy  := FALSE   : STORED('SuppressWithdrawnBankruptcy');
    STRING32 application_type := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
    INTEGER8 inFFDOptionsMask := FFD.FFDMask.Get(inApplicationType := application_type);
    INTEGER inFCRAPurpose := FCRA.FCRAPurpose.Get();
    
    // Return all records if either all the booleans are true, or all are false. The reason is 
    // because it's common to run a batch job without checking any parties and yet expect the 
    // system to return all results. Strictly a concession to human behavior.
    BOOLEAN all_or_none_are_checked := (match_attorneys AND match_creditors AND match_debtors) OR
                                        NOT (match_attorneys OR match_creditors OR match_debtors);
    
    SET OF STRING1 attorney_type := IF( match_attorneys, ['A'], [] );
    SET OF STRING1 creditor_type := IF( match_creditors, ['C'], [] );
    SET OF STRING1 debtor_type   := IF( match_debtors,   ['D'], [] );
        
    SET OF STRING1 party_types   := IF( all_or_none_are_checked, 
                                        ['A','C','D',''],
                                        attorney_type + creditor_type + debtor_type
                                       );
    
    ds_batch_in := IF( NOT useCannedRecs,
                      BatchServices.file_Bankruptcy_Batch_in(forceSeq := FALSE),
                      PROJECT(BatchServices._Sample_inBatchMaster('BANKRUPTCY'), BatchServices.layout_BankruptcyV3_Batch_in)
                      );  
                      
    // Search for Bk records by party.    
    ds_batch := BatchServices.Bankruptcy_BatchService_Records.search(ds_batch_in, 
                                                                      party_types, 
                                                                      isFCRA, 
                                                                      isDeepDive, 
                                                                      in_ssn_mask, 
                                                                      use_namessnlast4, 
                                                                      BIPFetchLevel, 
                                                                      BIPSkipMatch, 
                                                                      suppress_withdrawn_bankruptcy);
   
    // FCRA FFD
    res := BankruptcyV3_Services.fn_fcra_ffd_batch(ds_batch, inFFDOptionsMask, inFCRAPurpose);
    res_records := FFD.Mac.InquiryLexidBatch(ds_batch_in, res.records, BatchServices.layout_BankruptcyV3_Batch_out, 0);
    
    results_pre := sort(res_records, acctno); // records in batch out layout
    consumer_statements := sort(res.statements, acctno); // statements

    ut.mac_TrimFields(results_pre, 'results_pre', results);
        
    OUTPUT(results, NAMED('Results'));    
    OUTPUT(consumer_statements, NAMED('CSDResults'));
  
  
  ENDMACRO;
// BatchServices.Bankruptcy_BatchServiceFCRA();
 