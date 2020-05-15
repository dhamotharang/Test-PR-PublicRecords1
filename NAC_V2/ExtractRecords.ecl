﻿// get record types from file
import STD;
GetFileName(string ilfn) := FUNCTION
		s1 := Std.Str.SplitWords(ilfn, '::');
		n := COUNT(s1);
		return s1[n];
END;

RightNow := Std.Date.Today();

EXPORT ExtractRecords(string ilfn) := MODULE

	shared rNac := RECORD
		string	  filename;
		unsigned4	seqnum;
		Nac_V2.Layouts2.rNac2;
	END;	
	shared ds := dataset(ilfn, NAC_V2.Layouts2.rRawFile, CSV)(LENGTH(TRIM(text,left,right)) > 4);

	shared nacin := PROJECT(ds, TRANSFORM(rNac,			//Nac_V2.Layouts2.rNac2,
				string4 rc := left.text[1..4];
				len := MIN(LENGTH(left.text), 484);
				string484 text := left.text[5..len] + IF(len < 484, Std.Str.Repeat(' ', 484-len), '');
				self.CaseRec := IF(rc='CA01', TRANSFER(text, Nac_V2.Layouts2.rCase - RecordCode));
				self.ClientRec := IF(rc='CL01', TRANSFER(text, Nac_V2.Layouts2.rClient - RecordCode));
				self.AddressRec := IF(rc='AD01', TRANSFER(text, Nac_V2.Layouts2.rAddress - RecordCode));
				self.StateContactRec := IF(rc='SC01', TRANSFER(text, Nac_V2.Layouts2.rStateContact - RecordCode));
				self.ExceptionRec := IF(rc='EX01', TRANSFER(text, Nac_V2.Layouts2.rException - RecordCode));
				self.BadRec := IF(rc NOT IN Nac_V2.Layouts2.validRecordCodes, TRANSFER(text, Nac_V2.Layouts2.rBadRecord - RecordCode));
				self.RecordCode := rc;
				self.filename := GetFileName(left.filename);
				self.seqnum := COUNTER;
				));

	export cases := 
							PROJECT(nacin(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										self.GroupId := left.filename[6..9];
										self.OrigGroupId := left.filename[6..9];
										//self.filename := fname;
										self.Created := RightNow;
										self.Updated := RightNow;
										self.filename := left.filename;
										self.seqnum := left.seqnum;
										self := [];
										));

	 export clients := 	
										PROJECT(nacin(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											self.GroupId := left.filename[6..9];
											self.OrigGroupId := left.filename[6..9];
											//self.filename := fname;
											self.Created := RightNow;
											self.Updated := RightNow;
											self.filename := left.filename;
											self.seqnum := left.seqnum;
											self := [];
											)
										);

	 export addresses := 	
							PROJECT(nacin(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self.GroupId := left.filename[6..9];
												self.OrigGroupId := left.filename[6..9];
												//self.filename := fname;
												self.Created := RightNow;
												self.Updated := RightNow;
												self.filename := left.filename;
												self.seqnum := left.seqnum;
												self := [])
										);
										
			export contacts := 	
										PROJECT(nacin(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;
										self.GroupId := left.filename[6..9];
										self.OrigGroupId := left.filename[6..9];
										//self.filename := fname;
										self.Created := RightNow;
										self.Updated := RightNow;
										self.filename := left.filename;
										self.seqnum := left.seqnum;
										self := [];
										));
									
	 export exceptions := 
										PROJECT(nacin(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rExceptionEx,
										self := LEFT.ExceptionRec;
										self.RecordCode := left.RecordCode;
										self.SourceGroupId := left.filename[6..9];
										self.filename := left.filename;
										self.Created := RightNow;
										self.Updated := RightNow;
										self.seqnum := left.seqnum;
										self := [];
										));
										
		export badRecords :=	
							PROJECT(nacin(RecordCode NOT IN Nac_V2.Layouts2.validRecordCodes),
								TRANSFORM(Nac_V2.Layouts2.rBadRecord,
										self := LEFT.BadRec;
										self.RecordCode := left.RecordCode;
							));

										
		export types := 
			TABLE(nacin, {nacin.RecordCode, n := COUNT(GROUP)}, RecordCode, few);
		
		export filenames := 
			TABLE(nacin, {nacin.filename, n := COUNT(GROUP)}, filename, few);
		
		export RecordCount := COUNT(nacin);

END;