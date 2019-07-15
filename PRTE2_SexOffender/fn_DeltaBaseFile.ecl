import file_compare,std,prte2_SexOffender;

//Base Offender
file_base_sexoffender_base_new    := prte2_sexoffender.files.Offender_di_ref;
file_base_sexoffender_base_father := dataset(prte2_sexoffender.Constants.base_prefix +'sex_offender_main_father',prte2_sexoffender.Layouts.Offender_in,thor);	

//Base Offense
file_base_offense_base_new 							:= prte2_sexoffender.files.Offense_di_ref;
file_base_offense_base_father					:= dataset(prte2_sexoffender.Constants.base_prefix +'sex_offender_offenses_father',prte2_sexoffender.Layouts.Offense_in,thor);

EXPORT fn_DeltaBaseFile(string filedate) := 
ordered(
file_compare.Fn_File_Compare(file_base_sexoffender_base_father,
																													file_base_sexoffender_base_new,
																													prte2_sexoffender.Layouts.Offender_in-[lat,long],,prte2_sexoffender.Layouts.Offender_in-[lat,long],true,,true,true,'PRTE_SEXOFFENDER','file_base_offender',filedate),
																													
file_compare.Fn_File_Compare(file_base_offense_base_father,
																													file_base_offense_base_new,
																													prte2_sexoffender.Layouts.Offense_in-[offense_persistent_id],,prte2_sexoffender.Layouts.Offense_in-[offense_persistent_id],true,,true,true,'PRTE_SEXOFFENDER','file_base_offense',filedate)
																													
);

