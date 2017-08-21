import _Control, lib_fileservices;

cluster := if(_Control.ThisEnvironment.Name='Dataland','~thor40_241','~thor_data400');

makeSuperFiles(string ks) := SEQUENTIAL(
	if ( NOT fileservices.superfileexists(cluster+'::key::gong_history::fcra::delete::'+ks),
		fileservices.createsuperfile(cluster+'::key::gong_history::fcra::delete::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::gong_history::fcra::father::'+ks),
		fileservices.createsuperfile(cluster+'::key::gong_history::fcra::father::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::gong_history::fcra::grandfather::'+ks),
		fileservices.createsuperfile(cluster+'::key::gong_history::fcra::grandfather::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::gong_history::fcra::qa::'+ks),
		fileservices.createsuperfile(cluster+'::key::gong_history::fcra::qa::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::gong_history::fcra::built::'+ks),
		fileservices.createsuperfile(cluster+'::key::gong_history::fcra::built::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::gong_history::fcra::prod::'+ks),
		fileservices.createsuperfile(cluster+'::key::gong_history::fcra::prod::'+ks))
	);
makeSuperFiles1(string ks) := SEQUENTIAL(
	if ( NOT fileservices.superfileexists(cluster+'::key::business_header::filtered::fcra::delete::'+ks),
		fileservices.createsuperfile(cluster+'::key::business_header::filtered::fcra::delete::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::business_header::filtered::fcra::father::'+ks),
		fileservices.createsuperfile(cluster+'::key::business_header::filtered::fcra::father::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::business_header::filtered::fcra::grandfather::'+ks),
		fileservices.createsuperfile(cluster+'::key::business_header::filtered::fcra::grandfather::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::business_header::filtered::fcra::qa::'+ks),
		fileservices.createsuperfile(cluster+'::key::business_header::filtered::fcra::qa::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::business_header::filtered::fcra::built::'+ks),
		fileservices.createsuperfile(cluster+'::key::business_header::filtered::fcra::built::'+ks)),
	if ( NOT fileservices.superfileexists(cluster+'::key::business_header::filtered::fcra::prod::'+ks),
		fileservices.createsuperfile(cluster+'::key::business_header::filtered::fcra::prod::'+ks))
	);

export proc_create_FCRA_superkeys := SEQUENTIAL(
	makeSuperFiles('address'),
	makeSuperFiles('phone'),
	makeSuperFiles('did'),
	makeSuperFiles('hhid'),
	makeSuperFiles('bdid'),
	makeSuperFiles('name'),
	makeSuperFiles('zip_name'),
	makeSuperFiles('npa_nxx_line'),
	makeSuperFiles('surnames'),
	makeSuperFiles('wdtg'),
	makeSuperFiles('companyname'),
	makeSuperFiles('zip_name'),
	makeSuperFiles1('hri::phone10_v2')
);
