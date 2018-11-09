EXPORT key_compromised_dl_eq_pre() := function


    in_file := header.file_compromised_dl_eq_in;
    
    return index(in_file,{in_file},{in_file},'');
       
/*
Ticket / effort name: compromised_dl_eq_2017

Package:              headerNonUpdating
Key:                  thor_data400::key::header::refs::qa:: compromised_dl_eq
Key attribute:        header.key_compromised_dl_eq
Build attribute:      header.key_compromised_dl_eq_pre
Layout attribute:     header.layout_key_compromised_dl_eq := {string128 lname_ssn_fixedrandom_hash}

Header.file_compromised_dl_eq_in

*/

/*

import header,RoxieKeybuild;
filedate:='20180103z';

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(    header.key_compromised_dl_eq_pre()
                                               ,'~thor_data400::key::header::refs::qa:: compromised_dl_eq'
                                               ,'~thor_data400::key::header::refs::'+filedate+':: compromised_dl_eq'
                                               ,bld1);
                                               
bld1;

Dataland test key: W20180103-100450
Prod first key : W20180110-102717

Test output: Header.key_compromised_dl_eq

*/

END;