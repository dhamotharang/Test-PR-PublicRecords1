IMPORT Scrubs_Cortera_Tradeline, Scrubs;
EXPORT BuildTradelineScrubsReport(string8 version) := FUNCTION

		f := Scrubs_Cortera_Tradeline.In_Cortera_Tradeline;
		S := Scrubs_Cortera_Tradeline.Scrubs; // My scrubs module
		N := S.FromNone(F); // Generate the error flags

		U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
		ErrorSummary := output(U.SummaryStats, named('ErrorSummary')); // Show errors by field and type
		EyeballSomeErrors := output(choosen(U.AllErrors, 1000), named('EyeballSomeErrors')); // Just eyeball some errors
		SomeErrorValues := output(choosen(U.BadValues, 1000), named('SomeErrorValues')); // See my error field values
		stats := U.OrbitStats();
		OrbitReport := output(stats,all,named('OrbitReport'));
		//Generating a template to upload rules to Orbit
		//Scrubs.OrbitProfileStats(,,stats).ProfileTemplate;

		orbitStats := U.OrbitStats();
		GenerateAlertCSVTemplate := Scrubs.OrbitProfileStatsPost310('Scrubs_Cortera_Tradeline','ScrubsAlerts',orbitStats).ProfileAlertsTemplate;

		submitStats :=
			Scrubs.OrbitProfileStatsPost310('Scrubs_Cortera_Tradeline','ScrubsAlerts',orbitStats, version).SubmitStats 
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