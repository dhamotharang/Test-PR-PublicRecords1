IMPORT PRTE_CSV;

EXPORT Layouts := MODULE

	EXPORT AlphaBase_aircraft_reg := PRTE_CSV.FAA_Input_Layouts.input.fixed.layout_faa_aircraft_reg;
	EXPORT AlphaBase_airmen       := PRTE_CSV.FAA_Input_Layouts.input.fixed.layout_faa_airmen;
	EXPORT AlphaBase_airmen_certs := PRTE_CSV.FAA_Input_Layouts.input.fixed.layout_faa_airmen_certs;

END;