//WARNING: THIS KEY IS AN FCRA KEY...
import doxie, doxie_build, FCRA;

dl4key := dedup (file_dl (did != 0, ~FCRA.Restricted_DL_Source(source_code)), did, dl_number, all);

export Key_DL_DID_FCRA := index (dl4key,
                             {unsigned6 s_did := dl4key.did},
                             {dl4key.dl_number, dl4key.orig_state}, 
														 '~thor_data400::key::dl::fcra::dl_did_' + doxie.Version_SuperKey);
