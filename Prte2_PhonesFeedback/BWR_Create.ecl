import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'PhonesFeedbackKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

addressbuild :=    DATASET([ ],layouts.address_layout);

didbuild :=        DATASET([ ],layouts.did_layout);

phonebuild :=      DATASET([ ],layouts.phone_layout);


addressKey := INDEX(addressbuild,{prim_range,prim_name,predir,addr_suffix,sec_range,zip5},{addressbuild},
              prte2.constants.prefix + 'key::phonesfeedback::' + pversion + '::address'); 
						
didKey := INDEX(didbuild,{did},{didbuild},
          prte2.constants.prefix + 'key::phonesfeedback::' + pversion + '::did'); 
							
phoneKey := INDEX(phonebuild,{phone_number},{phonebuild},
         prte2.constants.prefix + 'key::phonesfeedback::' + pversion + '::phone'); 
	 		 
//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B', l_inenvment:='N', l_includeboolean:='N');
	
	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILDIndex(addressKey);

BUILDIndex(didKey);

BUILDIndex(phoneKey);

PerformUpdateOrNot;

output ('successful');

