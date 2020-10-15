IMPORT dx_PhoneFraud;
key := RECORD
    string10 	otp_phone;
END;
EXPORT key_otp :=  index({key}, {dx_PhoneFraud.layouts.OTP_payload}, dx_PhoneFraud.names.otp, opt);
