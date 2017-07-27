import ut, risk_indicators;

//all the standard keys and few files that are involved in keyed joins
business_header_ss.mac_AcceptSK('Q',toQA)

//expose slimsort files to the world
business_header_ss.mac_SS_SF_Move('~thor_data400::BASE::business_header.CompanyName', cn)
business_header_ss.mac_SS_SF_Move('~thor_data400::BASE::business_header.CompanyName_Address', cna)
business_header_ss.mac_SS_SF_Move('~thor_data400::BASE::business_header.CompanyName_FEIN', cnf)
business_header_ss.mac_SS_SF_Move('~thor_data400::BASE::business_header.CompanyName_Phone', cnp)

sss := sequential(
cn,
cna,
cnf,
cnp);

export proc_acceptsk_toqa := sequential(
toQA,
sss);