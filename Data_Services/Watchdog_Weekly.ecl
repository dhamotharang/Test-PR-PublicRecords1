/*--SOAP--
<message name="WatchdogWeekly">
</message>
*/

export Watchdog_Weekly := MACRO

output(choosen(watchdog.Key_Watchdog_GLB,10));
output(choosen(watchdog.Key_Watchdog_nonglb,10));
//output(choosen(watchdog.Key_Watchdog_Delta,10));
output(choosen(watchdog.Key_Best_SSN,10));
output(choosen(Suppress.Key_SSN_Bad,10));


ENDMACRO;