/*--SOAP--
<message name="Service_Clusters">
	<part name="_cluster" type="xsd:int" maxlength="5"/>
</message>
*/
/*--INFO-- This service usually returns all the clusters

*/


export Service_Clusters := MACRO
	UNSIGNED2 max_uint2 := 65535;
	UNSIGNED2 clid := max_uint2 : STORED('_cluster');

	ds := IF( clid != max_uint2,
			buzzsaw.Mod_Data_Indexes.IDX_Clusters_clID(clid=clid),
			buzzsaw.Mod_Data_Indexes.IDX_Clusters_clID);
			
/*	L_Plot := buzzsaw.Mod_Data_Indexes.L_Cluster_Plot;
	ds_t := TRANSFORM(ds, L_Plot, 
			SELF.min_date := buzzsaw.Mod_Y2K.format_date(LEFT.min_date),
			SELF.max_date := buzzsaw.Mod_Y2K.format_date(LEFT.max_date),
			SELF := LEFT);*/
	o := SORT(ds, -size);


	OUTPUT(o
		, NAMED('data')
		, ALL
	);

ENDMACRO;