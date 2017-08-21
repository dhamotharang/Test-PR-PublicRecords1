import scrubs,scrubs_phonefraud,std,ut,tools;

EXPORT fn_RunScrubs(string pVersion, string emailList) := function

return sequential(
scrubs.ScrubsPlus('PhoneFraud','Scrubs_PhoneFraud','Scrubs_PhoneFraud_OTP_Raw','RawOTP',pVersion,emailList,false),
scrubs.ScrubsPlus('PhoneFraud','Scrubs_PhoneFraud','Scrubs_PhoneFraud_OTP_Base','BaseOTP',pVersion,emailList,true),
scrubs.ScrubsPlus('PhoneFraud','Scrubs_PhoneFraud','Scrubs_PhoneFraud_Spoofing_Raw','RawSpoofing',pVersion,emailList,false),
scrubs.ScrubsPlus('PhoneFraud','Scrubs_PhoneFraud','Scrubs_PhoneFraud_Spoofing_Base','BaseSpoofing',pVersion,emailList,true)
);

end;

