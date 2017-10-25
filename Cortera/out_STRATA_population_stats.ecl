import strata, ut, std;

GetDate := (STRING8)Std.Date.Today();
EXPORT out_STRATA_population_stats(DATASET(cortera.Layout_Header_Out) F, string version = getdate) := function

	
	//ds := Cortera.Files.Hdr_Out(country='US', current);
	ds := F(country='US', current);
	s := strata.macf_Pops(ds,'state','string2','',true);
	tStats := SORT(s,state);

	strata.createXMLStats(tStats,'Cortera','header',version,'',resultsOut); 
	
	resultsOut : FAILURE(OUTPUT('Failed to update header strata'));

	return tStats;
end;
