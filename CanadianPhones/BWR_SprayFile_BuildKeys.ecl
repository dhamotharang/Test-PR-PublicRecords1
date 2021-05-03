import Canadianphones, ut,Roxiekeybuild, Canadianphones_V2, Scrubs_CanadianPhones, DOPS;



export BWR_SprayFile_BuildKeys(STRING  pVersion,
															STRING  pSource,
															STRING  pHostname
															) := function
#workunit('name','Canadian Phones & V2 - ' + pVersion);


//READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME////READ ME//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Update Frequency: Monthly Full File Replace; However all files should be sprayed and processed so that we keep history.
//FTP data from:\\tapeload02b\k\telephone\wp_canadian_(ex) to edata12:):/hds_2/telephones/canadian> **This is infousa data that no longer updates
//FTP data from:\\tapeload02b\k\eda\acxiom to edata12:):/hds_2/telephones/canadian/axciom>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Process Input Files, Build keys, Pull and Distribute QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//pVersion := '20100727';
//pSource  := '/data/Builds/builds/CanadianPhones/data'
//pHostname := 'bctlpedata12.risk.regn.net'

dops_update := DOPS.updateversion('CanadianPhonesKeys',pVersion,'kevin.reeder@lexisnexisrisk.com;Jason.Allerdings@lexisnexisrisk.com',,'N');
dops_update_v2 := DOPS.updateversion('CanadianPhonesV2Keys',pVersion,'kevin.reeder@lexisnexisrisk.com;Jason.Allerdings@lexisnexisrisk.com',,'N');

return sequential(
CanadianPhones.spray_CanadianWhitepages(pVersion, pSource,	pHostname)
//,Canadianphones.map_CanadianWhitepages **infousa residences - no longer updating, historical data only**
//,Canadianphones.map_infoUSACanBus **infousa residences - no longer updating, historical data only**
//,Canadianphones.map_axciomCanBus(pVersion) - no longer updating, historical data only
//,Canadianphones.map_axciomCanRes(pVersion) - no longer updating, historical data only
,Canadianphones.map_InfutorWP(pVersion)
,Scrubs_CanadianPhones.PreBuildScrubs(pVersion)
,CanadianPhones.strata_popCanadianPhonesInfutor(pVersion).all
,CanadianPhones.proc_build_cwp_keys(pVersion) 
,dops_update
,CanadianPhones.sample_CanadianBase
,CanadianPhones_V2.map_InfutorWP_v2(pVersion)
,CanadianPhones_V2.proc_build_base
,CanadianPhones_V2.proc_build_cwp_keys(pVersion)
,CanadianPhones_V2.strata_popFileCanadianPhonesV2Base(pVersion)
,dops_update_v2
,fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::InfutorWP')
,fileservices.clearsuperfile(CanadianPhones.thor_cluster + 'in::InfutorWP_v2')
);

end;

