// These two counts should be equal
// DIDs can be duplicate in the email data - but DID+email should be unique

DS1 := PRTE2_Email_Data_Ins.Files.Email_Base_DS;
OUTPUT(COUNT(DS1));

DS3 := DEDUP(SORT(DS1,did,clean_email),did,clean_email);
OUTPUT(COUNT(DS3));

