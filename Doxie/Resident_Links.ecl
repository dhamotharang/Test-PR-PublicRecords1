import doxie_crs;
export Resident_Links := 
	dedup(project(doxie.Resident_Records, doxie_crs.layout_Resident_Links), all);