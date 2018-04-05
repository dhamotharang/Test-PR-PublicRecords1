import OKC_Student_List;

EXPORT File_Student_In := module

export Using:= dataset(OKC_Student_List.Filenames().input.student.using,OKC_Student_List.Layout_Student_In, 	
																		csv(heading(1), 
																		separator('|'),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));
																		
export Used:= dataset(OKC_Student_List.Filenames().input.student.used,OKC_Student_List.Layout_Student_In, 	
																		csv(heading(1), 
																		separator('|'),
																		quote('"'),
																		terminator(['\r\n','\r','\n'])));
end;