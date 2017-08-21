export mac_SSN_DID_stats(infile, cnt_infile,outfile) := macro

#uniquename(rstat_cnt)
#uniquename(rstat_percentage)

%rstat_cnt% := record	

	cnt1 := count(infile(cnt =1));
	cnt2 := count(infile(cnt =2));
  cnt3 := count(infile(cnt =3));
	cnt4 := count(infile(cnt =4));
	cnt5 := count(infile(cnt =5));
	cnt6 :=	count(infile(cnt =6));
	cnt7 := count(infile(cnt =7));
	cnt8 :=			count(infile(cnt =8));
	cnt9 :=				count(infile(cnt =9));
	cnt10 :=					count(infile(cnt =10));
	cnt11 :=						count(infile(cnt > 10));

	integer total 		:= count(group);
  end
 ;

dcntTable 	:= table(infile,%rstat_cnt%,few);
//output(dStatsTable,named('Stats'));

%rstat_percentage% := record
  integer countGroup := count(group);

  pt1 := count(infile(cnt =1))/cnt_infile*100;
	pt2 := (count(infile(cnt =2))*2/cnt_infile)*100;
  pt3 := (count(infile(cnt =3))*3/cnt_infile)*100;
	pt4 := (count(infile(cnt =4))*4/cnt_infile)*100;
	pt5 := (count(infile(cnt =5))*5/cnt_infile)*100;
	pt6 := (count(infile(cnt =6))*6/cnt_infile)*100;
	pt7 := (count(infile(cnt =7))*7/cnt_infile)*100;
	pt8 := (count(infile(cnt =8))*8/cnt_infile)*100;
	pt9 := (count(infile(cnt =9))*9/cnt_infile)*100;
	pt10 :=	(count(infile(cnt =10))*10/cnt_infile)*100;
	pt11 :=	( cnt_infile - (count(infile(cnt =1)) 
	                      +count(infile(cnt =2))*2
												+count(infile(cnt =3))*3
												+ count(infile(cnt =4))*4
												+ count(infile(cnt =5))*5
	                    + count(infile(cnt =6))*6
											+ count(infile(cnt =7))*7
	                    + count(infile(cnt =8))*8
	                    + count(infile(cnt =9))*9
	                    + count(infile(cnt =10))*10))/cnt_infile*100;

end;

	dpercentageTable 	:= table(infile,%rstat_percentage%,few);

outfile := parallel(output(dcntTable), output(dpercentageTable));

endmacro;