IMPORT $;

EXPORT key_Locid := MODULE

  SHARED mod_keyname := $.Keynames().Locid;

  SHARED str_keyname := $.Functions.mac_get_superfilename(mod_keyname);

  EXPORT Key := INDEX(
    // Keyed Fields
    {UNSIGNED6 locid
    },
    // Payload Fields
    {UNSIGNED6 ultid
    ,UNSIGNED6 orgid
    ,UNSIGNED6 seleid
    ,UNSIGNED6 proxid
    ,UNSIGNED4 dt_first_seen
    ,UNSIGNED4 dt_last_seen
    },
    str_keyname
  );

  /* Fetch interface for Roxie
    - Input BIP ids from @ds_input
  */
  EXPORT kFetch(
    DATASET($.Layouts.layout_kfetch_locid) ds_input
  ) := FUNCTION
    RETURN JOIN(ds_input, Key, 
      #EXPAND($.Functions.mac_get_join_condition('locid')),
      TRANSFORM(RIGHT),
      KEYED,
      LIMIT($.Constants.fetch_limit)
    );
  END;

  /* Fetch interface for Thor
    - Input BIP ids from @ds_input
  */
  EXPORT kFetch_thor(
    DATASET($.Layouts.layout_kfetch_locid) ds_input
  ) := FUNCTION
    RETURN JOIN(PULL(Key), ds_input,
      #EXPAND($.Functions.mac_get_join_condition('locid')),
      TRANSFORM(LEFT),
      SMART,
      LIMIT($.Constants.fetch_limit)
    );
  END;
END;