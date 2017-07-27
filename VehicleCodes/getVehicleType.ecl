import vehlic;
export getVehicleType(string2 st, string2 abrv, string3 vessel_abrv, string pDefaultValue='') :=
map(
st = 'FL' => getVehicleTypeFL(abrv, vessel_abrv),
st = 'MS' => getVehicleTypeMS(abrv, vessel_abrv),
st = 'OH' => getVehicleTypeOH(abrv, vessel_abrv),
st = 'MO' => getVehicleTypeMO(abrv, vessel_abrv),
vehlic.proper_case(pDefaultValue));