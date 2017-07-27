/*--SOAP--
	<part name="DataRestrictionMask" type="xsd:string"/>
<message name="WatchdogWeekly">
</message>
*/

export WatchdogKeys := MACRO

output(choosen(watchdog.Key_Watchdog_GLB,10));
output(choosen(watchdog.Key_Watchdog_nonglb,10));
//output(choosen(watchdog.Key_Watchdog_Delta,10));
output(choosen(watchdog.Key_Best_SSN,10));
output(choosen(Suppress.Key_SSN_Bad,10));
output(choosen(watchdog.key_watchdog_glb_nonblank,10));
output(choosen(watchdog.key_watchdog_nonglb_nonblank,10));
output(choosen(Watchdog.Key_Watchdog_GLB_nonExperian,10));
output(choosen(Watchdog.Key_Watchdog_GLB_nonExperian_nonblank,10));
output(choosen(Watchdog.key_watchdog_teaser,10));
output(choosen(Header.Key_Teaser_search,10));
output(choosen(Header.Key_Teaser_did,10));
output(choosen(Watchdog.Key_Watchdog_GLB_nonEquifax,10));
output(choosen(Watchdog.Key_Watchdog_GLB_nonEquifax_nonblank,10));
output(choosen(Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax,10));
output(choosen(Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank,10));


ENDMACRO;