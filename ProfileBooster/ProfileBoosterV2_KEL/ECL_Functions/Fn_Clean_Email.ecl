/*Cleans the input email 
This uses the same functions the data team uses to clean emails at the data layer.
*/
IMPORT email_data;

EXPORT Fn_Clean_Email(STRING email) := FUNCTION
  ClndUsrName := email_data.Fn_Clean_Email_Username(email);
  ClndUserWDomain := email_data.Fn_Clean_Email_Domain(email);

  // output(ClndUsrName);
  // output(ClndUserWDomain);
  ClndEmail := IF(ClndUsrName != '' OR ClndUserWDomain != '', ClndUsrName+'@'+ClndUserWDomain, '');
 RETURN ClndEmail;
END;