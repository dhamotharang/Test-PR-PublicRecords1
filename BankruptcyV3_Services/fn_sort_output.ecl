IMPORT Text_Search;

EXPORT fn_sort_output(
  DATASET({layouts.layout_rollup, Text_Search.Layout_ExternalKey}) ds_in,
  INTEGER1 state_sort,
  INTEGER1 case_sort,
  INTEGER1 fdate_sort,
  INTEGER1 lname_sort,
  INTEGER1 cname_sort) := FUNCTION

  rec_in := RECORDOF(ds_in);

  rec_sort := RECORD (rec_in)
    STRING state_sort_param;
    STRING case_sort_param;
    STRING fdate_sort_param;
    STRING lname_sort_param;
    STRING cname_sort_param;
  END;

  /* project sort params down to case level */
  rec_sort xfm_add_sort_params(rec_in le) := TRANSFORM

    /* debtors already sorted to give preference to Primary in fn_rollup_debtors */
    SELF.case_sort_param := le.case_number; // not necessary, for consistency
    SELF.fdate_sort_param := le.date_filed;
    SELF.state_sort_param := le.debtors[1].addresses[1].st;
    SELF.lname_sort_param := le.debtors[1].names[1].lname;
    /* for company name sort, check for secondary alias since the first alias for cname is often a person's name */
    SELF.cname_sort_param := 
      IF(le.debtors[1].names[1].cname='' AND le.debtors[1].names[2].cname <>'',
        le.debtors[1].names[2].cname, le.debtors[1].names[1].cname);
    SELF := le;
  END;

  /* project to layout with sort params */
  ds_added_params := PROJECT(ds_in, xfm_add_sort_params(LEFT));

  /* sort based on desired sort param (give preference to non-empty fields) */
  ds_sorted_w_params := MAP(
    state_sort = 1 => SORT(ds_added_params, state_sort_param='', state_sort_param),
    case_sort = 1 => SORT(ds_added_params, case_sort_param),
    fdate_sort = 1 => SORT(ds_added_params, fdate_sort_param),
    lname_sort = 1 => SORT(ds_added_params, lname_sort_param='', lname_sort_param),
    cname_sort = 1 => SORT(ds_added_params, cname_sort_param='', cname_sort_param),
    state_sort = -1 => SORT(ds_added_params, state_sort_param='', -state_sort_param),
    case_sort = -1 => SORT(ds_added_params, -case_sort_param),
    fdate_sort = -1 => SORT(ds_added_params, -fdate_sort_param),
    lname_sort = -1 => SORT(ds_added_params, lname_sort_param='', -lname_sort_param),
    cname_sort = -1 => SORT(ds_added_params, cname_sort_param='', -cname_sort_param),
    ds_added_params);
  
  /* project back to original layout */
  ds_rollup_sorted := PROJECT(ds_sorted_w_params, rec_in);
  
  RETURN ds_rollup_sorted;
  
END;
