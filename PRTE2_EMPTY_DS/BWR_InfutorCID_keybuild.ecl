import STD,PRTE2, _control, PRTE, Data_Services, InfutorCID;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name 			:= 'InfutorcidKeys';
dops_name_fcra 	:= 'FCA_InfutorcidKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';


dsFile := dataset([], layouts.infutor_cid);


Key_did     := index(dsFile,{did},{dsFile},prte2.constants.prefix+'key::infutorcid::'+ pIndexVersion+'::did');
Key_phone  := index(dsFile,{phone},{dsFile},prte2.constants.prefix+'key::infutorcid::'+ pIndexVersion+'::phone');
Key_did_fcra    := index(dsFile,{did},{dsFile},prte2.constants.prefix+'key::infutorcid::'+ pIndexVersion+'::did_fcra');
Key_phone_fcra  := index(dsFile,{phone},{dsFile},prte2.constants.prefix+'key::infutorcid::'+ pIndexVersion+'::phone_fcra');


//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');
updatedops_fcra	  	:= PRTE.UpdateVersion(dops_name_fcra, pIndexVersion, notifyEmail,'B','F','N');
PerformUpdateOrNot	:= IF(not skipDops,parallel(updatedops,updatedops_fcra), NoUpdate);

build_keys := sequential(parallel(build(Key_did, update), 
                                  build(Key_phone, update), 
                                  build(Key_did_fcra, update), 
                                  build(Key_phone_fcra, update)), 
                        PerformUpdateOrNot
												);

build_keys;                       
output ('successful');