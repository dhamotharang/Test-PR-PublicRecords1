export validvin(string17 vin) := length(trim(vin, all)) >= 15 and 
						   vin[1..10] <> '0000000000';