#option('sortindexpayload',false);


rMoxieFileForKeybuildLayout
 :=
  record
	VehLic.Layout_Vehreg_ToMike;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

dVehiclesMoxie	:=	dataset('~thor_data400::out::vehicles_moxie',rMoxieFileForKeybuildLayout,flat,__compressed__);

dVehiclesJoined	:=	dataset('~thor_data400::persist::vehreg_vehicles_joined',VehLic.Layout_Vehicles,flat,__compressed__);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

gRawSize	:= sizeof(vehlic.Layout_Vehreg_ToMike) * (count(dVehiclesJoined) + count(vehlic.irs_dummy_recs)) : global;
gHeaderSize	:= sizeof(vehlic.Layout_Vehreg_ToMike) : global;

dIndex		:= index(dVehiclesMoxie,{f:= moxietransform(__filepos, gRawSize, gHeaderSize)},{dVehiclesMoxie},'~thor_data400::key::moxie.mv.fpos.data.key_' + vehlic.Version_Development);

export Out_Moxie_Dev_FPos_Data_Key	:=	buildindex(dIndex,moxie,overwrite);

