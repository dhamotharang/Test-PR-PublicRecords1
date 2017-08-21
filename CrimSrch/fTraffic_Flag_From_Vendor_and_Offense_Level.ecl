sVendor08TrafficSet		// NC
 := [
	 'T'
	]
 ;

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
 
sVendor1YTrafficSet		// MO Court
 := [
	 'O'
	]
 ;

sVendor3FTrafficSet		// OH Brown Court
 := [
	 'T'
	]
 ;

sVendor3ITrafficSet		// OH Lawrence Court
 := [
	 'T'
	]
 ;
 
sVendor3JTrafficSet		// OH Pickaway Court
 := [
	 'T'
	]
 ;
 
sVendor3KTrafficSet		// TX Grayson Court
 := [
	 'T'
	]
 ;
 
sVendor3LTrafficSet		// TX Lamar Court
 := [
	 'T'
	]
 ;
 
sVendor3NTrafficSet		// LA East Baton Rouge Court
 := [
	 'TR'
	]
 ;

sVendor3OTrafficSet		// LA Jefferson Court
 := [
	 'T'
	]
 ;
 
sVendor4DTrafficSet		// OH Brown Court
 := [
	 'T'
	]
 ;

	
export fTraffic_Flag_From_Vendor_and_Offense_Level(string2 pVendor, string5 pOffenseLevel)
 :=
  case(pVendor,
	   '08' => if(trim(pOffenseLevel,right) in sVendor08TrafficSet,'Y','N'),
	   '31' => if(trim(pOffenseLevel,right) in sVendor31TrafficSet,'Y','N'),
	   '44' => if(trim(pOffenseLevel,right) in sVendor44TrafficSet,'Y','N'),
	   '45' => if(pOffenseLevel[1] = 'T','Y','N'),
	   '48' => if(trim(pOffenseLevel,right) in sVendor48TrafficSet,'Y','N'),
	   '57' => if(trim(pOffenseLevel,right) in sVendor57TrafficSet,'Y','N'),
	   '60' => if(trim(pOffenseLevel,right) in sVendor60TrafficSet,'Y','N'),
	   '1Y' => if(trim(pOffenseLevel,right) in sVendor1YTrafficSet,'Y','N'),
	   '3F' => if(trim(pOffenseLevel,right) in sVendor3FTrafficSet,'Y','N'),
	   '3I' => if(trim(pOffenseLevel,right) in sVendor3ITrafficSet,'Y','N'),
	   '3J' => if(trim(pOffenseLevel,right) in sVendor3JTrafficSet,'Y','N'),
	   '3K' => if(trim(pOffenseLevel,right) in sVendor3KTrafficSet,'Y','N'),
	   '3L' => if(trim(pOffenseLevel,right) in sVendor3LTrafficSet,'Y','N'),
	   '3N' => if(trim(pOffenseLevel,right) in sVendor3NTrafficSet,'Y','N'),
	   '3O' => if(trim(pOffenseLevel,right) in sVendor3OTrafficSet,'Y','N'),
	   '4D' => if(trim(pOffenseLevel,right) in sVendor4DTrafficSet,'Y','N'),
	   ''
	  )
 ;