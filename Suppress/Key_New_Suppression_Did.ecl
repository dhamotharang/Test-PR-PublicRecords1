IMPORT Data_Services, doxie;

EXPORT Key_New_Suppression_Did(BOOLEAN isFCRA = FALSE) := FUNCTION

    rec             := $.Layout_New_Suppression_Did;
    KeyNamePrefix	:= 'thor_data400::key::suppression::'+IF(isFCRA,'fcra::','');
    KeyNameSuffix   := '::link_type_did';
    key_name        := Data_Services.Data_location.Prefix('NONAMEGIVEN')+ KeyNamePrefix + doxie.Version_SuperKey + KeyNameSuffix;

    RETURN INDEX ({rec.did}, rec, key_name);
END;