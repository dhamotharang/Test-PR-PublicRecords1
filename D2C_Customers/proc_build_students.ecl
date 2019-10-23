import American_student_list, Watchdog, PromoteSupers;

dsMajor := DATASET([
{'A','BIOLOGICAL SCIENCE'},
{'B','BUSINESS/COMMERCE'},
{'C','EDUCATION'},
{'D','ENGINEERING'},
{'E','HEALTH PROFESSIONS'},
{'F','HUMANITIES'},
{'G','LAW'},
{'H','PHYSICAL SCIENCE'},
{'I','RELIGION'},
{'J','SOCIAL SCIENCE'},
{'K','LIBERAL ARTS'},
{'L','NURSING'},
{'M','COMPUTER'},
{'N','ARCHITECTURE'},
{'O','MUSIC'},
{'P','ACCOUNTING'},
{'Q','BIOLOGY'},
{'R','MARKETING'},
{'S','FINANCE'},
{'T','MEDICINE'},
{'U',''},		//UNCLASSIFIED
{'V','CHIROPRACTIC'},
{'W','ART'},
{'X',''},
{'Y','ENGLISH/JOURNALISM'},
{'Z','MANAGEMENT'}
], {STRING1 abbreviation, string18 major});
dictMajor := DICTIONARY(dsMajor, {abbreviation => major});

Wdog := distribute(Watchdog.File_Best_nonglb(adl_ind = 'CORE'), hash(did));

EXPORT proc_build_students(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

    students   := DISTRIBUTE(American_student_list.File_american_student_DID(did<>0), hash(did));
    students_s := SORT(students, did, historical_flag, -date_last_seen, local);

	D2C_Customers.layouts.rStudent AddStudent(students_s L) := TRANSFORM
        self.LexId := (unsigned6)L.did;				
        self.CLASS := IF(REGEXFIND('^\\d\\d$',L.CLASS), L.Class, '');
        self.COLLEGE_NAME := L.COLLEGE_NAME;
        self.COLLEGE_MAJOR := dictMajor[L.COLLEGE_MAJOR].major;        
	END;

    ds := project(students_s, AddStudent(left))(COLLEGE_NAME<>'');	

    fullDS := ds;
    coreDS := join(distribute(ds, hash(LexID)), Wdog, left.LexID = right.did, transform(left), local);
    coreDerogatoryDS := join(coreDS, distribute(Files.derogatoryDS, did), left.LexID = right.did, transform(left), local);
   
    outDS := map( mode = 1 => fullDS,          //FULL
                 mode = 2 => coreDS,          //QUARTERLY
                 mode = 3 => coreDerogatoryDS //MONTHLY
               );
   
   sMode := map(Mode = 1 => 'full',
                Mode = 2 => 'core',
                Mode = 3 => 'derogatory',
                ''
                );
                
   PromoteSupers.MAC_SF_BuildProcess(outDS,'~thor_data400::output::d2c::' + sMode + '::students',doit,2,,true,ver);
   return if(Mode not in [1,2,3], output('phones - INVALID MODE - ' + Mode), doit);

END;