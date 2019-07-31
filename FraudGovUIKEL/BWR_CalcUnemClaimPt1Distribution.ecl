import FraudgovUIKEL;
import std;


EXPORT BWR_CalcUnemClaimPt1Distribution := MODULE
		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, INTEGER attribute_value := (INTEGER)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;


		// Nicole Attributes 
		SHARED ds_BusAcctLiabToOldestUnemClmSpan := fn_macro(ds, 'BusAcctLiabToOldestUnemClmSpan', Bus_Acct_Liab_To_Oldest_Unem_Clm_Span_);
		SHARED ds_BusAcctLiabToNewestUnemClmSpan := fn_macro(ds, 'BusAcctLiabToNewestUnemClmSpan', Bus_Acct_Liab_To_Newest_Unem_Clm_Span_);
	  SHARED ds_BusIncorpToLiabSpan := fn_macro(ds, 'BusIncorpToLiabSpan', Bus_Incorp_To_Liab_Span_);
		SHARED ds_BusIncorpToOldestUnemClmSpan := fn_macro(ds, 'BusIncorpToOldestUnemClmSpan', Bus_Incorp_To_Oldest_Unem_Clm_Span_);
		SHARED ds_BusIncorpToNewestUnemClmSpan := fn_macro(ds, 'BusIncorpToNewestUnemClmSpan', Bus_Incorp_To_Newest_Unem_Clm_Span_);
		SHARED ds_BusLiabToOldestUnemClmSpan := fn_macro(ds, 'BusLiabToOldestUnemClmSpan', Bus_Liab_To_Oldest_Unem_Clm_Span_);
		SHARED ds_BusLiabToNewestUnemClmSpan := fn_macro(ds, 'BusLiabToNewestUnemClmSpan', Bus_Liab_To_Newest_Unem_Clm_Span_);
		
		SHARED ds_BusAcctUnemClaimCurrActiveCnt := fn_macro(ds, 'BusAcctUnemClaimCurrActiveCnt', Bus_Acct_Unem_Claim_Curr_Active_Cnt_);
		SHARED ds_BusAcctUnemClaimFiledCntEv := fn_macro(ds, 'BusAcctUnemClaimFiledCntEv', Bus_Acct_Unem_Claim_Filed_Cnt_Ev_);
		SHARED ds_BusAcctUnemClaimFiledCnt1Y := fn_macro(ds, 'BusAcctUnemClaimFiledCnt1Y', Bus_Acct_Unem_Claim_Filed_Cnt1_Y_);
		SHARED ds_BusAcctUnemClaimFiledCnt120D := fn_macro(ds, 'BusAcctUnemClaimFiledCnt120D', Bus_Acct_Unem_Claim_Filed_Cnt120_D_);
		SHARED ds_BusAcctUnemClaimFiledCnt90D := fn_macro(ds, 'BusAcctUnemClaimFiledCnt90D', Bus_Acct_Unem_Claim_Filed_Cnt90_D_);
		SHARED ds_BusAcctUnemClaimFiledCnt30D := fn_macro(ds, 'BusAcctUnemClaimFiledCnt30D', Bus_Acct_Unem_Claim_Filed_Cnt30_D_); 
		
		SHARED ds_BusAcctUnemClaimApprvCntEv := fn_macro(ds, 'BusAcctUnemClaimApprvCntEv', Bus_Acct_Unem_Claim_Apprv_Cnt_Ev_);
		SHARED ds_BusAcctUnemClaimApprvCnt1Y := fn_macro(ds, 'BusAcctUnemClaimApprvCnt1Y', Bus_Acct_Unem_Claim_Apprv_Cnt1_Y_);
		SHARED ds_BusAcctUnemClaimApprvCnt120D := fn_macro(ds, 'BusAcctUnemClaimApprvCnt120D', Bus_Acct_Unem_Claim_Apprv_Cnt120_D_);
		SHARED ds_BusAcctUnemClaimApprvCnt90D := fn_macro(ds, 'BusAcctUnemClaimApprvCnt90D', Bus_Acct_Unem_Claim_Apprv_Cnt90_D_);
		SHARED ds_BusAcctUnemClaimApprvCnt30D := fn_macro(ds, 'BusAcctUnemClaimApprvCnt30D', Bus_Acct_Unem_Claim_Apprv_Cnt30_D_); 

		SHARED ds_BusUnemClaimCurrActiveCnt := fn_macro(ds, 'BusUnemClaimCurrActiveCnt', Bus_Unem_Claim_Curr_Active_Cnt_);
		SHARED ds_BusUnemClaimFiledCntEv := fn_macro(ds, 'BusUnemClaimFiledCntEv', Bus_Unem_Claim_Filed_Cnt_Ev_);
		SHARED ds_BusUnemClaimFiledCnt1Y := fn_macro(ds, 'BusUnemClaimFiledCnt1Y', Bus_Unem_Claim_Filed_Cnt1_Y_);
		SHARED ds_BusUnemClaimFiledCnt120D := fn_macro(ds, 'BusUnemClaimFiledCnt120D', Bus_Unem_Claim_Filed_Cnt120_D_);
		SHARED ds_BusUnemClaimFiledCnt90D := fn_macro(ds, 'BusUnemClaimFiledCnt90D', Bus_Unem_Claim_Filed_Cnt90_D_);
		SHARED ds_BusUnemClaimFiledCnt30D := fn_macro(ds, 'BusUnemClaimFiledCnt30D', Bus_Unem_Claim_Filed_Cnt30_D_);
		
		SHARED ds_BusUnemClaimApprvCntEv := fn_macro(ds, 'BusUnemClaimApprvCntEv', Bus_Unem_Claim_Apprv_Cnt_Ev_);
		SHARED ds_BusUnemClaimApprvCnt1Y := fn_macro(ds, 'BusUnemClaimApprvCnt1Y', Bus_Unem_Claim_Apprv_Cnt1_Y_);
		SHARED ds_BusUnemClaimApprvCnt120D := fn_macro(ds, 'BusUnemClaimApprvCnt120D', Bus_Unem_Claim_Apprv_Cnt120_D_);
		SHARED ds_BusUnemClaimApprvCnt90D := fn_macro(ds, 'BusUnemClaimApprvCnt90D', Bus_Unem_Claim_Apprv_Cnt90_D_);
		SHARED ds_BusUnemClaimApprvCnt30D := fn_macro(ds, 'BusUnemClaimApprvCnt30D', Bus_Unem_Claim_Apprv_Cnt30_D_); 


		SHARED ds_All := 	ds_BusAcctLiabToOldestUnemClmSpan + ds_BusAcctLiabToNewestUnemClmSpan + ds_BusIncorpToLiabSpan + ds_BusIncorpToOldestUnemClmSpan +
		          ds_BusIncorpToNewestUnemClmSpan + ds_BusLiabToOldestUnemClmSpan + ds_BusLiabToNewestUnemClmSpan +

              ds_BusAcctUnemClaimCurrActiveCnt + ds_BusAcctUnemClaimFiledCntEv + ds_BusAcctUnemClaimFiledCnt1Y + ds_BusAcctUnemClaimFiledCnt120D +
							ds_BusAcctUnemClaimFiledCnt90D + ds_BusAcctUnemClaimFiledCnt30D  + ds_BusAcctUnemClaimApprvCntEv + ds_BusAcctUnemClaimApprvCnt1Y +
							ds_BusAcctUnemClaimApprvCnt120D + ds_BusAcctUnemClaimApprvCnt90D + ds_BusAcctUnemClaimApprvCnt30D +
							
							ds_BusUnemClaimCurrActiveCnt + ds_BusUnemClaimFiledCntEv + ds_BusUnemClaimFiledCnt1Y + ds_BusUnemClaimFiledCnt120D +
							ds_BusUnemClaimFiledCnt90D + ds_BusUnemClaimFiledCnt30D  + ds_BusUnemClaimApprvCntEv + ds_BusUnemClaimApprvCnt1Y +
							ds_BusUnemClaimApprvCnt120D + ds_BusUnemClaimApprvCnt90D + ds_BusUnemClaimApprvCnt30D;
							
		// Show tables that verify for SeleID level variables that every record with the same SeleID receives the same attribute value
		/*
				BusIncorpToLiabSpan
		*/
		
		EXPORT fn_seleCheck(dsMac, attr_str, attr_name) := FUNCTIONMACRO	
				// Check that Time to Oldest Claim is shorter or equal to time to newest claim for span variables. 		
				

				// First table rolls up by seleid and attribute name. Gets number of counts
				xt1 := TABLE(dsMac, {STRING30 sele:=(STRING30)Bus_Acct_Sele_I_D_Append_, STRING30 atr:=(STRING30)attr_name, cnt:=COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_, attr_name);
				// Second table rolls up by seleid to find out how many seleis multiple attributes - failing the test
				xt2 := TABLE(xt1, {sele, cntt:=COUNT(GROUP)}, sele);
				
				// Return a PASS/FAIL 
				// RETURN xt2;
				pass_cnt := COUNT(xt2(cntt=1));
				RETURN ROW({attr_str, pass_cnt, COUNT(xt2)-pass_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;
		
		
		SHARED dsSeleBusIncorpToLiabSpan := fn_seleCheck(ds, 'BusIncorpToLiabSpan', Bus_Incorp_To_Liab_Span_);
		SHARED dsSeleBusIncorpToOldestUnemClmSpan := fn_seleCheck(ds, 'BusIncorpToOldestUnemClmSpan', Bus_Incorp_To_Oldest_Unem_Clm_Span_);
		SHARED dsSeleBusIncorpToNewestUnemClmSpan := fn_seleCheck(ds, 'BusIncorpToNewestUnemClmSpan', Bus_Incorp_To_Newest_Unem_Clm_Span_);
		SHARED dsSeleBusLiabToOldestUnemClmSpan := fn_seleCheck(ds, 'BusLiabToOldestUnemClmSpan', Bus_Liab_To_Oldest_Unem_Clm_Span_);
		SHARED dsSeleBusLiabToNewestUnemClmSpan := fn_seleCheck(ds, 'BusLiabToNewestUnemClmSpan', Bus_Liab_To_Newest_Unem_Clm_Span_);
		
		SHARED dsSeleBusUnemClaimCurrActiveCnt := fn_seleCheck(ds, 'BusUnemClaimCurrActiveCnt', Bus_Unem_Claim_Curr_Active_Cnt_);
		SHARED dsSeleBusUnemClaimFiledCntEv := fn_seleCheck(ds, 'BusUnemClaimFiledCntEv', Bus_Unem_Claim_Filed_Cnt_Ev_);
		SHARED dsSeleBusUnemClaimFiledCnt1Y := fn_seleCheck(ds, 'BusUnemClaimFiledCnt1Y', Bus_Unem_Claim_Filed_Cnt1_Y_);
		SHARED dsSeleBusUnemClaimFiledCnt120D := fn_seleCheck(ds, 'BusUnemClaimFiledCnt120D', Bus_Unem_Claim_Filed_Cnt120_D_);
		SHARED dsSeleBusUnemClaimFiledCnt90D := fn_seleCheck(ds, 'BusUnemClaimFiledCnt90D', Bus_Unem_Claim_Filed_Cnt90_D_);
		SHARED dsSeleBusUnemClaimFiledCnt30D := fn_seleCheck(ds, 'BusUnemClaimFiledCnt30D', Bus_Unem_Claim_Filed_Cnt30_D_); 
		
		SHARED dsSeleBusUnemClaimApprvCntEv := fn_seleCheck(ds, 'BusUnemClaimApprvCntEv', Bus_Unem_Claim_Apprv_Cnt_Ev_);
		SHARED dsSeleBusUnemClaimApprvCnt1Y := fn_seleCheck(ds, 'BusUnemClaimApprvCnt1Y', Bus_Unem_Claim_Apprv_Cnt1_Y_);
		SHARED dsSeleBusUnemClaimApprvCnt120D := fn_seleCheck(ds, 'BusUnemClaimApprvCnt120D', Bus_Unem_Claim_Apprv_Cnt120_D_);
		SHARED dsSeleBusUnemClaimApprvCnt90D := fn_seleCheck(ds, 'BusUnemClaimApprvCnt90D', Bus_Unem_Claim_Apprv_Cnt90_D_);
		SHARED dsSeleBusUnemClaimApprvCnt30D := fn_seleCheck(ds, 'BusUnemClaimApprvCnt30D', Bus_Unem_Claim_Apprv_Cnt30_D_); 
		
		
		SHARED dsSeleChecks := dsSeleBusIncorpToLiabSpan + dsSeleBusIncorpToOldestUnemClmSpan + dsSeleBusIncorpToNewestUnemClmSpan + 
		           dsSeleBusLiabToOldestUnemClmSpan + dsSeleBusLiabToNewestUnemClmSpan + dsSeleBusUnemClaimCurrActiveCnt + dsSeleBusUnemClaimFiledCntEv + 
							 dsSeleBusUnemClaimFiledCnt1Y + dsSeleBusUnemClaimFiledCnt120D + dsSeleBusUnemClaimFiledCnt90D + dsSeleBusUnemClaimFiledCnt30D  + 
							 dsSeleBusUnemClaimApprvCntEv + dsSeleBusUnemClaimApprvCnt1Y + dsSeleBusUnemClaimApprvCnt120D + dsSeleBusUnemClaimApprvCnt90D + 
							 dsSeleBusUnemClaimApprvCnt30D;
							
		
		
		EXPORT fn_spanCheck(dsMac, attr_oldest, attr_newest, attr_name) := FUNCTIONMACRO	
				// Check that Time to Oldest Claim is shorter or equal to time to newest claim for span variables. 		
				xt1 := TABLE(dsMac, {INTEGER Check := IF(attr_oldest <= attr_newest, 1,0)});
				// Return a PASS/FAIL  
				pass_cnt := COUNT(xt1(Check=1));
				fail_cnt := COUNT(xt1(Check=0));
				RETURN ROW({attr_name, pass_cnt, fail_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;
		
		
		SHARED ds_BusAcctLiabToUnemClm := fn_spanCheck(ds, Bus_Acct_Liab_To_Oldest_Unem_Clm_Span_, Bus_Acct_Liab_To_Newest_Unem_Clm_Span_,'BusAcctLiabToUnemClm');
    SHARED ds_BusIncorpToUnemClm := fn_spanCheck(ds, Bus_Incorp_To_Oldest_Unem_Clm_Span_, Bus_Incorp_To_Newest_Unem_Clm_Span_,'BusIncorpToUnemClm');
    SHARED ds_BusLiabToUnemClm := fn_spanCheck(ds, Bus_Liab_To_Oldest_Unem_Clm_Span_, Bus_Liab_To_Newest_Unem_Clm_Span_,'BusLiabToUnemClm');

		SHARED dsSpanChecks := ds_BusAcctLiabToUnemClm + ds_BusIncorpToUnemClm + ds_BusLiabToUnemClm;




		EXPORT fn_dateCheck(dsMac, attr_1y, attr_120d, attr_90d, attr_30d, attr_name) := FUNCTIONMACRO	
				// Check that Time to Oldest Claim is shorter or equal to time to newest claim for span variables. 		
				xt1 := TABLE(dsMac, {INTEGER Check := IF(attr_30d <= attr_90d AND attr_90d <= attr_120d AND attr_120d <= attr_1y, 1,0)});
				// Return a PASS/FAIL  
				pass_cnt := COUNT(xt1(Check=1));
				fail_cnt := COUNT(xt1(Check=0));
				RETURN ROW({attr_name, pass_cnt, fail_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;

    SHARED ds_BusAcctUnemClaimFiledCnt := fn_dateCheck(ds, Bus_Acct_Unem_Claim_Filed_Cnt1_Y_, Bus_Acct_Unem_Claim_Filed_Cnt120_D_, Bus_Acct_Unem_Claim_Filed_Cnt90_D_, Bus_Acct_Unem_Claim_Filed_Cnt30_D_, 'BusAcctUnemClaimFiledCnt');
		SHARED ds_BusAcctUnemClaimApprvCnt := fn_dateCheck(ds, Bus_Acct_Unem_Claim_Apprv_Cnt1_Y_, Bus_Acct_Unem_Claim_Apprv_Cnt120_D_, Bus_Acct_Unem_Claim_Apprv_Cnt90_D_, Bus_Acct_Unem_Claim_Apprv_Cnt30_D_, 'BusAcctUnemClaimApprvCnt');
    SHARED ds_BusUnemClaimFiledCnt := fn_dateCheck(ds, Bus_Unem_Claim_Filed_Cnt1_Y_, Bus_Unem_Claim_Filed_Cnt120_D_, Bus_Unem_Claim_Filed_Cnt90_D_, Bus_Unem_Claim_Filed_Cnt30_D_, 'BusUnemClaimFiledCnt');
    SHARED ds_BusUnemClaimApprvCnt := fn_dateCheck(ds, Bus_Unem_Claim_Apprv_Cnt1_Y_, Bus_Unem_Claim_Apprv_Cnt120_D_, Bus_Unem_Claim_Apprv_Cnt90_D_, Bus_Unem_Claim_Apprv_Cnt30_D_, 'BusUnemClaimApprvCnt');

    SHARED dsDateChecks := ds_BusAcctUnemClaimFiledCnt + ds_BusAcctUnemClaimApprvCnt + ds_BusUnemClaimFiledCnt + ds_BusUnemClaimApprvCnt;

		
		EXPORT writeFile(dsMac, reportName) := FUNCTIONMACRO
			// If landing zone is on the same server as the Dali
			daliserver := std.system.Thorlib.DaliServer();
			cpos := std.Str.Find(daliserver, ':', 1)-1;
			lzip := daliserver[1..cpos];
			lz_dir := '/var/lib/HPCCSystems/mydropzone/fraudgov/kelattributes/20190701/';
			file_path := '~nnavarro::fraudgov::kelattributes::20190701::';
			thor_file := file_path + reportName;
			lz_path := lz_dir + reportName + '.csv';
			thor_out := OUTPUT(dsMac,, thor_file, CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"')), OVERWRITE);
			RETURN SEQUENTIAL(std.file.CreateExternalDirectory(lzip, lz_dir), thor_out, std.file.Despray(thor_file, lzip,lz_path,,,,true));
		ENDMACRO;


		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'UnemClaimPt1_AttributesDistribution'),
															writeFile(dsSeleChecks, 'UnemClaimPt1_SelePassFailTests'),
															writeFile(dsSpanChecks, 'UnemClaimPt1_SpanPassFailTests'),
															writeFile(dsDateChecks, 'UnemClaimPt1_DatePassFailTests'));

 








END;