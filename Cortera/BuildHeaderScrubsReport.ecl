import Scrubs_Cortera, Scrubs;
EXPORT BuildHeaderScrubsReport(DATASET(cortera.Layout_Header) F, string version) := FUNCTION

		S := Scrubs_Cortera.Scrubs; // My scrubs module
		N := S.FromNone(F); // Generate the error flags

		U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
		ErrorSummary := output(U.SummaryStats, named('ErrorSummary_'+version)); // Show errors by field and type
		EyeballSomeErrors := output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors_'+version)); // Just eyeball some errors
		SomeErrorValues := output(choosen(U.BadValues, 1000), named('SomeErrorValues_'+version)); // See my error field values
		stats := U.OrbitStats();
		OrbitReport := output(stats,all,named('OrbitReport_'+version));
		//Generating a template to upload rules to Orbit
		//Scrubs.OrbitProfileStats(,,stats).ProfileTemplate;

		orbitStats := U.OrbitStats();

		submitStats :=
			Scrubs.OrbitProfileStats('Scrubs_cortera_header_in2','ScrubsAlerts',orbitStats,version,'Cortera').SubmitStats 
									: FAILURE(OUTPUT('Could not update Orbit with Scrubs'));
		return SEQUENTIAL(
				ErrorSummary,
				EyeballSomeErrors,
				SomeErrorValues,
				OrbitReport,
				submitStats
				//GenerateAlertCSVTemplate
		);

END;