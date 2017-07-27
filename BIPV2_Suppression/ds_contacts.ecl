
bizr := record
	unsigned6 ID;//dont need type because i want to suppress agressively?
	string9 fein;
	string250 company_name;
	boolean suppressAtAnyCompany := false;
end;

personr := record
	unsigned6 DID;
	string9 SSN;
	string25 fname;	
	string25 lname; //this field is required by the join
end;

rec := record
	bizr biz;
	personr person;
	unsigned6 bug_num;
	string500 note;
end;

ds_suppressions :=
DATASET([
//to add a supression, just add a row here.  
// will automatically check fname/lname flips so dont enter both combinations.  
// will will automatically upper case and remove cname punctuation
	transform(
		rec,
		self.biz.ID := 88399440,
		self.biz.fein := '202752826',
		self.biz.company_name := 'Live Well Financial Inc',
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'Michael',
		self.person.lname := 'Hild',
		self.bug_num := 141202;
		self.note := 'ID is SELE'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 88399440,
		self.biz.fein := '202752826',
		self.biz.company_name := 'Live Well Financial Inc',
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'Michael',
		self.person.lname := 'Hilt',				//same as previous row but HILT vs HILD
		self.bug_num := 141202;
		self.note := 'ID is SELE'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 88399440,
		self.biz.fein := '202752826',
		self.biz.company_name := 'Live Well Financial Inc',
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'Micheal',		//same as first row but Micheal vs Michael
		self.person.lname := 'Hild',				
		self.bug_num := 141202;
		self.note := 'ID is SELE'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 26007079,
		self.biz.fein := '',
		self.biz.company_name := 'HAWKEYE TRUCK BEDS',
		self.person.DID := 5576164,
		self.person.SSN := '410717987',
		self.person.fname := 'AL',
		self.person.lname := 'OTHMAN',				
		self.bug_num := 143430;
		self.note := 'ID is SELE'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 26007079,
		self.biz.fein := '',
		self.biz.company_name := 'HAWKEYE TRUCK BEDS',
		self.person.DID := 5576164,
		self.person.SSN := '410717987',
		self.person.fname := 'JAFARI',   //same as previous row but JAFARI
		self.person.lname := 'OTHMAN',				
		self.bug_num := 143430;
		self.note := 'ID is SELE'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 30020075,
		self.biz.fein := '',
		self.biz.company_name := 'RJD ROOSTER, INC',
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'Yasin',   //same as previous row but JAFARI
		self.person.lname := 'Hussain',				
		self.bug_num := 143430;
		self.note := 'ID is SELE'
	)
])

+ DATASET ([
	transform(
		rec,
		self.biz.ID := 0,//any
		self.biz.fein := '',
		self.biz.company_name := '',//any
		self.biz.suppressAtAnyCompany := TRUE;		
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'DAVID',   //same as previous row but JAFARI
		self.person.lname := 'peyman',				
		self.bug_num := 152064;
		self.note := 'need to filter ANY occurence of this name'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 0,//any
		self.biz.fein := '',
		self.biz.company_name := '',//any
		self.biz.suppressAtAnyCompany := TRUE;		
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'DAVE',   //same as previous row but JAFARI
		self.person.lname := 'peyman',				
		self.bug_num := 152064;
		self.note := 'need to filter ANY occurence of this name'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 0,//any
		self.biz.fein := '',
		self.biz.company_name := '',//any
		self.biz.suppressAtAnyCompany := TRUE;		
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'SHALA',   //same as previous row but JAFARI
		self.person.lname := 'peyman',				
		self.bug_num := 152064;
		self.note := 'need to filter ANY occurence of this name'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 0,//any
		self.biz.fein := '',
		self.biz.company_name := '',//any
		self.biz.suppressAtAnyCompany := TRUE;		
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'Shahla',   //same as previous row but JAFARI
		self.person.lname := 'peyman',				
		self.bug_num := 152064;
		self.note := 'need to filter ANY occurence of this name'
	)
])
+ DATASET ([							
	transform(
		rec,
		self.biz.ID := 0,//any
		self.biz.fein := '',
		self.biz.company_name := '',//any
		self.biz.suppressAtAnyCompany := TRUE;		
		self.person.DID := 0,
		self.person.SSN := '',
		self.person.fname := 'Shalah',   //same as previous row but JAFARI
		self.person.lname := 'peyman',				
		self.bug_num := 153301;
		self.note := 'need to filter ANY occurence of this name'
	)
])
+ DATASET ([
	transform(
		rec,
		self.biz.ID := 14167680,
		self.biz.fein := '',
		self.biz.company_name := 'AVANTE ABSTRACT INC',//any
		self.biz.suppressAtAnyCompany := FALSE;		
		self.person.DID := 68482046,
		self.person.SSN := '',
		self.person.fname := 'Angela',   //same as previous row but JAFARI
		self.person.lname := 'Farole',				
		self.bug_num := 157300;
		self.note := 'Ms. Farole has other contact records, not associated with Avante, which can remain.'
	)
])

;

ds_suppressions_namesflipped :=
ds_suppressions +
project(							
	ds_suppressions,  
	transform(
		rec,
		self.person.fname := left.person.lname,
		self.person.lname := left.person.fname,
		self := left
	)
);

EXPORT ds_contacts := 
project(
	ds_suppressions_namesflipped,
	transform(
		rec,		
		self.biz.company_name := stringlib.stringtouppercase(left.biz.company_name);
		self.person.fname 		:= stringlib.stringtouppercase(left.person.fname);
		self.person.lname 		:= stringlib.stringtouppercase(left.person.lname);
		self := left
	)
);