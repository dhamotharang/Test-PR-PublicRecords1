import Scrubs_Gong, Scrubs;
EXPORT BuildScrubsReport(DATASET(gong_neustar.Layout_Neustar) F, string version) := FUNCTION


		S := Scrubs_Gong.Scrubs; // My scrubs module
		N := S.FromNone(F); // Generate the error flags

		U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
		ErrorSummary := output(U.SummaryStats, named('ErrorSummary_'+version)); // Show errors by field and type
		EyeballSomeErrors := output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors_'+version)); // Just eyeball some errors
		SomeErrorValues := output(choosen(U.BadValues, 1000), named('SomeErrorValues_'+version)); // See my error field values
		stats := U.OrbitStats();
		OrbitReport := output(stats,all,named('OrbitReport_'+version));
		//Generating a template to upload rules to Orbit
		//Scrubs.OrbitProfileStats(,,stats).ProfileTemplate;


		orbitStats := U.OrbitStats();			// : persist('~persist::gong::scrubs_prt');

		submitStats:=Scrubs.OrbitProfileStatsPost310('Scrubs_gong_neustar_in','ScrubsAlerts',orbitStats,version,'Gong').SubmitStats;

		return SEQUENTIAL(
				ErrorSummary,
				EyeballSomeErrors,
				SomeErrorValues,
				OrbitReport,
				submitStats
		);

END;