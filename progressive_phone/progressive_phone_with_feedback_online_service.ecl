/*--SOAP--
<message name="Progressive_Phone_With_Feedback_Online_Service" wuTimeout="300000">
 <part name="DedupePhones" type="tns:XmlDataSet" cols="70" rows="25"/>
 <part name="DPPAPurpose" type="xsd:unsignedInt"/>
 <part name="GLBPurpose" type="xsd:unsignedInt"/>
 <part name="KeepSamePhoneInDiffLevels" type="xsd:boolean"/>
 <part name="DedupAgainstInputPhones" type="xsd:boolean"/>
 <part name="MaxPhoneCount" type="xsd:unsignedInt"/>
 <part name="CountType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
 <part name="CountType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="CountType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
 <part name="CountType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
 <part name="CountType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
 <part name="CountType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
 <part name="CountType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
 <part name="CountType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="CountType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
 <part name="CountType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
 <part name="CountType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
 <part name="CountType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
 <part name="CountType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
 <part name="CountType_Th_TRYHARDER" type="xsd:unsignedInt"/>
 <part name="DynamicOrdering" type="xsd:boolean"/>
 <part name="OrderType1_Es_EDASEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType2_Se_SKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType3_Ap_PROGRESSIVEADDRESSSEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType4_Sp_POSSIBLESPOUSE" type="xsd:unsignedInt"/>
 <part name="OrderType4_Md_POSSIBLEPARENTS" type="xsd:unsignedInt"/>
 <part name="OrderType4_Cl_CLOSESTRELATIVE" type="xsd:unsignedInt"/>
 <part name="OrderType4_Cr_CORESIDENT" type="xsd:unsignedInt"/>
 <part name="OrderType5_Sx_EXPANDEDSKIPTRACESEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType6_Pp_PHONESPLUSSEARCH" type="xsd:unsignedInt"/>
 <part name="OrderType7_UNVERIFIEDPHONE" type="xsd:unsignedInt"/>
 <part name="OrderType_Ne_CLOSESTNEIGHBOR" type="xsd:unsignedInt"/>
 <part name="OrderType_Wk_PEOPLEATWORK" type="xsd:unsignedInt"/>
 <part name="OrderType_Rl_POSSIBLERELOCATION" type="xsd:unsignedInt"/>
 <part name="OrderType_Th_TRYHARDER" type="xsd:unsignedInt"/>
 <part name="IncludeBusinessPhone" type="xsd:boolean"/>
 <part name="IncludeLandlordPhone" type="xsd:boolean"/>
 <part name="IncludeLastResort" type="xsd:boolean"/>
 <part name="UniqueIDConfidenceTreshold" type="xsd:unsignedInt"/>
 <part name="ExcludeNonCellPhonesPlusData" type="xsd:boolean"/>
 <part name="ExcludeDeadContacts" type="xsd:boolean"/>
 <part name="StrictAPSXMatch" type="xsd:boolean"/>
 <part name="DID" type="xsd:string"/>
 <part name="DataPermissionMask" type="xsd:string"/>
 <part name="DataRestrictionMask" type="xsd:string" default="00000000000"/>
 <part name="ProgressivePhonesSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
 <part name="SkipPhoneScoring" type="xsd:boolean"/>
 <part name="ReturnScore" type="xsd:boolean"/>
 <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
 <part name="Phone_Score_Model" type="xsd:string"/>
 <part name="MaxNumAssociate" type="xsd:unsignedInt"/>
 <part name="MaxNumAssociateOther" type="xsd:unsignedInt"/>
 <part name="MaxNumFamilyOther" type="xsd:unsignedInt"/>
 <part name="MaxNumFamilyClose" type="xsd:unsignedInt"/>
 <part name="MaxNumParent" type="xsd:unsignedInt"/>
 <part name="MaxNumSpouse" type="xsd:unsignedInt"/>
 <part name="MaxNumSubject" type="xsd:unsignedInt"/>
 <part name="MaxNumNeighbor" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service returns progressive phones with feedback.*/
