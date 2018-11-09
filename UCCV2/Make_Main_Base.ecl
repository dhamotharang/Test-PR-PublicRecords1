import address, did_add, didville,PromoteSupers,header_slimsort,UccV2,business_header,Business_Header_SS;


PromoteSupers.MAC_SF_BuildProcess(UCCV2.proc_build_CA_main_base,uccv2.cluster.cluster_out+'base::UCC::main::CA',OutCA, 2,,true);
PromoteSupers.Mac_SF_BuildProcess(UCCV2.proc_build_DNB_main_base,uccv2.cluster.cluster_out+'base::UCC::main::DNB',OutDNB, 2,,true);
PromoteSupers.MAC_SF_BuildProcess(UCCV2.proc_build_IL_main_base,uccv2.cluster.cluster_out+'base::UCC::main::IL',OutIL, 2,,true);
PromoteSupers.MAC_SF_BuildProcess(UCCV2.proc_build_MA_main_base,uccv2.cluster.cluster_out+'base::UCC::main::MA',OutMA, 2,,true);
PromoteSupers.MAC_SF_BuildProcess(UCCV2.proc_build_NYC_main_base,uccv2.cluster.cluster_out+'base::UCC::main::NYC',OutNYC, 2,,true);
PromoteSupers.MAC_SF_BuildProcess(UCCV2.proc_build_TX_main_base,uccv2.cluster.cluster_out+'base::UCC::main::TX',OutTX, 2,,true);
PromoteSupers.MAC_SF_BuildProcess(UCCV2.proc_build_Harris_TX_main_base,uccv2.cluster.cluster_out+'base::UCC::main::TH',OutTH, 2,,true);
outWA	:=	UCCV2.proc_build_WA_main_base;

oCA :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccv2::CA::initialfiling')>0),outCA,output('no new data in CA'));
oDnB:=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::dnb::financingStatement')>0),outDNB,output('no new data in DnB'));
oIL :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::IL::filing')>0),outIL,output('no new data in IL'));
oMA :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::MA')>0),outMA,output('no new data in MA'));
oNYC:=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::NYC::master')>0),outNYC,output('no new data in NYC'));
oTX :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::Tx::Filing ')>0),outTX,output('no new data in TX'));
oTH :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::TH ')>0),outTH,output('no new data in TH'));
oWA :=IF(NOTHOR(FileServices.GetSuperFileSubCount('~thor_data400::in::uccV2::WA')>0),outWA,output('no new data in WA'));

Done:=parallel(
								oCA,oDnB,oIL,oMA,oNYC,oTX,oTH,oWA);

export Make_Main_Base := Done;