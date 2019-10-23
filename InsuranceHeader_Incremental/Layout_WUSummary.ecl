// Workman (workunit manager) layouts
EXPORT Layout_WUSummary := MODULE
	EXPORT names := RECORD
		STRING name;
	END;
	EXPORT Iters := RECORD
		STRING24 wuid;
		STRING owner;
		STRING cluster;
		STRING job;
		STRING10 state;
		STRING7 priority;
		BOOLEAN online;
		BOOLEAN protected;
		STRING totalthortime;
		STRING description;
		STRING version;
		STRING iteration;
		DATASET(names) filesread;
		DATASET(names) fileswritten;
	END;
	
	EXPORT WUInfo := RECORD
		STRING name{XPATH('name')};
		STRING wuid{XPATH('wuid')};
		STRING esp{XPATH('esp')};
		STRING env{XPATH('env')};
		STRING state{XPATH('state')};
		STRING iteration{XPATH('iteration')};
		STRING version{XPATH('version')};
		STRING total_thor_time{XPATH('total_thor_time')};
		REAL8 total_time_secs{XPATH('total_time_secs')};
		STRING run_total_thor_time{XPATH('run_total_thor_time')};
		REAL8 run_total_time_secs{XPATH('run_total_time_secs')};
		STRING subotal_thor_time{XPATH('subotal_thor_time')};
		REAL8 subtotal_time_secs{XPATH('subtotal_time_secs')};
		STRING time_finished{XPATH('time_finished')};
		STRING errors{XPATH('errors')};
	END;
END;
