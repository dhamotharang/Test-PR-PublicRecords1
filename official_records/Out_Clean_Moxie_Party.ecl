InputFile := dataset('~thor_200::in::official_records_party_'+official_records.Version_Development,official_records.Layout_Moxie_Party,thor) ;

Clean_File := InputFile(regexfind(',',cname1) = true and ~regexfind('&',cname1) = true);


export Out_Clean_Moxie_Party := if(count(Clean_File) > 1,official_records.Clean_n_valid_name,output('do nothing'));


