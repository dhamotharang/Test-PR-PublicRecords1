export getVesselTypeFL(string2 abrv) := case(abrv,

 'AR' => 	'Airboat',
 'OM' => 	'Open Motorboat',
 'CB' => 	'Cabin Motorboat',
 'AS' => 	'Auxillary Sailboat',
 'IN' => 	'Inflatable',
 'HB' => 	'Houseboat',
 'PN' => 	'Pontoon',
 'PW' => 	'Personal Watercraft',
 'OT' => 	'',
 'CN' => 	'Canoe',
 'SL' => 	'Sailboat',''
);