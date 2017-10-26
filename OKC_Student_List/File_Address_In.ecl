import OKC_Student_List;

EXPORT File_Address_In := module

export Using:= dataset(OKC_Student_List.Filenames().input.address.using,OKC_Student_List.Layout_Address_In, 	
																		csv(heading(1), 
																		separator('|'),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));
																		
export Used:= dataset(OKC_Student_List.Filenames().input.address.used,OKC_Student_List.Layout_Address_In, 	
																		csv(heading(1), 
																		separator('|'),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));
																		
end;