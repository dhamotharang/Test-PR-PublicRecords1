#workunit('name', 'Corporate List Contents of all Input Superfiles');


import corp;

corp_contents  := fileservices.SuperFileContents(corp.Filenames().CorpUpdate);
cont_contents  := fileservices.SuperFileContents(corp.Filenames().ContUpdate);
event_contents := fileservices.SuperFileContents(corp.Filenames().EventUpdate);
supp_contents  := fileservices.SuperFileContents(corp.Filenames().SuppUpdate);

output(corp_contents, named('Corp_Input_Superfile_Contents'));
output(cont_contents, named('Corp_Cont_Input_Superfile_Contents'));
output(event_contents, named('Corp_Event_Input_Superfile_Contents'));
output(supp_contents, named('Corp_Supp_Input_Superfile_Contents'));