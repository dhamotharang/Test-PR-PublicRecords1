//WARNING: THIS KEY IS AN FCRA KEY...
import doxie,crimsrch,data_services;

df_ := hygenics_search.File_Moxie_Offender_Dev((integer)did != 0);

	new_rec := record
	 CrimSrch.Layout_FCRA_Offender;
	 string12	did;
	end;

	df := project(df_,transform(new_rec,self := left));

export Key_Offenders_FCRA := index (df,
                                    {unsigned6 sdid := (integer)df.did},
                                    {df},
                                    data_services.data_location.prefix() + 'thor_200::key::criminal_offenders::fcra::' + doxie.Version_SuperKey + '::did');
