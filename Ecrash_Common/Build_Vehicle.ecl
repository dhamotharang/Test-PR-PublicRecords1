EXPORT Build_Vehicle := MODULE
	EXPORT Main_Base(dsn) := FUNCTIONMACRO
				IMPORT Suppress, VehicleV2;
				//'~thor_data400::base::vehicleV2::main'
				Main_Base_DS       :=	DATASET(DSN,VehicleV2.Layout_Base.Main,THOR);	
				RETURN Main_Base_DS;
		ENDMACRO;
		
		EXPORT Party_Base_Bip(dsn) := FUNCTIONMACRO
				IMPORT Suppress, VehicleV2;
				//'~thor_data400::base::vehicleV2::party'
				Party_Base_DS       :=	DATASET(dsn,VehicleV2.Layout_Base.Party_bip,THOR);	
				RETURN(Suppress.applyRegulatory.applyMotorVehiclep(Party_Base_DS));				
		ENDMACRO;
		
/* 		EXPORT Party_Base_bip(dsn) := functionmacro
   				Import Suppress;
   				//'~thor_data400::base::vehicleV2::party'
   				Party_Base_ds       :=	dataset(dsn,VehicleV2.Layout_Base.Party_bip,thor);	
   				return(Suppress.applyRegulatory.applyMotorVehiclep(Party_Base_ds));				
   		endmacro;
   
   		EXPORT Main_Base(dsn) := functionmacro
   				Import Suppress;
   				//'~thor_data400::base::vehicleV2::main'
   				Main_Base_ds       :=	dataset(dsn,VehicleV2.Layout_Base.Main,thor);	
   				return(Suppress.applyRegulatory.applyMotorVehiclem(Main_Base_ds));
   		endmacro;
*/


END;