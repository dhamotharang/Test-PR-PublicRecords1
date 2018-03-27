IMPORT _Control, ut, PRTE2_Common, address;

EXPORT Transforms := MODULE

	EXPORT Layouts.Layout_AddrAddr_XRef ReformatXRef2AddAdd(Layouts.Layout_Base_XRef L, UNSIGNED4 C) := TRANSFORM
			SELF.RECNUM := C;
			SELF  := L;
			SELF  := [];
	END;
	EXPORT Layouts.Layout_NameAddr_XRef ReformatXRef2NameAdd(Layouts.Layout_Base_XRef L, UNSIGNED4 C) := TRANSFORM
			SELF.RECNUM := C;
			SELF  := L;
			SELF  := [];
	END;
	EXPORT Layouts.Layout_XRef_Left ReformatXRef2Left(Layouts.Layout_Base_XRef L) := TRANSFORM
		SELF  := L;
		SELF  := [];
	END;
	EXPORT Layouts.Layout_Base_XRef ReformatLeft2XRef(Layouts.Layout_XRef_Left L) := TRANSFORM
		SELF := L;
		SELF := [];
	END;

	EXPORT Layouts.Layout_Base_XRef_Enhanced ReformatXRef2Enhanced (Layouts.Layout_Base_XRef L, UNSIGNED4 C) := TRANSFORM
			SELF.RECNUM := C;
			Street1 := TRIM(l.street+' '+l.apt);
			CSZString := trim(l.City) + ' ' + trim(l.state) + ' ' + trim(l.zip);
			STRING clean_address := address.CleanAddress182(trim(Street1), trim(CSZString) );
			SELF.prim_range					:= clean_address [1..10];
			SELF.predir     				:= clean_address[11..12];
			SELF.prim_name  				:= clean_address [13..40];
			SELF.addr_suffix 				:= clean_address [41..44];
			SELF.postdir       			:= clean_address [45..46];
			SELF.unit_desig    			:= clean_address [47..56];
			SELF.sec_range  				:= clean_address [57..64];
			SELF.p_city_name 				:= clean_address[65..89];
			SELF.v_city_name 				:= clean_address[90..114];
			SELF.st         				:= clean_address [115..116];
			z1 						 					:= clean_address[117..121];
			z2         		 					:= (integer) z1; 
			SELF.zip5    		 				:= (string5) INTFORMAT(z2,5,1);
			SELF.zip4       				:= (string) clean_address[122..125];
			z4String := IF(self.zip4>'','-'+TRIM(self.zip4),'' );
			SELF.Clean_streetaddr1 := TRIM( TRIM(self.prim_range) + ' ' + TRIM(self.prim_name) + ' ' +TRIM(self.addr_suffix), LEFT, RIGHT );
			SELF.Clean_CityStZip := TRIM( TRIM(self.v_city_name) + ' ' + TRIM(self.st) + ' ' + TRIM(self.zip5)+ z4String, LEFT, RIGHT );
			SELF  := L;
			SELF  := [];
	END;
	
	EXPORT DATASET(Layouts.Layout_Base_XRef) 
			ClearAllMappedAddresses(DATASET(Layouts.Layout_Base_XRef) inProps) := FUNCTION
					LHP  := PROJECT(inProps, ReformatXRef2Left(LEFT) );
					Full_Props := PROJECT(LHP, ReformatLeft2XRef(LEFT) );
					RETURN Full_Props;
	END;

END;