export Files :=
module

	export company_address := dataset(thor_clusters.files + 'base::dnb_data::20061210::company::address', Layouts.out.business_summary, flat);
	export company_mail := dataset(thor_clusters.files + 'base::dnb_data::20061210::company::mailing_address', Layouts.out.business_summary, flat);

	export contacts_address := dataset(thor_clusters.files + 'base::dnb_data::20061210::contacts::address', Layouts.out.business_contacts, flat);
	export contacts_mail := dataset(thor_clusters.files + 'base::dnb_data::20061210::contacts::mailing_address', Layouts.out.business_contacts, flat);

	export crim_offender := dataset(thor_clusters.files + 'base::dnb_data::20061210::crim_offender', Layouts.out.crim_offender, flat);
	export crim_offense := dataset(thor_clusters.files + 'base::dnb_data::20061210::crim_offense', Layouts.out.crim_offense, flat);



end;