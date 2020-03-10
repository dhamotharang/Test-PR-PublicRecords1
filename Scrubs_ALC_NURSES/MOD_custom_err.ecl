


IMPORT ALC, Scrubs_ALC_NURSES, ut;

EXPORT MOD_custom_err := MODULE




SHARED fn_format_number_with_commas(STRING p) := FUNCTION
  RETURN stringlib.stringreverse(regexreplace('([0-9]{3})(?=[0-9])',stringlib.stringreverse((STRING)(INTEGER) p),'$1,'));
END;

SHARED fn_format_percent (REAL part, REAL whole, UNSIGNED8 decimal_places) := FUNCTION  
  formatted_pct:=(STRING)(ROUND((((REAL)part / (REAL)whole) * 100) , decimal_places)) + '%';
  RETURN formatted_pct;
END;


  EXPORT fn_get_tx_err_pct := FUNCTION

/*
For this to work in testing, make Scrubs_ALC_NURSESIn_ALC_NURSES point to HISTORY superfiles, minding the version number:
*chech for latest version:   *in::alc::202*nurses*
ds_nurses_hist1 := DATASET('~thor_data400::in::alc::20200130::nurses1', ALC.Layouts.Input.Nurses, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
ds_nurses_hist2 := DATASET('~thor_data400::in::alc::20200130::nurses2', ALC.Layouts.Input.Nurses, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
ds_nurses_hist3 := DATASET('~thor_data400::in::alc::20200130::nurses3', ALC.Layouts.Input.Nurses, CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n', '\r\n']), QUOTE('"')));
EXPORT In_ALC_NURSES := ds_nurses_hist1 +
                        ds_nurses_hist2 +
												ds_nurses_hist3;
*/


/*
 the old validation function from ALC.Custom_Scrubs.fn_valid_tx_nurse_license_no 
  can be removed 
EXPORT fn_valid_tx_nurse_license_no(STRING license_no, STRING state) := FUNCTION
	  is_in_tx         := StringLib.StringFind(state, 'TX', 1) > 0;
		starts_with_ap   := license_no[1..2] = 'AP';
		is_proper_length := LENGTH(TRIM(license_no)) = 8;

    RETURN MAP(NOT(is_in_tx) OR NOT(starts_with_ap)             => 0,
		           is_in_tx AND starts_with_ap AND is_proper_length => 0,
							 1);
	END;
*/






    ds_all := (Scrubs_ALC_NURSES.In_ALC_NURSES);  
    ds_tx := ds_all(reg_state = 'TX#');


    rl_TX := RECORD
      STRING120     reg_state;
      STRING20      license_no;
      BOOLEAN       is_not_valid;    
      //BOOLEAN    is_tx_lic_valid_by_regstate;
    END;


    // fn_tx_lic_valid_by_regstate (STRING20 license_no, STRING100 reg_state):= FUNCTION
    //   BOOLEAN check := IF(reg_state = 'TX#' AND license_no[1..2] = 'AP' AND  (NOT ut.ISNUMERIC(TRIM(license_no)[3..8]) OR NOT LENGTH(TRIM(license_no)) = 8), 0,1);
    //   RETURN check;
    // END;



    rl_TX x(ALC.Layouts.Input.Nurses l) := TRANSFORM
      SELF.reg_state := l.reg_state;
      SELF.license_no := l.license_no;
     SELF.is_not_valid := ALC.Custom_Scrubs.fn_valid_tx_nurse_license_no(l.license_no, l.reg_state);
      //SELF.is_tx_lic_valid_by_regstate := fn_tx_lic_valid_by_regstate(l.license_no, l.reg_state);
    END;


    ds_TX_with_valid_check := PROJECT(ds_tx, x(LEFT));
    cnt_all_nurse_records := COUNT(ds_all);
    cnt_all_tx_nurse_licenses := COUNT(ds_TX_with_valid_check);
   
    //cnt_all_tx_nurse_licenses_not_valid := COUNT(ds_TX_with_valid_check (is_not_valid=false));
    //cnt_bad_format_by_regstate := COUNT(ds_TX_with_valid_check (is_not_valid=TRUE));

    ds_bad_format := ds_TX_with_valid_check(is_not_valid=TRUE AND reg_state = 'TX#' AND license_no[1..2] <> 'AP' );
    cnt_bad_format := COUNT(ds_bad_format);

    // OUTPUT(fn_format_number_with_commas((STRING)cnt_all_nurse_records), NAMED('all_nurse_count'));
    // OUTPUT(fn_format_number_with_commas((STRING)cnt_all_tx_nurse_licenses), NAMED('all_texas_nurse_count'));
    // OUTPUT(fn_format_percent(cnt_all_tx_nurse_licenses, cnt_all_nurse_records,2) , NAMED('tx_pct'));
    // OUTPUT(CHOOSEN(ds_TX_with_valid_check(is_not_valid=false AND reg_state = 'TX#' AND license_no[1..2] = 'AP' AND LENGTH(TRIM(license_no)) = 8), 100), NAMED('valid_sample_ap'));
    // OUTPUT(CHOOSEN(ds_TX_with_valid_check(is_not_valid=false AND reg_state = 'TX#' AND license_no[1..2] <> 'AP' ), 100), NAMED('valid_sample_not_ap'));
    // OUTPUT(CHOOSEN(ds_TX_with_valid_check(is_not_valid=true), 100), NAMED('not_valid_sample'));    
    err_pct := (((REAL)cnt_bad_format/ (REAL)cnt_all_nurse_records) *100);

    RETURN err_pct; 
  END;

END;
 





