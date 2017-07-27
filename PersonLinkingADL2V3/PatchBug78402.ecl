rec := PersonLinkingADL2V3.Process_xADL2_Layouts.LayoutScoredFetch;

export PatchBug78402(DATASET(rec) in_data) := FUNCTION

	m(f) := macro
		self.f := if(left.f > 65000, 0, left.f)
	endmacro;

	out_data :=
	project(
		in_data,
		transform(
			rec,
			m(Weight),
			m(NAME_SUFFIXWeight),
			m(FNAMEWeight),
			m(MNAMEWeight),
			m(LNAMEWeight),
			m(PRIM_RANGEWeight),
			m(PRIM_NAMEWeight),
			m(SEC_RANGEWeight),
			m(CITYWeight),
			m(STATEWeight),
			m(ZIPWeight),
			m(ZIP4Weight),
			m(COUNTYWeight),
			m(SSN5Weight),
			m(SSN4Weight),
			m(DOBWeight_year),
			m(DOBWeight_month),
			m(DOBWeight_day),
			m(PHONEWeight),
			m(MAINNAMEWeight),
			m(FULLNAMEWeight),
			m(ADDR1Weight),
			m(LOCALEWeight),
			m(ADDRSWeight),
			self := left
		)
	);
	// output(in_data, named('in_data'));
	// output(out_data, named('out_data'));
	
	// return in_data;
	return out_data;
END;