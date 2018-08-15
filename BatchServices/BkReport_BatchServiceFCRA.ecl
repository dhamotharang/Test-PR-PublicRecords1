/*--SOAP--
<message name="BkReport_BatchServiceFCRA">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="SSNMask"			  type="xsd:string"/>	
	<part name="ApplicationType"   	type="xsd:string"/>

	<part name="MaxResults"           type="xsd:unsignedInt"/>
	<part name="Max_Results_Per_Acct" type="xsd:byte"/>	
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	
	<part name="Match_Attorneys"      type="xsd:boolean"/>
	<part name="Match_Creditors"      type="xsd:boolean"/>
	<part name="Match_Debtors"        type="xsd:boolean"/>

	<part name="SuppressWithdrawnBankruptcy" type="xsd:boolean"/>
	<part name="FFDOptionsMask"   	  type="xsd:string"/>
	<part name="FCRAPurpose"   	  type="xsd:string"/>
	
	<part name="Use_FixCase"		  type="xsd:boolean"/>	
	
	<part name="Chapter_Includes"	  type="xsd:string"/>
	<part name="DCode_Includes"  	  type="xsd:string"/>	
	
	<part name="DaysBack"		 	  type="xsd:unsignedInt"/>		
</message>
*/

IMPORT AutoStandardI, BatchServices, BankruptcyV3_Services, BankruptcyV3, FFD;

