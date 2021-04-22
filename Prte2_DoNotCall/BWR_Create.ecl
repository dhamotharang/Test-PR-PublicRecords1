
import DMA,STD, PRTE2, _control, PRTE, dops, Orbit3; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'DoNotCallKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

phonekeybuild :=    DATASET([ ],DMA.layout_suppressionTPS.Delta);


phoneKey := INDEX(phonekeybuild,{phonenumber},{phonekeybuild},prte2.constants.prefix + 'key::dnc::' + pversion + '::phone'); 

key_validation :=  output(dops.ValidatePRCTFileLayout(pversion, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,dops_name, 'N'), named(dops_name+'Validation'));

orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - DoNotCallKeys', pversion, 'PN', email_list:= _control.MyInfo.EmailAddressNormal);

                            
//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);
//----------------------------------------------------------------------------------

BUILDIndex(phoneKey);

PerformUpdateOrNot;
key_validation;
orbit_update;

output ('successful');
