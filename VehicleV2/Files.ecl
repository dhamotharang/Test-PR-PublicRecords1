import	ut,address, suppress,data_services;

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
		
		export	Infutor_Vin	:=
		module
			export	Raw					:=	dataset('~thor_data400::in::vehiclev2::inf_nondppa::vin_raw',VehicleV2.Layout_Infutor_Vin.Raw_Main,thor);
			export	Prepped			:=	dataset('~thor_data400::in::vehiclev2::inf_nondppa::vin',VehicleV2.Layout_Infutor_Vin.Prepped,thor);
			export	PreppedBldg	:=	dataset('~thor_data400::in::vehiclev2::inf_nondppa::vin_building',VehicleV2.Layout_Infutor_Vin.Prepped,thor);
		end;
		
		export	Infutor_Motorcycle	:=
		module
			export	Raw					:=	dataset('~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_raw',
			                                VehicleV2.Layout_Infutor_Motorcycle.Raw_Main,
			                                CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\r\n','\n\r'])));
			export	Prepped			:=	dataset('~thor_data400::in::vehiclev2::inf_nondppa::motorcycle',VehicleV2.Layout_Infutor_Motorcycle.Prepped,thor);
			export	PreppedBldg	:=	dataset('~thor_data400::in::vehiclev2::inf_nondppa::motorcycle_building',VehicleV2.Layout_Infutor_Motorcycle.Prepped,thor);
		end;

		export	MA	:=
		module
			export	Raw					:=	dataset('~thor_data400::in::vehiclev2::di::ma_raw',VehicleV2.Layout_MA.RAW,thor);
			export	Prepped			:=	dataset('~thor_data400::in::vehiclev2::di::ma',VehicleV2.Layout_MA.PREPPED,thor);
			export	PreppedBldg	:=	dataset('~thor_data400::in::vehiclev2::di::ma_building',VehicleV2.Layout_MA.PREPPED,thor);
		end;
		
	end;
	
	//BUG 172059, Add missing makes
	MakeConst_extra								:= dataset(['DIAT','EGIL','JEP','KAW','LNDR','LEXU','MIN','MNNI','MINI','UD','POLA','PONI','ROV',                                            
	                                          'SATU','SUZI','TRUM','YAM','IMPE','ZCZY','STLG','STRG'], {string MakeCode});
	export	Base	:=
	module
		export	Experian	          :=	dataset('~thor_data400::base::vehicleV2::experian',VehicleV2.Layout_Experian.Layout_Experian_Updating_as_VehicleV2,thor);
		export	NC				          :=	dataset('~thor_data400::base::vehicleV2::direct::nc',VehicleV2.Layout_NC.NC_as_VehicleV2_Layout,thor);
		export	OH				          :=	dataset('~thor_data400::base::vehicleV2::direct::oh',VehicleV2.Layout_OH.OH_as_VehicleV2,thor);
		export	Infutor_Vin					:=	dataset('~thor_data400::base::vehicleV2::inf_nondppa_vin',VehicleV2.Layout_Infutor_Vin.Infutor_Vin_as_VehicleV2,thor);
		export	Infutor_Motorcycle	:=	dataset('~thor_data400::base::vehicleV2::inf_nondppa_motorcycle',VehicleV2.Layout_Infutor_Motorcycle.Infutor_Motorcycle_as_VehicleV2,thor);
		export	MA									:=	dataset('~thor_data400::base::vehicleV2::direct::ma',VehicleV2.Layout_MA.MA_as_VehicleV2,thor);
		export	Main					      :=	dataset('~thor_data400::base::vehicleV2::main',VehicleV2.Layout_Base.Main,thor);
		// export	Party_bip       		:=	dataset('~thor_data400::base::vehicleV2::party',VehicleV2.Layout_Base.Party_bip,thor);	
		export  party_bip						:=  project(VehicleV2.Prep_Build.Party_Base_bip(data_services.data_location.prefix() + 'thor_data400::base::vehicleV2::party'), transform(VehicleV2.Layout_Base.Party_CCPA,self:=left));
		export	Party			          :=	project(Party_bip,transform(VehicleV2.Layout_Base.Party,self:=left));
		export  Picker              :=  dataset('~thor_data400::out::vehicle_valid_make_model', {string MakeID,string MakeCode,string MakeDescription,	string ModelDescription}, csv(separator('|')));
		export  MakeConst           :=  dataset('~thor_data400::out::vehicle_valid_make_constant',{string MakeCode}, flat) + MakeConst_extra; 
		export  Make                :=  dataset('~thor_data400::base::WC_Vehicle::Make', {string10 makecode, unsigned2 i }, flat); 
		export  BodyStyle           :=  dataset('~thor_data400::base::WC_Vehicle::bodystyle', {string2 body_style, string50 body_style_description, string20 category, UNSIGNED2 i}, flat); 
		export  Picker_BodyStyle    :=  dataset('~thor_data400::out::vehicle_valid_body_code', {string body_style,string body_style_description,string category}, csv(separator('|')));

	end;

end;