//WARNING: THIS KEY IS AN FCRA KEY...
Import Data_Services, doxie,crimsrch, ut,hygenics_search,Life_EIR;

df:= Life_EIR.File_FCRA_Criminal.Offenders(Vendor not in hygenics_search.sCourt_Vendors_To_Omit and (integer)did != 0);

/*new_rec := record
 CrimSrch.Layout_FCRA_Offender;
 string12	did;
end;

df := project(df_,transform(new_rec,self := left));*/

export Key_Offenders_FCRA := index (df,
                                    {unsigned6 sdid := (integer)df.did},
                                    {df},
                                    Data_Services.Data_location.Prefix('Provider')+'thor_200::key::criminal_offenders::fcra::' + doxie.Version_SuperKey + '::did');
