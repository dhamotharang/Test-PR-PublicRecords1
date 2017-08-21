import PromoteSupers,header;
export Proc_Accept_SRC_toQA(string filedate='00000000') := function

PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::header.rid_fheader','Q',out7prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::header_rid_srid_fheader','Q',out23prep,2)
PromoteSupers.mac_sk_move_v2('~thor_data400::key::dlv2_src_index_fheader','Q',do5prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::bkv2_src_index_fheader','Q',do3prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::veh_v2_src_index_fheader','Q',do27prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::propasses_src_index_fheader','Q',do11prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::propdeed_src_index_fheader','Q',do12prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::lienv2_src_index_fheader','Q',do23prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::eq_src_index_fheader','Q',do20prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::experian_src_index_fheader','Q',do31prep,2);
PromoteSupers.mac_sk_move_v2('~thor_data400::key::TN_src_index_fheader','Q',do33prep,2);

return sequential(
								out7prep
								,out23prep
								,do5prep
								,do3prep
								,do27prep
								,do11prep
								,do12prep
								,do23prep
								,do20prep
								,do31prep
								,do33prep
								);

end;