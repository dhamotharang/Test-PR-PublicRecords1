// Bair._CRON_Import_Scheduler
// scheduler job name -> Bair Importer Scheduler
// queued job nane -> Bair Importer - Importing yyyyMMdd_HHmmssfff
//								 -> Bair Importer Listening | Sentinel=Available
//								 -> Bair Importer Listening | Sentinel=Blocked
// ON_NOTIFY: bair_importer
	// Get Files ready from Orbit
	// Spray the XML Files from LZ
	// Build Input Files
// Expected execution time -> variable, it depends of the file	
	
// Bair_importer._BWR_Cron_Push -> now Bair._CRON_Import_Controller
// scheduler job bane -> Bair Importer Controller
// queue job bane -> Monitor Bair Importer
// EVERY_THREE_MINUTES:
	// if no importer submitted, compiling, blocked, or running then start a new one
	// if importer in queue running longer than 2 hour, notify developers
	// reports every 10K geocder calls
// Expected execution time -> 30 seconds

// Bair_importer._BWR_Cron_Cleanup -> now Bair._CRON_Delete_orphan_Inputs
// scheduler job nane -> Bair Importer Cleanup
// queued job nane -> Housekeeping
// ONCE_AT_MIDNIGHT:
	// Deletes obsolete input files
// Expected execution time -> 1-5 minutes

// Bair.Build_All_Controller_CRON -> now Bair._CRON_Build_pload_Controller
// scheduler job nane -> Bair Build All Controller
// queued job nane -> Bair Build All Monitor
// EVERY_TWO_MINUTES:
	// if any 'Bair Build All Monitor' not completed in queue, do nothing
		// else spin Bair.Build_All_Scheduler_CRON by notifying the scheduler -> Bair Build All Scheduler
// Expected execution time -> 30 seconds

// Bair.Build_All_Scheduler_CRON -> now Bair._CRON_Build_Payloads
// scheduler job nane -> Bair Build All Scheduler
// queued job nane -> Bair FULL or DELTA Build All
// ON_NOTIFY: Bair Build All Scheduler
	// Build payload delta
// Expected execution time -> 3-5 minutes DELTA
// Expected execution time -> 30-45 minutes FULL

// Bair.Build_Boolean_Full_Scheduler -> now Bair._CRON_Build_Boolean_Full
// scheduler job nane -> Bair Boolean Full Build Scheduler
// queued job nane -> Bair BOOLEAN Full Build and Deploy:
// ON_NOTIFY: bld_and_deploy_booleankeys_full
	// Build Boolean keys full
// Expected execution time -> 6-8 hours

// Bair.Build_Boolean_Delta_Scheduler -> now Bair._CRON_Build_Boolean_Delta
// scheduler job nane -> Bair Boolean Delta Build Scheduler
// queued job nane -> Bair BOOLEAN Delta Build and Deploy:
// ON_NOTIFY: bld_and_deploy_booleankeys_delta
	// Build Boolean keys delta
// Expected execution time -> 4-9 minutes

// Bair.Build_Composite_Full_Scheduler -> now Bair._CRON_Build_Comp_Full
// scheduler job nane -> Bair Composite Full Build Scheduler
// queued job nane -> Bair COMPOSITE Full Build and Deploy:
// ON_NOTIFY: bld_and_deploy_compositekeys_full
	// Build Composite keys full
// Expected execution time -> 4-6 hours

// Bair.Build_Composite_Delta_Scheduler -> now Bair._CRON_Build_Comp_Delta
// scheduler job nane -> Bair Composite Delta Build Scheduler
// queued job nane -> Bair COMPOSITE Delta Build and Deploy:
// ON_NOTIFY: bld_and_deploy_compositekeys_delta
	// Build Composite keys delta
// Expected execution time -> 30-45 minutes

// Bair.raidsReportController_CRON -> now Bair._CRON_RAIDS_Report_Controller
// scheduler job nane -> Bair Raids Report Controller
// queued job nane -> Bair Raids Report Monitor
// EVERY_TWO_MINUTES:
	// if any 'Bair Raids Report Email' in process, do nothing
		// else spin Bair.raidsReportScheduler_CRON by notifying the scheduler -> Bair Raids Report Scheduler
// Expected execution time -> 1 seconds

// Bair.raidsReport_CRON -> now Bair._CRON_Send_RAIDS_Report
// scheduler job nane -> Bair Raids Report Scheduler
// queued job nane -> Bair Raids Report Email
// EVERY_TWO_MINUTES or ON_NOTIFY: Bair Raids Report Scheduler
	// Build RAIDS Report and email it
// Expected execution time -> 30 seconds

// Bair.raidsReportScheduler_CRON -> same as Bair.raidsReport_CRON? now Bair._CRON_Send_RAIDS_Report
// scheduler job nane -> Bair Raids Report Scheduler
// queued job nane -> Bair Raids Report Email
// EVERY_TWO_MINUTES:
	// Build RAIDS Report and email it
// Expected execution time -> 30 seconds

//STEPS TO RUN A DR BUILD
// 1.	Run this in DR -> Bair._CRON_Master_Controller.fnSetThorDRstate(true);
// 2.	De-schedule jobs in Bair prod â€“ wait for all jobs in flight to complete
// 3.	De-schedule jobs in Bair DR â€“ wait for all jobs in flight to complete
// 4.	Wait for master controller to schedule jobs
// 5.	After master controller scheduled jobs run this -> Bair._CRON_Master_Controller.all
// 6. Run this in PROD -> Bair._CRON_Master_Controller.Backups;

//STEPS TO RUN A PROD BUILD
// 1.	Run this in DR -> Bair._CRON_Master_Controller.fnSetThorDRstate(false);
// 2.	De-schedule jobs in Bair DR â€“ wait for all jobs in flight to complete
// 3.	De-schedule jobs in Bair PROD â€“ wait for all jobs in flight to complete
// 4.	Wait for master controller to schedule jobs
// 5.	After master controller scheduled jobs run this -> Bair._CRON_Master_Controller.all
// 6. Run this in DR -> Bair._CRON_Master_Controller.Backups;
// 7.
