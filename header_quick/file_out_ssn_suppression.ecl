import ut;
export file_out_ssn_suppression := dataset(/*ut.foreign_prod+*/'~thor_data400::out::ssn_suppression',{string9 ssn,string6 ssn_mask,string15 rc,string2 crlf},flat);