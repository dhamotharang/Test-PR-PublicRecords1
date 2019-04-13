//Prte2.layouts.DEFLT_CPA will probably not be needed in this BWR. Awaiting production update of SalesChannel.layouts.keybuild.

import SalesChannel, STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'SalesChannelKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

dkeybuild :=    DATASET([ ],SalesChannel.layouts.keybuild);
linkbuild :=    DATASET([ ],layouts);

bdidKey := INDEX(dkeybuild,{bdid},{dkeybuild},prte2.constants.prefix + 'key::saleschannel::' + pversion + '::bdid'); 

didKey := INDEX(dkeybuild,{did},{dkeybuild},prte2.constants.prefix + 'key::saleschannel::' + pversion + '::did'); 

LinkKey := INDEX(linkbuild,
{ultid,orgid,seleid,proxid,powid,empid,dotid},{linkbuild},
prte2.constants.prefix + 'key::saleschannel::' + pversion + '::linkids'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(didKey);

//BUILD(bdidKey);

//BUILD(linkKey);

PerformUpdateOrNot;

output ('successful');

