import _Control,header,Roxiekeybuild,dops; 

elist:=         'gabriel.marcan@lexisnexisrisk.com'
             + ',Debendra.Kumar@lexisnexisrisk.com'
 			 + ',jose.bello@lexisnexisrisk.com'
			 + ',Michael.Gould@lexisnexisrisk.com'
;

// // // // // // // // // FullHeader DOPS update

// h_version := Header.version_build;
h_version := '20180926';

dops.updateversion('SourceKeys'             ,h_version,elist,,'N'); // header // Show Sources <=== NOTE !! RELEASE THE DAY AFTER
dops.updateversion('PersonHeaderKeys'       ,h_version,elist,,'N'); // header // Header
dops.updateversion('PersonHeaderWeeklyKeys' ,h_version,elist,,'N'); // header // Header
dops.updateversion('PersonSlimsortKeys'     ,h_version,elist,,'N'); // header // Slimsorts
dops.updateversion('PersonLabKeys'          ,h_version,elist,,'N'); // header // PersonXLAB
dops.updateversion('RelativeV3Keys'         ,h_version,elist,,'N'); // header // RelativesV3
dops.updateversion('PersonAncillaryKeys'    ,h_version,elist,,'N'); // header // PersonAncillaryKeys
dops.updateversion('AddressRawAIDKeys'      ,h_version,elist,,'N'); // header // AddressRawAIDKeys

dops.updateversion('FCRA_PersonHeaderKeys'  ,h_version,elist,,'F'); // header // FCRA_Header
dops.updateversion('AddressRawAIDKeys'      ,h_version,elist,,'F'); // header // FCRA_Header

dops.updateversion('RemoteLinkingKeys'      ,h_version,elist,,'N'); // header // RemoteLinkingKeys



dops.updateversion('PersonHeaderKeys'       ,h_version,elist,,'B'); // header // <=== NOTE !! RELEASE THE DAY AFTER
dops.updateversion('PowerSearchKeys'        ,h_version,elist,,'B'); // header // <=== NOTE !! RELEASE THE DAY AFTER

// // // // // // // // // QuickHeader DOPS update

// qh_version := Header.Sourcedata_month.v_eq_as_of_date; // 'thor_data400::flag::version::equifax_weekly'
qh_version := '20181028';

// rt_version := qh_version;//+'a';
rt_version := '20181028';

dops.updateversion('QuickHeaderKeys'     ,qh_version,elist,,'N'); // orbit: Quick Header
dops.updateversion('QHsourceKeys'        ,qh_version,elist,,'N'); // orbit: QHsourceKeys
dops.updateversion('FCRA_QuickHeaderKeys',qh_version,elist,,'F'); // orbit: FCRA_Quick_Header

dops.updateversion('RiskTableKeys'       ,rt_version,elist,,'N'); // orbit: Risk Indicator
dops.updateversion('FCRA_RiskTableKeys'  ,rt_version,elist,,'F'); // orbit: FCRA_Risk_Indicator

// Previous runs:
// --------------

// 20180724 W20180827-111117, W20180827-112227
// 20180626 W20180717-130929, W20180719-090656
// 20180522 W20180621-131050
// 20180320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-141513#/stub/Summary 
// 20170221 W20180320-130359, http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180321-083453#/stub/Summary
// 20170130 
// 20171025a
// W20171129-131843 20171025
// W20171102-133021 20170925
// W20170808-122919 20170628
// W20170724-104501 20170522
// W20170612-103318
// W20170306-210632
// W20170222-122452, W20170222-122806, W20170222-125240 20170123
// W20170118-085218 20161220
// W20160926-105240