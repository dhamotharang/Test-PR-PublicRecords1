


IMPORT ALC, Scrubs_ALC_NURSES;

EXPORT MOD_custom_err := MODULE

  EXPORT fn_get_tx_err_pct := FUNCTION
    ds_all := (Scrubs_ALC_NURSES.In_ALC_NURSES);
    ds_tx := ds_all(state = 'TX');

    rl_TX := RECORD
      STRING2    state;
      STRING20   license_no;
      BOOLEAN    is_not_valid;
      BOOLEAN    is_tx_lic_really_valid;
    END;

    fn_tx_lic_really_valid (STRING20 license_no, STRING2 state):= FUNCTION
      BOOLEAN check := IF(state = 'TX' AND license_no[1..2] = 'AP' AND LENGTH(TRIM(license_no)) = 8, 1,0);
      RETURN check;
    END;

    rl_TX x(ALC.Layouts.Input.Nurses l) := TRANSFORM
      SELF.state := l.state;
      SELF.license_no := l.license_no;
      SELF.is_not_valid := ALC.Custom_Scrubs.fn_valid_tx_nurse_license_no(l.license_no, l.state);
      SELF.is_tx_lic_really_valid := fn_tx_lic_really_valid(l.license_no, l.state);
    END;

    ds_TX_with_valid_check := PROJECT(ds_tx, x(LEFT));
    cnt_all_tx_nurse_licenses := COUNT(ds_TX_with_valid_check);
    cnt_all_tx_nurse_licenses_not_valid := COUNT(ds_TX_with_valid_check (is_not_valid=false));
    diff := cnt_all_tx_nurse_licenses - cnt_all_tx_nurse_licenses_not_valid;
    err_pct :=  100 - (cnt_all_tx_nurse_licenses_not_valid / cnt_all_tx_nurse_licenses  ) * 100;

    RETURN err_pct; 
  END;

END;
 