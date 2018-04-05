import strata, ut, std;

GetDate := (STRING8)Std.Date.Today();
EXPORT out_STRATA_attributes_stats(DATASET(cortera.Layout_Attributes_Out) F, string version = getdate) := function

	
	//ds := Cortera.Files.Attributes(current_rec);
	ds := F(current_rec);
	s := strata.macf_Pops(ds,'st','string2','',true);
	tStats := SORT(s,st);

	strata.createXMLStats(tStats,'Cortera','attributes',version,'',resultsOut); 
	
	resultsOut : FAILURE(OUTPUT('Failed to update attributes strata')); 

	return tStats;
end;
