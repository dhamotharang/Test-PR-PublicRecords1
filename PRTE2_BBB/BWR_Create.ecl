import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'BBBKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

MemBdidBuild :=       DATASET([ ],Layouts.Membdid);
NonMemBdidBuild :=    DATASET([ ],Layouts.NonMembdid);
MemLinkidsBuild :=    DATASET([ ],Layouts.MemLinkids);
NonMemLinkidsBuild := DATASET([ ],Layouts.NonMemLinkids);


MemBdidKey := INDEX(MemBdidBuild,
{bdid},{MemBdidbuild},
prte2.constants.prefix + 'key::bbb::' + pversion + '::member::bdid'); 

NonMemBdidKey := INDEX(NonMemBdidBuild,
{bdid},{NonMemBdidbuild},
prte2.constants.prefix + 'key::bbb::' + pversion + '::nonmember::bdid'); 

MemLinkids := INDEX(MemLinkidsBuild,
{ultid,orgid,seleid,proxid,powid,empid,dotid},{MemLinkidsBuild},
prte2.constants.prefix + 'key::bbb::' + pversion + '::member::linkids'); 

NonMemLinkids := INDEX(NonMemLinkidsBuild,
{ultid,orgid,seleid,proxid,powid,empid,dotid},{NonMemLinkidsBuild},
prte2.constants.prefix + 'key::bbb::' + pversion + '::nonmember::linkids'); 


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);


BUILD(membdidKey);
BUILD(nonmembdidKey);
BUILD(memlinkids);
BUILD(nonmemlinkids);

PerformUpdateOrNot;

output ('successful');

