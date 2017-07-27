export GetVesselTypeMO(string3 pVesselAbbreviation)
  := case(pVesselAbbreviation,
		  'AIR' => 'Air Boat',
		  'BAS' => 'Bass Boat',
		  'CAN' => 'Canoe',
		  'COM' => 'Commercial',
		  'CRU' => 'Cruiser',
		  'DAY' => 'Daycruiser',
		  'DEC' => 'Deck Boat',
		  'DRG' => 'Drag or Performance Boat',
		  'HOV' => 'Hovercraft',
		  'HRO' => 'Hydroplane',
		  'HSE' => 'Houseboat',
		  'HYD' => 'Hydrofoil',
		  'JET' => 'Jet Ski',
		  'OFF' => 'Official',
		  'PON' => 'Pontoon',
		  'RAF' => 'Inflatable Boat',
		  'RUN' => 'Runabout',
		  'SAL' => 'Sailboat',
		  'SUR' => 'Surf Jet',
		  'UTL' => 'Utility',
		  'WET' => 'Wet Bike',
		  'YAT' => 'Yacht',
		  ''
		 );