/*2015-02-10T08:01:16Z (Ayeesha Kayttala)

*/
import doxie, ut ,Data_Services; 
ds := project ( FLAccidents_Ecrash.File_KeybuildV2.out(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3']) , FLAccidents_Ecrash.Layouts.key_slim_layout ); 

tab := table (ds, {ds.jurisdiction_nbr , string8 MaxSent_to_hpcc_date := max(group,ds.date_vendor_last_reported)}, ds.jurisdiction_nbr);

EXPORT Key_eCrashv2_agencyId_sentdate := index ( tab 
                                                ,{jurisdiction_nbr} 
																								,{MaxSent_to_hpcc_date}
																								,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_agencyId_Sentdate_' + doxie.Version_SuperKey);