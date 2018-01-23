BWR_to_run_BocaShell_Macros(fcra_roxieIP, neutralroxieIP, no_of_recs_to_run, filetag) := function

		import RiskWise, sghatti, ut;

		//Here are the URLs to run data collections for testing non-FCRA OSS roxie
		// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
		// cert128 702 - roxiestaging.sc.seisint.com:9876

		// staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
		// QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 


		// cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';

		// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
		// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
		// fcra_roxieIP := RiskWise.Shortcuts.staging_fcra_roxieIP;  
		// fcra_roxieIP := RiskWise.Shortcuts.Dev196;  
		// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
		// neutralroxieIP := RiskWise.shortcuts.Dev196;
		// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral
		// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral
		// neutralroxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP;  
		// neutralroxieIP := 'http://10.173.1.130:8223/';

		// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;  
		// fcra_roxieIP := RiskWise.shortcuts.prod_batch_fcra;  
		// filetag := 'address_cleaner_baseline';  // i.e. vehicles_cert_130
		// filetag := 'address_cleaner_second';  // i.e. vehicles_cert_130

		//**** RUNTIME SETTINGS ******
		bs_version := 41;
		// no_of_threads := 15;
		no_of_threads := 3;
		Timeout := 120;
		Retry_time := 3;
		// no_of_recs_to_run := 20000;
		//***** UNIQUE OUPUT FILE TAG *********
		// filetag := 'test';  // i.e. vehicles_cert_130
		// filetag := 'nuestar_baseline';  // i.e. vehicles_cert_130
		// filetag := 'nuestar_second';  // i.e. vehicles_cert_130


		bocashell_50_cert_fcra_infile_name :=  MAP(bs_version = 50 => '~scoring_project::in::bocashell_v3_v4_v5_input_20140528', 
																							 bs_version = 41 => '~scoring_project::in::bocashell_v3_v4_v5_input_20140528',
																								bs_version = 30 => '~scoring_project::in::bocashell_v3_v4_v5_input_20140528','');
																								
		bocashell_50_cert_fcra_outfile_name := MAP(bs_version = 50 =>'~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate ,
																								bs_version = 41 => '~scoringqa::out::bs_41_tracking_edina_fcra_NO_EDINA_' + filetag + '_'  + ut.GetDate,
																								bs_version = 30 => '~scoringqa::out::bs_30_tracking_edina_fcra_NO_EDINA_' + filetag + '_'  + ut.GetDate,'');

		bocashell_50_cert_nonfcra_infile_name := MAP(bs_version = 50 => '~scoring_project::in::bocashell_v3_v4_v5_input_20140528', 
																								bs_version = 41 => '~scoring_project::in::bocashell_v3_v4_v5_input_20140528',
																								bs_version = 30 => '~scoring_project::in::bocashell_v3_v4_v5_input_20140528','');
																								 
		bocashell_50_cert_nonfcra_outfile_name := MAP(bs_version = 50 =>'~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate ,
																								bs_version = 41 => '~scoringqa::out::bs_41_tracking_edina_nonfcra_NO_EDINA_' + filetag + '_'  + ut.GetDate, 
																								bs_version = 30 => '~scoringqa::out::bs_30_tracking_edina_nonfcra_NO_EDINA_' + filetag + '_'  + ut.GetDate,'');
																								


		bocashell_cert_fcra_41 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( 41, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_50_cert_fcra_infile_name,bocashell_50_cert_fcra_outfile_name,no_of_recs_to_run);

		bocashell_cert_nonfcra_41 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( 41, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_50_cert_nonfcra_infile_name,bocashell_50_cert_nonfcra_outfile_name,no_of_recs_to_run);

		bocashell_cert_fcra_50 := Scoring_Project_Macros.BocaShell_50_FCRA_cert_MACRO( 50, fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_50_cert_fcra_infile_name,'~scoringqa::out::tracking::bocashell50::cert_bs_50_FCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate,no_of_recs_to_run);

		bocashell_cert_nonfcra_50 := Scoring_Project_Macros.BocaShell_50_nonFCRA_cert_MACRO( 50, neutralroxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,bocashell_50_cert_nonfcra_infile_name,'~scoringqa::out::tracking::bocashell50::cert_bs_50_nonFCRA_NO_EDINA_' + filetag + '_'  + ut.GetDate,no_of_recs_to_run);


		exe := Sequential(
								bocashell_cert_fcra_41, 
								bocashell_cert_nonfcra_41,
								bocashell_cert_fcra_50,
								bocashell_cert_nonfcra_50
								);
								
		return exe;
end;
