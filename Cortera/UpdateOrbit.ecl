/***

	update scrubs and strata in orbit

****/
import Orbit3,ut;


EXPORT UpdateOrbit(string version,string build_name) := FUNCTION

	create_build := sequential(
										    
                                                         Orbit3.proc_Orbit3_CreateBuild_AddItem ( build_name,version)
								     );
	return create_build;
END;