/*--SOAP--
<message name="Service_Macro_Clusters">
	<part name="_min_x" type="xsd:int" maxlength="6"/>
	<part name="_max_x" type="xsd:int" maxlength="6"/>
	<part name="_min_y" type="xsd:int" maxlength="6"/>
	<part name="_max_y" type="xsd:int" maxlength="6"/>
</message>
*/
/*--INFO-- This service usually returns all the clusters

*/


export Service_Macro_Clusters := MACRO
	UNSIGNED2 min_uint2 := 0;
	UNSIGNED2 max_uint2 := 65535;
	INTEGER2 min_int2 := -32768;
	INTEGER2 max_int2 :=  32767;
	
	UNSIGNED2 min_x := min_uint2 : STORED('_min_x');
	UNSIGNED2 max_x := max_uint2 : STORED('_max_x');
	INTEGER2 min_y := min_int2 : STORED('_min_y');
	INTEGER2 max_y := max_int2 : STORED('_max_y');
	
	buzzsaw.Mod_Data.L_Cluster_Plot three_headed_monster(
			buzzsaw.Mod_Data_Indexes.IDX_Cluster_Plot L) := TRANSFORM
		SELF := L;
	END;
	
	in_range_x(UNSIGNED2 x) := IF( min_x > min_uint2,
		IF( max_x < max_uint2, x BETWEEN min_x AND max_x, x >= min_x),
		IF( max_x < max_uint2, x <= max_x, TRUE));
		
	in_range_y(INTEGER2 y) := IF( min_y > min_int2,
		IF( max_y < max_int2, y BETWEEN min_y AND max_y, y >= min_y),
		IF( max_y < max_int2, y <= max_y, TRUE));
	
	ds_f := buzzsaw.Mod_Data_Indexes.IDX_Cluster_Plot((in_range_x(x))	AND (in_range_y(y)));
	ds_p := PROJECT(ds_f, three_headed_monster(LEFT));
			
//	OUTPUT('factor: ' + rnd_factor, NAMED('factor'));

	o := SORT(ds_p, -size);

	//maybe these should be saved to a dataset somewhere so they won't be recalculated each time . . .
//	OUTPUT(buzzsaw.Mod_Data_Util.log_min_mean, NAMED('log_min_mean'));
//	OUTPUT(buzzsaw.Mod_Data_Util.log_max_stdev, NAMED('log_max_stdev'));

	OUTPUT(o
		, NAMED('data')
		, ALL
	);

ENDMACRO;