import STD,PRTE2, _control, PRTE, Data_Services, Vendor_Src; 

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'VendorSourceKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';

ds := dataset([], {Vendor_Src.layouts.Base}-county_text);

Key_source       := index(ds,{source_code},{ds},prte2.constants.prefix+'key::vendor_src_info::'+ pIndexVersion+'::vendor_source');


//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(build(Key_source, update), 
                         PerformUpdateOrNot
												);

build_keys;                       
output ('successful');

