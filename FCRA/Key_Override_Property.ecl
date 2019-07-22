import doxie, ut, ln_propertyv2, data_services;

EXPORT Key_Override_Property := MODULE

// Any record definitions can be exported, if needed
	
	shared fname_prefix := Data_Services.Data_location.Prefix('property_overrides')+'thor_data400::base::override::fcra::qa::';
	shared daily_prefix := Data_Services.Data_location.Prefix('property_overrides')+'thor_data400::base::override::fcra::daily::qa::';
	shared keyname_prefix := Data_Services.Data_location.Prefix('property_overrides')+'thor_data400::key::override::fcra::';
	

// Assessment Record
	shared assessment_override_layout := record
		string20 flag_file_id;
		ln_propertyv2.layout_property_common_model_base;
	end;

	shared ds_assessment := dataset(fname_prefix + 'assessment', assessment_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_assessment := dataset (daily_prefix + 'assessment', assessment_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_assessment, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_assessment,ln_fares_id,replaceds);
  export assessment := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'property_assessment::qa::ffid', OPT);


// Deed Record
	shared deed_override_layout := record
		string20 flag_file_id;
		ln_propertyv2.layout_deed_mortgage_common_model_base;
	end;

	shared ds_deed := dataset (fname_prefix + 'deed', deed_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_deed := dataset (daily_prefix + 'deed', deed_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_deed, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_deed,ln_fares_id,replaceds);
  export deed := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'property_deed::qa::ffid', OPT);



//Search Record
	shared search_override_layout := record
		string20 flag_file_id;
		ln_propertyv2.layout_search_building;
	end;

	shared ds_search := dataset (fname_prefix + 'property_search', search_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
	dailyds_search := dataset (daily_prefix + 'property_search', search_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);
  kf := dedup (sort (ds_search, -flag_file_id), except flag_file_id);
	FCRA.Mac_Replace_Records(kf,dailyds_search,persistent_record_id,replaceds);
  export search := index (replaceds, {flag_file_id}, {replaceds}, keyname_prefix + 'property_search::qa::ffid', OPT);


// Ownership: this is a derivative override based on the main overrides (search, A & D) 
  ds_ownership := FCRA.functions.GetPropertyOwnershipOverrideFile (
                    project (ds_search, ln_propertyv2.layout_search_building),
                    project (ds_assessment, ln_propertyv2.layout_property_common_model_base),
                    project (ds_deed,ln_propertyv2.layout_deed_mortgage_common_model_base));

  export ownership := index (ds_ownership, {did}, {ds_ownership}, keyname_prefix +'property_ownership::qa::did');


END;