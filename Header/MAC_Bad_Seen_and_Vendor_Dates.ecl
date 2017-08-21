export MAC_Bad_Seen_and_Vendor_Dates(infile, outfile) := macro

#uniquename(seen_and_vendor_date_fix)
typeof(infile) %seen_and_vendor_date_fix%(infile l) := transform

 unsigned3 v_fs := header.ConvertYYYYMMToNumberOfMonths(l.dt_first_seen);
 unsigned3 v_ls := header.ConvertYYYYMMToNumberOfMonths(l.dt_last_seen);
 unsigned3 v_vf := header.ConvertYYYYMMToNumberOfMonths(l.dt_vendor_first_reported);
 unsigned3 v_vl := header.ConvertYYYYMMToNumberOfMonths(l.dt_vendor_last_reported);
 
 unsigned3 v_gd := header.ConvertYYYYMMToNumberOfMonths((integer)ut.GetDate);
 
 //Dates 1 month in the future are acceptable
 unsigned3 v_dt_first_seen            := if((l.dt_first_seen            between 1 and 189999) or v_fs>v_gd+1, 0, l.dt_first_seen);
 unsigned3 v_dt_last_seen             := if((l.dt_last_seen             between 1 and 189999) or v_ls>v_gd+1, 0, l.dt_last_seen);
 unsigned3 v_dt_vendor_first_reported := if((l.dt_vendor_first_reported between 1 and 189999) or v_vf>v_gd+1, 0, l.dt_vendor_first_reported);
 unsigned3 v_dt_vendor_last_reported  := if((l.dt_vendor_last_reported  between 1 and 189999) or v_vl>v_gd+1, 0, l.dt_vendor_last_reported);
 
 //If 0 set to the other date
 unsigned3 v_dt_first_seen2            := if(v_dt_first_seen            = 0,v_dt_last_seen,             v_dt_first_seen            ); 
 unsigned3 v_dt_last_seen2             := if(v_dt_last_seen             = 0,v_dt_first_seen,            v_dt_last_seen             );
 unsigned3 v_dt_vendor_first_reported2 := if(v_dt_vendor_first_reported = 0,v_dt_vendor_last_reported,  v_dt_vendor_first_reported );
 unsigned3 v_dt_vendor_last_reported2  := if(v_dt_vendor_last_reported  = 0,v_dt_vendor_first_reported, v_dt_vendor_last_reported  );
 
 self.dt_first_seen            := if(v_dt_first_seen2            < v_dt_last_seen2,             v_dt_first_seen2,            v_dt_last_seen2);
 self.dt_last_seen             := if(v_dt_last_seen2             > v_dt_first_seen2,            v_dt_last_seen2,             v_dt_first_seen2);
 self.dt_vendor_first_reported := if(v_dt_vendor_first_reported2 < v_dt_vendor_last_reported2,  v_dt_vendor_first_reported2, v_dt_vendor_last_reported2);
 self.dt_vendor_last_reported  := if(v_dt_vendor_last_reported2  > v_dt_vendor_first_reported2, v_dt_vendor_last_reported2,  v_dt_vendor_first_reported2);
 self                          := l;

end;

outfile := project(infile, %seen_and_vendor_date_fix%(left));

endmacro;