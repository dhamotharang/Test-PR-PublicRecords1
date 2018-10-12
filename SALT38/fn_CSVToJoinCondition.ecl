// Function to create a join condition from a comma-delimited list of field names
// For example, an input of 'fname,mname,lname' will produce 'LEFT.fname = RIGHT.fname AND LEFT.mname = RIGHT.mname AND LEFT.lname = RIGHT.lname'
// the output of this function can be used with #EXPAND to become a join condition
IMPORT STD;
EXPORT fn_CSVToJoinCondition(STRING csvString) := FUNCTION
	joinConditionPrep_RemoveSpaces 			:= STD.Str.FindReplace(csvString, ' ', '') + ',';
	joinConditionPrep_JoinSyntax 				:= REGEXREPLACE('([^,]+)', joinConditionPrep_RemoveSpaces, 'LEFT.$1 = RIGHT.$1 AND ');
	joinConditionPrep_RemoveComma 			:= STD.Str.FindReplace(joinConditionPrep_JoinSyntax, ',', '');
	joinConditionPrep_RemoveTrailingAND	:= REGEXREPLACE(' +AND $', joinConditionPrep_RemoveComma, '');
	joinCondition := joinConditionPrep_RemoveTrailingAND;
	RETURN joinCondition;
END;
