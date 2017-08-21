import ut;

ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehiclefull','Q',out1)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_id','Q',out2)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_did','Q',out3)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName','Q',out3b)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag','Q',out4)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin','Q',out5)
ut.mac_sk_move('~thor_data400::wc_vehicle::keynameindex_'+doxie_build.buildstate,'Q',out6)
ut.mac_sk_move('~thor_data400::wc_vehicle::keymodelindex_'+doxie_build.buildstate,'Q',out7)
ut.MAC_SK_Move_v2('~thor_data400::key::'+doxie_build.buildstate+'vehicle_st_vnum','Q',out8)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid','Q',out9)
ut.MAC_SK_Move_v2('~thor_data400::key::bocashell_veh_did','Q',out10)
ut.MAC_SK_Move_v2('~thor_data400::key::vehicle::fcra::bocashell.did','Q',out11)
ut.MAC_SK_Move_v2('~thor_data400::key::vehicle::fcra::did','Q',out12)
ut.MAC_SK_Move_v2('~thor_data400::key::vehicle::fcra::full','Q',out13)
ut.MAC_SK_Move_v2('~thor_data400::key::fcra::publicvehicle_vin','Q',out14)
ut.MAC_SK_Move_v2('~thor_data400::key::publicvehicle_addr','Q',out15)

export Proc_AcceptSK_veh_toQA := parallel(out1, out2, out3, out3b, out4, out5, out6, out7, out8, out9,out10, out11, out12, out13,out14,out15);
