/*--SOAP--
<message name="Progressive_Phone_With_Feedback_Batch_Service" wuTimeout="300000">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
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
  <part name="IncludeRelativeCellPhones" type="xsd:boolean"/>
  <part name="UniqueIDConfidenceTreshold" type="xsd:unsignedInt"/>
  <part name="ExcludeNonCellPhonesPlusData" type="xsd:boolean"/>
  <part name="StrictAPSXMatch" type="xsd:boolean"/>
  <part name="Blankout_Linetype_C_CELL" type="xsd:boolean"/>
  <part name="Blankout_Linetype_P_POTS_Landline" type="xsd:boolean"/>
  <part name="Blankout_Linetype_G_PAGER" type="xsd:boolean"/>
  <part name="Blankout_Linetype_V_VOIP" type="xsd:boolean"/>
  <part name="Blankout_Linetype_I_PR_VI" type="xsd:boolean"/>
  <part name="Blankout_Linetype_8_TOLL_FREE" type="xsd:boolean"/>
  <part name="Blankout_Linetype_U_UNKNOWN_OTHER" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="UsePremiumSource_A" type="xsd:boolean"/>
  <part name="PremiumSource_A_limit" type="xds:integer"/>
  <part name="Gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
  <part name="SkipPhoneScoring" type="xsd:boolean"/>
  <part name="ReturnScore" type="xsd:boolean"/>
  <part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
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
&lt;batch_in&gt;
  &lt;Row&gt;
    &lt;did&gt;&lt;/did&gt;
    &lt;acctno&gt;&lt;/acctno&gt;
    &lt;name_first&gt;&lt;/name_first&gt;
    &lt;name_middle&gt;&lt;/name_middle&gt;
    &lt;name_last&gt;&lt;/name_last&gt;
    &lt;name_suffix&gt;&lt;/name_suffix&gt;
    &lt;dob&gt;&lt;/dob&gt;
    &lt;phoneno&gt;&lt;/phoneno&gt;
    &lt;prim_range&gt;&lt;/prim_range&gt;
    &lt;predir&gt;&lt;/predir&gt;
    &lt;prim_name&gt;&lt;/prim_name&gt;
    &lt;suffix&gt;&lt;/suffix&gt;
    &lt;postdir&gt;&lt;/postdir&gt;
    &lt;unit_desig&gt;&lt;/unit_desig&gt;
    &lt;sec_range&gt;&lt;/sec_range&gt;
    &lt;p_city_name&gt;&lt;/p_city_name&gt;
    &lt;st&gt;&lt;/st&gt;
    &lt;z5&gt;&lt;/z5&gt;
    &lt;z4&gt;&lt;/z4&gt;
    &lt;ssn&gt;&lt;/ssn&gt;
    &lt;phoneno_1&gt;&lt;/phoneno_1&gt;
    &lt;phoneno_2&gt;&lt;/phoneno_2&gt;
    &lt;phoneno_3&gt;&lt;/phoneno_3&gt;
    &lt;phoneno_4&gt;&lt;/phoneno_4&gt;
    &lt;phoneno_5&gt;&lt;/phoneno_5&gt;
    &lt;phoneno_6&gt;&lt;/phoneno_6&gt;
    &lt;phoneno_7&gt;&lt;/phoneno_7&gt;
    &lt;phoneno_8&gt;&lt;/phoneno_8&gt;
    &lt;phoneno_9&gt;&lt;/phoneno_9&gt;
    &lt;phoneno_10&gt;&lt;/phoneno_10&gt;
  &lt;/Row&gt;
&lt;/batch_in&gt;
</pre>
*/

IMPORT progressive_phone, addrBest, Gateway, ut;

