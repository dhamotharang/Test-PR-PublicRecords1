IMPORT PhoneFraud;

EXPORT BaseSpoofing_In_PhoneFraud := project(PhoneFraud.File_Spoofing.Base,transform(Scrubs_PhoneFraud.BaseSpoofing_Layout_PhoneFraud,Self.id_value:=left.id;self:=left;));