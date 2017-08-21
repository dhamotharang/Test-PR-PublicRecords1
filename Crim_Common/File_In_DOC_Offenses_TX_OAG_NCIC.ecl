export File_In_DOC_Offenses_TX_OAG_NCIC := module

export layout := record
string code;
string description;
string statute;
string off_lev;
string degree;
end;

export lkup:= dataset('~thor_data400::in::tx_ncic_codes.csv',layout, csv(separator(','),terminator(['\r\n','\r','\n']),quote('"')));

end;