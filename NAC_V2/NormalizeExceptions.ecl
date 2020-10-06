EXPORT NormalizeExceptions(DATASET($.Layouts2.rExceptionRecord) ex = $.Files2.dsExceptionRecords) := FUNCTION
	exout := ex(sourcegroupid <> matchedgroupid ); // interstate exceptions
	exin := ex(sourcegroupid = matchedgroupid);			// intrastate exceptions
	mirror := project(exin, TRANSFORM(recordof(ex),	
						self.sourceprogramstate := left.matchedstate;
						self.sourceprogramcode := left.matchedprogramcode;
						self.sourceclientid := left.matchedclientid;
						self.matchedstate := left.sourceprogramstate;
						self.matchedprogramcode := left.sourceprogramcode;
						self.matchedclientid := left.sourceclientid;
						self := left;));
	raw := exout + exin + mirror;
	unique := DEDUP(raw, sourcegroupid, sourceprogramstate, SourceProgramCode, SourceClientId,
                      matchedgroupid, matchedstate, matchedprogramcode, matchedclientid, all);
	return unique;
END;