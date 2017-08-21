import codes, mdr,header;

export state_dppa_ok_thor(dataset(recordof(header.layout_header)) in_hdr, string permission) := function

dppa_recs0 := in_hdr( mdr.Source_is_DPPA(src)); 
// Added temporary src field 
temp_rec := record 
in_hdr; 
string2 temp_translateSource; 
end; 
temp_rec  reformat( dppa_recs0 l) := transform 
self.temp_translateSource := header.translateSource(L.src)[1..2];
self := l ; 
end; 

dppa_recs := project(dppa_recs0, reformat(left)); 
not_dppa_recs := in_hdr(~mdr.Source_is_DPPA(src));
codes_file    := codes.File_Codes_V3_In(file_name='GENERAL');

recordof(in_hdr) tran(temp_rec le) := transform
 self := le;
end;

outds := join(dppa_recs,codes_file, 
		  (
		   ((mdr.sourcetools.sourceisexperianvehicle(left.src)=true or mdr.sourcetools.sourceisexperiandl(left.src)=true) and right.field_name='EXPERIAN-DL-PURPOSE')
		   or
		   (mdr.sourcetools.sourceisexperianvehicle(left.src)=false and mdr.sourcetools.sourceisexperiandl(left.src)=false and right.field_name='DL-PURPOSE')
		  )		  
	      and RIGHT.field_name2=left.temp_translateSource
		  and RIGHT.code=permission,
		 tran(LEFT), LEFT ONLY, LOOKUP);
		 

concat := outds + not_dppa_recs;

return concat;

end;