export IsValidSsn(unsigned pSsn) :=
	pSsn > 999999
	and	((string)pSsn)[1..3] not in ['666']
	and pSsn < 900000000
	and ((string)pSsn)[6..9] != '0000'
	and pSsn != 078051120
	;
