IMPORT $;

prefix := '~';//'~foreign::10.241.3.238:7070::';

File_ADVO := DATASET('', $.Layouts.Layout_Common_Out_k, THOR);

EXPORT Key_Addr1 := INDEX(File_ADVO,
                           {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},{File_ADVO},
                            prefix + 'thor_data400::key::advo::qa::addr_search1');

