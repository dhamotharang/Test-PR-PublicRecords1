import strata, ut, std;

/***
We can't create a Strata report because there is no useful group by field.
Using link id creates a file that is much too large to be of value.

****/

EXPORT out_STRATA_population_stats(DATASET($.Layout_Tradeline) F = $.Files.Adds,
																		string version = (STRING8)Std.Date.Today()) := function

	s := strata.macf_Pops(F,'link_id','unsigned4',0,true);
	tStats := SORT(s,link_id);

	strata.createXMLStats(tStats,'CorteraTradeline','tradeline',version,'',resultsOut); 
	
	resultsOut : FAILURE(OUTPUT('Failed to update tradeline strata'));

	return tStats;
end;
