IMPORT $;

EXPORT keynames(STRING pVersion = WORKUNIT) := MODULE

  EXPORT FirmographicsScore := $.Functions.fn_get_mod_keyname('FirmographicsScore', pVersion);

END;