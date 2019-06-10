IMPORT Data_Services;

EXPORT RAW := MODULE    
EXPORT GetPhoneType (ds_in) := FUNCTIONMACRO

    LOCAL phones := PROJECT(ds_in, TRANSFORM({dx_PhonesInfo.Layouts.Phones_Type_Main.phone},
                                    SELF.phone := LEFT.phone)); 
    LOCAL phone_type := JOIN(ds_in , dx_PhonesInfo.Key_Phones_Type,
									KEYED(LEFT.phone = RIGHT.phone),
									TRANSFORM(dx_PhonesInfo.Layouts.Phones_Type_Main, SELF.phone := LEFT.phone; SELF:= RIGHT), 
                                    limit(0), KEEP(500));
    RETURN phone_type;                                           
ENDMACRO;  

EXPORT GetPhoneTransactions (ds_in) := FUNCTIONMACRO
    IMPORT MDR;
    LOCAL phones := PROJECT(ds_in, TRANSFORM({dx_PhonesInfo.Layouts.Phones_Transaction_Main.phone},
                                    SELF.phone := LEFT.phone)); 
    LOCAL phone_transactions := JOIN(ds_in , dx_PhonesInfo.Key_Phones_Transaction,
									KEYED(LEFT.phone = RIGHT.phone) AND 								 
                                    RIGHT.source != MDR.sourceTools.src_PhoneFraud_OTP,// No rules have been defined for this source
									TRANSFORM(dx_PhonesInfo.Layouts.Phones_Transaction_Main, SELF.phone := LEFT.phone; SELF:= RIGHT), 
                                    limit(0), KEEP(500));
    RETURN phone_transactions;                                           
ENDMACRO; 

END;