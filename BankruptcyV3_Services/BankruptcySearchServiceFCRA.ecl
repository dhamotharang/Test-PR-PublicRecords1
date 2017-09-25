/*--SOAP--
<message name="BankruptcySearchServiceFCRA">
	<!-- Indexed Directly -->
  <part name="TMSID" 							type="xsd:string"/>
  <part name="BDID" 							type="xsd:string"/>
  <part name="DID" 								type="xsd:string"/>

	<!-- Indexed by Autokey -->
	<part name="PartyType"          type="xsd:string"/>
  <part name="CompanyName" 				type="xsd:string"/>
	<part name="UnParsedFullName" 	type="xsd:string"/>
  <part name="FirstName"   				type="xsd:string"/>
  <part name="MiddleName"  				type="xsd:string"/>
  <part name="LastName"    				type="xsd:string"/>
  <part name="Addr"	       				type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"       				type="xsd:string"/>
  <part name="Zip"         				type="xsd:string"/>
  <part name="County"           	type="xsd:string"/>
  <part name='SSN'								type='xsd:string'/>
  <part name='SSNLast4'						type='xsd:string'/>
  <part name="FEIN"		  					type="xsd:string"/>
	
	<!-- CaseNumber -->
	<part name="EnableCaseNumberFilterSearch" type="xsd:boolean"/>
	<part name="CaseNumber"         type="xsd:string"/>
	
  <part name="FilingJurisdiction"	type='xsd:string'/>	
	
  <part name="PenaltThreshold"		type="xsd:unsignedInt"/>
	
  <part name="DPPAPurpose" 				type="xsd:byte"/>
  <part name="GLBPurpose" 				type="xsd:byte"/>
  <part name="SSNMask"						type="xsd:string"/>
	<part name="ApplicationType"   	type="xsd:string"/>
	
  <part name="AllowNickNames" 		type="xsd:boolean"/>
  <part name="PhoneticMatch"  		type="xsd:boolean"/>
  <part name="NoDeepDive" 				type="xsd:boolean"/>
  <part name="ZipRadius"  				type="xsd:unsignedInt"/>
  <part name="MaxResults"  				type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" 				type="xsd:unsignedInt"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
	<part name="StrictMatch"		type="xsd:boolean"/>

	<part name="StateSort" 					type="xsd:Int"/>
	<part name="FileDateSort"				type="xsd:Int"/>
	<part name="CaseSort" 					type="xsd:Int"/>
	<part name="LastNameSort" 			type="xsd:Int"/>
	<part name="CompanyNameSort" 		type="xsd:Int"/>

	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
	<part name="NonSubjectSuppression" type="xsd:unsignedInt" default="2"/> <!-- [1,2,3] -->
  <part name="ApplyNonsubjectRestrictions" type="xsd:boolean"/> 
  <part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/> 
</message>
*/
/*--INFO-- This service searches the Bankruptcyv3 files.*/

import doxie, Text_Search, FCRA, AutoStandardI, WSInput;

