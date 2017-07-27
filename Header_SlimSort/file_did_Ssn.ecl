import header;
slim_rec_plus := layout_DID_SSN_Plus;

export file_did_Ssn := dataset('~thor_data400::base::did_ssn_glb' + header_slimsort.version,slim_rec_plus,flat);