/*--HELP-- 
<pre>
&lt;ProgressivePhonesSearchRequest&gt;
  &lt;Row&gt;
    &lt;SearchBy&gt;
      &lt;UniqueId&gt;&lt;/UniqueId&gt;
      &lt;Name&gt;
        &lt;Full&gt;&lt;/Full&gt;
        &lt;First&gt;&lt;/First&gt;
        &lt;Middle&gt;&lt;/Middle&gt;
        &lt;Last&gt;&lt;/Last&gt;
        &lt;Suffix&gt;&lt;/Suffix&gt;
        &lt;Prefix&gt;&lt;/Prefix&gt;
      &lt;/Name&gt;
      &lt;Address&gt;
        &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
        &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt;
        &lt;City&gt;&lt;/City&gt;
        &lt;State&gt;&lt;/State&gt;
        &lt;Zip5&gt;&lt;/Zip5&gt;
        &lt;Zip4&gt;&lt;/Zip4&gt;
        &lt;StreetNumber&gt;&lt;/StreetNumber&gt;
        &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt;
        &lt;StreetName&gt;&lt;/StreetName&gt;
        &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt;
        &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt;
        &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt;
        &lt;UnitNumber&gt;&lt;/UnitNumber&gt;
        &lt;County&gt;&lt;/County&gt;
        &lt;PostalCode&gt;&lt;/PostalCode&gt;
        &lt;StateCityZip&gt;&lt;/StateCityZip&gt;
      &lt;/Address&gt;
      &lt;SSN&gt;&lt;/SSN&gt;
      &lt;DedupeInfo&gt;
        &lt;Phones&gt;
          &lt;Row&gt;
            &lt;Value&gt;&lt;/Value&gt;
          &lt;/Row&gt;
        &lt;/Phones&gt;
      &lt;/DedupeInfo&gt;
    &lt;/SearchBy&gt;
    &lt;Options&gt;
      &lt;ReturnCount&gt;&lt;/ReturnCount&gt;
      &lt;StartingRecord&gt;&lt;/StartingRecord&gt;
      &lt;UseNicknames&gt;&lt;/UseNicknames&gt;
      &lt;UsePhonetics&gt;&lt;/UsePhonetics&gt;
      &lt;KeepSamePhoneInDiffLevels&gt;&lt;/KeepSamePhoneInDiffLevels&gt;
      &lt;DedupeAgainstInputPhones&gt;&lt;/DedupeAgainstInputPhones&gt;
      &lt;IncludePhonesFeedback&gt;&lt;/IncludePhonesFeedback&gt;
      &lt;IncludeBusinessPhone&gt;&lt;/IncludeBusinessPhone&gt;
      &lt;IncludeLandlordPhone&gt;&lt;/IncludeLandlordPhone&gt;
      &lt;IncludeNonCellPhonesPlusData&gt;&lt;/IncludeNonCellPhonesPlusData&gt;
      &lt;IncludeLastResort&gt;&lt;/IncludeLastResort&gt;
      &lt;StrictAPSXMatch&gt;&lt;/StrictAPSXMatch&gt;
      &lt;BlankOutDuplicatePhones&gt;&lt;/BlankOutDuplicatePhones&gt;
      &lt;IncludeDeadContacts&gt;&lt;/IncludeDeadContacts&gt;
      &lt;UniqueIDConfidenceTreshold&gt;&lt;/UniqueIDConfidenceTreshold&gt;
      &lt;MaxPhoneCount&gt;&lt;/MaxPhoneCount&gt;
      &lt;EDACount&gt;&lt;/EDACount&gt;
      &lt;SkipTraceCount&gt;&lt;/SkipTraceCount&gt;
      &lt;ProgressiveAddressCount&gt;&lt;/ProgressiveAddressCount&gt;
      &lt;SpouseCount&gt;&lt;/SpouseCount&gt;
      &lt;ParentsCount&gt;&lt;/ParentsCount&gt;
      &lt;ClosestRelativesCount&gt;&lt;/ClosestRelativesCount&gt;
      &lt;CoResidentCount&gt;&lt;/CoResidentCount&gt;
      &lt;ExpandedSkipTraceCount&gt;&lt;/ExpandedSkipTraceCount&gt;
      &lt;PhonesPlusCount&gt;&lt;/PhonesPlusCount&gt;
      &lt;UnverifiedCount&gt;&lt;/UnverifiedCount&gt;
      &lt;ClosestNeighborCount&gt;&lt;/ClosestNeighborCount&gt;
      &lt;PAWCount&gt;&lt;/PAWCount&gt;
      &lt;PossibleRelocationCount&gt;&lt;/PossibleRelocationCount&gt;
      &lt;TypeThTryHarderCount&gt;&lt;/TypeThTryHarderCount&gt;
      &lt;InputCount&gt;&lt;/InputCount&gt;
      &lt;DynamicOrdering&gt;&lt;/DynamicOrdering&gt;
      &lt;EDAOrder&gt;&lt;/EDAOrder&gt;
      &lt;SkipTraceOrder&gt;&lt;/SkipTraceOrder&gt;
      &lt;ProgressiveAddressOrder&gt;&lt;/ProgressiveAddressOrder&gt;
      &lt;SpouseOrder&gt;&lt;/SpouseOrder&gt;
      &lt;ParentsOrder&gt;&lt;/ParentsOrder&gt;
      &lt;ClosestRelativesOrder&gt;&lt;/ClosestRelativesOrder&gt;
      &lt;CoResidentOrder&gt;&lt;/CoResidentOrder&gt;
      &lt;ExpandedSkipTraceOrder&gt;&lt;/ExpandedSkipTraceOrder&gt;
      &lt;PhonesPlusOrder&gt;&lt;/PhonesPlusOrder&gt;
      &lt;UnverifiedOrder&gt;&lt;/UnverifiedOrder&gt;
      &lt;ClosestNeighborOrder&gt;&lt;/ClosestNeighborOrder&gt;
      &lt;PAWOrder&gt;&lt;/PAWOrder&gt;
      &lt;PossibleRelocationOrder&gt;&lt;/PossibleRelocationOrder&gt;
      &lt;TypeThTryHarderOrder&gt;&lt;/TypeThTryHarderOrder&gt;
      &lt;ScoreModel&gt;&lt;/ScoreModel&gt;
      &lt;MaxNumAssociate&gt;&lt;/MaxNumAssociate&gt;
      &lt;MaxNumAssociateOther&gt;&lt;/MaxNumAssociateOther&gt;
      &lt;MaxNumFamilyOther;&lt;/MaxNumFamilyOther&gt;
      &lt;MaxNumFamilyClose&gt;&lt;/MaxNumFamilyClose&gt;
      &lt;MaxNumParent&gt;&lt;/MaxNumParent&gt;
      &lt;MaxNumSpouse&gt;&lt;/MaxNumSpouse&gt;
      &lt;MaxNumNeighbor&gt;&lt;/MaxNumNeighbor&gt;
      &lt;MaxNumSubject&gt;&lt;/MaxNumSubject&gt;
      &lt;SkipPhoneScoring&gt;&lt;/SkipPhoneScoring&gt;
      &lt;ReturnScore&gt;&lt;/ReturnScore&gt;
    &lt;/Options&gt;
    &lt;User&gt;
      &lt;AccountNumber&gt;&lt;/AccountNumber&gt;
    &lt;/User&gt;
  &lt;/Row&gt;
&lt;/ProgressivePhonesSearchRequest&gt;
</pre>
*/

