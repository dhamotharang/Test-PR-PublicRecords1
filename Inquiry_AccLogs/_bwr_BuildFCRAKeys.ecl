import ut, data_services;

valid_states := ['running','queued','compiling','blocked'];

RunningWU := count(WorkunitServices.WorkunitList('')(job = 'FCRA Inquiry Logs Keys' and wuid <> workunit and state in valid_states)) > 0;

if(~RunningWU, inquiry_acclogs.ProcBuildFCRAKeys()) 
:	when(cron('01 0-23/6 * * 7'));