import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'DataBridgeKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

dkeybuild :=    DATASET([ ],Layouts);

dKey := INDEX(dkeybuild,{ultid,orgid,seleid,proxid,powid,empid,dotid},{dkeybuild},prte2.constants.prefix + 'key::databridge::' + pversion + '::linkids'); 

//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:= PRTE.UpdateVersion(dops_name, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean:='N');
	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILDIndex(dKey);

PerformUpdateOrNot;

output ('successful');

