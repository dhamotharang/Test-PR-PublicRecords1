import ut;

numrec := record
	layout_sc1osd1i;
	string3	prodnum;
end;

numrec into_num(layout_sc1osd1i L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed27, into_num(LEFT, '001')) +
	 project(file_seed28, into_num(LEFT, '004')) +
	 project(file_seed29, into_num(LEFT, '005')) +
	 project(file_seed30, into_num(LEFT, '011')) +
	 project(file_Seed31, into_num(LEFT, '012')) +
	 project(file_seed32, into_num(LEFT, '013')) +
	 project(file_seed33, into_num(LEFT, '014')) + 
	 project(file_seed34, into_num(LEFT, '015')) +
	 project(file_seed35, into_num(LEFT, '017')) +
	 project(file_seed36, into_num(LEFT, '018')) +
	 project(file_seed37, into_num(LEFT, '019')) +
	 project(file_seed38, into_num(LEFT, '031')) +
	 project(file_seed39, into_num(LEFT, '040')) +
	 project(file_Seed40, into_num(LEFT, '063')) +
	 project(file_seed41, into_num(LEFT, '100')) +
	 project(file_seed42, into_num(LEFT, '101')) +
	 project(file_Seed59, into_num(LEFT, '065')) +
	 project(file_Seed60, into_num(LEFT, '163')) +
	 
	 project(file_Seed75, into_num(LEFT, '201')) +
	 project(file_Seed76, into_num(LEFT, '213')) +
	 project(file_Seed77, into_num(LEFT, '214')) +
	 project(file_Seed78, into_num(LEFT, '215')) +
	 project(file_Seed79, into_num(LEFT, '216')) +
	 project(file_Seed80, into_num(LEFT, '217')) +
	 project(file_Seed81, into_num(LEFT, '218')) +
	 project(file_Seed82, into_num(LEFT, '219')) +
	 project(file_Seed83, into_num(LEFT, '220')) +
	 project(file_Seed86, into_num(LEFT, '080')) +
	 project(file_Seed87, into_num(LEFT, '089')) +
	 project(file_seed88, into_num(LEFT, '047')) +
	 project(file_seed89, into_num(LEFT, '266')) +
	 project(file_seed91, into_num(LEFT, '259')) +
	 project(file_seed98, into_num(LEFT, '212')) + // 2x12
	 project(file_seed100, into_num(LEFT, '026')) + // ex26
	 project(file_seed102, into_num(LEFT, '267')) + // 2x67	 
	 project(file_seed103, into_num(LEFT, '268')) + // 2x68	 	 
	 project(file_seed105, into_num(LEFT, '095')) + // ex95
	 project(file_seed109, into_num(LEFT, '269')) + // 2x69
	 project(files.file_2x70, into_num(LEFT, '270')) + // 2x70
	 project(files.file_2x71, into_num(LEFT, '271')) // 2x71
	 ;



export Key_sc1osd1i := index(df,{prodnum, social},{account_out,
	riskwiseid,
	score,
	reason11,
	reason21,
	reason31,
	reason41,
	score2,
	reason12,
	reason22,
	reason32,
	reason42,
	score3,
	reason13,
	reason23,
	reason33,
	reason43,
	score4,
	reason14,
	reason24,
	reason34,
	reason44,
	reserved_out}, '~thor_data400::key::seed::qa::sc1osd1i');
