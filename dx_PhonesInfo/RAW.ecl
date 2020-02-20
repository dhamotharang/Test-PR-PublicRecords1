IMPORT Data_Services;

EXPORT RAW := MODULE    
EXPORT GetPhoneType (ds_in) := FUNCTIONMACRO
 
    LOCAL phone_type := JOIN(ds_in , dx_PhonesInfo.Key_Phones_Type,
									KEYED(LEFT.phone = RIGHT.phone),
									TRANSFORM(dx_PhonesInfo.Layouts.Phones_Type_Main, SELF.phone := LEFT.phone; SELF:= RIGHT), 
                                    limit(10000, SKIP));
    RETURN phone_type;                                           
ENDMACRO;  

EXPORT GetPhoneTransactions (ds_in) := FUNCTIONMACRO
    IMPORT MDR;

    LOCAL phone_transactions := JOIN(ds_in , dx_PhonesInfo.Key_Phones_Transaction,
									KEYED(LEFT.phone = RIGHT.phone),								 
									TRANSFORM(dx_PhonesInfo.Layouts.Phones_Transaction_Main, SELF.phone := LEFT.phone; SELF:= RIGHT), 
                                    limit(10000, SKIP));
    RETURN phone_transactions;                                           
ENDMACRO; 

EXPORT GetLerg6Phones (ds_in) := FUNCTIONMACRO
    IMPORT MDR, Phones;
 
    LOCAL Lerg6_phones := JOIN(ds_in, dx_PhonesInfo.Key_Phones_Lerg6, 
										(LEFT.phone[1..3] =RIGHT.npa and left.phone[4..6]=RIGHT.nxx AND
										(left.phone[7]=RIGHT.block_id or RIGHT.block_id = Phones.Constants.PhoneAttributes.DEFAULT_BLOCK_ID)),
		                                TRANSFORM(dx_PhonesInfo.Layouts.lerg6Main, SELF:= RIGHT),
                                        LIMIT(1000, SKIP));
    RETURN Lerg6_phones;                                           
ENDMACRO;

END;