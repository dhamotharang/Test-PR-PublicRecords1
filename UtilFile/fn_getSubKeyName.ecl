IMPORT Data_Services;
//get template filename i.e.'~thor_data400::key::utility::@version@::Member'

EXPORT fn_getSubKeyName(STRING keyname, STRING filedate) := FUNCTION

STRING prefix        :=  Data_Services.Data_Location.Prefix('Utility') + 'thor_data400::key::utility::';

i_daily_sub          := prefix+ IF(filedate != '', '@version@::', '')  + keyname;

RETURN i_daily_sub;

END;