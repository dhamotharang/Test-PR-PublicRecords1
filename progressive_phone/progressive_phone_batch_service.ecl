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
  <part name="UseMetronet" type="xsd:boolean"/>
  <part name="Confirmation_GoToGateway" type="xsd:boolean"/>
  <part name="MetronetLimit" type="xds:integer"/>
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

import progressive_phone, didville, MDR, risk_indicators, Royalty, ut, addrbest, iesp, STD;

export progressive_phone_batch_service := macro
	
gateways_in := Gateway.Configuration.Get();
boolean IncludeLastResort := false : STORED ('IncludeLastResort');
boolean callMetronet := false : STORED('UseMetronet');
boolean Confirmation_GoToGateway:= false : STORED ('Confirmation_GoToGateway'); //used to force metronet gateway hit even if we have the phone in house
integer metronetLimit := 0 : STORED('MetronetLimit');

boolean UsePremiumSource_A:= false : STORED ('UsePremiumSource_A'); //equifax
integer PremiumSource_A_limit:= 0 : STORED ('PremiumSource_A_limit');//max of 3 equifax phones can be returned

UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
UNSIGNED2 MaxNumAssociateOther  := 0 : STORED('MaxNumAssociateOther');
UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
UNSIGNED2 MaxNumParent := 0 : STORED('MaxNumParent');
UNSIGNED2 MaxNumSpouse := 0 : STORED('MaxNumSpouse');
UNSIGNED2 MaxNumSubject := 0 : STORED('MaxNumSubject');
UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');
BOOLEAN RunRelocation	:= FALSE :STORED('RunRelocation');

// Options for phone_shell WFP V8
STRING25 scoreModel := '' : STORED('Phone_Score_Model'); //COLLECTIONSCORE_V3 for new score model.

BOOLEAN ReturnScore := FALSE : STORED('ReturnScore'); // Unless ReturnScore is TRUE - blank out the Phone Score values

f_in_raw_unfixed := dataset([],progressive_phone.layout_progressive_batch_in) : STORED('batch_in',few);

f_dedup_phones := DATASET([],iesp.share.t_StringArrayItem): STORED('DedupePhones');


f_in_raw := PROJECT(f_in_raw_unfixed,
            TRANSFORM(progressive_phone.layout_progressive_batch_in,
						SELF.ssn  := Stringlib.StringFilter(LEFT.ssn, '1234567890');
						SELF      := LEFT));
						
_f_out := UNGROUP(addrbest.Progressive_phone_common(f_in_raw,
																										, 
																										f_dedup_phones,
																										gateways_in, 
																										, 
																										, 
																										, 
																										callMetronet, 
																										, 
																										metronetLimit,
																										scoreModel,
																										MaxNumAssociate,
																										MaxNumAssociateOther,
																										MaxNumFamilyOther,
																										MaxNumFamilyClose,
																										MaxNumParent,
																									  MaxNumSpouse,
																										MaxNumSubject,
																										MaxNumNeighbor,
																										Confirmation_GoToGateway,
																										UsePremiumSource_A,
																										PremiumSource_A_limit, 
																										RunRelocation));	
																										
MODEL_DEBUG := Progressive_Phone.Common.Model_Debug;

rec_out := record(progressive_phone.layout_progressive_batch_out)
	string8 search_date;
	string8 subj_phone_date_last;
	unsigned6 did;
	integer1 sort_order_position;
	#IF(MODEL_DEBUG)
	Progressive_Phone.Common.Layout_Debug_v1 - progressive_phone.layout_progressive_batch_out - did - subj_phone_date_last; // Return the attributes when debugging is turned on
	#END
end;

BOOLEAN SkipPhoneScoring := FALSE : STORED('SkipPhoneScoring');

f_out_temp_1 := MAP(scoreModel <> '' =>  GROUP(SORTED(_f_out, phone_score), phone_score), 
									  scoreModel = '' AND SkipPhoneScoring => GROUP(SORTED(_f_out, sort_order), sort_order),
										GROUP(SORTED(_f_out, phone_score), phone_score));
										
results_1 := progressive_phone.FN_BatchFinalAssignments(f_out_temp_1, progressive_phone.layout_progressive_phone_common, callMetronet, UsePremiumSource_A, scoreModel);

// ROYALTIES
boolean ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
dRoyaltiesByAcctno_LastResort := if(IncludeLastResort, Royalty.RoyaltyLastResort.GetBatchRoyaltiesByAcctno(f_in_raw_unfixed, results_1, vendor, acctno, acctno));
dRoyaltiesByAcctno_METRONET := if(callMetronet, Royalty.RoyaltyMetronet.GetBatchRoyaltiesByAcctno(f_in_raw_unfixed, _f_out,,,acctno));
dRoyaltiesByAcctno_EQUIFAX := if(UsePremiumSource_A, Royalty.RoyaltyEFXDataMart.GetBatchRoyaltiesByAcctno(f_in_raw_unfixed, results_1,,,acctno));
dRoyaltiesByAcctno := dRoyaltiesByAcctno_LastResort + dRoyaltiesByAcctno_METRONET + dRoyaltiesByAcctno_EQUIFAX;
dRoyalties := Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);

today := (string) STD.Date.Today();
f_out_pos := PROJECT(results_1, TRANSFORM(rec_out,SELF.sort_order_position := counter,
																										SELF.search_date := today,
																										SELF := LEFT,																																																				
																										SELF := []));
																										
//We need to ensure that if return score is false, we blank out the score right before returning the results since prior logic depends on the score being present																										
final_results := IF(ReturnScore, f_out_pos, PROJECT(f_out_pos, TRANSFORM(RECORDOF(f_out_pos), SELF.phone_score := ''; SELF := LEFT)));

output(dRoyalties,named('RoyaltySet'));  							
output(final_results, named('Results'));
		
endmacro;