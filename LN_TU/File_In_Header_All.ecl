Layout_In_Header_All ReformatInAddFileDate1(File_In_Header_93 L) := Transform
self.file_date := '199312';
self := L;
end;

in_file_1 := Project(File_In_Header_93,ReformatInAddFileDate1(Left));

//in_first1 := enth(in_file_1,1000000);
Layout_In_Header_All ReformatInAddFileDate2(File_In_Header_96 L) := Transform
self.file_date := '199612';
self := L;
end;

in_file_2 := Project(File_In_Header_96,ReformatInAddFileDate2(Left));
//in_first_2 := choosen(in_file_2,10000);

in_file_2001_all := File_In_Header_2001_part1 + File_In_Header_2001_part2;
//in_file_2001_all := File_In_Header_2001_part2;
Layout_In_Header_All ReformatInAddFileDate3(in_file_2001_all L) := Transform
self.file_date := '200112';
self := L;
end;

in_file_3 := Project(in_file_2001_all,ReformatInAddFileDate3(Left));
//in_first_3 := choosen(in_file_3,10000);


in_files :=in_file_1 + in_file_2 + in_file_3  ; 

export File_In_Header_All := in_files;




