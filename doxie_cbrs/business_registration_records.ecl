import BusReg, codes, suppress, doxie, business_header, ut,doxie_cbrs_raw, doxie_cbrs;
doxie_cbrs.MAC_Selection_Declare()

export business_registration_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

//corpcode
//sos_code
//
outk := doxie_cbrs_raw.business_registrations(bdids,Include_BusinessRegistrations_val,Max_BusinessRegistrations_val).records;


outk decodeit(outk l) := transform
	self.corpcode_decode   := Codes.BUSREG_COMPANY.corpcode(l.corpcode);
	self.sos_code_decode   := Codes.BUSREG_COMPANY.sos_code(l.sos_code);
	self.filing_cod_decode := Codes.BUSREG_COMPANY.filing_cod(l.filing_cod);
	self.status_decode	   := codes.BUSREG_COMPANY.status(L.status);
	self.file_date_decode  := doxie_cbrs.get_BizRegDate(l.file_date);
	self.proc_date_decode  := doxie_cbrs.get_BizRegDate(stringlib.StringFilterOut(l.proc_date,'/'));
	self := l;
end;

unmsk := project(outk, decodeit(left));

//doxie_cbrs.mac_mask_ssn(unmsk, msk1, ofc1_ssn)  //got rid of this field

return sort(unmsk,company_name,-record_date);
END;
