/*--SOAP--
<message name="BestAddress and Progressive Phones Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="DateLastSeen"		type="xsd:string"/>	
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>	
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="UseNameUniqueDID" type="xsd:boolean"/>
  <part name="PartialAddressDedup" type="xsd:boolean"/>
  <part name="InputAddressDedup" type="xsd:boolean"/>	
  <part name="StartWithNextMostCurrent" type="xsd:boolean"/>
  <part name="EndWithNextMostCurrent" type="xsd:boolean"/>
  <part name="FirstNameLastNameMatch" type="xsd:boolean"/>	
  <part name="FirstNameMatch" type="xsd:boolean"/>	
  <part name="LastNameMatch" type="xsd:boolean"/>	
  <part name="FullNameMatch" type="xsd:boolean"/>	
  <part name="FirstInitialLastNameMatch" type="xsd:boolean"/>	
  <part name="ReturnDedupFlag" type="xsd:boolean"/>
  <part name="KeepSamePhoneInDiffLevels" type="xsd:boolean"/>
  <part name="DedupAgainstInputPhones" type="xsd:boolean"/>
  <part name="DoNOTRollupDateFirstSeen" type="xsd:boolean"  default="false"/>
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
  <part name="IncludeDriversLicense" type="xsd:boolean"/>
	<part name="IncludeDeceasedDate" type="xsd:boolean"/>
	<part name="UniqueIDConfidenceTreshold" type="xsd:unsignedInt"/>
	<part name="ExcludeNonCellPhonesPlusData" type="xsd:boolean"/>
	<part name="StrictAPSXMatch" type="xsd:boolean"/>
	<part name="BlankOutDuplicatePhones" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>	
 	<part name="IncludeLastResort" type="xsd:boolean"/>
  <part name="DataPermissionMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
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
	<part name="Gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
*/
/*--INFO-- This service returns best addresses and progressive phones */
/*--HELP-- 
<pre>
&lt;batch_in&gt;
  &lt;Row&gt;
    &lt;acctno&gt;&lt;/acctno&gt;
    &lt;did&gt;&lt;/did&gt;
    &lt;addr1&gt;&lt;/addr1&gt;
    &lt;addr1_2&gt;&lt;/addr1_2&gt;
    &lt;city_name1&gt;&lt;/city_name1&gt;
    &lt;st1&gt;&lt;/st1&gt;
    &lt;zip1&gt;&lt;/zip1&gt;
    &lt;addr2&gt;&lt;/addr2&gt;
    &lt;addr2_2&gt;&lt;/addr2_2&gt;
    &lt;city_name2&gt;&lt;/city_name2&gt;
    &lt;st2&gt;&lt;/st2&gt;
    &lt;zip2&gt;&lt;/zip2&gt;
    &lt;addr3&gt;&lt;/addr3&gt;
    &lt;addr3_2&gt;&lt;/addr3_2&gt;
    &lt;city_name3&gt;&lt;/city_name3&gt;
    &lt;st3&gt;&lt;/st3&gt;
    &lt;zip3&gt;&lt;/zip3&gt;
    &lt;addr4&gt;&lt;/addr4&gt;
    &lt;addr4_2&gt;&lt;/addr4_2&gt;
    &lt;city_name4&gt;&lt;/city_name4&gt;
    &lt;st4&gt;&lt;/st4&gt;
    &lt;zip4&gt;&lt;/zip4&gt;
    &lt;addr5&gt;&lt;/addr5&gt;
    &lt;addr5_2&gt;&lt;/addr5_2&gt;
    &lt;city_name5&gt;&lt;/city_name5&gt;
    &lt;st5&gt;&lt;/st5&gt;
    &lt;zip5&gt;&lt;/zip5&gt;
    &lt;addr6&gt;&lt;/addr6&gt;
    &lt;addr6_2&gt;&lt;/addr6_2&gt;
    &lt;city_name6&gt;&lt;/city_name6&gt;
    &lt;st6&gt;&lt;/st6&gt;
    &lt;zip6&gt;&lt;/zip6&gt;
    &lt;addr7&gt;&lt;/addr7&gt;
    &lt;addr7_2&gt;&lt;/addr7_2&gt;
    &lt;city_name7&gt;&lt;/city_name7&gt;
    &lt;st7&gt;&lt;/st7&gt;
    &lt;zip7&gt;&lt;/zip7&gt;
    &lt;addr8&gt;&lt;/addr8&gt;
    &lt;addr8_2&gt;&lt;/addr8_2&gt;
    &lt;city_name8&gt;&lt;/city_name8&gt;
    &lt;st8&gt;&lt;/st8&gt;
    &lt;zip8&gt;&lt;/zip8&gt;
    &lt;addr9&gt;&lt;/addr9&gt;
    &lt;addr9_2&gt;&lt;/addr9_2&gt;
    &lt;city_name9&gt;&lt;/city_name9&gt;
    &lt;st9&gt;&lt;/st9&gt;
    &lt;zip9&gt;&lt;/zip9&gt;
    &lt;addr10&gt;&lt;/addr10&gt;
    &lt;addr10_2&gt;&lt;/addr10_2&gt;
    &lt;city_name10&gt;&lt;/city_name10&gt;
    &lt;st10&gt;&lt;/st10&gt;
    &lt;zip10&gt;&lt;/zip10&gt;
    &lt;dl&gt;&lt;/dl&gt;
    &lt;dlstate&gt;&lt;/dlstate&gt;
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

//************** This service was not updated part of Waterfall phones V8/Contact plus V3 project because it is a R0 service so batch doesn't update their plugins for it on Version 7/8
//This is because it is currently running WFP V6 / CP V1 
import AddrBest, progressive_phone, ut, WSInput;

export BestAddr_ProgressivePhone_Service := macro
#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
 //The following macro defines the field sequence on WsECL page of query.
 WSInput.MAC_AddrBest_bestaddr_progressivephone_service();

gateways_in := Gateway.Configuration.Get();

//WFP v7 only.  Returns the input phone along with any other selected countTypes.
BOOLEAN includeInputPhone := FALSE : STORED('IncludeInputPhone'); 

boolean include_driverslicense := false : stored('IncludeDriversLicense');
boolean include_deceased_date  := false : stored('IncludeDeceasedDate');

BOOLEAN ReturnScore := FALSE : STORED('ReturnScore');
STRING  scoreModel := ''		: STORED('Phone_Score_Model');

UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
UNSIGNED2 MaxNumAssociateOther  := 0 : STORED('MaxNumAssociateOther');
UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
UNSIGNED2 MaxNumParent := 0 : STORED('MaxNumParent');
UNSIGNED2 MaxNumSpouse := 0 : STORED('MaxNumSpouse');
UNSIGNED2 MaxNumSubject := 0 : STORED('MaxNumSubject');
UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');

currentDt := (UNSIGNED4) StringLib.getDateYYYYMMDD();
 
f_in_raw := dataset([],AddrBest.Layout_BestAddr.Batch_in_both) : stored('batch_in',few);
  
dl_recs := AddrBest.functions.fn_getDIDfromDL(f_in_raw);
	
AddrBest.Layout_BestAddr.Batch_in_both load_did(f_in_raw l, dl_recs r) := transform
   self.did := if (l.did = 0, r.did, l.did);
	 self := l;
end;  	
	f_in_raw_dlDIDs := join(f_in_raw, dl_recs, left.acctno = right.acctno, load_did(left,right), LEFT OUTER, LIMIT(1000,SKIP));
	
	
f_in_best_addr := project(f_in_raw_dlDIDs,AddrBest.Layout_BestAddr.Batch_in);

bestaddrs := AddrBest.BestAddr_common(f_in_best_addr);

f_in_progressive_phone := project(f_in_raw_dlDIDs, transform(progressive_phone.layout_progressive_batch_in,
																			self.did :=0,
																			self := left));
																			
ProgressivePhones := AddrBest.Progressive_phone_common(f_in_progressive_phone,
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

out_rec := addrBest.Layout_BestAddr.batch_Out_both;
out_recp := addrBest.Layout_BestAddr.batch_Out_both_wp_did;

out_recp out_format(bestaddrs l,integer C):=transform
	self.cnt := C;
	self.ind := 'A';
	self := l;
	self.p_did := l.did;
	self := [];
end;

out_recp out_format2(progressivePhones l,integer C):=transform
	self.cnt := C;
	self.ind := 'P';

	// Unless ReturnScore is TRUE - blank out the Phone Score values
	SELF.phone_score := IF(ReturnScore = TRUE, l.phone_score, '');

	self := l;
	self := [];
end;

both_wo_dl_dead := project(bestaddrs, out_format(left,counter)) + project(ProgressivePhones, out_format2(left,counter));

//add drivers license 
both_w_dl := if (include_driverslicense, project(AddrBest.functions.fn_addDL(both_wo_dl_dead),out_recp), both_wo_dl_dead);

//add deceased date
both := if (include_deceased_date, project(AddrBest.functions.fn_addDeceased(both_w_dl),out_recp), both_w_dl);

out_recs := sort(project(both,out_rec),acctno,ind,cnt);

results := progressive_phone.FN_BatchFinalAssignments(out_recs, out_rec);

output(results, named('Results'));	

endmacro;