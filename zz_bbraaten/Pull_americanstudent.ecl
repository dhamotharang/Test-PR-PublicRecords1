#workunit('name','AMS');
// import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, Data_Services, American_student_list;
Import Data_Services, American_student_list, Doxie;
import _control;


file_in := American_student_list.File_american_student_DID_PH_Suppressed_v2;

American_student_DID_base	:=	PROJECT(file_in((unsigned8)did<>0), American_student_list.layout_american_student_base_v2);

key_DID_prod := index(American_student_DID_base, 
                            {unsigned6 l_did := (unsigned)did},{American_student_DID_base},
				            // Data_Services.foreign_prod.Prefix('american_student')+'thor_data400::key::American_Student::20160823::DID2');		
				            // '~thor_data400::key::American_Student::20170302::DID2');		
				            '~thor_data400::key::American_Student::20170504c::DID2');		
				            // '~foreign::' + '10.173.235.23' + '::'+'thor_data400::key::fcra::american_student::20170504c::did2');		

key_DID_Cert := index(American_student_DID_base, 
                            {unsigned6 l_did := (unsigned)did},{American_student_DID_base},
				            // Data_Services.foreign_prod.Prefix('american_student')+'thor_data400::key::American_Student::20160823::DID2');		
				            // '~thor_data400::key::American_Student::20170302::DID2');		
				            '~foreign::' + '10.173.235.23' + '::'+'thor_data400::key::American_Student::20170526::DID2');		
				            // '~foreign::' + '10.173.235.23' + '::'+'thor_data400::key::fcra::american_student::20170526::did2');		

prod_key := pull(key_DID_prod);
Cert_key := pull(key_DID_Cert);

dis_prod := Distribute(prod_key, did);
dis_cert := Distribute(Cert_key, did);
 
// OUTPUT(count(j1), NAMED('v3__lienfiledage_count'));
// OUTPUT(CHOOSEN(j1, 25), named('v3__lienfiledage'));
// LN_COLLEGE_NAME;
	// string1					COLLEGE_MAJOR;
	// string4					NEW_COLLEGE_MAJOR;
	// string1         COLLEGE_CODE;
	// string20  			COLLEGE_CODE_EXPLODED;
	// string1         COLLEGE_TYPE;
	// string25				COLLEGE_TYPE_EXPLODED;
// count(key_DID);
// Count(key_DID(COLLEGE_NAME = ''));
// Count(American_student_list.key_DID(LN_COLLEGE_NAME = ''));
// Count(American_student_list.key_DID(COLLEGE_MAJOR = ''));
// Count(American_student_list.key_DID(COLLEGE_CODE = ''));
// Count(American_student_list.key_DID(COLLEGE_CODE_EXPLODED = ''));
// Count(American_student_list.key_DID(COLLEGE_TYPE = ''));
// Count(American_student_list.key_DID(COLLEGE_TYPE_EXPLODED = ''));

tbl_src_cert := table(dis_prod, {my_Class	 := 	Class	; _count := count(group)}, Class, local);
Class_dis_prod	:= table(tbl_src_cert, {my_Class; rec_count := sum(group, _count)}, my_Class); 

output(Class_dis_prod, all);

tbl_src_cert2 := table(dis_cert, {my_Class	 := 	Class	; _count := count(group)}, Class, local);
Class_dis_cert	:= table(tbl_src_cert2, {my_Class; rec_count := sum(group, _count)}, my_Class); 
output(Class_dis_cert, all);


// count(key_DID);
// Count(key_DID(COLLEGE_NAME = ''));
// Count(key_DID(LN_COLLEGE_NAME = ''));
// Count(key_DID(COLLEGE_MAJOR = ''));
// Count(key_DID(COLLEGE_CODE = ''));
// Count(key_DID(COLLEGE_CODE_EXPLODED = ''));
// Count(key_DID(COLLEGE_TYPE = ''));
// Count(key_DID(COLLEGE_TYPE_EXPLODED = ''));