import PromoteSupers;
export Proc_Accept_SRC_toQA(string filedate=header.version_build, boolean pFastHeader=false) := function

PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::header.rid_header','QM',M1,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::header_rid_srid_header','QM',M2,2)

PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::dlv2_src_index_header','QM',M3,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::bkv2_src_index_header','QM',M4,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::veh_v2_src_index_header','QM',M5,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::propasses_src_index_header','QM',M6,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::propdeed_src_index_header','QM',M7,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::lienv2_src_index_header','QM',M8,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::eq_src_index_header','QM',M9,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::experian_src_index_header','QM',M10,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::TN_src_index_header','QM',M11,2);

PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::ak_src_index','QM',M12,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::atf_src_index','QM',M13,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::em_src_index','QM',M14,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::ms_src_index','QM',M15,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::death_src_index','QM',M16,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::statedeath_src_index','QM',M17,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::prof_src_index','QM',M18,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::util_src_index','QM',M19,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::airm_src_index','QM',M20,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::for_src_index','QM',M21,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::dea_src_index','QM',M22,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::water_src_index','QM',M23,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::airc_src_index','QM',M24,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::boater_src_index','QM',M25,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::targ_src_index','QM',M26,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::voters_src_index','QM',M27,2);
PromoteSupers.Mac_SK_Move_v2('~thor_data400::key::nod_src_index','QM',M28,2);


return parallel(
								M1
								,M2

								,M3
								,M4
								,M5
								,M6
								,M7
								,M8
								,M9
								,M10
								,M11

								,M12
								,M13
								,M14
								,M15
								,M16
								,M17
								,M18
								,M19
								,M20
								,M21
								,M22
								,M23
								,M24
								,M25
								,M26
								,M27
								,M28
								);

end;