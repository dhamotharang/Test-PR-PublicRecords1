import _Control;
EXPORT _ESP :=
			CASE(_Control.ThisEnvironment.ThisDaliIp
					,_Control.IPAddress.bair_dataland_dali => _Control.IPAddress.bair_Dev_ESP
					,_Control.IPAddress.bair_prod_dali1     => _Control.IPAddress.bair_prod_ESP
					,_Control.IPAddress.bair_DR_dali1       => _Control.IPAddress.bair_DR_ESP
					,'ERROR: DALI TO ESP MAPPING in BAIR._ESP HAS NO MATCH'
					);