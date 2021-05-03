IMPORT dx_PhoneFraud;
key := RECORD
    string10 phone;
END;
EXPORT key_spoofing :=  index({key}, {dx_PhoneFraud.layouts.spoofing_payload}, dx_PhoneFraud.names.spoofing, opt);
