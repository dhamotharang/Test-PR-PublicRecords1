#WORKUNIT('name','Utility SSN correction Build');

import utilfile,data_services;

export CSD_header_cleanup_SSN(string filedate) := function
//new SSN correction probvided by EQ
SSN_correction_in := utilfile.file_SSN_correction_in.raw_20160520;
correction_util_dedup := dedup(sort(distribute(SSN_correction_in(reference_num <> '' and ssn <> ''), hash(reference_num,ssn)), reference_num, ssn, local), reference_num, ssn, local);
//split base file to new and old format and suppression SSN separately.
//util_base := utilfile.file_util.full_base;
util_base := dataset(data_services.foreign_prod +'thor_data400::base::utility_file', UtilFile.layout_util.base, flat);

util_base_has_SSN := util_base((unsigned)ssn <> 0);
util_base_has_no_SSN := util_base((unsigned)ssn = 0);

temp_rec := record

UtilFile.layout_util.base;
string10 new_exchange_serial_number := '';
string9 new_ssn := '';

end;

util_base_old := project(util_base_has_SSN(~regexfind('[0-9]+', util_type)), temp_rec);
util_base_new := project(util_base_has_SSN(regexfind('[0-9]+', util_type)), temp_rec);


util_base_old_dist := distribute(util_base_old, hash(exchange_serial_number));

lookupfile := dedup(sort(distribute(utilfile.file_utility_nctue_in.lookupfile,hash(digit_old_ref_nbr)), digit_old_ref_nbr,digit_new_ref_nbr, local), digit_old_ref_nbr,digit_new_ref_nbr, local);

temp_rec tjoin1(util_base_old_dist le, lookupfile ri) := transform

self.new_exchange_serial_number := if(le.exchange_serial_number = ri.digit_old_ref_nbr, ri.digit_new_ref_nbr, '');

self := le;

end;

old_append_new_num := join(util_base_old_dist,lookupfile, left.exchange_serial_number = right.digit_old_ref_nbr,tjoin1(left,right), left outer, local);

old_append_new_num tjoin(old_append_new_num le, correction_util_dedup ri) := transform

self.new_ssn := if(le.new_exchange_serial_number = ri.reference_num and le.ssn = ri.ssn, '', le.ssn);
self := le;

end;

old_util_base_match := join(old_append_new_num, correction_util_dedup, left.new_exchange_serial_number = right.reference_num and left.ssn = right.ssn, tjoin(left,right), left outer, lookup);

old_1 := output(count(util_base_old), named('count_util_old_has_ssn_before_correction'));
old_2 := output(count(old_util_base_match), named('count_util_old_has_ssn_after_correction'));
old_3 := output(count(old_util_base_match(new_exchange_serial_number <> '' and new_ssn = '')),named('count_util_old_ssn_correction'));

util_base_new tjoin_new(util_base_new le, correction_util_dedup ri) := transform

self.new_exchange_serial_number := if(le.exchange_serial_number = ri.reference_num and le.ssn = ri.ssn, ri.reference_num, '');
self.new_ssn := if(le.exchange_serial_number = ri.reference_num and le.ssn = ri.ssn, '', le.ssn);
self := le;

end;

new_util_base_match := join(util_base_new, correction_util_dedup, left.exchange_serial_number = right.reference_num and left.ssn = right.ssn, tjoin_new(left,right), left outer, lookup);

new_1 := output(count(util_base_new), named('count_util_new_has_ssn_before_correction'));
new_2 := output(count(new_util_base_match), named('count_util_new_has_ssn_after_correction'));
new_3 := output(count(new_util_base_match(new_exchange_serial_number <> '' and new_ssn = '')),named('count_util_new_ssn_correction')); 

comb_all := project(new_util_base_match + old_util_base_match,
transform(UtilFile.layout_util.base, self.ssn := if(left.new_exchange_serial_number <> '' and left.new_ssn = '', '', left.ssn), self := left));

all_1 := output(count(comb_all(ssn = '')),named('count_util_ssn_correction_after_transfer_base'));
all_2 := output(count(util_base_has_SSN), named('total_count_util_base_has_SSN_before_cleanup'));
all_3 := output(count((comb_all +  util_base_has_no_SSN)((unsigned)ssn <> 0)), named('total_count_util_base_has_SSN_after_cleanup'));
//generate SSN suppression file for header patch
comb_ssn_correction_for_header := project((new_util_base_match + old_util_base_match)(new_exchange_serial_number <> '' and new_ssn = '' and ssn != ''),
transform(UtilFile.layout_util.base, self := left));

ssn_correction_for_header := output(comb_ssn_correction_for_header,, '~thor_data400::out::util_base_correction_SSN_' + filedate, overwrite,__compressed__);
//generate the new base file with correction SSN blank out. 
total_cnt := output(count(util_base), named('total_count_util_base'));
ssn_correction_for_util := output(comb_all +  util_base_has_no_SSN,, '~thor_data400::base::utility_correction_SSN_' + filedate, overwrite,__compressed__);

//move files 
move_super := sequential(fileservices.AddSuperFile('~thor_data400::base::utility_file_no_SSN_correction_' + filedate ,'~thor_data400::base::utility_file',,true);
fileservices.AddSuperFile('~thor_data400::base::utility_file' ,'~thor_data400::base::utility_correction_SSN_' + filedate);
fileservices.promotesuperfilelist(['~thor_data400::base::utility_file_SSN_correction', 
																						 '~thor_data400::base::utility_file_SSN_correction_father'],
																						 '~thor_data400::out::util_base_correction_SSN_' + filedate,true));

return sequential(old_1, old_2, old_3,new_1,new_2,new_3, all_1, all_2, all_3, ssn_correction_for_header, total_cnt, ssn_correction_for_util);

end;





