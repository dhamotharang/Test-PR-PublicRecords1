import American_student_list, Watchdog, PromoteSupers;

/********* STUDENTS **********/
//SRC code - 'SL'

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
{'U','UNCLASSIFIED'},
{'V','CHIROPRACTIC'},
{'W','ART'},
{'X',''},
{'Y','ENGLISH/JOURNALISM'},
{'Z','MANAGEMENT'}
], {STRING1 abbreviation, string18 major});
dictMajor := DICTIONARY(dsMajor, {abbreviation => major});

/********* STUDENTS **********/

EXPORT proc_build_students(unsigned1 mode, string8 ver, string20 customer_name) := FUNCTION

    //200M records
    BaseFile := distribute(D2C_Customers.Files.ASLDS(mode), hash(did));
    students_s := SORT(BaseFile, did, historical_flag, -date_last_seen, local);

	D2C_Customers.layouts.rStudent AddStudent(students_s L) := TRANSFORM
        self.LexId := (unsigned6)L.did;				
        self.CLASS := IF(REGEXFIND('^\\d\\d$',L.CLASS), L.Class, '');
        self.COLLEGE_NAME := L.COLLEGE_NAME;
        self.COLLEGE_MAJOR := dictMajor[L.COLLEGE_MAJOR].major;        
	END;

    inDS := project(students_s, AddStudent(left))(COLLEGE_NAME<>'');

    res := D2C_Customers.MAC_WriteCSVFile(inDS, mode, ver, 22);
    return res;

END;