IMPORT AutoStandardI, Doxie, progressive_phone, addrBest, iesp, PhonesFeedback_Services, ut,
       Royalty, Gateway;

EXPORT progressive_phone_with_feedback_online_service := MACRO
  rec_in := iesp.progressivephones.t_ProgressivePhonesSearchRequest;
  // "FEW" keyword set to make data read more efficient
  ds_in := DATASET([], rec_in) : STORED('ProgressivePhonesSearchRequest', FEW);
  // "independent" keyword used here to make statement atomic and a signal to 
  // code generator to not combine it with other lines of code.
  first_row := ds_in[1] : INDEPENDENT;
  
  //set options
  search_by := GLOBAL(first_row.SearchBy);
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
  iesp.ECL2ESP.SetInputName(search_by.Name);
  iesp.ECL2ESP.SetInputAddress(search_by.Address);
  global_mod := AutoStandardI.GlobalModule();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(global_mod);

  #STORED('DID', search_by.UniqueId);
  #STORED('DedupePhones', search_by.DedupeInfo.phones);
  #STORED('ExcludeDeadContacts', ~first_row.options.IncludeDeadContacts);
  #STORED('DedupAgainstInputPhones', first_row.options.DedupeAgainstInputPhones);
  #STORED('KeepSamePhoneInDiffLevels', first_row.options.KeepSamePhoneInDiffLevels);
  #STORED('IncludePhonesFeedback', first_row.options.IncludePhonesFeedback);
  #STORED('IncludeLastResort', first_row.options.IncludeLastResort);
  #STORED('UniqueIDConfidenceTreshold', first_row.options.UniqueIDConfidenceTreshold);
  #STORED('BlankOutDuplicatePhones', first_row.options.BlankOutDuplicatePhones);
  #STORED('MaxPhoneCount', first_row.options.MaxPhoneCount);
  #STORED('CountType1_ES_EDASEARCH', first_row.options.EDACount);
  #STORED('CountType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceCount);
  #STORED('CountType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressCount);
  #STORED('CountType4_SP_POSSIBLESPOUSE', first_row.options.SpouseCount);
  #STORED('CountType4_MD_POSSIBLEPARENTS', first_row.options.ParentsCount);
  #STORED('CountType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesCount);
  #STORED('CountType4_CR_CORESIDENT', first_row.options.CoResidentCount);
  #STORED('CountType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceCount);
  #STORED('CountType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusCount);
  #STORED('CountType7_UNVERIFIEDPHONE', first_row.options.UnverifiedCount);
  #STORED('CountType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborCount);
  #STORED('CountType_WK_PEOPLEATWORK', first_row.options.PAWCount);
  #STORED('CountType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationCount);
  #STORED('CountType_TH_TRYHARDER', first_row.options.TypeThTryHarderCount);
  #STORED('DynamicOrdering', first_row.options.DynamicOrdering);
  #STORED('OrderType1_ES_EDASEARCH', first_row.options.EDAOrder);
  #STORED('OrderType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceOrder);
  #STORED('OrderType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressOrder);
  #STORED('OrderType4_SP_POSSIBLESPOUSE', first_row.options.SpouseOrder);
  #STORED('OrderType4_MD_POSSIBLEPARENTS', first_row.options.ParentsOrder);
  #STORED('OrderType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesOrder);
  #STORED('OrderType4_CR_CORESIDENT', first_row.options.CoResidentOrder);
  #STORED('OrderType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceOrder);
  #STORED('OrderType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusOrder);
  #STORED('OrderType7_UNVERIFIEDPHONE', first_row.options.UnverifiedOrder);
  #STORED('OrderType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborOrder);
  #STORED('OrderType_WK_PEOPLEATWORK', first_row.options.PAWOrder);
  #STORED('OrderType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationOrder);
  #STORED('OrderType_TH_TRYHARDER', first_row.options.TypeThTryHarderOrder);
     
  #STORED('IncludeBusinessPhone', first_row.options.IncludeBusinessPhone);
  #STORED('IncludeLandlordPhone', first_row.options.IncludeLandlordPhone);

  #STORED('ExcludeNonCellPhonesPlusData', ~first_row.options.IncludeNonCellPhonesPlusData);
  #STORED('StrictAPSXMatch', first_row.options.StrictAPSXMatch);
  #STORED('SkipPhoneScoring', first_row.options.SkipPhoneScoring);
  #STORED('ReturnScore', first_row.options.ReturnScore);
  #STORED('Phone_Score_Model', first_row.options.ScoreModel);
  
  #STORED('MaxNumAssociate', first_row.options.MaxNumAssociate);
  #STORED('MaxNumAssociateOther', first_row.options.MaxNumAssociateOther);
  #STORED('MaxNumFamilyOther', first_row.options.MaxNumFamilyOther);
  #STORED('MaxNumFamilyClose', first_row.options.MaxNumFamilyClose);
  #STORED('MaxNumParent', first_row.options.MaxNumParent);
  #STORED('MaxNumSpouse', first_row.options.MaxNumSpouse);
  #STORED('MaxNumSubject', first_row.options.MaxNumSubject);
  #STORED('MaxNumNeighbor', first_row.options.MaxNumNeighbor);
  
  IncludePhonesFeedback := TRUE : STORED('IncludePhonesFeedback');
 
  BOOLEAN ReturnScores := FALSE : STORED('ReturnScore');
  STRING14 ldid := '0' : STORED('DID');
   
  gateways_in := Gateway.Configuration.Get();
  
  // Options for phone_shell WFP v7
  STRING scoreModel := '' : STORED('Phone_Score_Model');
  
  UNSIGNED2 MaxNumAssociate      := 0 : STORED('MaxNumAssociate');
  UNSIGNED2 MaxNumAssociateOther := 0 : STORED('MaxNumAssociateOther');
  UNSIGNED2 MaxNumFamilyOther    := 0 : STORED('MaxNumFamilyOther');
  UNSIGNED2 MaxNumFamilyClose    := 0 : STORED('MaxNumFamilyClose');
  UNSIGNED2 MaxNumParent   := 0 : STORED('MaxNumParent');
  UNSIGNED2 MaxNumSpouse   := 0 : STORED('MaxNumSpouse');
  UNSIGNED2 MaxNumSubject  := 0 : STORED('MaxNumSubject');
  UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');
  
  f_dedup_phones := DATASET([],iesp.share.t_StringArrayItem) : STORED('DedupePhones');
  
  Rec1(STRING14 did_value) := TRANSFORM(progressive_phone.layout_progressive_batch_in,
                                SELF.did := (INTEGER)did_value,
                                SELF := []);
  f_in_raw := DATASET([Rec1(ldid)]);
  
  f_out := PROJECT(UNGROUP(addrBest.Progressive_phone_common(f_in_raw, 
                                , // progressive_phone.waterfall_phones_options
                                f_dedup_phones, 
                                gateways_in, 
                                , // type_a_with_did = FALSE
                                , // useNeustar = TRUE
                                , // default_sx_match_limit = FALSE
                                , // isPFR = FALSE
                                scoreModel, // this decides if Phone_Shell is called. Send COMMON_SCORE to call the Phone_Shell (or deprecated values PHONESCORE_V2 or COLLECTIONSCORE_V3)
                                MaxNumAssociate,
                                MaxNumAssociateOther,
                                MaxNumFamilyOther,
                                MaxNumFamilyClose,
                                MaxNumParent,
                                MaxNumSpouse,
                                MaxNumSubject,
                                MaxNumNeighbor)), progressive_phone.layout_progressive_online_out);
    
  PhonesFeedback_Services.Mac_Append_Feedback(f_out // Input File
       ,did
       ,subj_phone10
       ,f_out_w_fb // Output file with feedback dataset
       ,mod_access);
   
  Royalty.MAC_RoyaltyLastResort(f_out, lastresort_royalties, vendor, subj_phone10) 
  OUTPUT(lastresort_royalties, NAMED('RoyaltySet'));     
   
  rslt := IF(IncludePhonesFeedback, f_out_w_fb, f_out);
  ut.getTimeZone(rslt, subj_phone10, timeZone, finalout);
   
  BOOLEAN SkipPhonesScoring := FALSE : STORED('SkipPhoneScoring');
  // If we are skipping the phone scoring model sort by sort order, else sort by the phone score returned from the model
  // Note also that if scoreModel = '', then Phone_Shell was not run. GetPhonesV1 was run instead in addrBest.Progressive_phone_common above.
  sort_rslt := MAP(scoreModel <> ''                      => finalout,
                   SkipPhonesScoring AND scoreModel = '' => SORT(finalout, sort_order, sort_order_internal),  
                                                            SORT(finalout, -phone_score));         
   
  tempresults := iesp.transform_progressive_phones(sort_rslt, ReturnScores, scoreModel); 
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, 
                         results, 
                         iesp.progressivephones.t_ProgressivePhonesSearchResponse, 
                         Records,
                         FALSE);
        
  OUTPUT(results, NAMED('Results'));
ENDMACRO;
// progressive_phone.progressive_phone_with_feedback_online_service();