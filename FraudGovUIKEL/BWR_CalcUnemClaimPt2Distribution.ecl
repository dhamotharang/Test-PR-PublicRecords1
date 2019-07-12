import FraudgovUIKEL;
import std;


EXPORT BWR_CalcUnemClaimPt2Distribution := MODULE

		SHARED ds := FraudgovUIKel.Q__show_Employers.Res0;

		EXPORT fn_macro(dsMac, attributeStr, attribute) := FUNCTIONMACRO
				ds_cnt := COUNT(dsMac);
				RETURN SORT(TABLE(dsMac, {STRING30 attribute_name := attributeStr, INTEGER attribute_value := (INTEGER)attribute, cnt:=COUNT(GROUP), pct_of_file := COUNT(GROUP)/ds_cnt}, attribute), attribute_value);
		ENDMACRO;


		// Nate Attributes 
		// Claim attributes
		// Business Account attributes
		shared ds_BusAcctUnemClmAcctCurrActiveCnt := fn_macro(ds, 'BusAcctUnemClmAcctCurrActiveCnt', Bus_Acct_Unem_Clm_Acct_Cur_Active_Cnt_);
		
		shared ds_BusAcctUnemClmAcctFiledCntEv := fn_macro(ds, 'BusAcctUnemClmAcctFiledCntEv', Bus_Acct_Unem_Clm_Acct_Filed_Cnt_Ev_);
		shared ds_BusAcctUnemClmAcctFiledCnt1Y := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt1Y', Bus_Acct_Unem_Clm_Acct_Filed_Cnt1_Y_);
		shared ds_BusAcctUnemClmAcctFiledCnt120D := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt120D', Bus_Acct_Unem_Clm_Acct_Filed_Cnt120_D_);
		shared ds_BusAcctUnemClmAcctFiledCnt90D := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt90D', Bus_Acct_Unem_Clm_Acct_Filed_Cnt90_D_);
		shared ds_BusAcctUnemClmAcctFiledCnt30D := fn_macro(ds, 'BusAcctUnemClmAcctFiledCnt30D', Bus_Acct_Unem_Clm_Acct_Filed_Cnt30_D_);
		
		shared ds_BusAcctUnemClmLexIDFiledCntEv := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCntEv', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_);
		shared ds_BusAcctUnemClmLexIDFiledCnt1Y := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt1Y', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_);
		shared ds_BusAcctUnemClmLexIDFiledCnt120D := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt120D', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt120_D_);
		shared ds_BusAcctUnemClmLexIDFiledCnt90D := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt90D', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt90_D_);
		shared ds_BusAcctUnemClmLexIDFiledCnt30D := fn_macro(ds, 'BusAcctUnemClmLexIDFiledCnt30D', Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt30_D_);
		
		shared ds_BusAcctLexIDMultiUnemClmCntEv := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCntEv', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_);
		shared ds_BusAcctLexIDMultiUnemClmCnt1Y := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt1Y', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_);
		shared ds_BusAcctLexIDMultiUnemClmCnt120D := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt120D', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt120_D_);
		shared ds_BusAcctLexIDMultiUnemClmCnt90D := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt90D', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt90_D_);
		shared ds_BusAcctLexIDMultiUnemClmCnt30D := fn_macro(ds, 'BusAcctLexIDMultiUnemClmCnt30D', Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt30_D_);
		
		// Legal business attributes
		shared ds_BusUnemClmAcctCurrActiveCnt := fn_macro(ds, 'BusUnemClmAcctCurrActiveCnt', Bus_Unem_Clm_Acct_Cur_Active_Cnt_);
		shared ds_BusUnemClmAcctFiledCntEv := fn_macro(ds, 'BusUnemClmAcctFiledCntEv', Bus_Unem_Clm_Acct_Filed_Cnt_Ev_);
		shared ds_BusUnemClmAcctFiledCnt1Y := fn_macro(ds, 'BusUnemClmAcctFiledCnt1Y', Bus_Unem_Clm_Acct_Filed_Cnt1_Y_);
		shared ds_BusUnemClmAcctFiledCnt120D := fn_macro(ds, 'BusUnemClmAcctFiledCnt120D', Bus_Unem_Clm_Acct_Filed_Cnt120_D_);
		shared ds_BusUnemClmAcctFiledCnt90D := fn_macro(ds, 'BusUnemClmAcctFiledCnt90D', Bus_Unem_Clm_Acct_Filed_Cnt90_D_);
		shared ds_BusUnemClmAcctFiledCnt30D := fn_macro(ds, 'BusUnemClmAcctFiledCnt30D', Bus_Unem_Clm_Acct_Filed_Cnt30_D_);
		
		shared ds_BusUnemClmLexIDFiledCntEv := fn_macro(ds, 'BusUnemClmLexIDFiledCntEv', Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_);
		shared ds_BusUnemClmLexIDFiledCnt1Y := fn_macro(ds, 'BusUnemClmLexIDFiledCnt1Y', Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_);
		shared ds_BusUnemClmLexIDFiledCnt120D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt120D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_);
		shared ds_BusUnemClmLexIDFiledCnt90D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt90D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_);
		shared ds_BusUnemClmLexIDFiledCnt30D := fn_macro(ds, 'BusUnemClmLexIDFiledCnt30D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_);
		
		shared ds_BusLexIDMultiUnemClmCntEv := fn_macro(ds, 'BusLexIDMultiUnemClmCntEv', Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_);
		shared ds_BusLexIDMultiUnemClmCnt1Y := fn_macro(ds, 'BusLexIDMultiUnemClmCnt1Y', Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_);
		shared ds_BusLexIDMultiUnemClmCnt120D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt120D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_);
		shared ds_BusLexIDMultiUnemClmCnt90D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt90D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_);
		shared ds_BusLexIDMultiUnemClmCnt30D := fn_macro(ds, 'BusLexIDMultiUnemClmCnt30D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_);


		SHARED ds_All := 	ds_BusAcctUnemClmAcctCurrActiveCnt + 
											ds_BusAcctUnemClmAcctFiledCntEv + ds_BusAcctUnemClmAcctFiledCnt1Y + ds_BusAcctUnemClmAcctFiledCnt120D + ds_BusAcctUnemClmAcctFiledCnt90D + ds_BusAcctUnemClmAcctFiledCnt30D + 
											ds_BusAcctUnemClmLexIDFiledCntEv + ds_BusAcctUnemClmLexIDFiledCnt1Y + ds_BusAcctUnemClmLexIDFiledCnt120D + ds_BusAcctUnemClmLexIDFiledCnt90D + ds_BusAcctUnemClmLexIDFiledCnt30D + 
											ds_BusAcctLexIDMultiUnemClmCntEv + ds_BusAcctLexIDMultiUnemClmCnt1Y + ds_BusAcctLexIDMultiUnemClmCnt120D + ds_BusAcctLexIDMultiUnemClmCnt90D + ds_BusAcctLexIDMultiUnemClmCnt30D + 
											ds_BusUnemClmAcctCurrActiveCnt + ds_BusUnemClmAcctFiledCntEv + ds_BusUnemClmAcctFiledCnt1Y + ds_BusUnemClmAcctFiledCnt120D + ds_BusUnemClmAcctFiledCnt90D + ds_BusUnemClmAcctFiledCnt30D + 
											ds_BusUnemClmLexIDFiledCntEv + ds_BusUnemClmLexIDFiledCnt1Y + ds_BusUnemClmLexIDFiledCnt120D + ds_BusUnemClmLexIDFiledCnt90D + ds_BusUnemClmLexIDFiledCnt30D + 
											ds_BusLexIDMultiUnemClmCntEv + ds_BusLexIDMultiUnemClmCnt1Y + ds_BusLexIDMultiUnemClmCnt120D + ds_BusLexIDMultiUnemClmCnt90D + ds_BusLexIDMultiUnemClmCnt30D;

		// Show tables that verify for SeleID level variables that every record with the same SeleID receives the same attribute value
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
		
		
		shared dsSeleBusUnemClmAcctCurrActiveCnt := fn_seleCheck(ds, 'BusUnemClmAcctCurrActiveCnt', Bus_Unem_Clm_Acct_Cur_Active_Cnt_);
		shared dsSeleBusUnemClmAcctFiledCntEv := fn_seleCheck(ds, 'BusUnemClmAcctFiledCntEv', Bus_Unem_Clm_Acct_Filed_Cnt_Ev_);
		shared dsSeleBusUnemClmAcctFiledCnt1Y := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt1Y', Bus_Unem_Clm_Acct_Filed_Cnt1_Y_);
		shared dsSeleBusUnemClmAcctFiledCnt120D := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt120D', Bus_Unem_Clm_Acct_Filed_Cnt120_D_);
		shared dsSeleBusUnemClmAcctFiledCnt90D := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt90D', Bus_Unem_Clm_Acct_Filed_Cnt90_D_);
		shared dsSeleBusUnemClmAcctFiledCnt30D := fn_seleCheck(ds, 'BusUnemClmAcctFiledCnt30D', Bus_Unem_Clm_Acct_Filed_Cnt30_D_);
		
		shared dsSeleBusUnemClmLexIDFiledCntEv := fn_seleCheck(ds, 'BusUnemClmLexIDFiledCntEv', Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_);
		shared dsSeleBusUnemClmLexIDFiledCnt1Y := fn_seleCheck(ds, 'BusUnemClmLexIDFiledCnt1Y', Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_);
		shared dsSeleBusUnemClmLexIDFiledCnt120D := fn_seleCheck(ds, 'BusUnemClmLexIDFiledCnt120D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_);
		shared dsSeleBusUnemClmLexIDFiledCnt90D := fn_seleCheck(ds, 'BusUnemClmLexIDFiledCnt90D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_);
		shared dsSeleBusUnemClmLexIDFiledCnt30D := fn_seleCheck(ds, 'BusUnemClmLexIDFiledCnt30D', Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_);
		
		shared dsSeleBusLexIDMultiUnemClmCntEv := fn_seleCheck(ds, 'BusLexIDMultiUnemClmCntEv', Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_);
		shared dsSeleBusLexIDMultiUnemClmCnt1Y := fn_seleCheck(ds, 'BusLexIDMultiUnemClmCnt1Y', Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_);
		shared dsSeleBusLexIDMultiUnemClmCnt120D := fn_seleCheck(ds, 'BusLexIDMultiUnemClmCnt120D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_);
		shared dsSeleBusLexIDMultiUnemClmCnt90D := fn_seleCheck(ds, 'BusLexIDMultiUnemClmCnt90D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_);
		shared dsSeleBusLexIDMultiUnemClmCnt30D := fn_seleCheck(ds, 'BusLexIDMultiUnemClmCnt30D', Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_);
		
		
		SHARED dsSeleChecks := dsSeleBusUnemClmAcctCurrActiveCnt + dsSeleBusUnemClmAcctFiledCntEv + dsSeleBusUnemClmAcctFiledCnt1Y + dsSeleBusUnemClmAcctFiledCnt120D + dsSeleBusUnemClmAcctFiledCnt90D + dsSeleBusUnemClmAcctFiledCnt30D + 
													 dsSeleBusUnemClmLexIDFiledCntEv + dsSeleBusUnemClmLexIDFiledCnt1Y + dsSeleBusUnemClmLexIDFiledCnt120D + dsSeleBusUnemClmLexIDFiledCnt90D + dsSeleBusUnemClmLexIDFiledCnt30D + 
													 dsSeleBusLexIDMultiUnemClmCntEv + dsSeleBusLexIDMultiUnemClmCnt1Y + dsSeleBusLexIDMultiUnemClmCnt120D + dsSeleBusLexIDMultiUnemClmCnt90D + dsSeleBusLexIDMultiUnemClmCnt30D;
		
							
		EXPORT fn_dateCheck(dsMac, attr_ev, attr_1y, attr_120d, attr_90d, attr_30d, attr_name) := FUNCTIONMACRO	
				// Check that Time to Oldest Claim is shorter or equal to time to newest claim for span variables. 		
				xt1 := TABLE(dsMac, {INTEGER Check := IF(attr_30d <= attr_90d AND attr_90d <= attr_120d AND attr_120d <= attr_1y AND attr_1y <= attr_ev, 1,0)});
				// Return a PASS/FAIL  
				pass_cnt := COUNT(xt1(Check=1));
				fail_cnt := COUNT(xt1(Check=0));
				RETURN ROW({attr_name, pass_cnt, fail_cnt}, {STRING30 attribute_name, INTEGER npass, INTEGER nfail});	
		ENDMACRO;

    SHARED ds_BusAcctUnemClmAcctFiledCnt := fn_dateCheck(ds, Bus_Acct_Unem_Clm_Acct_Filed_Cnt_Ev_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt1_Y_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt120_D_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt90_D_, Bus_Acct_Unem_Clm_Acct_Filed_Cnt30_D_, 'BusAcctUnemClmAcctFiledCnt');
		SHARED ds_BusAcctUnemClmLexIDFiled := fn_dateCheck(ds, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt120_D_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt90_D_, Bus_Acct_Unem_Clm_Lex_I_D_Filed_Cnt30_D_, 'BusAcctUnemClmLexIDFiled');
		SHARED ds_BusAcctLexIDMultiUnemClm := fn_dateCheck(ds, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt120_D_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt90_D_, Bus_Acct_Lex_I_D_Multi_Unem_Clm_Cnt30_D_, 'BusAcctLexIDMultiUnemClm');
	  SHARED ds_BusUnemClmAcctFiledCnt := fn_dateCheck(ds, Bus_Unem_Clm_Acct_Filed_Cnt_Ev_, Bus_Unem_Clm_Acct_Filed_Cnt1_Y_, Bus_Unem_Clm_Acct_Filed_Cnt120_D_, Bus_Unem_Clm_Acct_Filed_Cnt90_D_, Bus_Unem_Clm_Acct_Filed_Cnt30_D_, 'BusUnemClmAcctFiledCnt');
		SHARED ds_BusUnemClmLexIDFiled := fn_dateCheck(ds, Bus_Unem_Clm_Lex_I_D_Filed_Cnt_Ev_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt1_Y_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt120_D_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt90_D_, Bus_Unem_Clm_Lex_I_D_Filed_Cnt30_D_, 'BusUnemClmLexIDFiled');
		SHARED ds_BusLexIDMultiUnemClm := fn_dateCheck(ds, Bus_Lex_I_D_Multi_Unem_Clm_Cnt_Ev_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt1_Y_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt120_D_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt90_D_, Bus_Lex_I_D_Multi_Unem_Clm_Cnt30_D_, 'BusLexIDMultiUnemClm');
	
    SHARED dsDateChecks := ds_BusAcctUnemClmAcctFiledCnt + ds_BusAcctUnemClmLexIDFiled + ds_BusAcctLexIDMultiUnemClm + ds_BusUnemClmAcctFiledCnt + ds_BusUnemClmLexIDFiled + ds_BusLexIDMultiUnemClm;

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
		
		// EXPORT main := ds_BusAcctUnemClmLexIDFiledCntEv + ds_BusAcctUnemClmLexIDFiledCnt1Y + ds_BusAcctUnemClmLexIDFiledCnt120D + ds_BusAcctUnemClmLexIDFiledCnt90D + ds_BusAcctUnemClmLexIDFiledCnt30D;
		// EXPORT main := OUTPUT(dsDateChecks, NAMED('dsDateChecks'));
		EXPORT main := SEQUENTIAL(writeFile(ds_All, 'UnemClaimPt2_AttributesDistribution'),
															writeFile(dsSeleChecks, 'UnemClaimPt2_SelePassFailTests'),
															writeFile(dsDateChecks, 'UnemClaimPt2_DatePassFailTests'));

END;