//WARNING: THIS KEY IS AN FCRA KEY...
import doxie, doxie_build, FCRA, ut;

dl4key := dedup (Driversv2.file_dl_search (did != 0, ~FCRA.Restricted_DL_Source(source_code)), did, dl_number, all);

export Key_DL_DID_FCRA := index (dl4key,
                             {unsigned6 s_did := dl4key.did},
                             {dl4key.dl_number, dl4key.orig_state}, 
							 '~thor_data400::key::dl2::fcra::'+ doxie.Version_SuperKey +'::dl_did');
							 //'~thor_data400::key::dl2::fcra::dl_did_' + doxie.Version_SuperKey);

