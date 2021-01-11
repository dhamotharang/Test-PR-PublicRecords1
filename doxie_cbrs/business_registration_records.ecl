IMPORT codes, doxie_cbrs_raw, doxie_cbrs, STD;
doxie_cbrs.MAC_Selection_Declare()

EXPORT business_registration_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

//corpcode
//sos_code
//
outk := doxie_cbrs_raw.business_registrations(bdids,Include_BusinessRegistrations_val,Max_BusinessRegistrations_val).records;


outk decodeit(outk l) := TRANSFORM
  SELF.corpcode_decode := Codes.BUSREG_COMPANY.corpcode(l.corpcode);
  SELF.sos_code_decode := Codes.BUSREG_COMPANY.sos_code(l.sos_code);
  SELF.filing_cod_decode := Codes.BUSREG_COMPANY.filing_cod(l.filing_cod);
  SELF.status_decode := codes.BUSREG_COMPANY.status(L.status);
  SELF.file_date_decode := doxie_cbrs.get_BizRegDate(l.file_date);
  SELF.proc_date_decode := doxie_cbrs.get_BizRegDate(STD.STR.FilterOut(l.proc_date,'/'));
  SELF := l;
END;

unmsk := PROJECT(outk, decodeit(LEFT));

//doxie_cbrs.mac_mask_ssn(unmsk, msk1, ofc1_ssn) //got rid of this field

RETURN SORT(unmsk,company_name,-record_date);
END;
