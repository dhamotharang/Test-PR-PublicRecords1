import ut;

ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehiclefull','P',out1)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_id','P',out2)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_did','P',out3)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_coName','P',out3b)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_tag','P',out4)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_vin','P',out5)
ut.mac_sk_move('~thor_data400::wc_vehicle::keynameindex_'+doxie_build.buildstate,'P',out6)
ut.mac_sk_move('~thor_data400::wc_vehicle::keymodelindex_'+doxie_build.buildstate,'P',out7)
ut.MAC_SK_Move_v2('~thor_data400::key::'+doxie_build.buildstate+'vehicle_st_vnum','P',out8)
ut.mac_sk_move('~thor_data400::key::'+doxie_build.buildstate+'vehicle_bdid','P',out9)
ut.MAC_SK_Move_v2('~thor_data400::key::bocashell_veh_did','P',out10)

export Proc_AcceptSK_veh_toProd := parallel(out1, out2, out3, out3b, out4, out5, out6, out7, out8, out9, out10);