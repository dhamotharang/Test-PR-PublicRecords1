//Raw real estate license files from Arizona Department of Real Estate Commission


export files_ALS0812 := MODULE

// AL Real Estate Company and Personnel file
	export real_estate_company := DATASET('~thor_data400::in::proflic_mari::als0812::using::company_personel',Prof_License_Mari.layout_ALS0812.Comp_Personnel_src,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));
// AL Real Estate Active and Inactive Agents file
  export real_estate_agents := DATASET('~thor_data400::in::proflic_mari::als0812::using::real_estate_licensee',Prof_License_Mari.layout_ALS0812.Agents_src,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')));

END;