IMPORT AutoKeyI;

EXPORT Constants := MODULE

	EXPORT UNSIGNED1 MAX_PERSONS := 5;
	EXPORT UNSIGNED1 MAX_RELATIVES := 10;
	EXPORT UNSIGNED1 MAX_VEHICLES  := 15;

	EXPORT UNSIGNED1 MIN_PROPERTIES := 2;
	EXPORT UNSIGNED1 MAX_PROPERTIES := 15;
	EXPORT UNSIGNED1 DEFAULT_PROPERTIES := 5;

	EXPORT UNSIGNED1 SCORE_THRESHOLD := 80;
	EXPORT UNSIGNED1 HOMESTEAD_YEARS := 3;
	EXPORT UNSIGNED1 FORECLOSURE_YEARS := 3;

	EXPORT UNSIGNED1 INPUT_ADDR   := 10; // isInputAddress
	EXPORT UNSIGNED1 IN_STATE     := 20; // hasAssessments AND hasDeedRecords AND hasHmstdExmptn AND inState
	EXPORT UNSIGNED1 OUT_OF_STATE := 25; // hasAssessments AND hasDeedRecords AND hasHmstdExmptn AND NOT inState
	EXPORT UNSIGNED1 HAS_EXMPTNS  := 30; // hasAssessments AND NOT hasDeedRecords AND hasHmstdExmptn
	EXPORT UNSIGNED1 NO_EXMPTNS   := 40; // hasAssessments AND hasDeedRecords AND NOT hasHmstdExmptn
	EXPORT UNSIGNED1 DEED_ONLY    := 50; // NOT hasAssessments AND hasDeedRecords
	EXPORT UNSIGNED1 ASSESS_ONLY  := 60; // hasAssessments AND NOT hasDeedRecords

	EXPORT STRING GLB_REQUIRED_MSG := 'GLBA permissible purpose is required';

	EXPORT NO_LEXID_FOUND_CODE     := AutoKeyI.errorcodes._codes.NO_RECORDS; // 10
	EXPORT LOW_LEXID_SCORE_CODE    := AutoKeyI.errorcodes._codes.LEXID_FAIL; // 307
	EXPORT TOO_MANY_SUBJECTS_CODE  := AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS; // 203
	EXPORT INSUFFICIENT_INPUT_CODE := AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT; // 301

	EXPORT NO_LEXID_FOUND     := 'NL'; // = No LexID found';
	EXPORT LOW_LEXID_SCORE    := 'LS'; // = Low LexID score (less than threshold)';
	EXPORT TOO_MANY_SUBJECTS  := 'ID'; // = Multiple identities (subjects) associated to a LexID';
	EXPORT INSUFFICIENT_INPUT := 'MI'; // = Lacking minimum input';

	EXPORT NO_INFO := 'NO INFO';

END;
