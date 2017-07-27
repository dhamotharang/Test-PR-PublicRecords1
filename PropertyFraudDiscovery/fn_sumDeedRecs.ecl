IMPORT STD;

EXPORT fn_sumDeedRecs(DATASET(Layouts.batch_working_prop) ds_work_prop_recs,
											IParams.BatchParams in_mod) := FUNCTION

	// SUMMARIZE DEEDS BY VENDOR

	Layouts.entityRec getChronologicalSellers(Layouts.sumDeedsRec L) := TRANSFORM
		SELF.entities:=PROJECT(L.sellers,
		TRANSFORM(Layouts.dateDidNameRec,SELF.date:=L.date,SELF:=LEFT));
	END;

	Layouts.entityRec getChronologicalBuyers(Layouts.sumDeedsRec L) := TRANSFORM
		SELF.entities:=PROJECT(L.buyers,
		TRANSFORM(Layouts.dateDidNameRec,SELF.date:=L.date,SELF:=LEFT));
	END;

	Layouts.sumDeedsRec getDeedSummary(Layouts.deedsPartiesRec L) := TRANSFORM
		deed:=L.deeds[1];// FIRST RECORD
		INTEGER sales_price:=(INTEGER)deed.sales_price;
		INTEGER loan_amt:=(INTEGER)deed.first_td_loan_amount;
		BOOLEAN isMortgageOnlyDeed:=loan_amt>0 AND sales_price<=1;

		SELF.ln_fares_id:=L.ln_fares_id;
		SELF.date:=L.sortby_date;
		SELF.sales_price:=sales_price;
		SELF.loan_amt:=loan_amt;

		SELF.is_HS_deed:=deed.document_type_code IN CONSTANTS.DOCUMENT_TYPE.HIGHLY_SUSPICIOUS_DEEDS OR
			deed.fares_mortgage_deed_type IN CONSTANTS.MORTGAGE_DEED_TYPE.HIGHLY_SUSPICIOUS_DEEDS;
		SELF.is_MS_deed:=deed.document_type_code IN CONSTANTS.DOCUMENT_TYPE.MODERATELY_SUSPICIOUS_DEEDS OR
			deed.fares_mortgage_deed_type IN CONSTANTS.MORTGAGE_DEED_TYPE.MODERATELY_SUSPICIOUS_DEEDS;
		SELF.is_noise_deed:=deed.document_type_code IN CONSTANTS.DOCUMENT_TYPE.NOISE_DEEDS OR
			deed.fares_mortgage_deed_type IN CONSTANTS.MORTGAGE_DEED_TYPE.NOISE_DEEDS OR isMortgageOnlyDeed;

		SELF.doc_type_cd:=deed.document_type_code;
		SELF.doc_type_desc:=deed.document_type_desc;
		SELF.mort_deed_type:=deed.fares_mortgage_deed_type;
		SELF.mort_deed_desc:=deed.fares_mortgage_deed_type_desc;

		SELF.buyer:=STD.Str.CleanSpaces(deed.name1+' '+deed.name2);
		SELF.seller:=STD.Str.CleanSpaces(deed.seller1+' '+deed.seller2);

		SELF.is_same_trans:=FALSE;// DEFAULT;

		buyerEntities:=PROJECT(L.parties(party_type='O').entity,TRANSFORM(Layouts.didNameBoolRec,
			SELF.did:=(UNSIGNED6)LEFT.did,
			SELF.seleid:=(UNSIGNED6)LEFT.seleid,
			SELF.name:=STD.Str.CleanSpaces(LEFT.fname+' '+LEFT.lname+' '+LEFT.name_suffix+' '+LEFT.cname),SELF:=[]));// DEBUG
		SELF.buyers:=buyerEntities;

		sellerEntities:=PROJECT(L.parties(party_type='S').entity,TRANSFORM(Layouts.didNameBoolRec,
			SELF.did:=(UNSIGNED6)LEFT.did,
			SELF.seleid:=(UNSIGNED6)LEFT.seleid,
			SELF.name:=STD.Str.CleanSpaces(LEFT.fname+' '+LEFT.lname+' '+LEFT.name_suffix+' '+LEFT.cname),SELF:=[]));// DEBUG
		SELF.sellers:=sellerEntities;
	END;

	Layouts.sumDeedsVndrRec getDeedVndrSummary(Layouts.deedVndr L) := TRANSFORM
		UNSIGNED thisYear:=(UNSIGNED)StringLib.getDateYYYYMMDD()[1..4];
		STRING8 duration1:=(STRING)(thisYear-in_mod.NumberInterval1Years)+'0000';
		STRING8 duration2:=(STRING)(thisYear-in_mod.NumberInterval2Years)+'0000';

		SELF.vndrSrcFlg:=L.vndrSrcFlg;
		SELF.num_prop_yrs:=in_mod.NumberPropertyYears;
		SELF.interval_1_yrs:=in_mod.NumberInterval1Years;
		SELF.interval_2_yrs:=in_mod.NumberInterval2Years;

		deedSummary:=PROJECT(L.deedsParties,getDeedSummary(LEFT));

		SELF.has_HS_deed:=EXISTS(deedSummary(is_HS_deed,date>=duration2));
		SELF.has_MS_deed:=EXISTS(deedSummary(is_MS_deed,date>=duration2));
		SELF.deed_summary:=DeedSummary;

		entitiesDeedSummary:=DeedSummary(NOT is_noise_deed);

		normBuyers:=DEDUP(SORT(NORMALIZE(PROJECT(entitiesDeedSummary,getChronologicalBuyers(LEFT)),LEFT.entities,
			TRANSFORM(Layouts.dateDidNameRec,SELF:=RIGHT)),-date,did),date,did);
		// COUNT INDIVDUAL BUYERS BY DID IN TIME INTERVALS
		SELF.num_buyers_interval_1:=COUNT(DEDUP(SORT(normBuyers(did!=0,date>=duration1),did),did));
		SELF.num_buyers_interval_2:=COUNT(DEDUP(SORT(normBuyers(did!=0,date>=duration2),did),did));
		SELF.chronological_buyers:=normBuyers;

		normSellers:=DEDUP(SORT(NORMALIZE(PROJECT(entitiesDeedSummary,getChronologicalSellers(LEFT)),LEFT.entities,
			TRANSFORM(Layouts.dateDidNameRec,SELF:=RIGHT)),-date,did),date,did);
		// COUNT INDIVDUAL SELLERS BY DID IN TIME INTERVALS
		SELF.num_sellers_interval_1:=COUNT(DEDUP(SORT(normSellers(did!=0,date>=duration1),did),did));
		SELF.num_sellers_interval_2:=COUNT(DEDUP(SORT(normSellers(did!=0,date>=duration2),did),did));
		SELF.chronological_sellers:=normSellers;

		SELF:=[];
	END;

	Layouts.batch_working_prop getDeedBatchSummary(Layouts.batch_working_prop L) := TRANSFORM
		SELF.deed_summary_by_vendor:=PROJECT(L.deedVndrProperties,getDeedVndrSummary(LEFT));
		SELF:=L;
		SELF:=[];
	END;

	// SET SOME SUMMARY VALUES

	Layouts.sumDeedsRec setIsSameTrans(Layouts.sumDeedsRec L,UNSIGNED subject_did,DATASET(Layouts.relationship) relationships) := TRANSFORM
		setOfrelationships:=SET(relationships,did);
		buyers:=PROJECT(L.buyers,TRANSFORM(Layouts.didNameBoolRec,
			SELF.is_subject:=IF(subject_did!=0,LEFT.did=subject_did,FALSE),
			SELF.is_relative:=LEFT.did IN setOfrelationships,
			SELF:=LEFT));
		sellers:=PROJECT(L.sellers,TRANSFORM(Layouts.didNameBoolRec,
			SELF.is_subject:=IF(subject_did!=0,LEFT.did=subject_did,FALSE),
			SELF.is_relative:=LEFT.did IN setOfrelationships,
			SELF:=LEFT));
		SELF.is_same_trans:=
			(EXISTS(sellers(is_subject)) AND EXISTS(buyers(is_relative))) OR
			(EXISTS(sellers(is_relative)) AND EXISTS(buyers(is_subject)));
		SELF.buyers:=buyers;
		SELF.sellers:=sellers;
		SELF:=L;
	END;

	Layouts.rollSaleRec unknownSeller() := TRANSFORM
		SELF.date:='00000000';
		SELF.seller:='UNKNOWN';
		SELF:=[];
	END;

	Layouts.rollSaleRec seqRollRecs(Layouts.rollSaleRec L,INTEGER cnt) := TRANSFORM
		SELF.seq:=cnt;
		SELF:=L;
		SELF:=[];
	END;

	Layouts.rollSaleRec setDifference(Layouts.rollSaleRec L,Layouts.rollSaleRec R) := TRANSFORM
		// FIRST SEQ IS UNKNOWN LEFT, SO BUYER AND PRICE PULLED FROM RIGHT
		STRING80 buyer:=IF(L.seq=1,R.seller,L.buyer);
		INTEGER bought:=IF(L.seq=1,R.sales_price,L.sales_price);
		INTEGER sold:=R.sales_price;
		SELF.sales_price:=bought;
		SELF.buyer:=buyer;
		SELF.buy_date:=L.date;
		SELF.bought:=bought;
		SELF.sell_date:=R.date;
		SELF.sold:=sold;
		SELF.difference:=sold-bought;
		SELF:=L;
	END;

	Layouts.sumSaleRec setInterval(Layouts.rollSaleRec L) := TRANSFORM
		UNSIGNED thisYear:=(UNSIGNED)StringLib.getDateYYYYMMDD()[1..4];
		STRING8 duration1:=(STRING)(thisYear-in_mod.NumberInterval1Years)+'0000';
		STRING8 duration2:=(STRING)(thisYear-in_mod.NumberInterval2Years)+'0000';
		SELF.interval:=MAP(
			L.sell_date>=duration1 => 1,
			L.sell_date>=duration2 => 2,
			0);
		SELF:=L;
	END;

	Layouts.sumDeedsVndrRec setDeedVndrSummary(Layouts.sumDeedsVndrRec L,UNSIGNED subject_did,DATASET(Layouts.relationship) relationships) := TRANSFORM
		// CALCULATE CHANGE IN SALE VALUE, DO NOT INCLUDE NOISE DEEDS OR DUPLICATE DEEDS
		ds_tmpRollRecs:=PROJECT(L.deed_summary(NOT is_noise_deed),TRANSFORM(Layouts.rollSaleRec,SELF:=LEFT,SELF:=[]));
		ds_dupRollRecs:=DEDUP(SORT(ds_tmpRollRecs,RECORD),RECORD);
		ds_unkRollRecs:=IF(EXISTS(ds_dupRollRecs),DATASET([unknownSeller()])+ds_dupRollRecs,ds_dupRollRecs);
		
		ds_rollRecs_1:=PROJECT(ds_unkRollRecs,seqRollRecs(LEFT,COUNTER));
		ds_rollRecs_2:=PROJECT(ds_dupRollRecs,seqRollRecs(LEFT,COUNTER));
		ds_rollRecs_3:=MERGE(ds_rollRecs_1,ds_rollRecs_2,SORTED(seq,date));
		ds_rolledRecs:=SORT(ROLLUP(ds_rollRecs_3,LEFT.seq=RIGHT.seq,setDifference(LEFT,RIGHT)),-seq);

		#IF(CONSTANTS.DEBUG_SALES_ROLLUP)
		SELF.roll_Dedup:=SORT(ds_dupRollRecs,-date);// DEBUG
		SELF.roll_Recs1:=SORT(ds_rollRecs_1,-seq,-date);// DEBUG
		SELF.roll_Recs2:=SORT(ds_rollRecs_2,-seq,-date);// DEBUG
		SELF.roll_Sales_In:=SORT(ds_rollRecs_3,-seq,-date);// DEBUG
		SELF.roll_Sales_Out:=ds_rolledRecs;// DEBUG
		#END

		// SALES SUMMARY DOES NOT INCLUDE FIRST OR LAST ROLLED RECORDS, AS THEY WILL HAVE NO CHANGE IN SALE VALUE
		sales_summary:=PROJECT(ds_rolledRecs(seq!=1,seq!=COUNT(ds_rolledRecs)),setInterval(LEFT));
		SELF.cnt_sales_summary:=COUNT(sales_summary(interval>=1));
		SELF.sales_summary:=sales_summary;

		// SET HAS SAME TRANSACTION
		deedSummary:=PROJECT(L.deed_summary,setIsSameTrans(LEFT,subject_did,relationships));
		SELF.has_same_trans:=EXISTS(deedSummary(is_same_trans));
		SELF.deed_summary:=deedSummary;

		// SET IS SUBJECT AND IS RELATIVE
		setOfrelationships:=SET(relationships,did);
		ds_buyers:=PROJECT(L.chronological_buyers,TRANSFORM(Layouts.dateDidNameRec,
			SELF.is_Subject:=IF(subject_did!=0,LEFT.did=subject_did,FALSE),
			SELF.is_relative:=LEFT.did IN setOfrelationships,
			SELF:=LEFT));
		ds_sellers:=PROJECT(L.chronological_sellers,TRANSFORM(Layouts.dateDidNameRec,
			SELF.is_Subject:=IF(subject_did!=0,LEFT.did=subject_did,FALSE),
			SELF.is_relative:=LEFT.did IN setOfrelationships,
			SELF:=LEFT));
		SELF.subject_is_a_buyer:=EXISTS(ds_buyers(is_Subject));
		SELF.chronological_buyers:=ds_buyers;
		SELF.subject_is_a_seller:=EXISTS(ds_sellers(is_Subject));
		SELF.chronological_sellers:=ds_sellers;

		// SET HAS DIFFERENT TRANSACTION
		ds_sellerIsSubject:=ds_sellers(is_subject);
		sellerIsSubjectDates:=SET(ds_sellerIsSubject,date);
		ds_buyerIsRelative:=ds_buyers(EXISTS(ds_sellerIsSubject) AND is_relative AND date > MIN(sellerIsSubjectDates) AND date NOT IN sellerIsSubjectDates);
		buyerIsRelativeDates:=SET(ds_buyerIsRelative,date);
		BOOLEAN sellerIsSubjectAndBuyerIsRelative:=EXISTS(ds_sellerIsSubject) AND EXISTS(ds_buyerIsRelative);

		ds_sellerIsRelative:=ds_sellers(is_relative);
		sellerIsRelativeDates:=SET(ds_sellerIsRelative,date);
		ds_buyerIsSubject:=ds_buyers(EXISTS(ds_sellerIsRelative) AND is_subject AND date > MIN(sellerIsRelativeDates) AND date NOT IN sellerIsRelativeDates);
		buyerIsSubjectDates:=SET(ds_buyerIsSubject,date);
		BOOLEAN sellerIsRelativeAndBuyerIsSubject:=EXISTS(ds_sellerIsRelative) AND EXISTS(ds_buyerIsSubject);

		BOOLEAN hasDiffTrans:=sellerIsSubjectAndBuyerIsRelative OR sellerIsRelativeAndBuyerIsSubject;

		ds_straw_sellers:=DEDUP(SORT(
				ds_sellers(~is_subject AND date > MIN(sellerIsSubjectDates) AND date <= MAX(buyerIsRelativeDates))+
				ds_sellers(~is_subject AND date > MIN(sellerIsRelativeDates) AND date <= MAX(buyerIsSubjectDates)),
			-date,did),date,did);

		ds_straw_buyers:=DEDUP(SORT(
				ds_buyers(~is_subject AND date >= MIN(sellerIsSubjectDates) AND date < MAX(buyerIsRelativeDates))+
				ds_buyers(~is_subject AND date >= MIN(sellerIsRelativeDates) AND date < MAX(buyerIsSubjectDates)),
			date,did),date,did);

		SELF.has_diff_trans:=hasDiffTrans;
		SELF.did_diff_trans :=IF(hasDiffTrans,IF(EXISTS(ds_straw_sellers),ds_straw_sellers(did!=0)[1].did ,ds_straw_buyers(did!=0)[1].did),0);
		SELF.name_diff_trans:=IF(hasDiffTrans,IF(EXISTS(ds_straw_sellers),ds_straw_sellers(did!=0)[1].name,ds_straw_buyers(did!=0)[1].name),'');

		SELF.straw_sellers:=ds_straw_sellers;
		SELF.straw_buyers:=SORT(ds_straw_buyers,-date,did);
		SELF.subject_seller:=ds_sellerIsSubject;
		SELF.relative_buyer:=ds_buyerIsRelative;
		SELF.relative_seller:=ds_sellerIsRelative;
		SELF.subject_buyer:=ds_buyerIsSubject;

		SELF:=L;
	END;

	Layouts.batch_working_prop setDeedBatchSummary(Layouts.batch_working_prop L) := TRANSFORM
		SELF.deed_summary_by_vendor:=PROJECT(L.deed_summary_by_vendor,setDeedVndrSummary(LEFT,L.did,L.relationships));
		SELF:=L;
	END;

	ds_tmp_deed_recs := PROJECT(ds_work_prop_recs,getDeedBatchSummary(LEFT));
	ds_sum_deed_recs := PROJECT(ds_tmp_deed_recs,setDeedBatchSummary(LEFT));

	RETURN ds_sum_deed_recs;

END;