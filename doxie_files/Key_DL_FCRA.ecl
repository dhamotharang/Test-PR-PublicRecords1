/* **************** WARNING WARNING WARNING *************** */
/* THIS KEY IS A FAKE FCRA KEY						*/
/* IT POINTS TO NON_FCRA DATA AND *CANNOT* BE USED FOR      */
/* REAL FCRA PURPOSES								*/
/* ******************************************************** */

import doxie_build, doxie;

dl4key := dedup(file_dl(did != 0), did, dl_number, all);

export Key_DL_FCRA := index(dl4key, {unsigned6 s_did := dl4key.did}, {dl4key.dl_number,dl4key.orig_state}, '~thor_data400::key::dl_FCRA_'+doxie_build.buildstate + '_' + doxie.Version_SuperKey);
