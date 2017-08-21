/*--SOAP--
<message name="headerFileSearchRequest" wuTimeout="300000">
  <part name="watchtype" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service builds the watchdog files.*/

export RunWatchdogService := MACRO

#workunit('name','Watchdog ' + watchdog.RunDate_build);

firstout := output('Building Watchdog files...');
lastout := output('Done Building Watchdog files...');

	sequential(firstout,
			 watchdog.BWR_Best(),
			 watchdog.BWR_Delta,
			 watchdog.BWR_Moxie_Key,
			 lastout)


ENDMACRO;