EXPORT progressive_phone_with_feedback_batch_service := MACRO

  f_in_raw := DATASET([], progressive_phone.layout_progressive_batch_in) : STORED('batch_in', FEW);

  BOOLEAN IncludeLastResort := FALSE : STORED('IncludeLastResort');
  gateways_in := Gateway.Configuration.Get();

  BOOLEAN UsePremiumSource_A := FALSE : STORED('UsePremiumSource_A'); //equifax
  INTEGER PremiumSource_A_limit  := 0 : STORED('PremiumSource_A_limit');

  UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
  UNSIGNED2 MaxNumAssociateOther  := 0 : STORED('MaxNumAssociateOther');
  UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
  UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
  UNSIGNED2 MaxNumParent   := 0 : STORED('MaxNumParent');
  UNSIGNED2 MaxNumSpouse   := 0 : STORED('MaxNumSpouse');
  UNSIGNED2 MaxNumSubject  := 0 : STORED('MaxNumSubject');
  UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');

  // Options for phone_shell WFP v8
  STRING25 scoreModel := '' : STORED('Phone_Score_Model'); // COLLECTIONSCORE_V3 for new score model.

  #STORED('IncludePhonesFeedback', TRUE);

  BOOLEAN ReturnScore := FALSE : STORED('ReturnScore'); // Unless ReturnScore is TRUE - blank out the Phone Score values


  inMod := progressive_phone.waterfall_phones_options;
  inModNoBlankingOfPhone10 := MODULE(PROJECT(inMod, progressive_phone.iParam.Batch))
    EXPORT BOOLEAN BlankOutLineTypeCell     := FALSE;
    EXPORT BOOLEAN BlankOutLineTypePotsLand := FALSE;
    EXPORT BOOLEAN BlankOutLineTypePager    := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeVOIP     := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeIsland   := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeTollFree := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeUnknown  := FALSE;
   END;

  BOOLEAN isD2C := ut.IndustryClass.is_Knowx;
  callEquifax := IF(isD2C, FALSE, UsePremiumSource_A);

  wf_without_fb_recs := addrBest.Progressive_phone_common(f_in_raw,
                                                          inModNoBlankingOfPhone10, // progressive_phone.waterfall_phones_options
                                                          , // dedup_phones = DATASET([],iesp.share.t_StringArrayItem)
                                                          gateways_in,
                                                          , // type_a_with_did (false)
                                                          , // useNeustar (true)
                                                          , // default_sx_match_limit (false)
                                                          , // isPFR (false)
                                                          scoreModel, // this decides if Phone_Shell is called. Send COMMON_SCORE to call the Phone_Shell (or deprecated values PHONESCORE_V2 or COLLECTIONSCORE_V3)
                                                          MaxNumAssociate,
                                                          MaxNumAssociateOther,
                                                          MaxNumFamilyOther,
                                                          MaxNumFamilyClose,
                                                          MaxNumParent,
                                                          MaxNumSpouse,
                                                          MaxNumSubject,
                                                          MaxNumNeighbor,
                                                          callEquifax,
                                                          PremiumSource_A_limit);

  wf_with_meta_recs := progressive_phone.functions.UpdateWithMetadata(UNGROUP(wf_without_fb_recs));
  wf_with_fb_recs := progressive_phone.FN_AppendFeedback(wf_with_meta_recs);

  wf_with_blanking := IF(inMod.BlankOutLineTypeCell
        OR inMod.BlankOutLineTypePotsLand
        OR inMod.BlankOutLineTypePager
        OR inMod.BlankOutLineTypeVOIP
        OR inMod.BlankOutLineTypeIsland
        OR inMod.BlankOutLineTypeTollFree
        OR inMod.BlankOutLineTypeUnknown,
    progressive_phone.functions.conditionallyBlankPhone10(wf_with_fb_recs, inMod), wf_with_fb_recs);

  ut.mac_TrimFields(wf_with_blanking, 'wf_with_blanking', result_trimmed);

  results_1 := progressive_phone.FN_BatchFinalAssignments(result_trimmed, progressive_phone.layout_progressive_batch_out_with_fb, callEquifax, scoreModel);

  // ROYALTIES
  BOOLEAN ReturnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
  dRoyaltiesByAcctno_LastResort := IF(IncludeLastResort, Royalty.RoyaltyLastResort.GetBatchRoyaltiesByAcctno(f_in_raw, results_1, vendor, acctno, acctno));
  dRoyaltiesByAcctno_EQUIFAX := IF(callEquifax, Royalty.RoyaltyEFXDataMart.GetBatchRoyaltiesByAcctno(f_in_raw, results_1, , , acctno));
  dRoyaltiesByAcctno := dRoyaltiesByAcctno_LastResort + dRoyaltiesByAcctno_EQUIFAX;
  dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);

  //We need to ensure that if return score is false, we blank out the score right before returning the results since prior logic depends on the score being present
  final_results := IF(ReturnScore, results_1, PROJECT(results_1, TRANSFORM(RECORDOF(results_1), SELF.phone_score := '', SELF := LEFT)));

  OUTPUT(dRoyalties,NAMED('RoyaltySet'));
  OUTPUT(final_results, NAMED('Results'));

ENDMACRO;
