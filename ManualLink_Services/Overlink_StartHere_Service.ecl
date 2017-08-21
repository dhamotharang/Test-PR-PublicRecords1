/*--SOAP--
<message name="Overlink_StartHere_Service" wuTimeout="300000">

 <part name="ADL" 					type="xsd:unsignedInt" 	required="1"/>
 <part name="BugNumber" 		type="xsd:unsignedInt" 	required="1"/>
 <part name="Comments200" 	type="xsd:string200"  	cols="50" rows="4"/>
	
 </message>
*/
/*--INFO-- This service will show you the header records for this ADL and ask you to confirm that it is overlinked.*/
/*--OTX-- ManualLink_Services.otx_StartHere */

import zz_cemtemp;

export Overlink_StartHere_Service() := 
FUNCTION

unsigned6 myADL 			:= 0 	: stored('ADL');
unsigned6 myBug 			:= 0 	: stored('BugNumber');
string200 myComments 	:= '' : stored('Comments200');



ds_confirmation :=
dataset(	
	[{'CONFIRMATION REQUIRED.  CLICK HERE TO CONFIRM THAT THIS ADL IS OVERLINKED.',myADL,myBug,myComments}],
	{string200 confirmation_message,unsigned6 ADL, unsigned6 Bug, string200 Comments}
);

ConfirmationAction :=
parallel(
	output(ds_confirmation, named('confirmation')),
	output(zz_cemtemp.Key_Header(keyed(s_did = myADL)), named('HeaderRecords'))
);

NoADLAction :=
output('Please go back and enter an ADL.');

NoBugAction :=
output('Please go back and enter a Bug Numer.');

return 
map(
	myADL = 0 	=> NoADLAction,
	myBug = 0		=> NoBugAction,
								 ConfirmationAction
);


END;