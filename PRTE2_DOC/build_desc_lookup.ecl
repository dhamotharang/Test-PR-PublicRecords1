import hygenics_crim;

EXPORT build_desc_lookup := FUNCTION

x_arr_off_type_1:=project(files.dcrim(data_type='1' and arr_off_desc_1 !=''),
  Transform(layouts.combined_desc_lookup_layout,
  self.off_desc := trim(left.arr_off_desc_1);  
	Self:=Left;
 ));

	x_arr_off:=project(files.dcrim(data_type='5' and arr_off_desc_1 !=''),
  Transform(layouts.combined_desc_lookup_layout,
  self.off_desc := trim(left.arr_off_desc_1);  
	Self:=Left;
 ));
	
  x_court_off:=project(files.dcrim(data_type='2' and court_off_desc_1 !='') ,
	Transform(layouts.combined_desc_lookup_layout,
	self.off_desc:=trim(left.court_off_desc_1);
	self:=left;
	));
	
	x_off_2:=project(files.doffense (off_desc_1 !=''),
	Transform(layouts.combined_desc_lookup_layout,
	self.off_desc:=trim(left.off_desc_1);
	self.data_type:= 'X';
	self:=left;
	));
	
	x_off := x_arr_off + x_arr_off_type_1 + x_court_off + x_off_2;
	
	x_off_final:=dedup(sort(distribute(x_off,hash(off_desc,offense_category)),record, local,skew(1.0)));
	

Buildlookup:= output(x_off_final,,constants.lookup_category_file,overwrite);

return sequential(Buildlookup);
		
		
END;	
	
	
	
	
	