export BankruptcySearchServiceFCRA(
	) :=
		macro
    
		//The following macro defines the field sequence on WsECL page of query.
	  WSInput.MAC_BankruptcyV3_Services_BankruptcySearchServiceFCRA();
		
		doxie.MAC_Header_Field_Declare(true);
		#constant('SearchIgnoresAddressOnly',true);
		#stored('ScoreThreshold',10);
		#stored('PenaltThreshold',10);
		#constant('DisplayMatchedParty',true);
		#constant('NoDeepDive', true);
		
		/* fetch sorting params */
		integer1 state_sort 	:= 0 : stored('StateSort');
		integer1 case_sort		:= 0 : stored('CaseSort');
		integer1 fdate_sort		:= 0 : stored('FileDateSort');
		integer1 lname_sort		:= 0 : stored('LastNameSort');
		integer1 cname_sort		:= 0 : stored('CompanyNameSort');
		boolean suppress_withdrawn_bankruptcy	:= false 	: stored('SuppressWithdrawnBankruptcy');
		boolean Enable_CaseNumFilterSrch	:= false 	: stored('EnableCaseNumberFilterSearch');
		
    //Check if the customer is a Collections customer
    fcra_subj_only := false : stored ('ApplyNonsubjectRestrictions');
		boolean isCollections := application_type_value IN AutoStandardI.Constants.COLLECTION_TYPES;
		boolean returnByDidOnly := fcra_subj_only OR isCollections;
    // Adjust party-type: only [D]ebtors should be used for collections:
    string party_type_adj := if (returnByDidOnly, BankruptcyV3_Services.consts.NAME_TYPES.DEBTOR, party_type);
		nss_default := Suppress.Constants.NonSubjectSuppression.doNothing;
		nss := ut.GetNonSubjectSuppression(nss_default);
		
		// for FCRA FFD
		valFFDOptionsMask := FFD.FFDMask.Get(inApplicationType := application_type_value);
		boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(valFFDOptionsMask);
	
		//------------------------------------------------------------------------------------
		//call gateway only when returnByDidOnly is true
		//if more than one DID is found this call will fail the service with desired error message
    unsigned6 input_did := (unsigned6) did_value;

		EnableCaseNumFilter := CaseNumber_value != '' and Enable_CaseNumFilterSrch;
    // gateways := Gateway.Constants.void_gateway : stored ('gateways', few);
		gateways := Gateway.Configuration.Get();
		picklist_res := FCRA.PickListSoapcall.non_esdl(gateways, true, ~EnableCaseNumFilter and returnByDidOnly and (input_did = 0)); 
		unsigned6 subj_did := if(returnByDidOnly  and (input_did = 0), (unsigned6) picklist_res[1].Records[1].UniqueId, input_did);
		//------------------------------------------------------------------------------------
		
    recs	 := bankruptcyv3_Services.bankruptcy_raw(true).search_view(in_ssn_mask := ssn_mask_value,
																																		 in_party_type := party_type_adj, 
																																		 in_filing_jurisdiction := FilingJurisdiction_value,
																																		 suppress_withdrawn_bankruptcy := suppress_withdrawn_bankruptcy,
                                                                     EnableCaseNumberFilter := EnableCaseNumFilter,  
                                                                     in_state := state_val,
                                                                     in_ssn := ssn_value,
                                                                     in_lname := lname_value,
                                                                     in_fname := fname_value,
                                                                     in_case_number := CaseNumber_value,
                                                                     in_did := input_did);
		rec_out := record
			bankruptcyv3_services.layouts.layout_rollup, 
			Text_Search.Layout_ExternalKey,
		end;
		
    rec_out addExt ( recs l) := transform
      self := l;
    	self.ExternalKey := l.TMSID;
    end;
    recs2 := project(recs, addext(left));
		
		// sort recs (before MAC_Marshall_Results so that SkipRecords and MaxResultsThisTime are sorted 
		recs_srt := bankruptcyv3_services.fn_sort_output(recs2, 
																											state_sort, 
																											case_sort, 
																											fdate_sort, 
																											lname_sort, 
																											cname_sort);
		
		recs_filt := recs_srt(~returnByDidOnly or (unsigned6)matched_party.did = subj_did or EnableCaseNumFilter );
		
		rec_out xformNonSubject(rec_out L) := transform
			debtors_supp := project(L.debtors((unsigned6)did = subj_did),
														 transform(BankruptcyV3_Services.layouts.layout_party,
																			 self.names := project(left.names, transform(BankruptcyV3_Services.layouts.layout_name,
																																									 self.orig_name := '', 
																																									 self := left)),
																			 self := left));
			debtors_restricted := debtors_supp + project(L.debtors(~((unsigned6)did = subj_did)), 
																									 transform(BankruptcyV3_Services.layouts.layout_party,
																														self.names := project(left.names, 
																																									transform(BankruptcyV3_Services.layouts.layout_name,
																																														self.lname := FCRA.Constants.FCRA_Restricted, 
																																														self := [])),
																														self := []));
			self.debtors := map(nss = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => debtors_restricted, 
													nss = Suppress.Constants.NonSubjectSuppression.returnBlank => debtors_supp,
													L.debtors);
			self := L;
		end;
		rsrt_nss := project(recs_filt, xformNonSubject(left));
		
		rsrt_final := if(nss <> Suppress.Constants.NonSubjectSuppression.doNothing, 
										 rsrt_nss,
										 recs_filt);
										 
	  //*************FCRA FFD --- getting FFD statements for matched parties only
	
	  //projecting to common layout for fn_fcra_ffd call
		temp_rollup := project(rsrt_final, bankruptcyv3_services.layouts.layout_rollup);
	
    matched_recs	:= 	project(temp_rollup, transform(bankruptcyv3_services.layouts.Matched_party_rec, self := left.matched_party));
		
    dsDIDs	      := 	project(dedup(matched_recs(party_type IN BankruptcyV3_Services.consts.DEBTOR_TYPES), did, all), 
		                          transform(FFD.Layouts.DidBatch, 
		                          self.acctno := FFD.Constants.SingleSearchAcctno, 
															self.did := (unsigned6) left.did));

	  //  Call the person context
	  pc_recs := FFD.FetchPersonContext(dsDIDs, gateways, FFD.Constants.DataGroupSet.Bankruptcy);
	 	
	  // Slim down the PersonContext
	  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
		
		// get FFD compliance records
	  temp_results_ffd  := BankruptcyV3_Services.fn_fcra_ffd(temp_rollup, slim_pc_recs, valFFDOptionsMask);
	 
	 // add back to search layout
	  final := join(rsrt_final, temp_results_ffd,
	                  left.tmsid = right.tmsid,
										transform(rec_out,
										self.StatementIds := right.StatementIds,
										self.isDisputed := right.isDisputed,
										self := right, // to get statementids and isdisputed for debtors child dataset
										self:= left));
										
    CaseNumberErrorCode := 
      FCRA.Functions.CheckCaseNumMinInput(CaseNumber_value, fname_value,
                                             lname_value,ssn_value,state_val,(unsigned6)did_value);
                                             
    if(Enable_CaseNumFilterSrch and CaseNumberErrorCode != 0,  
       FAIL(CaseNumberErrorCode, ut.MapMessageCodes(CaseNumberErrorCode)));

    if(EnableCaseNumFilter and count(final(matched_party.did != final[1].matched_party.did)) > 0,  
       FAIL(ut.constants_MessageCodes.FCRA_CASE_NUM_MORE_THAN_1_REC_RETURNED, 
            ut.MapMessageCodes(ut.constants_MessageCodes.FCRA_CASE_NUM_MORE_THAN_1_REC_RETURNED)));

	  // get FFD statements
	  consumer_statements := IF(ShowConsumerStatements and exists(final), FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

	  doxie.MAC_Marshall_Results(final, recs_marshalled);

    OUTPUT(recs_marshalled, NAMED('Results'));		
    OUTPUT (consumer_statements, named ('ConsumerStatements'));	

		endmacro;