import ut;

ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehiclefull','R',out1)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_id','R',out2)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_did','R',out3)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName','R',out3b)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag','R',out4)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin','R',out5)
ut.mac_sk_move('~thor_data400::wc_vehicle::keynameindex_'+doxie_build.buildstate,'R',out6)
ut.mac_sk_move('~thor_data400::wc_vehicle::keymodelindex_'+doxie_build.buildstate,'R',out7)

export Proc_RollbackSK_veh := parallel(out1, out2, out3, out3b, out4, out5, out6, out7);