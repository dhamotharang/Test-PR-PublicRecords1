﻿// Just have to run this before the first build.
// if you do not you run into errors like this from somewhere in the MACRO calls.
// Error:    System error: 0: AddSuperFile(addcontents): Could not locate super file PRTE::key::hunting_fishing::GRANDFATHER::autokey::Payload (0, 0), 0, 

import	PRTE2_Common;


	CTPrefix := '~PRTE::';
	
	do1 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','did');
	do2 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','rid');
	do3 := PRTE2_Common.SuperFiles.create(CTPrefix+'::key::ccw','did');
	do4 := PRTE2_Common.SuperFiles.create(CTPrefix+'::key::ccw','rid');
	do5 := PRTE2_Common.SuperFiles.create(CTPrefix+'::key::ccw::fcra','did');
	do6 := PRTE2_Common.SuperFiles.create(CTPrefix+'::key::ccw::fcra','rid');
	EmergesKeyPrefix := CTPrefix+'key::Emerges';
	do7 := PRTE2_Common.SuperFiles.create(EmergesKeyPrefix,'ccw_doxie_did');
	do8 := PRTE2_Common.SuperFiles.create(EmergesKeyPrefix,'ccw_doxie_did_fcra');
	do9 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::address');
	do10 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::citystname');
	do11 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::name');
	do12 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::payload');
	do13 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::ssn2');
	do14 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::stname');
	do15 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw','autokey::zip');
	do16 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::address');
	do17 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::citystname');
	do18 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::name');
	do19 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::payload');
	do20 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::ssn2');
	do21 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::stname');
	do22 := PRTE2_Common.SuperFiles.create(CTPrefix+'key::ccw::fcra','autokey::zip');



SEQUENTIAL(do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20,do21,do22);