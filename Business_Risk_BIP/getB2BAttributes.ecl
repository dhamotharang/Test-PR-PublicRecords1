IMPORT Business_Risk_BIP, _Control;

boolean use_library := NOT _Control.LibraryUse.ForceOff_B2B_attributes;

EXPORT getB2BAttributes(
            DATASET(Business_Risk_BIP.layouts.Shell) shell,
            Business_Risk_BIP.LIB_B2B_options options,
            set of string2 AllowedSourcesSet
          ) := FUNCTION

  #IF(use_library)
    attributes := LIBRARY('Business_Risk_BIP.LIB_B2B_attributes', Business_Risk_BIP.LIB_B2B_interface(shell, options, AllowedSourcesSet));
  #ELSE
    attributes := Business_Risk_BIP.LIB_B2B_attributes(shell, options, AllowedSourcesSet);
  #END

  RETURN attributes.Results;

END;
