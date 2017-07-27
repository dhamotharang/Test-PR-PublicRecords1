sVendor31TrafficSet		// Oregon court court_offense_level values deemed non-felony or misdemeanor
 := [
	'BINF',
	'UVIO',
	'AINF',
	'DINF',
	'CINF',
	'UINF',
	'AVIO',
	'VIO',
	'ORD',
	'INF',
	'AVI',
	'UVI',
	'VI',
	'DVIO',
	'VVIO',
	'BVIO',
	'IF',
	'UORD',
	'AIF',
	'V',
	'UIF',
	'CIF',
	'I',
	'BVI',
	'VINF',
	'CVIO',
	'UVIL',
	'VVI',
	'2VIO',
	'MVIO',
	'VVOI'
	]
 ;

sVendor44TrafficSet		// FL Osceola
 := [
	 'TT'
	]
 ;

sVendor48TrafficSet		// UT Court
 := [
	 'I',
	 'IN'
	]
 ;

sVendor57TrafficSet		// VA Fairfax
 := [
	 'I',
	 'ORD'
	]
 ;

sVendor60TrafficSet		// TX Denton
 := [
	 'MT',
	 'MTA'
	]
 ;

export fTraffic_Flag_From_Vendor_and_Offense_Level(string2 pVendor, string5 pOffenseLevel)
 :=
  case(pVendor,
	   '31' => if(trim(pOffenseLevel,right) in sVendor31TrafficSet,'Y','N'),
	   '44' => if(trim(pOffenseLevel,right) in sVendor44TrafficSet,'Y','N'),
	   '45' => if(pOffenseLevel[1] = 'T','Y','N'),
	   '48' => if(trim(pOffenseLevel,right) in sVendor48TrafficSet,'Y','N'),
	   '57' => if(trim(pOffenseLevel,right) in sVendor57TrafficSet,'Y','N'),
	   '60' => if(trim(pOffenseLevel,right) in sVendor60TrafficSet,'Y','N'),
	   ''
	  )
 ;