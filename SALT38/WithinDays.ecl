IMPORT Std.Date;
EXPORT BOOLEAN WithinDays(INTEGER2 l_Y, UNSIGNED1 l_M, UNSIGNED1 l_D, INTEGER2 r_Y, UNSIGNED1 r_M, UNSIGNED1 r_D, UNSIGNED2 d) := 
	ABS(Date.FromGregorianYMD(l_Y,l_M,l_D) - Date.FromGregorianYMD(r_Y,r_M,r_D)) <= d;
 
