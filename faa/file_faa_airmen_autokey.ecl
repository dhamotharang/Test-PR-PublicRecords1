import faa;

// temp layout created to convert string12 did_out to unsigned6 type and added
// other fields zero/blank for passing into autokey build.

temp_layout_searchFileAirmen := RECORD
	 recordof (faa.layout_airmen_data_out and not source);
	 unsigned6 airmen_id := 0;
	 unsigned1 zero:=0;
	 string1 blank:= '';
	 unsigned6 did_out6 := 0;
	 
END; 
 
temp_layout_searchFileAirmen xform(faa.searchFileAirmen l) := transform

	self.did_out6 := (unsigned6) l.did_out;
	self.airmen_id := l.airmen_id;
	self := l;
END;
  
export file_faa_airmen_autokey := project(faa.searchFileAirmen, xform(left));

