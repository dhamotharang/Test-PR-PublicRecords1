import Spoke, STD,PRTE2, _control, PRTE, BIPV2;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'SpokeKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + 'd';

fKey_base      := DATASET([ ],Spoke.Layouts.Keybuild);
fKey_linkids   := DATASET([ ],{BIPV2.IDlayouts.l_key_ids,
                               Spoke.Layouts.keybuild, 
                               integer1 fp}
                               );

didKey      := INDEX(fKey_base, {did}, {fKey_base},prte2.constants.prefix + 'key::spoke::' + pIndexVersion + '::did'); 
bdidKey     := INDEX(fKey_base, {bdid},{fKey_base},prte2.constants.prefix + 'key::spoke::' + pIndexVersion + '::bdid'); 
linkidsKey	:= INDEX(fKey_linkids, 
                    {ultid,orgid,seleid,proxid,powid,empid,dotid},
                    {fKey_linkids}, 
                    prte2.constants.prefix + 'key::spoke::' + pIndexVersion + '::linkids'); 

//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(
                         parallel(
                                  build(didKey, update), 
                                  build(bdidKey, update), 
                                  build(linkidsKey, update)
                                  ),
                         PerformUpdateOrNot);

build_keys;                       
output ('successful');