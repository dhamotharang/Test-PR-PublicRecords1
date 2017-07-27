import header;
EXPORT Constants := MODULE

	EXPORT NAME := 'NAME';
	EXPORT ADDR := 'ADDR';
	EXPORT SSN  := 'SSN';
	EXPORT DOB  := 'DOB';

	EXPORT keyNameSsnDob  := 'NAME,SSN,DOB';
	EXPORT keyNameSsnAddr := 'NAME,SSN,ADDR';
	EXPORT keyNameDobAddr := 'NAME,DOB,ADDR';
	EXPORT keySsnDobAddr  := 'SSN,DOB,ADDR';

	EXPORT setNameSsnDob  := [NAME,SSN,DOB];
	EXPORT setNameSsnAddr := [NAME,SSN,ADDR];
	EXPORT setNameDobAddr := [NAME,DOB,ADDR];
	EXPORT setSsnDobAddr  := [SSN,DOB,ADDR];

	EXPORT setNameSSN  := [NAME,SSN];
	EXPORT setNameAddr := [NAME,ADDR];
	EXPORT setNameDOB  := [NAME,DOB];
	EXPORT setAddrOnly := [ADDR];
	EXPORT setSSNOnly  := [SSN];

	EXPORT MAX_LEN := 30;
	EXPORT MAX_DIDS := 20;
	EXPORT MIN_MONTHS := 3;

	EXPORT srcFilter := ['ZT'];

	shared hnlr := Header.constants.no_longer_reported;
	EXPORT unsigned filterNLR := hnlr.did_not_in_en | hnlr.did_not_in_eq | hnlr.did_not_in_tn;
	EXPORT unsigned filterNLR_SSN := filterNLR | hnlr.ssn_not_in_en | hnlr.ssn_not_in_eq | hnlr.ssn_not_in_tn;
	
END;