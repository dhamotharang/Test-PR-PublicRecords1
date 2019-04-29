import Zoom, STD,PRTE2, _control, PRTE;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'ZoomKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + 'a';

fKey_base     := DATASET([ ],Zoom.Layouts.Keybuild);
ds_zoomid     := DATASET([ ],layouts.zomm_Layout_fixed_zoomid);
ds_ZoomXML    := DATASET([ ],Zoom.Layouts.KeyXML);
fKey_linkids  := DATASET([ ],{Zoom.layouts.Keybuild_BIP,integer1 fp});

fKey_zoomid   := project(ds_zoomid, transform(layouts.zomm_Layout_fixed_zoomid, self.zoomId := '', self := left));


didKey      := INDEX(fKey_base, {did}, {fKey_base},prte2.constants.prefix + 'key::zoom::' + pIndexVersion + '::did'); 
bdidKey     := INDEX(fKey_base, {bdid}, {fKey_base},prte2.constants.prefix + 'key::zoom::' + pIndexVersion + '::bdid'); 
zoomidKey   := INDEX(fKey_zoomid, {zoomID}, {fKey_zoomid},prte2.constants.prefix + 'key::zoom::' + pIndexVersion + '::ZoomId'); 
zoomXMLKey  := INDEX(ds_ZoomXML, {rawfields.ZoomID}, {ds_ZoomXML},prte2.constants.prefix + 'key::zoom::' + pIndexVersion + '::XMLZoomId'); 
linkidsKey	:= INDEX(fKey_linkids, 
                    {ultid,orgid,seleid,proxid,powid,empid,dotid,
                    ultscore,orgscore,selescore,proxscore,powscore,
                    empscore,dotscore,ultweight,orgweight,seleweight,
                    proxweight,powweight,empweight,dotweight}, 
                    {fKey_linkids}, 
                    prte2.constants.prefix + 'key::zoom::' + pIndexVersion + '::linkids'); 


//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(
                         parallel(
                                  build(didKey, update), 
                                  build(bdidKey, update), 
                                  build(zoomidKey, update),
                                  build(zoomXMLKey, update),
                                  build(linkidsKey, update)
                                  ),
                         PerformUpdateOrNot);

build_keys;                       
output ('successful');