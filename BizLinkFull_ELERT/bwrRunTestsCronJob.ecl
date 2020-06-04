import BizLinkFull_ELERT;

// #workunit('name', 'BIP ELERT Cron - Sources');
// BizLinkFull_ELERT.macCronJob(1) : WHEN(CRON('0 0 1 * *')); // ALL SOURCES RUN, FIRST OF MONTH AT MIDNIGHT

#workunit('name', 'BIP ELERT Cron - Stats');
BizLinkFull_ELERT.macCronJob(2) : WHEN(CRON('0 0 1 * *')); // STATS RUN, FIRST OF MONTH AT MIDNIGHT
