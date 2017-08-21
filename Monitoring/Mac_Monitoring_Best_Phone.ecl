//need to handle the number of records to return
export mac_monitoring_best_phone(in_f, out_f) := macro

//phone score logic borrowed from business best phone, with minor modification
#uniquename(phone_score)
unsigned1 %phone_score%(string10 ph) := 
  	   IF(ph[9..10] = '00', 3, 0) +
	   IF(ph[8..10] = '000', 5, 0) +
	   IF(ph[1..3] IN ['800','811','822','833','844','855','866','877','888'], 2, 0);

#uniquename(with_area_code)
unsigned1 %with_area_code%(string10 ph) := IF((unsigned)ph<10000000, 0, 1);

#uniquename(phone_type_score)
unsigned1 %phone_type_score%(string3 ph_type) := 
  	   map(ph_type = 'TA' => 1,
		  ph_type = 'TB' => 2,
	       ph_type = 'TC' => 3,
		  ph_type = 'TD' => 4,
		  ph_type = 'TG' => 5,
		  6);
		  
#uniquename(f_in_dist)
%f_in_dist% := distribute(in_f, hash(customer_id, record_id));		  
		  
//sort & dedup to remove duplicates
#uniquename(f_srt)
%f_srt% := sort(%f_in_dist%, customer_id, record_id,
                phone10, name_last, name_first, prim_range, prim_name, z5, %phone_type_score%(phone_type), -sec_range,
	  	      -phone_dt_last_seen, -phone_dt_first_seen, local);
			    
#uniquename(f_dep)
%f_dep% := dedup(%f_srt%, customer_id, record_id, 
                 phone10, name_last, name_first, prim_range, prim_name, z5, local);			    

//best logic - number with area code, reliable match, reliable number, dt_seen	   
#uniquename(f_grp)
%f_grp% := group(sort(%f_dep%, customer_id, record_id, 
                      -%with_area_code%(phone10),
			       %phone_type_score%(phone_type), 
			       %phone_score%(phone10),
			       -phone_dt_last_seen, -phone_dt_first_seen,
			       phone10, local), customer_id, record_id, local);

//keep the top phones only
#uniquename(layout_in_exp)
%layout_in_exp% := record
	in_f;
	boolean keep_these;
end;

#uniquename(get_top_best)
%layout_in_exp% %get_top_best%(%f_grp% l, unsigned cnt) := transform
   self.keep_these := if(cnt>l.best_phone_number, false, true);  
   self.best_phone_count := cnt;
   self := l;
end;

#uniquename(f_flt)
%f_flt% := project(%f_grp%,%get_top_best%(left, counter))(keep_these);
out_f := project(group(%f_flt%), transform({in_f}, self:=left));

endmacro;