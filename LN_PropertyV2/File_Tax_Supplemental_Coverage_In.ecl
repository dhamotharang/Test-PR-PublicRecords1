import LN_PropertyV2;

	dslayout_lookup := record
		string fips_code;
		string st;
		string county;
		string reid_tax_roll_coverage;
	end;

EXPORT File_Tax_Supplemental_Coverage_In := dataset('~thor_data400::in::ln_propertyv2::tax_and_supplemental_coverage', dslayout_lookup, csv(separator('\t'),terminator(['\r\n','\r','\n']),quote('')));