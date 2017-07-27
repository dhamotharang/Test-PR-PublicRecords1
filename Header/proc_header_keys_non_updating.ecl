import RoxieKeybuild , header , ut; 
export proc_header_keys_non_updating(string filedate) := function 

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_Phonetic_equivs_fname, '~thor_data400::hdr_phonetic_fname_top10','~thor_data400::key::header::'+filedate+'::phonetic_fname_top10',fname_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_phonetic_fname_top10','~thor_data400::key::header::'+filedate+'::phonetic_fname_top10',mv_fname);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_Phonetic_equivs_lname, '~thor_data400::hdr_phonetic_lname_top10','~thor_data400::key::header::'+filedate+'::phonetic_lname_top10',lname_blg);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_phonetic_lname_top10','~thor_data400::key::header::'+filedate+'::phonetic_lname_top10',mv_lname);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_fname_ngram, '~thor_data400::key::hdr_fname_ngram','~thor_data400::key::header::'+filedate+'::fname_ngram',fname_ngram);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_fname_ngram','~thor_data400::key::header::'+filedate+'::fname_ngram',mv_fname_ngram);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Header.key_lname_ngram, '~thor_data400::hdr_lname_ngram','~thor_data400::key::header::'+filedate+'::lname_ngram',lname_ngram);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hdr_lname_ngram','~thor_data400::key::header::'+filedate+'::lname_ngram',mv_lname_ngram);

// move to qa 
ut.MAC_SK_Move_v2('~thor_data400::key::hdr_phonetic_fname_top10','Q',out1) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::hdr_phonetic_lname_top10','Q',out2) ; 

ut.MAC_SK_Move_v2('~thor_data400::key::hdr_fname_ngram','Q',out3) ; 
ut.MAC_SK_Move_v2('~thor_data400::key::hdr_lname_ngram','Q',out4) ; 


return sequential( fname_blg, lname_blg,fname_ngram,lname_ngram, mv_fname, mv_lname,mv_fname_ngram,mv_lname_ngram,out1, out2,out3,out4); 

end; 