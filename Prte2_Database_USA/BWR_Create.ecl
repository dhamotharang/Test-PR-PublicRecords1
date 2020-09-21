import dx_Database_USA,STD, PRTE2, _control, PRTE, dops, Orbit3; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'DatabaseUSAKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

dkeybuild :=    DATASET([ ],dx_Database_USA.Layout_Keybase);


didKey := INDEX(dkeybuild,{did},{dkeybuild},prte2.constants.prefix + 'key::database_usa::' + pversion + '::did'); 

Key_Validation     := output(dops.ValidatePRCTFileLayout(pversion, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, dops_name, 'N'));

orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - Database_USA', pversion, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);

                            
//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILDIndex(didKey);

PerformUpdateOrNot;
Key_validation;
orbit_update;

output ('successful');
