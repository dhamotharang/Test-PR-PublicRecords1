IMPORT PhonesFeedback_Services;
EXPORT ReportService_IDs := MODULE
  EXPORT params := INTERFACE(PhonesFeedback_Services.AutoKey_IDs.params)
    EXPORT STRING15 phone_number := '';
    EXPORT STRING12 in_DID:='';
  END;
  EXPORT val(params in_mod) := FUNCTION
    phone_number := DATASET([{in_mod.phone_number, in_mod.in_DID}], PhonesFeedback_Services.Layouts.rec_in_request);
    by_phone_number := IF(in_mod.phone_number != '',PhonesFeedback_Services.Raw.byPhoneNumber(phone_number));
    RETURN by_phone_number;
  END;
END;
