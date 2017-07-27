import codes, risk_indicators, doxie_crs, suppress;
doxie.MAC_Header_Field_Declare()
doxie.mac_selection_declare()

// restoring prior behavior so as not to break ESP layer with multiple 
// elements with the same SSN.
// eventually, the dedup should be reverted to a RECORD dedup
// when ESP is ready to handle it
ssns := dedup(doxie.comp_ssns, ssn9, all);

lhs := doxie_crs.layout_HRI_SSN;

lhs putem(ssns l) := transform
	self.ssn := l.ssn_unmasked;
	self.did := l.did;
	self.hri_ssn := [];
	self.ssn_unmasked := l.ssn_unmasked;
end;

forhri := project(ssns, putem(left));
doxie.mac_addhrissn(forhri, whri, false)

// currently need to filter the new 0150 HRI after the fact
// until ESP is ready to handle DID/SSN pairs in the SSN HRIs in the report
whri cleanHRI(whri L) := TRANSFORM
	SELF.hri_ssn := L.hri_ssn(hri <> '0150');
	SELF := L;
END;

whri_cleaned := PROJECT(whri, cleanHRI(LEFT));
suppress.MAC_Mask(whri_cleaned, out_mskd, ssn, blank, true, false);

export HRI_SSN_records := out_mskd;