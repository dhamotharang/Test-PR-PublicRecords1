export fn_check_one(string input_file, string dest_file_qualifier) := function

import ut,header_services,_control;

super_file 	:= '~thor_data400::in::md5::qa::ssn'+dest_file_qualifier;

my_layout := header_services.Supplemental_Data.layout_in;
header_services.Supplemental_Data.mac_verify(	input_file,my_layout,supp_ds_func1);
in_new := supp_ds_func1();
ds_new := dedup(sort(in_new,record),all);

in_current := dataset(super_file,my_layout,flat);
ds_current := dedup(sort(in_current,record),all);

my_layout to_get_ij(ds_new l, ds_current r) := transform
self.hval_s := l.hval_s;
self.nl :=	l.nl;
end;
ds_ij := join(ds_new,ds_current,left.hval_s=right.hval_s, to_get_ij(left,right),inner);

new_count := count(ds_new);
current_count := count(ds_current);
ij_count := count(ds_ij);

// output(new_count,named('new_count'));
// output(current_count,named('current_count'));
// output(ij_count,named('ij_count'));

compare_result := MAP((new_count = current_count and ij_count=new_count) => '0',
												(ij_count/current_count >= 0.60) => '1',
												'9');
		
stepa := output(compare_result);

do_it := stepa : success(output(compare_result)),failure(output('8'));

return do_it;

end;