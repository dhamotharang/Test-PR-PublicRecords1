bh := Business_Header.File_Business_Header;
bc := business_header.File_Business_Contacts;

address.MAC_Append_FipsCounty(bh		// Input File
							,zip		// Zip5 field in input file
							,true
							,county	// Fips county field in input file(to fix)
							,bh_fixed	// Output file with fixed county code
							);

address.MAC_Append_FipsCounty(bc		// Input File
							,zip		// Zip5 field in input file
							,true
							,county	// Fips county field in input file(to fix)
							,bc_fixed	// Output file with fixed county code
							);
nondigitregex := '[^[:digit:]]';


sequential(
 output(count(bh(regexfind(nondigitregex, county) = false)), named('BHGoodCountiesBeforeFix'))
,output(count(bc(regexfind(nondigitregex, county) = false)), named('BCGoodCountiesBeforeFix'))
,output(count(bh(regexfind(nondigitregex, county))), named('BHBadCountiesBeforeFix'))
,output(count(bc(regexfind(nondigitregex, county))), named('BCBadCountiesBeforeFix'))

,parallel(
	output(bc_fixed,,'~thor_data400::base::business_header::20060814c::contacts', overwrite),
	output(bh_fixed,,'~thor_data400::base::business_header::20060814c::search', overwrite)
),

	VersionControl.mutilities.clear_add('~thor_data400::base::business_header'				,	'~thor_data400::base::business_header::20060814c::search'),
	VersionControl.mutilities.clear_add('~thor_data400::base::business_header_grandfather'	,	'~thor_data400::base::business_header_father'),
	VersionControl.mutilities.clear_add('~thor_data400::base::business_header_father'		,	'~thor_data400::base::business_header_qa'),
	VersionControl.mutilities.clear_add('~thor_data400::base::business_header_qa'			,	'~thor_data400::base::business_header::20060814c::search'),

	VersionControl.mutilities.clear_add('~thor_data400::base::business_contacts'			,	'~thor_data400::base::business_header::20060814c::contacts'),
	VersionControl.mutilities.clear_add('~thor_data400::base::business_contacts_grandfather',	'~thor_data400::base::business_contacts_father'),
	VersionControl.mutilities.clear_add('~thor_data400::base::business_contacts_father'		,	'~thor_data400::base::business_contacts_qa'),
	VersionControl.mutilities.clear_add('~thor_data400::base::business_contacts_qa'			,	'~thor_data400::base::business_header::20060814c::contacts'),
	 output(count(bh(regexfind(nondigitregex, county) = false)), named('BHGoodCountiesAfterFix'))
	,output(count(bc(regexfind(nondigitregex, county) = false)), named('BCGoodCountiesAfterFix'))
	,output(count(bh(regexfind(nondigitregex, county))), named('BHBadCountiesAfterFix'))
	,output(count(bc(regexfind(nondigitregex, county))), named('BCBadCountiesAfterFix'))

);