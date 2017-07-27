sVendor82TrafficSet		// OK-29_Counties have traffic/infraction if positions 7-9 of offender_key have any of these
 := [
	'CRT',
	'MRT',
	'NFT',
	'TR ',
	'TRI',
	'TRC',
	'TRI',
	'T  ',
	'TV ',
	'BTR',
	'WL '
	]
 ;

export fTraffic_Flag_From_Vendor_and_Offender_Key(string2 pVendor, string pOffenderKey)
 :=
  case(pVendor,
	   '82' => if(pOffenderKey[7..9] in sVendor82TrafficSet,'Y','N'),
	   ''
	  )
 ;