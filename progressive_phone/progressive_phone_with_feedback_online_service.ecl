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

IMPORT progressive_phone, addrbest,iesp,PhonesFeedback_Services,ut,phonesFeedback,Phonesplus_v2,Royalty;

EXPORT progressive_phone_with_feedback_online_service := MACRO
		rec_in := iesp.progressivephones.t_ProgressivePhonesSearchRequest;
		// "FEW" keyword set to make data read more efficient
		ds_in := DATASET ([], rec_in) : STORED ('ProgressivePhonesSearchRequest', FEW);
		// "independent" keyword used here to make statement atomic and a signal to 
		// code generator to not combine it with other lines of code.
		first_row := ds_in[1] : independent;
		//set options
		search_by := global (first_row.SearchBy);
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputName (search_by.Name);
		iesp.ECL2ESP.SetInputAddress (search_by.Address);

		#stored('DID', search_by.UniqueId);
		#stored('DedupePhones', search_by.DedupeInfo.phones );
		#stored('ExcludeDeadContacts', ~first_row.options.IncludeDeadContacts );
		#stored('DedupAgainstInputPhones', first_row.options.DedupeAgainstInputPhones );
		#stored('KeepSamePhoneInDiffLevels', first_row.options.KeepSamePhoneInDiffLevels );
		#stored('IncludePhonesFeedback', first_row.options.IncludePhonesFeedback );
		#stored('IncludeLastResort', first_row.options.IncludeLastResort );
		#stored('UniqueIDConfidenceTreshold', first_row.options.UniqueIDConfidenceTreshold );
		#stored('BlankOutDuplicatePhones', first_row.options.BlankOutDuplicatePhones );
		#stored('MaxPhoneCount', first_row.options.MaxPhoneCount );
		#stored('CountType1_ES_EDASEARCH', first_row.options.EDACount );
		#stored('CountType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceCount );
		#stored('CountType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressCount );
		#stored('CountType4_SP_POSSIBLESPOUSE', first_row.options.SpouseCount );
		#stored('CountType4_MD_POSSIBLEPARENTS', first_row.options.ParentsCount );
		#stored('CountType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesCount );
		#stored('CountType4_CR_CORESIDENT', first_row.options.CoResidentCount );
		#stored('CountType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceCount );
		#stored('CountType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusCount);
		#stored('CountType7_UNVERIFIEDPHONE', first_row.options.UnverifiedCount );
		#stored('CountType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborCount );
		#stored('CountType_WK_PEOPLEATWORK', first_row.options.PAWCount );
		#stored('CountType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationCount );
		#stored('CountType_TH_TRYHARDER', first_row.options.TypeThTryHarderCount);
		#stored('DynamicOrdering', first_row.options.DynamicOrdering );
		#stored('OrderType1_ES_EDASEARCH', first_row.options.EDAOrder );
		#stored('OrderType2_SE_SKIPTRACESEARCH', first_row.options.SkipTraceOrder );
		#stored('OrderType3_AP_PROGRESSIVEADDRESSSEARCH', first_row.options.ProgressiveAddressOrder );
		#stored('OrderType4_SP_POSSIBLESPOUSE', first_row.options.SpouseOrder );
		#stored('OrderType4_MD_POSSIBLEPARENTS', first_row.options.ParentsOrder );
		#stored('OrderType4_CL_CLOSESTRELATIVE', first_row.options.ClosestRelativesOrder );
		#stored('OrderType4_CR_CORESIDENT', first_row.options.CoResidentOrder );
		#stored('OrderType5_SX_EXPANDEDSKIPTRACESEARCH', first_row.options.ExpandedSkipTraceOrder );
		#stored('OrderType6_PP_PHONESPLUSSEARCH', first_row.options.PhonesPlusOrder );
		#stored('OrderType7_UNVERIFIEDPHONE', first_row.options.UnverifiedOrder );
		#stored('OrderType_NE_CLOSESTNEIGHBOR', first_row.options.ClosestNeighborOrder );
		#stored('OrderType_WK_PEOPLEATWORK', first_row.options.PAWOrder );
		#stored('OrderType_RL_POSSIBLERELOCATION', first_row.options.PossibleRelocationOrder);
		#stored('OrderType_TH_TRYHARDER', first_row.options.TypeThTryHarderOrder);
					
		#stored('IncludeBusinessPhone', first_row.options.IncludeBusinessPhone );
		#stored('IncludeLandlordPhone', first_row.options.IncludeLandlordPhone );

		#stored('ExcludeNonCellPhonesPlusData', ~first_row.options.IncludeNonCellPhonesPlusData );
		#stored('StrictAPSXMatch', first_row.options.StrictAPSXMatch );
		#stored('SkipPhoneScoring', first_row.options.SkipPhoneScoring);
		#stored('ReturnScore', first_row.options.ReturnScore);
		#stored('Phone_Score_Model', first_row.options.ScoreModel);
		
		#stored('MaxNumAssociate', first_row.options.MaxNumAssociate);
		#stored('MaxNumAssociateOther', first_row.options.MaxNumAssociateOther);
		#stored('MaxNumFamilyOther', first_row.options.MaxNumFamilyOther);
		#stored('MaxNumFamilyClose', first_row.options.MaxNumFamilyClose);
		#stored('MaxNumParent', first_row.options.MaxNumParent);
		#stored('MaxNumSpouse', first_row.options.MaxNumSpouse);
		#stored('MaxNumSubject', first_row.options.MaxNumSubject);
		#stored('MaxNumNeighbor', first_row.options.MaxNumNeighbor);
		
		IncludePhonesFeedback := true : stored('IncludePhonesFeedback');
	
		BOOLEAN ReturnScores := FALSE : STORED('ReturnScore');
		string14 ldid := '0' : stored('DID');
			
		gateways_in := Gateway.Configuration.Get();
		
		// Options for phone_shell WFP v7
		STRING scoreModel		 				:= '': STORED('Phone_Score_Model');
		
		UNSIGNED2 MaxNumAssociate := 0 : STORED('MaxNumAssociate');
		UNSIGNED2 MaxNumAssociateOther  := 0 : STORED('MaxNumAssociateOther');
		UNSIGNED2 MaxNumFamilyOther := 0 : STORED('MaxNumFamilyOther');
		UNSIGNED2 MaxNumFamilyClose := 0 : STORED('MaxNumFamilyClose');
		UNSIGNED2 MaxNumParent := 0 : STORED('MaxNumParent');
		UNSIGNED2 MaxNumSpouse := 0 : STORED('MaxNumSpouse');
		UNSIGNED2 MaxNumSubject := 0 : STORED('MaxNumSubject');
		UNSIGNED2 MaxNumNeighbor := 0 : STORED('MaxNumNeighbor');
		
		f_dedup_phones := dataset([],iesp.share.t_StringArrayItem) : STORED('DedupePhones');
		
		Rec1(string14 did_value) := transform(progressive_phone.layout_progressive_batch_in,
												self.did := (integer)did_value,
												self := []);
		f_in_raw := dataset([Rec1(ldid)]);
		
		f_out := PROJECT(UNGROUP(addrbest.Progressive_phone_common(f_in_raw, 
																																, 
																																f_dedup_phones, 
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
																																MaxNumNeighbor)), progressive_phone.layout_progressive_online_out);
				
			PhonesFeedback_Services.Mac_Append_Feedback(f_out		// Input File
					  ,did
					  ,subj_phone10
					  ,f_out_w_fb	// Output file with feedback dataset
					  );
			
			Royalty.MAC_RoyaltyLastResort(f_out, lastresort_royalties, vendor, subj_phone10)	
			output(lastresort_royalties,named('RoyaltySet'));					
			
			rslt := if(IncludePhonesFeedback, f_out_w_fb, f_out);
			ut.getTimeZone(rslt,subj_phone10,timeZone,finalout);
			
			BOOLEAN SkipPhonesScoring := FALSE : STORED('SkipPhoneScoring');
			// If we are skipping the phone scoring model sort by sort order, else sort by the phone score returned from the model
			sort_rslt := MAP(scoreModel <> '' => finalout,
											SkipPhonesScoring AND scoreModel = '' => sort(finalout,sort_order,sort_order_internal),  
											sort(finalout, -phone_score));							 	
			
			tempresults := iesp.transform_progressive_phones(sort_rslt, ReturnScores, scoreModel);	
			iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tempresults, 
																								 results, 
																								 iesp.progressivephones.t_ProgressivePhonesSearchResponse, 
																								 Records,
																								 false);
								
			output(results, named('Results'));
	
ENDMACRO;
// progressive_phone.progressive_phone_with_feedback_online_service();