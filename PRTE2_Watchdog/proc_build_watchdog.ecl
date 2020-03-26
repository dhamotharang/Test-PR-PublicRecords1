IMPORT Roxiekeybuild,Watchdog,Suppress,header,std,PRTE2_Header,_Control;

EXPORT proc_build_watchdog(string filedate) := function

	Roxiekeybuild.Mac_SK_BuildProcess_v2_local(prte2_watchdog.key_watchdog(), prte2_watchdog.constants.keyname_watchdog + 'univesal', prte2_watchdog.constants.keyname_watchdog + filedate+ '::univesal', k01); 

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2( prte2_watchdog.constants.keyname_watchdog +'@version@'+'::univesal' ,prte2_watchdog.constants.keyname_watchdog + filedate+ '::univesal', mb01); 

  Roxiekeybuild.Mac_SK_Move_V2(prte2_watchdog.constants.keyname_watchdog +'@version@'+'::univesal', 'Q', mq01);

  buildKey := SEQUENTIAL(
													k01,
													mb01,
													mq01
													);

  RETURN buildKey;

END;