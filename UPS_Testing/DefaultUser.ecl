IMPORT iesp;

SearchUser := iesp.share.t_User;

UserVals := RECORD
	TYPEOF(SearchUser.GLBPurpose) GLBPurpose := '1';
	TYPEOF(SearchUser.DLPurpose) DLPurpose := '1';
	TYPEOF(SearchUser.DebitUnits) DebitUnits := 0;
	TYPEOF(SearchUser.SSNMaskingOn) SSNMaskingOn := 0;
	TYPEOF(SearchUser.DLMask) DLMask := 0;
	TYPEOF(SearchUser.DLMaskingOn) DLMaskingOn := 0;
END;	

EmptyUser := ROW(UserVals);

SearchUser UserTransform(UserVals L) := TRANSFORM
	SELF := L;
	SELF := [];
END;

export SearchUser DefaultUser := PROJECT(EmptyUser, UserTransform(LEFT));
