IMPORT $;

prefix := '~';//'~foreign::10.241.3.238:7070::';

File_RawACE := DATASET('', $.Layouts.rRawACE, THOR);

EXPORT Key_RawACE := INDEX(File_RawACE,{Line1, LineLast},{File_RawACE},
       prefix + 'thor_data400::key::address_clean::clean_qa');

			