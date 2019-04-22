import One_Click_Data, STD,PRTE2, _control, PRTE, BIPV2;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'OneClickDataKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';

fKey_base      := DATASET([ ],One_Click_Data.Layouts.Keybuild);
fKey_linkids   := DATASET([ ],{One_Click_Data.Layouts.Temporary.Keybuild_Linkids,integer1 fp});

didKey      := INDEX(fKey_base, {did}, {fKey_base},prte2.constants.prefix + 'key::one_click_data::' + pIndexVersion + '::did'); 
bdidKey     := INDEX(fKey_base, {bdid}, {fKey_base},prte2.constants.prefix + 'key::one_click_data::' + pIndexVersion + '::bdid'); 
linkidsKey	:= INDEX(fKey_linkids, 
                    {ultid,orgid,seleid,proxid,powid,empid,dotid,
                    ultscore,orgscore,selescore,proxscore,powscore,
                    empscore,dotscore,ultweight,orgweight,seleweight,
                    proxweight,powweight,empweight,dotweight}, 
                    {fKey_linkids}, 
                    prte2.constants.prefix + 'key::one_click_data::' + pIndexVersion + '::linkids'); 

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