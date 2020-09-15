/*
  - Collection of functions and macros for BIPV2 index definition
*/
IMPORT $;
IMPORT tools;

EXPORT Functions := MODULE

  /*
    - Appends @str_infix to key prefix defined in Constants
  */
  SHARED STRING fn_append_key_infix(STRING str_infix) := FUNCTION
    RETURN $.Constants.str_key_prefix + '::' + str_infix + '::';
  END;

  /*
    - Declares keyname module for BIP @str_keyname and @pVersion
  */
  EXPORT /* mod_keyname */ fn_get_mod_keyname(STRING str_keyname, STRING pVersion) := FUNCTION
    RETURN tools.mod_FilenamesBuild(fn_append_key_infix(str_keyname) + '@version@', pVersion);
  END;

   /*
    - Returns a STRING logical superfilename from a @mod_keyname module.
    - Superfile scope follows doxie.Version_SuperKey.
  */
  EXPORT /* STRING */ mac_get_superfilename(mod_keyname) := FUNCTIONMACRO
    IMPORT doxie;

    RETURN '~' + #EXPAND(#TEXT(mod_keyname) + '.' + doxie.Version_SuperKey);
  ENDMACRO;

  EXPORT mac_get_join_condition(str_fields) := FUNCTIONMACRO
    RETURN REGEXREPLACE(',', 
      REGEXREPLACE('([\\w_]+)', str_fields, 'LEFT.$0 = RIGHT.$0'),
      ' AND '
    );
  ENDMACRO;

END;