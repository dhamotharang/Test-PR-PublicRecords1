IMPORT yellowpages, ut, Cellphone;

EXPORT Mac_clean_phone(infile, outfile) := macro
import data_services;

file_phonetype := dataset(data_services.data_location.prefix('Utility') + 'thor_data400::base::utility_phonetype',utilfile.layout_phonetype, flat);
file_invalid_phonetype := file_phonetype(phonetype = 'INVALID-NPA/NXX/TB');

infile tjoin_phone(infile le, file_invalid_phonetype ri) := transform

self.phone := if(le.phone = ri.phone, '', le.phone);
self := le;
end;

infile_blank_phone := join(infile,file_invalid_phonetype,left.phone = right.phone, tjoin_phone(left,right), lookup, left outer);

infile_blank_phone tjoin_workphone(infile_blank_phone le, file_invalid_phonetype ri) := transform

self.work_phone := if(le.work_phone = ri.phone, '', le.work_phone);
self := le;
end;

outfile := join(infile_blank_phone,file_invalid_phonetype,left.work_phone = right.phone, tjoin_workphone(left,right), lookup, left outer);

endmacro;


