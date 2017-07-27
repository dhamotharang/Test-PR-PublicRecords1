import AutoKey;

 word_tab := DriversV2.File_uber_word_in;

export Key_DL_UberWords := INDEX(word_tab, {word},{cnt,id,field_specificity},DriversV2.Constants.autokey_qa_Keyname+'UberWords');


