export Layout_SlimCounter :=
RECORD
	unsigned6 did;
	QSTRING25 city;
	QSTRING2 st;
	QSTRING4 lname4;
	QSTRING3 fname3;
	
	UNSIGNED2 total_cnt := 1;
	INTEGER3 base_cnt := 0;
	// one extra
	INTEGER3 base_age := 0;					// 1
	INTEGER3 base_states := 0;				// 1
	INTEGER3 base_city := 0;					// 2
	INTEGER3 base_coHabit := 0;				// 7
	INTEGER3 base_ffirst := 0;				// 7
	INTEGER3 base_flast := 0;				// 10
	INTEGER3 base_maiden := 0;				// 10
	// two extra
	INTEGER3 base_age_states := 0;
	INTEGER3 base_age_city := 0;
	INTEGER3 base_age_coHabit := 0;
	INTEGER3 base_age_ffirst := 0;
	INTEGER3 base_age_flast := 0;
	INTEGER3 base_age_maiden := 0;
	INTEGER3 base_states_city := 0;
	INTEGER3 base_states_coHabit := 0;
	INTEGER3 base_states_ffirst := 0;
	INTEGER3 base_states_flast := 0;
	INTEGER3 base_states_maiden := 0;
	INTEGER3 base_city_coHabit := 0;
	INTEGER3 base_city_ffirst := 0;
	INTEGER3 base_city_flast := 0;
	INTEGER3 base_city_maiden := 0;
	INTEGER3 base_coHabit_ffirst := 0;
	// three extra
	INTEGER3 base_age_states_city := 0;
	INTEGER3 base_age_states_coHabit := 0;
	INTEGER3 base_age_states_ffirst := 0;
	INTEGER3 base_age_states_flast := 0;
	INTEGER3 base_age_states_maiden := 0;
	INTEGER3 base_age_city_coHabit := 0;
	INTEGER3 base_age_city_ffirst := 0;
	INTEGER3 base_age_city_flast := 0;
	INTEGER3 base_age_city_maiden := 0;
	INTEGER3 base_states_city_coHabit := 0;
	INTEGER3 base_states_city_ffirst := 0;
	INTEGER3 base_states_city_flast := 0;
	INTEGER3 base_states_city_maiden := 0;
	// 4 extra
	INTEGER3 base_age_states_city_coHabit := 0;
	INTEGER3 base_age_states_city_ffirst := 0;
	INTEGER3 base_age_states_city_flast := 0;
	INTEGER3 base_age_states_city_maiden := 0;
END;