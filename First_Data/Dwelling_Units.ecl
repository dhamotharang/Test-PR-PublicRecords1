
dwelling_rec := record
 first_data.map_to_common.house_nbr;
 first_data.map_to_common.predir;
 first_data.map_to_common.str_name;
 first_data.map_to_common.postdir;
 first_data.map_to_common.str_suffix;
 //first_data.map_to_common.unit_type;
 first_data.map_to_common.unit_nbr;
 first_data.map_to_common.zip;
 count_ := count(group);
end;

dwelling_table := table(first_data.Map_To_Common,dwelling_rec,house_nbr,predir,str_name,postdir,str_suffix,unit_nbr,zip,few);

first_data.Layout_FDS populate_dwelling_units(first_data.Layout_FDS l, dwelling_rec r) := transform
 
 boolean has_right_rec := r.count_<>0;
 
 self.dwelling_unit_size := if(has_right_rec,
                             if(r.count_>99,'99',
							 if(r.count_>00,intformat(r.count_,2,1),'01')),
						    l.dwelling_unit_size);
 self                    := l;
end;

export Dwelling_Units := join(first_data.Map_To_Common,dwelling_table,
                              (left.house_nbr=right.house_nbr and left.predir=right.predir and left.str_name=right.str_name and
		                       left.postdir=right.postdir and left.str_suffix=right.str_suffix and left.unit_nbr=right.unit_nbr and
			                   left.zip=right.zip
				              ),
		                      populate_dwelling_units(left,right),
		                      left outer
		                      );