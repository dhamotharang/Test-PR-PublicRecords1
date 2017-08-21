import gong,Risk_Indicators;

//Check for cellphone type

tds := Risk_Indicators.File_Telcordia_tds;
f1  := tds(COCType in ['EOC','PMC','RCC','SP1','SP2'] 
       and 
		(regexfind('C',tds.ssc,0) != '' or
		 regexfind('R',tds.ssc,0) != '' or
		 regexfind('S',tds.ssc,0) != ''
		)
	   );

r1 := record
 f1.npa;
 f1.nxx;
 f1.tb;
end;

ta1      := table(f1,r1);
ta1_dupd := dedup(ta1,record,all);

export file_cellphone_check := ta1_dupd : persist('persist::pp_file_cellphone_check');