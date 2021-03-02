/*--SOAP--
<message name="Progressive_Phone_Batch_Service" wuTimeout="300000">
 <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
 <part name="DPPAPurpose" type="xsd:unsignedInt"/>
 <part name="GLBPurpose" type="xsd:unsignedInt"/>
 <part name="KeepSamePhoneInDIFfLevels" type="xsd:boolean"/>
 <part name="DedupAgainstInputPhones" type="xsd:boolean"/>
 <part name="MaxPhoneCount" type="xsd:unsignedInt"/>
 <part name="SXMatchRestrictionLimit" type="xsd:unsignedInt"/>
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
 <part name="UniqueIDConfidenceTreshold" type="xsd:unsignedInt"/>
 <part name="ExcludeNonCellPhonesPlusData" type="xsd:boolean"/>
 <part name="StrictAPSXMatch" type="xsd:boolean"/>
 <part name="BlankOutDuplicatePhones" type="xsd:boolean"/>
 <part name="Blankout_Linetype_C_CELL" type="xsd:boolean"/>
 <part name="Blankout_Linetype_P_POTS_Landline" type="xsd:boolean"/>
 <part name="Blankout_Linetype_G_PAGER" type="xsd:boolean"/>
 <part name="Blankout_Linetype_V_VOIP" type="xsd:boolean"/>
 <part name="Blankout_Linetype_I_PR_VI" type="xsd:boolean"/>
 <part name="Blankout_Linetype_8_TOLL_FREE" type="xsd:boolean"/>
 <part name="Blankout_Linetype_U_UNKNOWN_OTHER" type="xsd:boolean"/>
 <part name="DataRestrictionMask" type="xsd:string"/>
 <part name="IncludeSevenDigitPhones" type="xsd:boolean"/>
 <part name="IncludeLastResort" type="xsd:boolean"/>
 <part name="IncludeRelativeCellPhones" type="xsd:boolean"/>
 <part name="IncludeCellFirstforPP" type="xsd:boolean"/>
 <part name="DataPermissionMask" type="xsd:string"/>
 <part name="Match_Name" type="xsd:boolean"/>
 <part name="Match_Street_Address" type="xsd:boolean"/>
 <part name="Match_City" type="xsd:boolean"/>
 <part name="Match_State" type="xsd:boolean"/>
 <part name="Match_Zip" type="xsd:boolean"/>
 <part name="Match_SSN" type="xsd:boolean"/>
 <part name="Match_LinkID" type="xsd:boolean"/>
 <part name="SkipPhoneScoring" type="xsd:boolean"/>
 <part name="ReturnScore" type="xsd:boolean"/>
 <part name="UsePremiumSource_A" type="xsd:boolean"/>
 <part name="PremiumSource_A_limit" type="xds:integer"/>
 <part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
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
 <part name="RunRelocation" type="xsd:boolean"/>
 <part name="UseCommonScore" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns progressive phones.*/
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

IMPORT progressive_phone, Royalty, addrBest, iesp, STD, Gateway;

