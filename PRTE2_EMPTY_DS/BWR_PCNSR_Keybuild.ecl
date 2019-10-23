import DayBatchPCNSR, STD,PRTE2, _control, PRTE, BIPV2, Data_Services;  

skipDOPS:=FALSE;
string emailTo:='';
dops_name := 'PCNSRKeys';

version :=(string8)STD.Date.CurrentDate(True);
pIndexVersion := version + '';


dsFile := dataset([], DayBatchPCNSR.Layout_PCNSR_prekey);


Key_PCNSR_DID  := index(dsFile(did!=0),{did},{dsFile},prte2.constants.prefix+'key::daybatch_pcnsr::'+ pIndexVersion+'::pcnsr.did');
Key_PCNSR_Address  := index(dsFile,{zip, prim_name, prim_range, sec_range},{dsFile}, 
                                    prte2.constants.prefix+'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.address');
                                    
Key_PCNSR_HHID := index(dsFile,{hhid},{dsFile}, prte2.constants.prefix+'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.hhid');  
Key_PCNSR_LZ3  := index(dsFile, {lname,zip,prim_name},{dsFile},
                                   prte2.constants.prefix+'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.lz3');
Key_PCNSR_Nbr  := index(dsFile, {zip,zip4,prim_name,prim_range,sec_range},{dsFile},
                                   prte2.constants.prefix+'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.zz4317_deduped');
Key_PCNSR_Phone    := index(dsFile,{phone_number,area_code,st},{dsfile},
                                  prte2.constants.prefix+ 'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.phone.area_code.st');
Key_PCNSR_Surnames := index(dsFile,{lname,zip,prim_name},{dsFile},
                                     prte2.constants.prefix+'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.lz3_deduped');
Key_PCNSR_Z317LF   :=  index(dsFile, {zip,prim_name,prim_range,sec_range,lname,fname},{dsFile},
                                     prte2.constants.prefix+'key::daybatch_pcnsr::'+pIndexVersion+'::pcnsr.z137lf');
                                  
//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, pIndexVersion, notifyEmail,'B','N','N');

PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(
                         parallel(
                                  build(Key_PCNSR_DID, update), 
                                  build(Key_PCNSR_Address, update), 
                                  build(Key_PCNSR_HHID, update), 
                                  build(Key_PCNSR_LZ3, update), 
                                  build(Key_PCNSR_Nbr, update), 
                                  build(Key_PCNSR_Phone, update), 
                                  build(Key_PCNSR_Surnames, update), 
                                  build(Key_PCNSR_Z317LF, update),
                                  ),
                                  PerformUpdateOrNot);

build_keys;                       
output ('successful');
                                  