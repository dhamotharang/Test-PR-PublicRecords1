import Canadianphones, ut,Roxiekeybuild, Canadianphones_V2, Scrubs_CanadianPhones;



export BWR_SprayFile_BuildKeys(string filedate) := function



//READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Update Frequency: Monthly Full File Replace; However all files should be sprayed and processed so that we keep history.
//FTP data from:\\tapeload02b\k\telephone\wp_canadian_(ex) to edata12:):/hds_2/telephones/canadian> **This is infousa data that no longer updates
//FTP data from:\\tapeload02b\k\eda\acxiom to edata12:):/hds_2/telephones/canadian/axciom>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Process Input Files, Build keys, Pull and Distribute QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//filedate := '20100727';
//vsDate   := ut.GetDate;
dops_update := Roxiekeybuild.updateversion('CanadianPhonesKeys',filedate,'john.freibaum@lexisnexis.com',,'N');
dops_update_v2 := Roxiekeybuild.updateversion('CanadianPhonesV2Keys',filedate,'john.freibaum@lexisnexis.com',,'N');

return sequential(
CanadianPhones.spray_CanadianWhitepages(filedate)
//,Canadianphones.map_CanadianWhitepages **infousa residences - no longer updating, historical data only**
//,Canadianphones.map_infoUSACanBus **infousa residences - no longer updating, historical data only**
,Canadianphones.map_axciomCanBus(filedate)
,Canadianphones.map_axciomCanRes(filedate) 
,Scrubs_CanadianPhones.Axciom_Bus_Proc_Submit_Stats(filedate)			//BUG201215
,Scrubs_CanadianPhones.Axciom_Res_Proc_Submit_Stats(filedate)			//BUG201215
,CanadianPhones.strata_popCanadianPhonesBaseBus
,CanadianPhones.strata_popCanadianPhonesBaseRes
,CanadianPhones.proc_build_cwp_keys(filedate) 
,dops_update
,CanadianPhones.sample_CanadianBase
,CanadianPhones_V2.map_axciomCanBus(filedate)
,CanadianPhones_V2.map_axciomCanRes(filedate)
,CanadianPhones_V2.proc_build_base
,CanadianPhones_V2.proc_build_cwp_keys(filedate)
,CanadianPhones_V2.strata_popFileCanadianPhonesV2Base(filedate)
,dops_update_v2
,fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::axciombus')
,fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::axciomres')
,fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::axciombus_v2')
,fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::axciomres_v2')
);

end;

