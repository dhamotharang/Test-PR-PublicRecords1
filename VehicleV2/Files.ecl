import	data_services,address;

export Files	:=
module

	export	In	:=
	module
		export	OH	:=
		module
			export	Raw					:=	dataset('~thor_data400::in::vehiclev2::di::oh_raw',VehicleV2.Layout_OH.Raw_Main,thor);
			export	Prepped			:=	dataset('~thor_data400::in::vehiclev2::di::oh',VehicleV2.Layout_OH.Prepped,thor);
			export	PreppedBldg	:=	dataset('~thor_data400::in::vehiclev2::di::oh_building',VehicleV2.Layout_OH.Prepped,thor);
		end;
		
		export	NC	:=
		module
			export	Raw					:=	dataset('~thor_data400::in::vehiclev2::di::nc_raw',VehicleV2.Layout_NC.Raw_Layout,thor);
			export	Prepped			:=	dataset('~thor_data400::in::vehiclev2::di::nc',VehicleV2.Layout_NC.Prepped_Layout,thor);
			export	PreppedBldg	:=	dataset('~thor_data400::in::vehiclev2::di::nc_building',VehicleV2.Layout_NC.Prepped_Layout,thor);
		end;
		
		
		export	Experian	:=
		module
			export	Raw			:=	dataset('~thor_data400::in::vehiclev2::experian_raw',VehicleV2.Layout_Experian.Layout_Experian_Raw,thor);
			export	Prepped	:=	dataset('~thor_data400::in::vehiclev2::experian',VehicleV2.Layout_Experian.Layout_Experian_Prepped,thor);
		end;
	end;
	
	export	Base	:=
	module
		export	Experian	          :=	dataset('~thor_data400::base::vehicleV2::experian',VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2,thor);
		export	NC				          :=	dataset('~thor_data400::base::vehicleV2::direct::nc',VehicleV2.Layout_NC.NC_as_VehicleV2_Layout,thor);
		export	OH				          :=	dataset('~thor_data400::base::vehicleV2::direct::oh',VehicleV2.Layout_OH.OH_as_VehicleV2,thor);
		export	Main			          :=	dataset(data_services.foreign_prod+'~thor_data400::base::vehicleV2::main',VehicleV2.Layout_Base.Main,thor);
    export	Party_bip	          :=	dataset(data_services.foreign_prod+'~thor_data400::base::vehicleV2::party',VehicleV2.Layout_Base.Party_CCPA,thor);		
		export	Party			          :=	project(Party_bip,transform(VehicleV2.Layout_Base.Party,self:=left));
		export  Picker              :=  dataset(data_services.foreign_prod+'~thor_data400::out::vehicle_valid_make_model', {string MakeID,string MakeCode,string MakeDescription,	string ModelDescription}, csv(separator('|')));
		export  MakeConst           :=  dataset(data_services.foreign_prod+'~thor_data400::out::vehicle_valid_make_constant',{string MakeCode}, flat); 
		export  Make                :=  dataset('~thor_data400::base::WC_Vehicle::Make', {string10 makecode, unsigned2 i }, flat); 
		export  BodyStyle           :=  dataset('~thor_data400::base::WC_Vehicle::bodystyle', {string2 body_style, string50 body_style_description, string20 category, UNSIGNED2 i}, flat); 
		export  Picker_BodyStyle    :=  dataset('~thor_data400::out::vehicle_valid_body_code', {string body_style,string body_style_description,string category}, csv(separator('|')));

	end;

end;