//
// VehicleV2.Prep_Build
//

EXPORT Prep_Build := Module

		EXPORT Party_Base_bip(dsn) := functionmacro
				Import Suppress;
				//'~thor_data400::base::vehicleV2::party'
				// Party_Base_ds       :=	dataset(dsn,VehicleV2.Layout_Base.Party_bip,thor);	
				//Added for CCPA-103 
				Party_Base_ds       :=	dataset(dsn,VehicleV2.Layout_Base.Party_CCPA,thor);	
				// return(Suppress.applyRegulatory.applyMotorVehiclep(Party_Base_ds));				
				return(VehicleV2.Regulatory.applyMotorVehiclep(Party_Base_ds));				
		endmacro;

		EXPORT Main_Base(dsn) := functionmacro
				Import Suppress;
				//'~thor_data400::base::vehicleV2::main'
				Main_Base_ds       :=	dataset(dsn,VehicleV2.Layout_Base.Main,thor);	
				// return(Suppress.applyRegulatory.applyMotorVehiclem(Main_Base_ds));
				return(VehicleV2.Regulatory.applyMotorVehiclem(Main_Base_ds));
		endmacro;

end;