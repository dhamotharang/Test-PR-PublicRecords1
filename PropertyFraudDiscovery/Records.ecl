EXPORT Records := MODULE

	EXPORT BatchView (DATASET(Layouts.batch_in) ds_batch_in,
										IParams.BatchParams in_mod) := FUNCTION

		Layouts.batch_out getOutputRecs(Layouts.batch_working_prop L) := TRANSFORM
				// 4.3.4 - BEST ADDRESS AND DATE LAST SEEN WILL BE RETURNED IN OUTPUT ONLY IF DIFFERENT THAN THE INPUT PROPERTY
				BOOLEAN addrMatches:=L.addr=L.best_addr1 AND ((L.p_city_name=L.best_city AND L.st=L.best_state) OR L.z5=L.best_zip);
				SELF.best_addr1:=IF(addrMatches,'',L.best_addr1);
				SELF.best_city:=IF(addrMatches,'',L.best_city);
				SELF.best_state:=IF(addrMatches,'',L.best_state);
				SELF.best_zip:=IF(addrMatches,'',L.best_zip);
				SELF.date_last_seen:=IF(addrMatches,'',L.date_last_seen);
				// 4.3.8 - ANY FORCLOSURE FOUND FOR THE INPUT SUBJECT AT INPUT PROPERTY
				SELF.has_foreclosure:=L.has_foreclosure;
				// 4.3.6 - RELATIVE OR ASSOCIATE IS A BUSINESS AFFILIATE OF THE INPUT SUBJECT
				SELF.has_business_affiliate:=EXISTS(L.relationships(is_business_affiliate));

				// DEEDS SUMMARY SECTION
				// 4.3.7.3 - HIGHLY SUSPICIOUS AND MODERATELY SUSPICIOUS DEED TYPES
				has_HS_deed:=EXISTS(L.deed_summary_by_vendor(has_HS_deed));
				has_MS_deed:=EXISTS(L.deed_summary_by_vendor(has_MS_deed));
				SELF.has_HS_deed:=has_HS_deed;
				SELF.has_MS_deed:=has_MS_deed;
				// 4.3.5 - INPUT PROPERTY SOLD TO RELATIVES OR ASSOCIATES IN SAME OR DIFFERENT TRANSACTION
				SELF.has_same_trans:=EXISTS(L.deed_summary_by_vendor(has_same_trans));
				SELF.has_diff_trans:=EXISTS(L.deed_summary_by_vendor(has_diff_trans));
				SELF.did_diff_trans:=L.deed_summary_by_vendor(did_diff_trans!=0)[1].did_diff_trans;
				subject_is_a_buyer:=EXISTS(L.deed_summary_by_vendor(subject_is_a_buyer));
				subject_is_a_seller:=EXISTS(L.deed_summary_by_vendor(subject_is_a_seller));
				SELF.subject_is_a_buyer:=subject_is_a_buyer;
				SELF.subject_is_a_seller:=subject_is_a_seller;
				// 4.3.7 - NUMBER OF BUYERS AND SELLERS FOR THE INPUT PROPERTY
				num_buyers_interval_1:=MAX(SET(L.deed_summary_by_vendor,num_buyers_interval_1));
				num_buyers_interval_2:=MAX(SET(L.deed_summary_by_vendor,num_buyers_interval_2));
				num_sellers_interval_1:=MAX(SET(L.deed_summary_by_vendor,num_sellers_interval_1));
				num_sellers_interval_2:=MAX(SET(L.deed_summary_by_vendor,num_sellers_interval_2));
				SELF.num_buyers_interval_1:=num_buyers_interval_1;
				SELF.num_buyers_interval_2:=num_buyers_interval_2;
				SELF.num_sellers_interval_1:=num_sellers_interval_1;
				SELF.num_sellers_interval_2:=num_sellers_interval_2;
				// 4.3.7.2 - CHANGE IN SALE PRICE OF THE INPUT PROPERTY AS TRANSFERRED FROM OWNER TO OWNER
				ds_sales_summary := CASE(MAX(SET(L.deed_summary_by_vendor,cnt_sales_summary)),
					// CURRENTLY ONLY TWO POSSIBLE VENDOR SALES SUMMARIES, SELECT FIRST ONE WITH MAX COUNT
					L.deed_summary_by_vendor[1].cnt_sales_summary => L.deed_summary_by_vendor[1].sales_summary,
					L.deed_summary_by_vendor[2].cnt_sales_summary => L.deed_summary_by_vendor[2].sales_summary);
				ds_sales_summary_interval_1:=ds_sales_summary(interval=1);
				interval_1_saleDiff_1:=ds_sales_summary_interval_1[1].difference;
				interval_1_saleDiff_2:=ds_sales_summary_interval_1[2].difference;
				interval_1_saleDiff_3:=ds_sales_summary_interval_1[3].difference;
				interval_1_saleDiff_4:=ds_sales_summary_interval_1[4].difference;
				SELF.interval_1_saleDiff_1:=interval_1_saleDiff_1;
				SELF.interval_1_saleDiff_2:=interval_1_saleDiff_2;
				SELF.interval_1_saleDiff_3:=interval_1_saleDiff_3;
				SELF.interval_1_saleDiff_4:=interval_1_saleDiff_4;
				ds_sales_summary_interval_2:=ds_sales_summary(interval>=1);
				interval_2_saleDiff_1:=ds_sales_summary_interval_2[1].difference;
				interval_2_saleDiff_2:=ds_sales_summary_interval_2[2].difference;
				interval_2_saleDiff_3:=ds_sales_summary_interval_2[3].difference;
				interval_2_saleDiff_4:=ds_sales_summary_interval_2[4].difference;
				SELF.interval_2_saleDiff_1:=interval_2_saleDiff_1;
				SELF.interval_2_saleDiff_2:=interval_2_saleDiff_2;
				SELF.interval_2_saleDiff_3:=interval_2_saleDiff_3;
				SELF.interval_2_saleDiff_4:=interval_2_saleDiff_4;

				// ASSESSMENT SUMMARY SECTION
				// 4.3.7 - NUMBER OF OWNERS FOR THE INPUT PROPERTY
				num_owners_interval_1:=MAX(SET(L.assessment_summary_by_vendor,num_owners_interval_1));
				num_owners_interval_2:=MAX(SET(L.assessment_summary_by_vendor,num_owners_interval_2));
				SELF.num_owners_interval_1:=num_owners_interval_1;
				SELF.num_owners_interval_2:=num_owners_interval_2;
				subject_is_a_owner:=EXISTS(L.assessment_summary_by_vendor(subject_is_a_owner));
				SELF.subject_is_a_owner:=subject_is_a_owner;
				// 4.3.7.1 - DURATION OF OWNERSHIP FOR THE INPUT SUBJECT AT INPUT PROPERTY
				duration_subject_ownership:=MAX(SET(L.assessment_summary_by_vendor,duration_subject_ownership));
				SELF.duration_subject_ownership:=duration_subject_ownership;

				// CALC SCORE SECTION
				max_ent_int_1:=MAX(num_owners_interval_1,num_buyers_interval_1,num_sellers_interval_1);
				max_ent_int_2:=MAX(num_owners_interval_2,num_buyers_interval_2,num_sellers_interval_2);
				int_1_total:=SUM(interval_1_saleDiff_1,interval_1_saleDiff_2,interval_1_saleDiff_3,interval_1_saleDiff_4);
				int_2_total:=SUM(interval_2_saleDiff_1,interval_2_saleDiff_2,interval_2_saleDiff_3,interval_2_saleDiff_4);
				// 4.3.10 - SCORE CODES AND DESCRIPTIONS
				score_code:=MAP(
					NOT subject_is_a_owner AND NOT subject_is_a_buyer AND NOT subject_is_a_seller => 0,
					max_ent_int_2 <= 3 AND duration_subject_ownership <= 2 AND int_2_total <= 0 => 1,
					max_ent_int_2 <= 3 AND duration_subject_ownership <= 1 AND int_2_total >= 1 => 2,
					max_ent_int_2 >= 4 AND duration_subject_ownership <= 2 AND int_2_total >= 1 AND has_MS_deed => 3,
					max_ent_int_2 >= 4 AND duration_subject_ownership <= 2 AND int_2_total >= 1 AND has_HS_deed => 4,
					max_ent_int_2 >= 4 AND duration_subject_ownership <= 1 AND int_2_total >= 1 => 5,
					99);
				SELF.max_entities_interval_1:=max_ent_int_1;
				SELF.max_entities_interval_2:=max_ent_int_2;
				SELF.interval_1_totalDiff:=int_1_total;
				SELF.interval_2_totalDiff:=int_2_total;
				SELF.score_code:=score_code;
				SELF.score_desc:=CASE(score_code,
					0 => '', // NO MATCH ON SUBJECT LEXID
					1 => 'NO FRAUD',
					2 => 'LOWER SUSPICION OF FRAUD',
					3 => 'MODERATE SUSPICION OF FRAUD',
					4 => 'HIGHER SUSPICION OF FRAUD',
					5 => 'ALL FRAUD',
					''); // NO MATCH FOR DEFINED SCORES

				SELF:=L;
		END;

		ds_work1_recs := fn_getBestRecs(ds_batch_in,in_mod);	// 4.3.2 and 4.3.3 and 4.3.4
		ds_work2_recs := fn_getForeclosureRecs(ds_work1_recs,in_mod);	// 4.3.8
		ds_work3_recs := fn_getRelAssocRecs(ds_work2_recs,in_mod);	// 4.3.5 and 4.3.6

		ds_work_prop_recs := fn_getPropertyRecs(ds_work3_recs,in_mod);	// 4.3.7
		ds_work_deed_recs := fn_sumDeedRecs(ds_work_prop_recs,in_mod);	// 4.3.7
		ds_work_assessment_recs := fn_sumAssessmentRecs(ds_work_deed_recs,in_mod);	// 4.3.7

		ds_batch_out_recs := PROJECT(ds_work_assessment_recs,getOutputRecs(LEFT));

		#IF(CONSTANTS.DEBUG_OUTPUT)
		OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
		OUTPUT(ds_work3_recs,NAMED('ds_work3_recs'));
		OUTPUT(ds_work_prop_recs,NAMED('ds_work_prop_recs'));
		OUTPUT(ds_work_deed_recs,NAMED('ds_work_deed_recs'));
		OUTPUT(ds_work_assessment_recs,NAMED('ds_work_assessment_recs'));
		#END

		RETURN ds_batch_out_recs;
	END;

END;