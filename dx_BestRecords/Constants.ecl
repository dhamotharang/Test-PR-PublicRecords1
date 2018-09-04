import dx_BestRecords;

export Constants := module

	export perm_type := enum(unsigned4, 
		glb																			= 1, 
		glb_nonexperian													= 1 << 1, 
		glb_nonequifax													= 1 << 2, 
		glb_nonexperian_nonequifax							= 1 << 3, 
		glb_nonblank														= 1 << 4, 
		glb_nonexperian_nonblank								= 1 << 5, 
		glb_nonequifax_nonblank									= 1 << 6, 
		glb_nonexperian_nonequifax_nonblank			= 1 << 7, 
		glb_nonutil															= 1 << 8, 
		glb_nonutil_nonblank										= 1 << 9, 
		nonglb																	= 1 << 10, 
		nonglb_v2																= 1 << 11, 
		nonglb_nonblank													= 1 << 12, 
		nonglb_nonblank_v2											= 1 << 13, 
		marketing																= 1 << 14, 
		marketing_v2														= 1 << 15, 
		infutor																	= 1 << 16);

end;
