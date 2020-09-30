/*--SOAP--
<message name="Progressive_Phone_Batch_With_Details_Service" wuTimeout="300000">
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
  <part name="BlankOutDuplicatePhones" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="SkipPhoneScoring" type="xsd:boolean"/>
  <part name="ReturnScore" type="xsd:boolean"/>
  <part name="QSentV2_SearchType" type="xsd:string"/>
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
    &lt;phoneno_11&gt;&lt;/phoneno_11&gt;
    &lt;phoneno_12&gt;&lt;/phoneno_12&gt;
    &lt;phoneno_13&gt;&lt;/phoneno_13&gt;
    &lt;phoneno_14&gt;&lt;/phoneno_14&gt;
    &lt;phoneno_15&gt;&lt;/phoneno_15&gt;
    &lt;phoneno_16&gt;&lt;/phoneno_16&gt;
    &lt;phoneno_17&gt;&lt;/phoneno_17&gt;
    &lt;phoneno_18&gt;&lt;/phoneno_18&gt;
    &lt;phoneno_19&gt;&lt;/phoneno_19&gt;
    &lt;phoneno_20&gt;&lt;/phoneno_20&gt;
    &lt;phoneno_21&gt;&lt;/phoneno_21&gt;
    &lt;phoneno_22&gt;&lt;/phoneno_22&gt;
    &lt;phoneno_23&gt;&lt;/phoneno_23&gt;
    &lt;phoneno_24&gt;&lt;/phoneno_24&gt;
    &lt;phoneno_25&gt;&lt;/phoneno_25&gt;
    &lt;phoneno_26&gt;&lt;/phoneno_26&gt;
    &lt;phoneno_27&gt;&lt;/phoneno_27&gt;
    &lt;phoneno_28&gt;&lt;/phoneno_28&gt;
    &lt;phoneno_29&gt;&lt;/phoneno_29&gt;
    &lt;phoneno_30&gt;&lt;/phoneno_30&gt;
  &lt;/Row&gt;
&lt;/batch_in&gt;
</pre>
*/

//************** This service was not updated part of Waterfall phones V8/Contact plus V3 project because it is a R0 service so batch doesn't update their plugins for it on Version 7/8
//This is because it is currently running WFP V6 / CP V1
import progressive_phone, didville, risk_indicators, ut, addrbest, doxie, header, mdr,
  BatchServices, Gateway, Royalty, BatchShare;

export progressive_phone_batch_with_details_service := macro

  gateways_in := Gateway.Configuration.Get();

  // Options for phone_shell WFP v7
  STRING25 scoreModel := ''	: STORED('Phone_Score_Model');
  UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
  UNSIGNED2 MaxNumAssociateOther := 0 : STORED('MaxNumAssociateOther');
  UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
  UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
  UNSIGNED2 MaxNumParent := 0 : STORED('MaxNumParent');
  UNSIGNED2 MaxNumSpouse := 0 : STORED('MaxNumSpouse');
  UNSIGNED2 MaxNumSubject := 0 : STORED('MaxNumSubject');
  UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');

  in_mod := BatchShare.IParam.getBatchParams();
  mod_access := PROJECT(in_mod, doxie.IDataAccess);

  f_in_raw := dataset([],progressive_phone.layout_progressive_batch_in) : stored('batch_in',few);

  wf_recs := AddrBest.Progressive_phone_common(
    f_in_raw,
    ,
    ,
    gateways_in,
    ,
    ,
    ,
    ,
    scoreModel,
    MaxNumAssociate,
    MaxNumAssociateOther,
    MaxNumFamilyOther,
    MaxNumFamilyClose,
    MaxNumParent,
    MaxNumSpouse,
    MaxNumSubject,
    MaxNumNeighbor);

  f_out := progressive_phone.functions.UpdateWithMetadata(UNGROUP(wf_recs));
  header_recs_w_ssn := progressive_phone.fn_addSSN(f_out);

  /*--- Join back to original result, conserving main method for populating fields ---*/
  Progressive_Phone.Layout_Progressive_phones.common_with_meta_rec addssn(Progressive_Phone.Layout_Progressive_phones.common_with_meta_rec l, header_recs_w_ssn r) := transform
    ut.MAC_ds_to_string(r.SSNRec, ssn, ssn_string);
    self.ssn := ssn_string;
    ds_city := ut.ZipToCities(l.zip5).records;
    ut.MAC_ds_to_string(ds_city, city, outstring);
    self.vanityCities := outstring;
    self := l;
  end;

  f_out_ssn := join(f_out, header_recs_w_ssn,
    left.p_did = right.did and left.acctno = right.acctno,
    addssn(left, right),
    limit(0), keep(1),
    left outer);

  // WITHOUT QSENT
  results_without_qsent := project(f_out_ssn,
                                transform(progressive_phone.layout_progressive_phone_batch_with_details_out,
                                          self.did := intformat(left.did,12,1),
                                          self.p_did := intformat(left.p_did,12,1),
                                          self := left,
                                          self := []));

  // WITH QSENT
  STRING QSentV2_SearchType := '' : STORED('QSentV2_SearchType');
  DO_QSENTV2_NAME_ADDR := QSentV2_SearchType = batchServices.constants.RealTime.SearchType.NAME_ADDR;
  DO_QSENTV2_NAME_SSN  := QSentV2_SearchType = batchServices.constants.RealTime.SearchType.NAME_SSN;
  QSENTV2_GW := Gateway.Configuration.Get()(DO_QSENTV2_NAME_ADDR OR DO_QSENTV2_NAME_SSN, Gateway.Configuration.IsQSentV2(servicename));
  results_with_qsent := progressive_phone.FN_AppendQSentDetails(f_in_raw, results_without_qsent, mod_access, QSENTV2_GW, QSentV2_SearchType);

  // RESULTS - WITH OR WITHOUT QSENT
  results_temp := IF((DO_QSENTV2_NAME_ADDR OR DO_QSENTV2_NAME_SSN) AND COUNT(QSENTV2_GW) > 0,
    ungroup(results_with_qsent),
    results_without_qsent);

  // RESULTS - Unless ReturnScore is TRUE - blank out the Phone Score values
  BOOLEAN ReturnScore := FALSE : STORED('ReturnScore');

  results := IF(ReturnScore = TRUE, results_temp, PROJECT(results_temp, TRANSFORM(RECORDOF(results_temp), SELF.phone_score := ''; SELF := LEFT)));

  // BATCH RESULTS
  ut.mac_TrimFields(results, 'results', results_trimmed);
  results_final := progressive_phone.FN_BatchFinalAssignments(results_trimmed, progressive_phone.layout_progressive_phone_batch_with_details_out);

  // ROYALTIES
  boolean ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
  ds_qsroyalties := dedup(sort(results,acctno,royalty_type),acctno,royalty_type); // only one royalty count per accnt no per type.. royalties are per request
  dRoyaltiesQSent	:= Royalty.RoyaltyQSent.GetBatchRoyaltiesByAcctno(f_in_raw, ds_qsroyalties,,,,acctno);
  dRoyaltiesByAcctno := dRoyaltiesQSent;
  dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);

  output(dRoyalties,named('RoyaltySet'));
  output(results_final, named('Results'));

endmacro;
