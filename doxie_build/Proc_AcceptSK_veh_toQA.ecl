import ut;

ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehiclefull','Q',out1)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_id','Q',out2)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_did','Q',out3)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName','Q',out3b)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag','Q',out4)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin','Q',out5)
ut.mac_sk_move('~thor_data400::wc_vehicle::keynameindex_'+doxie_build.buildstate,'Q',out6)
ut.mac_sk_move('~thor_data400::wc_vehicle::keymodelindex_'+doxie_build.buildstate,'Q',out7)

export Proc_AcceptSK_veh_toQA := parallel(out1, out2, out3, out3b, out4, out5, out6, out7);