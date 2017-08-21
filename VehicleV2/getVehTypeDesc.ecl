export getVehTypeDesc(String code) := MAP(code='M' => 'MOTORCYCLE',
							code='P' => 'PASSENGER CAR/LIGHT TRUCK',
							code='L' => 'LIGHT TRUCK',
							code='T' => 'HEAVY TRUCK',
							code='X' => 'TRAILER',
							'UNKNOWN');
