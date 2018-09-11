IMPORT bank_routing;

EXPORT Mac_spray_accuity_bank_routing(source_IP,source_path,filedate,file_name,group_name,retval) := MACRO
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(sourceCsvSeparater)
#uniquename(sourceCsvTeminater)
#uniquename(sourceCsvQuote)
#uniquename(trfProject)
#uniquename(recSize)
#uniquename(Create_Superfiles)
#uniquename(CreateSuperFiles)

#workunit('name','Bank Routing Spray');

%sourceCsvSeparater% := '\\,';
%sourceCsvTeminater% := '\\r\\r\\n';
%recSize% := 653;

%spray_main% := FileServices.SprayVariable(Source_IP,source_path + file_name,%recSize%,%sourceCsvSeparater%,%sourceCsvTeminater%,,group_name,bank_routing.thor_cluster + 'in::accuity::rtbaset::'+ filedate,-1,,,true,true,true);

%Create_Superfiles% := sequential(FileServices.CreateSuperFile(bank_routing.thor_cluster + 'in::Accuity::rtbaset::Superfile',false),
 FileServices.CreateSuperFile(bank_routing.thor_cluster + 'in::Accuity::rtbaset::archive',false));
 
%CreateSuperFiles% := if (NOT(FileServices.SuperFileExists(bank_routing.thor_cluster + 'in::Accuity::rtbaset::Superfile')),%Create_Superfiles%);

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
 FileServices.AddSuperFile(bank_routing.thor_cluster + 'in::Accuity::rtbaset::archive', 
  bank_routing.thor_cluster + 'in::Accuity::rtbaset::Superfile',, true),
 FileServices.ClearSuperFile(bank_routing.thor_cluster + 'in::Accuity::rtbaset::Superfile'),
 FileServices.AddSuperFile(bank_routing.thor_cluster + 'in::Accuity::rtbaset::Superfile', 
  bank_routing.thor_cluster + 'in::accuity::rtbaset::'+ filedate), 
 FileServices.FinishSuperFileTransaction());

#uniquename(do_super)
#uniquename(out_super)

%do_super%  := sequential(output('do super ...'),%CreateSuperFiles%, %spray_main%, %super_main%);

retval := sequential(%do_super%);

ENDMACRO;