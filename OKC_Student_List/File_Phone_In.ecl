import OKC_Student_List;

EXPORT File_Phone_In := module

export Using:=dataset(OKC_Student_List.Filenames().input.phone.using,OKC_Student_List.Layout_Phone_In, 	
																		csv(heading(1), 
																		separator('|'),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));
																		
export Used:=dataset(OKC_Student_List.Filenames().input.phone.used,OKC_Student_List.Layout_Phone_In, 	
																		csv(heading(1), 
																		separator('|'),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));
																		
end;