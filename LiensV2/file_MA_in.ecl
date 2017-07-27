export file_MA_in := module

export ChildSupport := dataset('~thor_data400::in::liensv2::ma::childsupportlien', liensv2.layout_MA_in.childsupport, csv(terminator('\n'), separator(','), quote('"')));

export welflien := dataset('~thor_data400::in::liensv2::ma::welflien', liensv2.layout_MA_in.welflien, csv(terminator('\n'), separator(','), quote('"')));

export Writ := dataset('~thor_data400::in::liensv2::ma::writs', liensv2.layout_MA_in.writ, csv(terminator('\n'), separator(','), quote('"')));

export WritName := dataset('~thor_data400::in::liensv2::ma::writsname', liensv2.layout_MA_in.writname, csv(terminator('\n'), separator(','), quote('"')));

export WritType := dataset([{'A','ASSIGN FOR LIST OF CREDITORS'},
						{'C','LIST OF CREDITORS'},
						{'W','WRIT OF ATTACHMENT'},
						{'B','BULK TRANSFER'},
						{'M','MISCELLANEOUS'}],liensv2.layout_MA_in.writtype);
end;