﻿EXPORT email_msg(string wuid,boolean pUseProd) := MODULE

EXPORT NOC_MSG
	:=
	'** NOC **\n\n'

	+'http://' + IF(pUseProd,IDA._Constants().PROD_ESP,IDA._Constants().DATALAND_ESP) + ':8010/?legacy&inner=../WsWorkunits/WUInfo%3FWuid%3D'+wuid+'\n\n'

	+'Please investigate cause of failure of workunit '+wuid+' linked\n'
	+'above in' + IF(pUseProd,IDA._Constants().PROD_ESP,IDA._Constants().DATALAND_ESP) + ' THOR.  Then please resubmit it to ensure process\n'
	+'is running.\n\n'

	+'If the error message includes mention of "SOAP RPC error" or similar, this has historically\n'
	+'meant one or more Prod Thor ESP services require a bounce.\n\n'

	+'If this failure has occurred during the maintenance window, it is possibly related to network\n'
	+'or other updates/changes. Please resubmit knowing it is possible that it may fail again if\n'
	+'maintenance is ongoing.  In that case, you may delay resubmission temporarily,\n'
	+'but please do not forget.\n\n'

	+'If issues persist/repeat outside the Sunday maintenance window,\n'
	+'please contact fernando.incarnacao@lexisnexis.com and Jose.Bello@lexisnexis.com for assistance.\n'
	;

END;