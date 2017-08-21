 lkuprec := record
  string20 code_type;
  string8 code;
  string63 code_desc;
  string16 code_alpha;
  string35 code_desc2;
  string1 lf;
end;

EXPORT File_Code_Lookup := dataset('~thor_data::in::insider_trading_code_lookup_new',lkuprec,flat);