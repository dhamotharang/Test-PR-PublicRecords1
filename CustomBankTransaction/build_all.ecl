import ut, CustomBankTransaction;

EXPORT build_all(string filedate) := function

b_base := CustomBankTransaction.build_base;

b_keys := CustomBankTransaction.build_keys(filedate);

mv_qa := CustomBankTransaction.proc_acceptSK_toQA;

build_base_keys := sequential(b_base, b_keys, mv_qa);


return build_base_keys;

end;