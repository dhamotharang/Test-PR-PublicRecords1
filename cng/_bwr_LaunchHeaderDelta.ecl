// RUNS the header delta code at whatever time, day, month... you specify using the scheduler. 

EXPORT events := MODULE
	EXPORT dailyAtMidnight := CRON('0 0 * * *');
	EXPORT dailyAt( INTEGER hour, INTEGER minute=0) := EVENT('CRON',(STRING)minute + ' ' + (STRING)hour + ' * * *');
	EXPORT dailyAtMidday := dailyAt(12, 0);
	EXPORT EveryTwelveHours := CRON('0 0-23/12 * * *');
END;

cng.header_deltas() : WHEN(events.dailyAtMidnight);

