IMPORT ut,data_services;

Name := sort(nothor(fileservices.superfilecontents(data_services.foreign_logs + 'thor100_21::in::accurint_acclogs_cc')), -name)[1].name;
NameVersion := Name[stringlib.stringfind(Name, '::', 4) + 2 ..stringlib.stringfind(Name, '::', 5) -1];

export STRING version := NameVersion : stored('version');
