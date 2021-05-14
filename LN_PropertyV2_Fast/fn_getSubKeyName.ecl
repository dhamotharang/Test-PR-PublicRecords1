IMPORT LN_PropertyV2_Fast, Data_Services,std;
EXPORT fn_getSubKeyName(STRING sKeyName, STRING sFileDate, STRING sFcra = '') := FUNCTION
  STRING prefix := Data_Services.Data_Location.Prefix('ln_propertyv2') + 'thor_data400::key::ln_propertyv2::';
  RETURN prefix + sFcra + IF(sFileDate != '', '@version@::', '') + sKeyName;
END;