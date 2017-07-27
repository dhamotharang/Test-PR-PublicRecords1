import ut;
export Name_Match_Score(string fname1,string mname1,string lname1,
						 string fname2,string mname2,string lname2)  := 
map((fname1='' and mname1='' and lname1='') or 
    (fname2='' and mname2='' and lname2='') => 255,
	ut.NameMatch(fname1,mname1,lname1,fname2,mname2,lname2)=0=>100,
	ut.NameMatch(fname1,mname1,lname1,fname2,mname2,lname2)=1=>90,
	ut.NameMatch(fname1,mname1,lname1,fname2,mname2,lname2)=2=>80,
	ut.NameMatch(fname1,mname1,lname1,fname2,mname2,lname2)=3=>70,
	ut.NameMatch(fname1,mname1,lname1,fname2,mname2,lname2)<50=>50,
	ut.NameMatch(fname1,mname1,lname1,fname2,mname2,lname2)>98=>0,20);