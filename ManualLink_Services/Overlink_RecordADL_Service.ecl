/*--SOAP--
<message name="Overlink_RecordADL_Service" wuTimeout="300000">

 <part name="ADL" 					type="xsd:unsignedInt" 	required="1"/>
 <part name="BugNumber" 		type="xsd:unsignedInt" 	required="1"/>
 <part name="Comments200" 	type="xsd:string200"  	cols="50" rows="4"/>
	
 </message>
*/
/*--INFO-- Please do not use this service directly.*/

import zz_Cemtemp,doxie,ut;
export Overlink_RecordADL_Service() := 
FUNCTION

unsigned6 myADL 			:= 0 	: stored('ADL');
unsigned6 myBug 			:= 0 	: stored('BugNumber');
string200 myComment 	:= '' : stored('Comments200');


//***** DO SOME FILE SHUFFLING AND REPORT TO USER *****
ZeroDIDMessage() :=
FUNCTION
	return output('No action taken.  DID = 0');
END;

SuccessMessage() :=
FUNCTION
	return output((string)myADL + ' added to Dodgy DID list.  Thank you, ' + thorlib.jobowner() + ', for using ManualLink.');
END;

act :=
if(
	myADL = 0, 
	ZeroDIDMessage(),
	sequential(	
		ManualLink_Services.functions.AddRecord(myADL,myBug,myComment),
		SuccessMessage()
	)
);


return act;

END;