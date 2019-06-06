
IMPORT doxie;

EXPORT Transforms := MODULE

	EXPORT Layouts.batch_in xfm_clean_address(Layouts.batch_in le) :=
		TRANSFORM // Ref.: Address.GetCleanAddress
				clean_address := doxie.cleanaddress182(le.addr, le.p_city_name + ' ' + le.st + ' ' + le.z5);
			SELF.prim_range  := clean_address[1..10];
			SELF.predir      := clean_address[11..12];
			SELF.prim_name   := clean_address[13..40];
			SELF.addr_suffix := clean_address[41..44];
			SELF.postdir     := clean_address[45..46];
			SELF.unit_desig  := clean_address[47..56];
			SELF.sec_range   := clean_address[57..64];
			SELF.p_city_name := clean_address[90..114];
			SELF.st          := clean_address[115..116];
			SELF.z5          := clean_address[117..121];
			SELF.zip4        := clean_address[122..125];
			SELF             := le;	
			SELF             := [];
		END;

END;
