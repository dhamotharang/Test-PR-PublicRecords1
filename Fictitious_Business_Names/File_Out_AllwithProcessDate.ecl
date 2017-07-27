File_In_All :=  Fictitious_Business_Names.File_In_InfoUSA_DQ458 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ459 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ460 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ461 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ462 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ463 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ464 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ465 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ466 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ467 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ468 + 
								Fictitious_Business_Names.File_In_InfoUSA_DQ469 ;

//####################Add Process Date through Transf####################

Layout_File_In_All := record
string8 Process_Date;

Fictitious_Business_Names.Layout_In_InfoUSA
end;

Layout_File_In_All AddProcessDate(File_In_All L) := Transform
self.Process_Date := '20050630';
self := L;
end;

File_with_Date := Project(File_In_All,AddProcessDate(left));

//########################Process Date Added and File exported###############
export File_Out_AllwithProcessDate := File_with_Date;