//Monthly Blocked data
export Blocked_data_new := 
MACRO
	~(
   (fname[1..9]='BIRTHDATE')
or (stringlib.stringfind(lname,'BIRTHDATE',1)>0)
or (mdr.sourceTools.SourceIsUtilNoWorkPH(src) and ssn='066033492')
or (mdr.sourceTools.SourceIsUtilNoWorkPH(src) and fname='ALTA' and lname='MEADOWS')

or (phone='3369982510' and fname='DAVID' and lname='ELWOOD')
or  (fname='CREDIT' and lname='APPLICANT')
or  (fname='TATUM' and mname='WILL' and lname='BRYANT' and ssn='432758118')
or  (src='EQ' and fname='KARL' and mname='' and lname='WODERSEK' and ssn='212381216' and dob=19721000)// added on 20101222
or  (src='EQ' and fname='KARL' and mname='W' and lname='WONDERSEK' and ssn='212381216' and dob=19721002)// added on 20101222
or  (src='DE' and fname='CINDY' and mname='' and lname='LEWIS' and ssn='529026756' and dob=19581030)// added on 20101222
or  (src='EQ' and fname='BARBARA' and mname='JEAN' and lname='UTECH' and ssn='345407685' and dob=0)// added on 20101222
or  (src='UW' and phone='8187740633' and fname='GREG' and mname='' and lname='JOHNSON' and ssn='548801899') //20110124
or  (src='UT' and phone='8187399531' and fname='GREG' and mname='' and lname='JOHNSON' and ssn='548801899') //20110124
or  (src='EQ' and phone='3036399789' and fname='MICHAEL' and mname='H' and lname='WELTON' and ssn='521725741'  and dob=19540000) //20110303 Bug: 67812
or  (fname='COOKIE' and lname='MONSTER' and prim_name='SESAME')
or  (did=167987978810)

// or  (src='EQ' and fname='RONALD' and mname='L' and lname='GATES' and ssn='334303286') //added 20110725 bug 84154
// or  (src='EQ' and fname='RON' and mname='' and lname='GATES' and ssn='344323068') //added 20110725 bug 84154
// or  (src='EN' and fname='RONALD' and mname='L' and lname='GATES' and ssn='334303286') //added 20110725 bug 84154
// or  (src='EN' and fname='RON' and mname='' and lname='GATES' and ssn='334303286') //added 20110725 bug 84154

or (fname='A' and mname in ['GIFT','G FOR','G'] and lname='YOU') // added 20180608 bug DF-21135

or ~(		fname<>''
		and lname<>''
		and ~regexfind('^dickless$|^dickles$',trim(fname),nocase)
		and ~regexfind('^dickless$|^dickles$',trim(mname),nocase)
		and ~regexfind('^dickless$|^dickles$',trim(lname),nocase)
	 )
	)
ENDMACRO;