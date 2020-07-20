﻿/*2016-05-21T00:27:51Z (Kevin Huls)
Automated reinstate from 2016-05-19T17:47:55Z
*/
export getHRIDesc(string5 rc) := CASE(TRIM(rc),	
'CZ' => 'Address mismatch between city/state and zip code',
'CA' => 'The primary input address is a Commercial Mail Receiving Agency',
'CO' => 'The input zip code is a corporate only zip code',
'MO' => 'The input zip code is a military only zip code',
'ZI' => 'Unable to verify zip code',
'VA' => 'The input address is a vacant address',
'PB' => 'The input address is a PO Box',
'11' => 'The input address may be invalid according to postal specifications',
'12' => 'The input zip code belongs to a post office box',
'14' => 'The input address is a transient commercial or institutional address',
'50' => 'The input address matches a prison address',
'REASON CODE' + rc + ' IS INVALID');