EXPORT progressive_phone_batch_service := MACRO

  gateways_in := Gateway.Configuration.Get();
  BOOLEAN IncludeLastResort := FALSE : STORED('IncludeLastResort');

  BOOLEAN UsePremiumSource_A := FALSE : STORED('UsePremiumSource_A'); //equifax
  INTEGER PremiumSource_A_limit  := 0 : STORED('PremiumSource_A_limit'); //max of 3 equifax phones can be returned

  UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
  UNSIGNED2 MaxNumAssociateOther := 0 : STORED('MaxNumAssociateOther');
  UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
  UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
  UNSIGNED2 MaxNumParent   := 0 : STORED('MaxNumParent');
  UNSIGNED2 MaxNumSpouse   := 0 : STORED('MaxNumSpouse');
  UNSIGNED2 MaxNumSubject  := 0 : STORED('MaxNumSubject');
  UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');
  BOOLEAN RunRelocation := FALSE : STORED('RunRelocation');
  // CommonScore is using the latest and greatest Phone Shell and model (currently v3.0)
  // only chosen KTRs (e.g. Lifelock) are set up to send FALSE here for now (until we are certain it will perform well on 3.0)
  BOOLEAN UseCommonScore := TRUE : STORED('UseCommonScore');

  // Options for phone_shell WFP V8
  STRING25 scoreModel := '' : STORED('Phone_Score_Model'); //COLLECTIONSCORE_V3 for new score model.

  BOOLEAN ReturnScore := FALSE : STORED('ReturnScore'); // Unless ReturnScore is TRUE - blank out the Phone Score values

  f_in_raw_unfixed := DATASET([], progressive_phone.layout_progressive_batch_in) : STORED('batch_in', FEW);

  f_dedup_phones := DATASET([], iesp.share.t_StringArrayItem): STORED('DedupePhones');

  f_in_raw := PROJECT(f_in_raw_unfixed,
                TRANSFORM(progressive_phone.layout_progressive_batch_in,
                  SELF.ssn := STD.Str.Filter(LEFT.ssn, '1234567890');
                  SELF := LEFT));

  // To temporarily ease performance concerns for very large batch jobs (e.g. Lifelock) we need to force
  // this service (progressive_phone_batch_service) to run Phone Shell V1 while still allowing all other
  // Phone Shell services/products to go to the latest Phone Shell (currently 3.0) by default.
  // So for now we need to hijack the scoreModel we are sending to progressive_phone_common below
  // while still allowing the original scoreModel value to continue on its normal use
  // Expect original scoreModel to already use 18 chars so we only have about 7 chars max to work with
  STRING25 scoreModel_phoneshellv1 := IF(useCommonScore, scoreModel, 'PSV1_' + scoreModel);

  wf_recs := UNGROUP(addrbest.Progressive_phone_common(f_in_raw,
                                                    , // progressive_phone.waterfall_phones_options
                                                    f_dedup_phones,
                                                    gateways_in,
                                                    , // type_a_with_did (false)
                                                    , // useNeustar (true)
                                                    , // default_sx_match_limit (false)
                                                    , // isPFR (false)
                                                    scoreModel_phoneshellv1, // temp use our new scoreModel value
                                                    MaxNumAssociate,
                                                    MaxNumAssociateOther,
                                                    MaxNumFamilyOther,
                                                    MaxNumFamilyClose,
                                                    MaxNumParent,
                                                    MaxNumSpouse,
                                                    MaxNumSubject,
                                                    MaxNumNeighbor,
                                                    UsePremiumSource_A,
                                                    PremiumSource_A_limit,
                                                    RunRelocation));

  _f_out := progressive_phone.functions.UpdateWithMetadata(wf_recs);

  MODEL_DEBUG := Progressive_Phone.Common.Model_Debug;

  rec_out := RECORD(progressive_phone.layout_progressive_batch_out)
    STRING8 search_date;
    STRING8 subj_phone_date_last;
    UNSIGNED6 did;
    INTEGER1 sort_order_position;
    STRING17 phone_line_type_desc := '';
    UNSIGNED1 Phone_StarRating := 0;
    #IF(MODEL_DEBUG)
    Progressive_Phone.Common.Layout_Debug_v1 - progressive_phone.layout_progressive_batch_out - did - subj_phone_date_last; // Return the attributes when debugging is turned on
    #END
  END;

  BOOLEAN SkipPhoneScoring := FALSE : STORED('SkipPhoneScoring');

  f_out_temp_1 := MAP(scoreModel <> ''                     => GROUP(SORTED(_f_out, phone_score), phone_score),
                      scoreModel = '' AND SkipPhoneScoring => GROUP(SORTED(_f_out, sort_order), sort_order),
                                                              GROUP(SORTED(_f_out, phone_score), phone_score));

  results_1 := progressive_phone.FN_BatchFinalAssignments(f_out_temp_1, Progressive_Phone.Layout_Progressive_phones.batch_out_plus, UsePremiumSource_A, scoreModel);

  // ROYALTIES
  BOOLEAN ReturnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
  dRoyaltiesByAcctno_LastResort := IF(IncludeLastResort, Royalty.RoyaltyLastResort.GetBatchRoyaltiesByAcctno(f_in_raw_unfixed, results_1, vendor, acctno, acctno));
  dRoyaltiesByAcctno_EQUIFAX := IF(UsePremiumSource_A, Royalty.RoyaltyEFXDataMart.GetBatchRoyaltiesByAcctno(f_in_raw_unfixed, results_1, , , acctno));
  dRoyaltiesByAcctno := dRoyaltiesByAcctno_LastResort + dRoyaltiesByAcctno_EQUIFAX;
  dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);

  today := (STRING)STD.Date.Today();
  f_out_pos := PROJECT(results_1, TRANSFORM(rec_out,SELF.sort_order_position := COUNTER,
                                                    SELF.search_date := today,
                                                    SELF.phone_line_type_desc := LEFT.phone_line_type_desc,
                                                    SELF := LEFT,
                                                    SELF := []));

  //We need to ensure that if return score is false, we blank out the score right before returning the results since prior logic depends on the score being present
  final_results := IF(ReturnScore, f_out_pos, PROJECT(f_out_pos, TRANSFORM(RECORDOF(f_out_pos), SELF.phone_score := ''; SELF := LEFT)));

  OUTPUT(dRoyalties, NAMED('RoyaltySet'));
  OUTPUT(final_results, NAMED('Results'));

ENDMACRO;
