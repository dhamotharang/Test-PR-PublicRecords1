import VehLic, doxie_files;

_st :=  VehLic.FL_As_Vehicles 
 +	VehLic.MS_as_Vehicles 
 +	VehLic.TX_As_Vehicles
 +	VehLic.WI_As_Vehicles
 +	VehLic.OH_As_Vehicles
 +	VehLic.MN_as_Vehicles
 +	VehLic.MO_as_Vehicles
 +	VehLic.NC_as_Vehicles
 +	VehLic.MO_Vsl_As_Vehicles
 +	VehLic.ME_as_Vehicles
 +	VehLic.NE_as_Vehicles
 +  VehLic.ID_as_Vehicles
 +  VehLic.NM_as_Vehicles
 +	VehLic.ND_as_Vehicles
 +	VehLic.MT_as_Vehicles
 +	VehLic.WY_as_Vehicles
 +	VehLic.NV_as_Vehicles
 +	VehLic.KY_as_Vehicles;

doxie_files.Layout_Vehicles tol(_st L) :=
TRANSFORM
	SELF.record_type := ''; // should be in each state's 'as_vehicles' attribute
	SELF := L;
END;

export Vehicles_Incoming := PROJECT(_st, tol(LEFT)) : PERSIST('persist::vehicles_incoming'+buildstate);