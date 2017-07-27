import header;

//hfile := header.file_headers;

TSample := RECORD
	UNSIGNED6 WID;
	UNSIGNED6 DID;
END;

/*interfile1 := table(hfile(lname[1..2] = 'BA' and
									zip = '33444'),TSample);
*/

interfile1 := dataset('BASE::Watchdog_Customer1',TSample,flat);

SampleWidFmt := RECORD
	UNSIGNED6 did;
	SampleReqFile;
END;

SampleWidFmt mytrans(TSample L,SampleReqFile R) := TRANSFORM
	SELF.did := L.did;
	SELF := R;
END;

export SampleWid := join(interfile1,SampleReqFIle,LEFT.WID = RIGHT.wid,
						mytrans(LEFT,RIGHT));