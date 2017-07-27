/*--SOAP--
<message name="LaborActions_WHD_batch_service">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="DataRestrictionMask"	type="xsd:string"/>
		
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/

IMPORT BatchServices;
/*
	Available Autokeys: addressb2, citystnameb2, nameb2, namewordsb2, stnameb2, zipb2.
*/
EXPORT batch_service(BOOLEAN useCannedRecs = false) := 
	FUNCTION

		// Local layouts.

		rec_results_plus_summary_data := RECORD
			UNSIGNED4 Temp_Group_Id								 := 0;
			layouts_batch.layout_for_batch_records AND NOT
				[
					TotalViolations,
					BW_TotalAgreedAmount,
					CMP_TotalAssessments,
					EE_TotalViolations,
					EE_TotalAgreedCount		
				];
			UNSIGNED4	Summary_TotalViolations      := 0;
			UNSIGNED4	Summary_BW_TotalAgreedAmount := 0;
			UNSIGNED4	Summary_CMP_TotalAssessments := 0;
			UNSIGNED4	Summary_EE_TotalViolations   := 0;
			UNSIGNED4	Summary_EE_TotalAgreedCount  := 0;

			UNSIGNED4	TotalViolations              := 0;
			UNSIGNED4	BW_TotalAgreedAmount         := 0;
			UNSIGNED4	CMP_TotalAssessments         := 0;
			UNSIGNED4	EE_TotalViolations           := 0;
			UNSIGNED4	EE_TotalAgreedCount          := 0;
			STRING200 Violations_Summary           := '';
		END;
		
		
		// 1. Accept input records.
		ds_xml_in   := DATASET([], LaborActions_WHD_Services.layouts_batch.Batch_in) : STORED('batch_in', FEW);
		ds_batch_in := IF( NOT useCannedRecs, ds_xml_in, LaborActions_WHD_Services._canned_records );
		
		// 2. Get matching records, penalized.
		ds_matching_recs := LaborActions_WHD_Services.batch_service_records(ds_batch_in);
		
		// 3. The output is highly customized, consisting mostly of summary data rather than raw values.

		// 3.a. Convert summary data from string to integer for summing later.
		ds_recs_recast := 
			PROJECT(
				ds_matching_recs,
				TRANSFORM( rec_results_plus_summary_data,
					SELF.TotalViolations            := (UNSIGNED4)LEFT.TotalViolations,
					SELF.BW_TotalAgreedAmount       := (UNSIGNED4)LEFT.BW_TotalAgreedAmount,
					SELF.CMP_TotalAssessments       := (UNSIGNED4)LEFT.CMP_TotalAssessments,
					SELF.EE_TotalViolations         := (UNSIGNED4)LEFT.EE_TotalViolations,
					SELF.EE_TotalAgreedCount        := (UNSIGNED4)LEFT.EE_TotalAgreedCount,
					SELF                            := LEFT,
					SELF                            := []
				)
			);
		
		// Since a case_id may be referenced in more than one record, all records for a particular
		// case_id must be handled together; we'll sort and group to do so.
		ds_recs_sorted  := SORT(ds_recs_recast, acctno, caseid, -dateadded, -dateupdated);
		ds_recs_grouped := GROUP(ds_recs_sorted, acctno, caseid);
		
		// 3.b. Capture what sort of violation(s) occurred for a particular case. 
		
		// The following function accepts a dataset of records whose grouping is by acctno and case_id
		// (see comment above). It examines the fields in record layout that display the number of 
		// violations that occurred against a type of legislation (there are 27 types). Note that the
		// function doesn't care how many violations occured; only the existence of a type of violation
		// within the group. This gives us a dataset consisting of violation descriptions and null values.
		// We then rollup the dataset, appending descriptions as we go and separating each with a semicolon.
		// Finally, we return the descriptions as a STRING200. This may seem a bit short since there are 
		// many types of violations, but we will assume (for the time being anyway) that a company will 
		// tend to have many violations of relatively few acts of legislation, rather than a few violations
		// of many legislative acts.
		STRING200 describe_violations_summary( DATASET(rec_results_plus_summary_data) recs = DATASET([],rec_results_plus_summary_data) ) :=
			FUNCTION
				layout_desc := { STRING desc };
				
				ds_violation_descriptions :=
					DATASET(
						[
							{ IF( EXISTS(recs((UNSIGNED)CA_CountViolations > 0))        , 'CA (Copeland Anti-kickback Act)'                                                    , '') },
							{ IF( EXISTS(recs((UNSIGNED)CCPA_CountViolations > 0))      , 'CCPA (Consumer Credit Protection Act - Wage Garnishment)'                           , '') },
							{ IF( EXISTS(recs((UNSIGNED)CREW_CountViolations > 0))      , 'CREW (Longshoremen (D1))'                                                           , '') },
							{ IF( EXISTS(recs((UNSIGNED)CWHSSA_CountViolations > 0))    , 'CWHSSA (Contract Work Hours and Safety Standards Act)'                              , '') },
							{ IF( EXISTS(recs((UNSIGNED)DBRA_CL_CountViolations > 0))   , 'DBRA (Davis-Bacon and Related Act)'                                                 , '') },
							
							{ IF( EXISTS(recs((UNSIGNED)EEV_CountViolations > 0))       , 'EEV (ESA 91)'                                                                       , '') },
							{ IF( EXISTS(recs((UNSIGNED)EPPA_CountViolations > 0))      , 'EPPA (Employee Polygraph Protection Act)'                                           , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_CountViolations > 0))      , 'FLSA (Fair Labor Standards Act)'                                                    , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_CL_CountViolations > 0))   , 'FLSA - CL (Fair Labor Standards Act - Child Labor)'                                 , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_HMWKR_CountViolations > 0)), 'FLSA - HMWKR (Fair Labor Standards Act - industrial homework)'                      , '') },
							
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMW14_CountViolations > 0)), 'FLSA - SMW14 (Fair Labor Standards Act - Special Minimum Wages under Section 14(c))', '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMWAP_CountViolations > 0)), 'FLSA - SMWAP (Fair Labor Standards Act - Special Minimum Wages - Apprentices)'      , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMWFT_CountViolations > 0)), 'FLSA - SMWFT (Fair Labor Standards Act - Special Minimum Wages - Full Time)'        , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMWL_CountViolations > 0)) , 'FLSA - SMWL (Fair Labor Standards Act - Special Minimum Wages - Learners)'          , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMWMG_CountViolations > 0)), 'FLSA - SMWMG (Fair Labor Standards Act - Special Minimum Wages - Messengers)'       , '') },
							
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMWPW_CountViolations > 0)), 'FLSA - SMWPW (Fair Labor Standards Act - Special Minimum Wages - Patient worker)'   , '') },
							{ IF( EXISTS(recs((UNSIGNED)FLSA_SMWSL_CountViolations > 0)), 'FLSA - SMWSL (Fair Labor Standards Act - Special Minimum Wages - Student Learners)' , '') },
							{ IF( EXISTS(recs((UNSIGNED)FMLA_CountViolations > 0))      , 'FMLA (Family and Medical Leave Act)'                                                , '') },
							{ IF( EXISTS(recs((UNSIGNED)H1A_CountViolations > 0))       , 'H1A (Work Visa - Registered nurses for temporary employment)'                       , '') },
							{ IF( EXISTS(recs((UNSIGNED)H1B_CountViolations > 0))       , 'H1B (Work Visa - Speciality Occupations)'                                           , '') },
							
							{ IF( EXISTS(recs((UNSIGNED)H2A_CountViolations > 0))       , 'H2A (Work Visa - Seasonal Agricultural Workers)'                                    , '') },
							{ IF( EXISTS(recs((UNSIGNED)H2B_CountViolations > 0))       , 'H2B (Work Visa - Temporary Non-Agricultural Work)'                                  , '') },
							{ IF( EXISTS(recs((UNSIGNED)MPSA_CountViolations > 0))      , 'MSPA (Migrant and Seasonal Agricultural Worker Protection Act)'                     , '') },
							{ IF( EXISTS(recs((UNSIGNED)OSHA_CountViolations > 0))      , 'OSHA (Occupational Safety and Health Standards)'                                    , '') },
							{ IF( EXISTS(recs((UNSIGNED)PCA_CountViolations > 0))       , 'PCA (Public Contracts Act)'                                                         , '') },
							
							{ IF( EXISTS(recs((UNSIGNED)SCA_CountViolations > 0))       , 'SCA (Service Contract Act)'                                                         , '') },
							{ IF( EXISTS(recs((UNSIGNED)SRAW_CountViolations > 0))      , 'SRAW (Spec. Agri. Workers/Replenishment Agri. Workers)'                             , '') }
						],
						layout_desc
					);
				
				layout_desc xfm_concatenate_descriptions(layout_desc le, layout_desc ri) :=
					TRANSFORM
						SELF.desc := le.desc + 
							MAP( // Append a semicolon after each violation description, except for the last.
								TRIM(le.desc,LEFT,RIGHT) = '' AND TRIM(ri.desc,LEFT,RIGHT) != '' => ri.desc,
								TRIM(ri.desc,LEFT,RIGHT) != ''                                   => '; ' + ri.desc, 
								/* default...................................................*/     '' 
							);
					END;
					
				ds_violations_rolled :=
					ROLLUP(
						ds_violation_descriptions,
						TRUE,
						xfm_concatenate_descriptions(LEFT,RIGHT)
					);
					
				RETURN (STRING200)ds_violations_rolled[1].desc;

			END; // describe_violations_summary( )
		
		// 4. Dedup nearly-identical records using a rollup. Preserve the highest number of violations incurred
		// and the name/address information having the lowest penalty.
		rec_results_plus_summary_data doRollup_1( rec_results_plus_summary_data l, DATASET(rec_results_plus_summary_data) allRows) :=
			TRANSFORM
				record_having_lowest_compname_penalty := SORT(allRows,comp_name_penalty)[1];
				record_having_lowest_address_penalty  := SORT(allRows,address_penalty)[1];
				
				SELF.bdid                 := IF( EXISTS(allRows(bdid != 0)), allRows(bdid != 0)[1].bdid, 0 );
				SELF.employername         := record_having_lowest_compname_penalty.employername;
				SELF.address1             := record_having_lowest_address_penalty.address1;
				SELF.city                 := record_having_lowest_address_penalty.city;
				SELF.employerstate        := record_having_lowest_address_penalty.employerstate;
				SELF.zipcode              := record_having_lowest_address_penalty.zipcode;
				SELF.dateadded            := MAX(allRows, allRows.dateadded);
				SELF.dateupdated          := MAX(allRows, allRows.dateupdated);
				SELF.TotalViolations      := MAX(allRows, allRows.TotalViolations);
				SELF.BW_TotalAgreedAmount := MAX(allRows, allRows.BW_TotalAgreedAmount);
				SELF.CMP_TotalAssessments := MAX(allRows, allRows.CMP_TotalAssessments);
				SELF.EE_TotalViolations   := MAX(allRows, allRows.EE_TotalViolations);
				SELF.EE_TotalAgreedCount  := MAX(allRows, allRows.EE_TotalAgreedCount);
				SELF.Violations_Summary   := describe_violations_summary(allRows);
				SELF                      := l;
			END;
			
		ds_recs_rolled := 
			ROLLUP(
				ds_recs_grouped, 
				GROUP,
				doRollup_1(LEFT, ROWS(LEFT))
			);

		// 5. Create a unique number for a group of records with matching acctno and bdid. With the exception
		// that all records with a bdid of 0 (none) will be its own individual group.
		ds_recs_with_grpnum := ITERATE(SORT(ds_recs_rolled,acctno,bdid),
																	TRANSFORM(rec_results_plus_summary_data,
																						SELF.Temp_Group_Id := IF (LEFT.BDID = RIGHT.bdid AND RIGHT.bdid != 0,
																																			LEFT.Temp_Group_Id,
																																			LEFT.Temp_Group_Id +1),
																						SELF := RIGHT));
																	
		// 6. Group on the temporarily created group_id and perform a Group Rollup, 
		//    projecting the raw records into the final layout.
		LaborActions_WHD_Services.layouts_batch.Batch_out doRollup_2( rec_results_plus_summary_data l, DATASET(rec_results_plus_summary_data) allRows) :=
			TRANSFORM
				SELF.Summary_TotalViolations      := SUM(allRows, allRows.TotalViolations);
				SELF.Summary_BW_TotalAgreedAmount := SUM(allRows, allRows.BW_TotalAgreedAmount);
				SELF.Summary_CMP_TotalAssessments := SUM(allRows, allRows.CMP_TotalAssessments);
				SELF.Summary_EE_TotalViolations   := SUM(allRows, allRows.EE_TotalViolations);
				SELF.Summary_EE_TotalAgreedCount  := SUM(allRows, allRows.EE_TotalAgreedCount);
				
				SELF.CaseID_1               := allRows[1].caseid;
				SELF.TotalViolations_1      := allRows[1].TotalViolations;
				SELF.BW_TotalAgreedAmount_1 := allRows[1].BW_TotalAgreedAmount;
				SELF.CMP_TotalAssessments_1 := allRows[1].CMP_TotalAssessments;
				SELF.EE_TotalViolations_1   := allRows[1].EE_TotalViolations;
				SELF.EE_TotalAgreedCount_1  := allRows[1].EE_TotalAgreedCount;
				SELF.Violations_Summary_1   := allRows[1].Violations_Summary;

				SELF.CaseID_2               := allRows[2].caseid;
				SELF.TotalViolations_2      := allRows[2].TotalViolations;
				SELF.BW_TotalAgreedAmount_2 := allRows[2].BW_TotalAgreedAmount;
				SELF.CMP_TotalAssessments_2 := allRows[2].CMP_TotalAssessments;
				SELF.EE_TotalViolations_2   := allRows[2].EE_TotalViolations;
				SELF.EE_TotalAgreedCount_2  := allRows[2].EE_TotalAgreedCount;
				SELF.Violations_Summary_2   := allRows[2].Violations_Summary;

				SELF.CaseID_3               := allRows[3].caseid;
				SELF.TotalViolations_3      := allRows[3].TotalViolations;
				SELF.BW_TotalAgreedAmount_3 := allRows[3].BW_TotalAgreedAmount;
				SELF.CMP_TotalAssessments_3 := allRows[3].CMP_TotalAssessments;
				SELF.EE_TotalViolations_3   := allRows[3].EE_TotalViolations;
				SELF.EE_TotalAgreedCount_3  := allRows[3].EE_TotalAgreedCount;
				SELF.Violations_Summary_3   := allRows[3].Violations_Summary;

				SELF.CaseID_4               := allRows[4].caseid;
				SELF.TotalViolations_4      := allRows[4].TotalViolations;
				SELF.BW_TotalAgreedAmount_4 := allRows[4].BW_TotalAgreedAmount;
				SELF.CMP_TotalAssessments_4 := allRows[4].CMP_TotalAssessments;
				SELF.EE_TotalViolations_4   := allRows[4].EE_TotalViolations;
				SELF.EE_TotalAgreedCount_4  := allRows[4].EE_TotalAgreedCount;
				SELF.Violations_Summary_4   := allRows[4].Violations_Summary;

				SELF.CaseID_5               := allRows[5].caseid;
				SELF.TotalViolations_5      := allRows[5].TotalViolations;
				SELF.BW_TotalAgreedAmount_5 := allRows[5].BW_TotalAgreedAmount;
				SELF.CMP_TotalAssessments_5 := allRows[5].CMP_TotalAssessments;
				SELF.EE_TotalViolations_5   := allRows[5].EE_TotalViolations;
				SELF.EE_TotalAgreedCount_5  := allRows[5].EE_TotalAgreedCount;
				SELF.Violations_Summary_5   := allRows[5].Violations_Summary;

				SELF                        := l;
			END; 
		
		ds_recs_rolled_with_summary_totals := 
			ROLLUP(
				GROUP(ds_recs_with_grpnum,Temp_Group_Id),
				GROUP,
				doRollup_2(LEFT, ROWS(LEFT))
			);
			
		results := ds_recs_rolled_with_summary_totals(summary_totalviolations > 0); 
		
		// 7. Output.	
		
		// Debugs:
		// OUTPUT( ds_matching_recs_pre, NAMED('ds_matching_recs_pre') );
		// OUTPUT( ds_matching_recs, NAMED('ds_matching_recs') );

		RETURN OUTPUT( results, NAMED('Results') );
		
	END;