export BkReport_BatchServiceFCRA(useCannedRecs = 'false') := 
	MACRO
	
		#OPTION('optimizeProjects', TRUE);
		
		#CONSTANT('isFCRA', true);
		#CONSTANT('noDeepDive', true)
		
		STRING7 in_ssn_mask				:= 'NONE'	: STORED('SSNMask');
		
		//	Build party_type set.
		BOOLEAN match_attorneys := FALSE 	: STORED('Match_Attorneys');
		BOOLEAN match_creditors := FALSE 	: STORED('Match_Creditors');
		BOOLEAN match_debtors   := TRUE 	: STORED('Match_Debtors');
		BOOLEAN use_fixcase			:= FALSE	: STORED('Use_FixCase');
		
		BOOLEAN suppress_withdrawn_bankruptcy	:= FALSE 	: STORED('SuppressWithdrawnBankruptcy');
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
																			 
		/*	Grab the input XML and throw into a dataset. */
		ds_batch_in := DATASET([], BatchServices.layout_BkReport_Batch_in) : STORED('batch_in', FEW);
		
		ds_in := if (not useCannedRecs,
						ds_batch_in,
						BatchServices._Sample_Records.BkReport.ds_sample_input);
		
		/* 
			Separate records into case/court searches and tmsid searches so that we can
			'operate' on the court codes of those records that use court/case search.
		*/
		ds_tmsid			:= ds_in(tmsid != '');
		ds_court_case_in 	:= ds_in(tmsid  = '');
    
    /* Build lookup table to be used in translating from incoming 'court' to 'moxie_court' value to build TMSID */
		layout_court_lookup := RECORD
			bankruptcyv3.key_bankruptcyV3_courts.court;
			bankruptcyv3.key_bankruptcyV3_courts.moxie_court;
		END;
		
		court_lookup_table 	:= TABLE(bankruptcyv3.key_bankruptcyV3_courts, layout_court_lookup);
		
		/* 	Translate from incoming 'court' to 'moxie court' value value to build TMSID 
        Moved the court look up above the key join for the full case number because
        the banko.Key_Banko_courtcode_fullcasenumber keys are coded off of the 
        moxie court id, not the court id coming in. */

		ds_changed_to_moxie_court := 
      JOIN(ds_court_case_in, court_lookup_table, 
					 LEFT.court = RIGHT.court,
					 TRANSFORM(BatchServices.layout_BkReport_Batch_in,
									   SELF.court := RIGHT.moxie_court,
									   SELF := LEFT),
					 LOOKUP);
                
    BatchServices.layout_BkReport_Batch_in_plusCounter xfm_addCounter 
      (BatchServices.layout_BkReport_Batch_in ds_in, UNSIGNED1 rec_count_in ) :=
      TRANSFORM
        SELF.rec_count := rec_count_in,
        SELF           := ds_in
      END;
        
    ds_moxie_court := 
      PROJECT(ds_changed_to_moxie_court, xfm_addCounter(LEFT, COUNTER));

    ds_moxie_court_from_full_case := 
      JOIN(ds_moxie_court, banko.Key_Banko_courtcode_fullcasenumber(TRUE),
           KEYED(LEFT.court       = RIGHT.court_code AND
                 LEFT.case_number = RIGHT.BKCaseNumber),
           TRANSFORM(BatchServices.layout_BkReport_Batch_in_plusCounter,
                     SELF.case_number := RIGHT.casekey,
                     SELF := LEFT),
           KEEP(BankruptcyV3_Services.consts.MAX_PER_COURT_CASE_LOOKUP),LIMIT(0)); 
 
    // Using a LEFT ONLY to filter out input records with full case numbers
    // The resulting dataset will contain the input records that have the 
    // abbreviated case number input.
    // get the input that was not matched in the full case key join
    // and strip out the counter/rec_count to send through the 
    // BatchServices.Functions.Bankruptcy.fn_fix_case function
    ds_moxie_court_abbrev_case_num :=
      JOIN( ds_moxie_court, ds_moxie_court_from_full_case,
            LEFT.rec_count = RIGHT.rec_count,
            TRANSFORM(BatchServices.layout_BkReport_Batch_in,
                      SELF := LEFT),
            LEFT ONLY);
    
    /* 	If specified, 'fix' the case numbers */
		ds_casenums_fixed 	:= PROJECT(ds_moxie_court_abbrev_case_num, 
										TRANSFORM(BatchServices.layout_BkReport_Batch_in,
											SELF.case_number := BatchServices.Functions.Bankruptcy.fn_fix_case(LEFT.case_number, LEFT.court),
											SELF := LEFT));

		ds_moxie_court_abbrev_case_in		:= IF(use_fixcase, ds_casenums_fixed, ds_moxie_court_abbrev_case_num);

		// remove rec_count counter from full case number ds 
    ds_moxie_court_from_full_case_in :=
      PROJECT(ds_moxie_court_from_full_case, BatchServices.layout_BkReport_Batch_in);    
										
		/* 	Union case/court search records with tmsid search records */				
		ds_all := ds_tmsid + ds_moxie_court_abbrev_case_in + ds_moxie_court_from_full_case_in;

		/* 
			Project to BankruptcyV3_Services.layouts.layout_tmsid_ext.
			Build TMSID from the court code and casenumber if court/case is provided.
		*/
		BankruptcyV3_Services.layouts.layout_tmsid_ext xfm_tmsid_ext(BatchServices.layout_BkReport_Batch_in L) := TRANSFORM
			SELF.acctno := L.acctno;
			SELF.tmsid 	:= IF(L.tmsid != '', L.tmsid, 'BK' + TRIM(L.court, ALL) + TRIM(L.case_number, ALL));
			SELF := [];
		END;
		
		ds_tmsid_ext := PROJECT(ds_all, xfm_tmsid_ext(LEFT));				
		
		/* 	Send records through the bankruptcy batchservice report function. */
		ds_recs := BatchServices.Bankruptcy_BatchService_Records.report(ds_tmsid_ext, party_types, 
                                                                    TRUE, FALSE, in_ssn_mask, 
																																		suppress_withdrawn_bankruptcy);
		//*************FCRA FFD
		res := BankruptcyV3_Services.fn_fcra_ffd_batch(ds_recs, inFFDOptionsMask, inFCRAPurpose);
		
   	results_pre  := sort(res.records, acctno);
   	consumer_statements  := sort(res.statements, acctno);
		
	// 	Search for Bk records by party

		ut.mac_TrimFields(results_pre, 'results_pre', results);
				
		OUTPUT(results, NAMED('Results'));		
		OUTPUT(consumer_statements, NAMED('CSDResults'));
	
	ENDMACRO;	

// BatchServices.BkReport_BatchServiceFCRA();