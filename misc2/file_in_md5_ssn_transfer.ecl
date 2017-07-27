my_layout := record
string32 hval_s;
string2 nl;
end;

export file_in_md5_ssn_transfer := dataset('~thor_data400::in::md5::qa::ssn_transfer',my_layout,flat);
