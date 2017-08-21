import ut;

export fn_rule_for_normalizing_eq_ssn(
	string	pF1
	,string	pM1
	,string	pL1
	,string	pF2
	,string	pM2
	,string	pL2
	,string	pSSN)
	:=
	function

	threshld	:=5;

	f1			:=trim(pF1,all);
	m1			:=trim(pM1,all);
	l1			:=trim(pL1,all);
	f2			:=trim(pF2,all);
	m2			:=trim(pM2,all);
	l2			:=trim(pL2,all);


	match1a	:=	if(length(f1)>1 and length(m2)>1
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(m2),'X','X') < threshld
						,1,0)
					,0);

	match1b	:=	if(length(f1)>1 and length(l2)>1
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(l2),'X','X') < threshld
						,1,0)
					,0);


	match2a	:=	if(length(m1)>1 and length(f2)>1
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(m1),'X','X'
									,Metaphonelib.DMetaPhone1(f2),'X','X') < threshld
						,1,0)
					,0);

	match2b	:=	if(length(m1)>1 and length(m2)>1
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(m1),'X','X'
									,Metaphonelib.DMetaPhone1(m2),'X','X') < threshld
						,1,0)
					,0);

	match2c	:=	if(length(m1)>1 and length(l2)>1
					,if(ut.NameMatch(Metaphonelib.DMetaPhone1(m1),'X','X'
									,Metaphonelib.DMetaPhone1(l2),'X','X') < threshld
						,1,0)
					,0);


	match3a	:=	if(length(f1)>1 and datalib.gender(f1) in ['M','F'] and length(f2)>1
					,if( datalib.gender(f1) = datalib.gender(if(ut.NameMatch(f1,'X','X'
																			,f2,'X','X') < threshld,f1,f2))
						,1,0)
					,0);

	match3b	:=	if(length(f1)>1 and datalib.gender(f1) in ['M','F'] and length(m2)>1
					,if( datalib.gender(f1) = datalib.gender(if(ut.NameMatch(f1,'X','X'
																			,m2,'X','X') < threshld,f1,m2))
						,1,0)
					,0);

	match3c	:=	if(length(f1)>1 and datalib.gender(f1) in ['M','F'] and length(l2)>1
					,if( datalib.gender(f1) = datalib.gender(if(ut.NameMatch(f1,'X','X'
																			,l2,'X','X') < threshld,f1,l2))
						,1,0)
					,0);


	match4a	:=	if(length(m1)>1 and datalib.gender(m1) in ['M','F'] and length(f2)>1
					,if( datalib.gender(m1) = datalib.gender(if(ut.NameMatch(m1,'X','X'
																			,f2,'X','X') < threshld,m1,f2))
						,1,0)
					,0);

	match4b	:=	if(length(m1)>1 and datalib.gender(m1) in ['M','F'] and length(m2)>1
					,if( datalib.gender(m1) = datalib.gender(if(ut.NameMatch(m1,'X','X'
																			,m2,'X','X') < threshld,m1,m2))
						,1,0)
					,0);

	match4c	:=	if(length(m1)>1 and datalib.gender(m1) in ['M','F'] and length(l2)>1
					,if( datalib.gender(m1) = datalib.gender(if(ut.NameMatch(m1,'X','X'
																			,l2,'X','X') < threshld,m1,l2))
						,1,0)
					,0);


	match5	:=	if(	ut.NameMatch(f1,m1,l1,f2,m2,l2) < threshld,1,0);


	match6a	:=	if(	f1[1]+m1[1]=f2 or f1[1]+m1[1]=m2,1,0);

	match6b	:=	if(	f2[1]+m2[1]=f1 or f2[1]+m2[1]=m1,1,0);


	match7a	:=	if(	f1[1]=f2[1] and m1[1]=m2[1],1,0);

	match7b	:=	if(	f1[1]=m2[1] and m1[1]=f2[1],1,0);


	match8a	:=	if(f1<>''
					,if(f1=f2 or f1=m2 or f1=l2,1,0)
					,0);

	match8b	:=	if(m1<>''
					,if(m1=f2 or m1=m2 or m1=l2,1,0)
					,0);


	match10	:=	if(length(f1)>1 and length(f2)>1
						,if(ut.NameMatch(f1,'X','X',f2,'X','X') < threshld,1,0)
						,0);


	match11a	:=	if(ut.NameMatch( Metaphonelib.DMetaPhone1(f1),Metaphonelib.DMetaPhone1(m1),'X'
									,Metaphonelib.DMetaPhone1(f2),Metaphonelib.DMetaPhone1(m2),'X')
									< threshld,1,0);

	match11b	:=	if(ut.NameMatch( Metaphonelib.DMetaPhone1(f1),'X','X'
									,Metaphonelib.DMetaPhone1(f2),'X','X')
									< threshld,1,0);

	score	:=	
				+match1a+match1b
				+match2a+match2b+match2c
				+match3a+match3b+match3c
				+match4a+match4b+match4c
				+match5
				+match6a+match6b
				+match7a+match7b
				+match8a+match8b
				+match10
				+match11a+match11b
				;

	ssn	:=	if( score > 0, pSSN, '' );

	return	ssn;

end;
