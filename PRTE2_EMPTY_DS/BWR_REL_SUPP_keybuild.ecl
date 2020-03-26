import STD,PRTE2, _control, PRTE, BIPV2, Data_Services;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'RelV3SuppKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';


dsFile := dataset([], layouts.rel_supp);


Key_rel_supp  := index(dsFile,{did1, did2},{dsFile},prte2.constants.prefix+'key::insurance_header::'+ pIndexVersion+'::relatives_suppress');
//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(build(Key_rel_supp, update), 
                        PerformUpdateOrNot);

build_keys;                       
output ('successful');