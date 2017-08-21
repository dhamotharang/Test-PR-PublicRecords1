IMPORT PhoneFraud;

EXPORT RawSpoofing_In_PhoneFraud := project(PhoneFraud.File_Spoofing.Raw,transform(Scrubs_PhoneFraud.RawSpoofing_Layout_PhoneFraud,Self.id_value:=left.id;self:=left;));