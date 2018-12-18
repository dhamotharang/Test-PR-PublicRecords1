import ut,roxiekeybuild,promotesupers;

export Proc_FCRAacceptSK_toQA(string filedate, boolean pFastHeader=false) := function

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::fcra::header','Q',out1,2);
roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::fcra::hdr_apt_bldgs','Q',out2,2)
roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::fcra::en_hdr_apt_bldgs','Q',out3,2)
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::fcra::header_address','Q',out4,2);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::fcra::max_dt_last_seen','Q',out5,2);
roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::fcra::header.legacy_ssn','Q',out6,2);
roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::fcra::header.did.ssn.date','Q',out10,2);
roxiekeybuild.MAC_SK_Move_v2('~thor_data400::key::fcra::header::address_rank','Q',out11,2);
promotesupers.mac_SF_Move('~thor_data400::base::fcra_header','P',out7);
promotesupers.mac_SF_Move('~thor_data400::base::fcra_hhid','P',out8);
promotesupers.mac_SF_Move('~thor_data400::base::file_fcra_header_building','P',out9);

all_keys := sequential(
											out1
											,out2
											,out3
											,out4
											,out5
											,out6

											,out7
											,out8
											,out9
											,out10
											,out11
											);

return all_keys;

end;