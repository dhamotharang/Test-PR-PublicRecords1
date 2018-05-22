import _Control, Data_Services, doxie; 

ds := dataset([], Layouts.insuranceheader_xlink_did);
EXPORT key_insuranceheader_xlink_did := index(ds, {s_did}, {ds}-_Control.Layout_KeyExclusions,
																																										Data_Services.Data_location.prefix('PRTE')+'~prte::key::insuranceheader_xlink::'+ doxie.Version_SuperKey+'::did');