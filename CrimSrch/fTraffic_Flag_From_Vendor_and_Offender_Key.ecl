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

sVendor89TrafficSet		// OH-Putnam have traffic if "TR D" is found in between two sets of numbers (99999 TR D 99999)
 :=	[
	'TR D'
	]
 ;

export fTraffic_Flag_From_Vendor_and_Offender_Key(string2 pVendor, string pOffenderKey)
 :=
  case(pVendor,
	   '82' => 	if(pOffenderKey[7..9] in sVendor82TrafficSet,'Y','N'),
	   '89'	=>	if(trim(regexreplace('[0-9]+',regexreplace('^[0-9]+',pOffenderKey,''),''),left,right) in sVendor89TrafficSet,'Y','N'),
	   ''
	  )
 ;
 
