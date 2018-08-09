import file_compare,std,prte2_doc;


//Offender Base File
file_base_offender_base_new    			:= prte2_doc.Files.file_offenders_base_plus;
file_base_offender_base_father 			:= dataset('~PRTE::BASE::corrections::offenders_father',prte2_doc.Layouts.layout_offender_plus,thor);	

//Offense Base File
file_base_offense_base_new 							:= prte2_doc.Files.file_offenses_base_plus;
file_base_offense_base_father					:= dataset('~PRTE::BASE::corrections::offenses_father', prte2_doc.Layouts.layout_offenses_base_plus, FLAT);

//Activity Base File
file_activity_base_new												:= prte2_doc.Files.file_activity_base_plus;
file_activity_base_father									:= dataset('~PRTE::BASE::corrections::activity_father', prte2_doc.Layouts.layout_activity_base_plus, FLAT);

//Court Offenses Base File
file_court_offenses_base_new						:= prte2_doc.Files.file_court_offenses_plus;
file_court_offenses_base_father			:= dataset('~PRTE::BASE::corrections::court_offenses_father', prte2_doc.Layouts.layout_court_offenses_base_plus, FLAT );


//Punishment Base file
file_punishment_base_new										:= prte2_doc.Files.file_punishment_plus;
file_punishment_base_father 						:= dataset('~PRTE::BASE::corrections::punishment_father', prte2_doc.Layouts.layout_punishment_plus, FLAT);


EXPORT fn_DeltaBaseFile(string filedate) := 
ordered(

file_compare.Fn_File_Compare(file_base_offender_base_father,
																													file_base_offender_base_new,
																													prte2_doc.Layouts.layout_offender_plus,,prte2_doc.Layouts.layout_offender_plus,true,,true,true,'PRTE_DOC','file_base_offender',filedate),
																													
file_compare.Fn_File_Compare(file_base_offense_base_father,
																													file_base_offense_base_new,
																													prte2_doc.Layouts.layout_offenses_base_plus,,prte2_doc.Layouts.layout_offenses_base_plus,true,,true,true,'PRTE_DOC','file_base_offense',filedate),

file_compare.Fn_File_Compare(file_activity_base_father,
																													file_activity_base_new,
																													prte2_doc.Layouts.layout_activity_base_plus,,prte2_doc.Layouts.layout_activity_base_plus,true,,true,true,'PRTE_DOC','file_base_activity',filedate),

file_compare.Fn_File_Compare(file_court_offenses_base_father,
																													file_court_offenses_base_new,
																													prte2_doc.Layouts.layout_court_offenses_base_plus,,prte2_doc.Layouts.layout_court_offenses_base_plus,true,,true,true,'PRTE_DOC','file_base_court_offenses',filedate),

file_compare.Fn_File_Compare(file_punishment_base_father,
																													file_punishment_base_new,
																													prte2_doc.Layouts.layout_punishment_plus,,prte2_doc.Layouts.layout_punishment_plus,true,,true,true,'PRTE_DOC','file_base_punichment',filedate),
																													
);






