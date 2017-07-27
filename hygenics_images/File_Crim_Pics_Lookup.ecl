import ut, okc_sexual_offenders;
 
ds := dataset(ut.foreign_prod+'~thor_200::in::hd_crim_off::lookup::superfile', hygenics_images.Layout_Crim_Pics_Lookup, csv(separator('/'),terminator(['\r\n','\r','\n']),quote('"')));
 
 OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup fixState(ds l):= transform
	 self.state_of_origin := if(trim(l.column_1, left, right)<>'',
									trim(l.column_1, left, right)[1..2],
									''); //need to populate only the state
	 self.image_file_name := if(regexfind('.JPG|.JPEG|.GIF', trim(l.column_3, left, right), 0)<>'',
									trim(l.column_3, left, right),
								if(regexfind('.JPG|.JPEG|.GIF', trim(l.column_2, left, right), 0)<>'',
									trim(l.column_2, left, right),
									''));
	 self := l;
 end;
 
ds_project := project(ds,fixState(left)):persist('~thor_200::persist::hd_crim_off::lookup::test');
 
export File_Crim_Pics_Lookup := ds_project;