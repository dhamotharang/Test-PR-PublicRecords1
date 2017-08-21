import ut,fraudpoint3, AID;

export file := module

EXPORT in_20131001 := dataset(ut.foreign_prod + 'thor_data400::in::lexis_fraud_20131001', fraudpoint3.layout.tiger_direct, csv(heading(1), quote('"'), separator(','), terminator(['\r\n', '\n'])), opt); 
EXPORT in_20131101 := dataset(ut.foreign_prod + 'thor_data400::in::lexis_fraud_20131101', fraudpoint3.layout.tiger_direct, csv(heading(1), quote('"'), separator(','), terminator(['\r\n', '\n'])), opt); 
export in_20141029 := dataset('~thor_data::in::credit_fraud_cfd_21041029', fraudpoint3.layout.credit_fraud, csv(heading(1), quote('"'), separator(','), terminator(['\r\n', '\n'])), opt); 

end;