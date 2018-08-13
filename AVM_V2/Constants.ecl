EXPORT Constants := MODULE
	// DF-21487 following fields will be blanked out in thor_data400::key::avm_v2::fcra::qa::address
	EXPORT fields_to_clear := 'fips_code';
END;