IMPORT $;

EXPORT key_FirmographicsScore := MODULE

  SHARED mod_keyname := $.Keynames().FirmographicsScore;

  SHARED str_keyname := $.Functions.mac_get_superfilename(mod_keyname);

  EXPORT Key := INDEX(
    // Keyed Fields
    {UNSIGNED6 ultid
    ,UNSIGNED6 orgid
    ,UNSIGNED6 seleid
    },
    // Payload Fields
    {INTEGER  lnrs_modeled_marketing_revenue
    ,STRING2  lnrs_modeled_marketing_revenue_code
    ,INTEGER  lnrs_modeled_marketing_employee_count
    ,STRING2  lnrs_modeled_marketing_employee_count_code
    ,STRING2  lnrs_modeled_marketing_industry
    },
    str_keyname
  );

  /* Fetch interface for Roxie
    - Input BIP ids from @ds_input
  */
  EXPORT kFetch(
    DATASET($.Layouts.layout_kfetch_seleid) ds_input
  ) := FUNCTION
    RETURN JOIN(ds_input, Key, 
      LEFT.ultid = RIGHT.ultid AND LEFT.orgid = RIGHT.orgid AND LEFT.seleid = RIGHT.seleid,
      TRANSFORM(RIGHT),
      KEYED,
      LIMIT($.Constants.fetch_limit)
    );
  END;

  /* Fetch interface for Thor
    - Input BIP ids from @ds_input
  */
  EXPORT kFetch_thor(
    DATASET($.Layouts.layout_kfetch_seleid) ds_input
  ) := FUNCTION
    RETURN JOIN(PULL(Key), ds_input,
      #EXPAND($.Functions.mac_get_join_condition('ultid,orgid,seleid')),
      TRANSFORM(LEFT),
      SMART,
      LIMIT($.Constants.fetch_limit)
    );
  END;
END;