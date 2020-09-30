// get record types from file
import Std;
GetFileName(string ilfn) := FUNCTION
		s1 := Std.Str.SplitWords(ilfn, '::');
		n := COUNT(s1);
		return s1[n];
END;

RightNow := Std.Date.Today();
uc(string s) := Std.Str.ToUpperCase(s);

GetGid(string filename) := uc(filename[6..9]);

EXPORT ExtractRecords(string ilfn) := MODULE

	shared rNac := RECORD
		string	  filename;
		unsigned4	seqnum;
		Nac_V2.Layouts2.rNac2;
		STRING left_text; 
		UNSIGNED4 textLength;
	END;	


	shared ds := SORT(
						dataset(ilfn, NAC_V2.Layouts2.rRawFile, CSV)(LENGTH(TRIM(text,left,right)) > 4),
						GetFileName(filename));

	 ds1 := PROJECT(GROUP(ds,GetFileName(filename)), TRANSFORM(rNac,			//Nac_V2.Layouts2.rNac2,
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
				self.left_text := left.text;
				self.textLength :=  (LENGTH(left.text) -4);
	 ));


rNac2 := RECORD
	rNac;
	UNSIGNED4 	sizeof_rec;
	BOOLEAN 		invalidLength;
END;	
rNac2 xform2(rNac l) := TRANSFORM 
	self.sizeof_rec := MAP( 
		l.recordcode = 'CA01' => SIZEOF(l.CaseRec),
		l.recordcode = 'AD01' => SIZEOF(l.AddressRec),
		l.recordcode = 'CL01' => SIZEOF(l.ClientRec),
		l.recordcode = 'SC01' => SIZEOF(l.StateContactRec),
		l.recordcode = 'EX01' => SIZEOF(l.ExceptionRec),
		0); 
		self.invalidLength := IF( (l.textLength-4) >
			MAP(
			l.recordcode = 'CA01' => SIZEOF(l.CaseRec),
			l.recordcode = 'AD01' => SIZEOF(l.AddressRec),
			l.recordcode = 'CL01' => SIZEOF(l.ClientRec),
			l.recordcode = 'SC01' => SIZEOF(l.StateContactRec),
			l.recordcode = 'EX01' => SIZEOF(l.ExceptionRec), 
			0)
		 , TRUE, FALSE);
		self := l;
END;
 

EXPORT nacin := UNGROUP(PROJECT(ds1, xform2(left))); 


	export cases := 
							PROJECT(nacin(RecordCode = 'CA01'), TRANSFORM(Nac_V2.Layouts2.rCaseEx,
										self := LEFT.CaseRec;
										self.RecordCode := left.RecordCode;
										self.GroupId := GetGid(left.filename);
										self.OrigGroupId := GetGid(left.filename);
										self.Created := RightNow;
										self.Updated := RightNow;
										self.filename := left.filename;
										self.seqnum := left.seqnum;
										self.textLength := left.textLength; 
										self.invalidLength := left.invalidLength; 
										self := [];
										));

	 export clients := 	
										PROJECT(nacin(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
											self := LEFT.ClientRec;
											self.RecordCode := left.RecordCode;
											self.GroupId := GetGid(left.filename);
											self.OrigGroupId := GetGid(left.filename);
											self.Created := RightNow;
											self.Updated := RightNow;
											self.filename := left.filename;
											self.seqnum := left.seqnum;
											self.textLength := left.textLength; 
											self.invalidLength := left.invalidLength; 
											self := [];
											)
										);

	 export addresses := 	
							PROJECT(nacin(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
												self := LEFT.AddressRec;
												self.RecordCode := left.RecordCode;
												self.GroupId := GetGid(left.filename);
												self.OrigGroupId := GetGid(left.filename);
												self.Created := RightNow;
												self.Updated := RightNow;
												self.filename := left.filename;
												self.seqnum := left.seqnum;
												self.textLength := left.textLength; 
												self.invalidLength := left.invalidLength; 
												self := [])
										);
										
			export contacts := 	
										PROJECT(nacin(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
										self := LEFT.StateContactRec;
										self.RecordCode := left.RecordCode;
										self.GroupId := GetGid(left.filename);
										self.OrigGroupId := GetGid(left.filename);
										self.Created := RightNow;
										self.Updated := RightNow;
										self.filename := left.filename;
										self.seqnum := left.seqnum;
										self.textLength := left.textLength;
										self.invalidLength := left.invalidLength;
										self := [];
										));
									
	 export exceptions := 
										PROJECT(nacin(RecordCode = 'EX01'), TRANSFORM(Nac_V2.Layouts2.rExceptionEx,
										self := LEFT.ExceptionRec;
										self.RecordCode := left.RecordCode;
										self.SourceGroupId := GetGid(left.filename);
										self.GroupId := GetGid(left.filename);
										self.OrigGroupId := GetGid(left.filename);
										self.filename := left.filename;
										self.Created := RightNow;
										self.Updated := RightNow;
										self.seqnum := left.seqnum;
										self.textLength := left.textLength; 
										self.invalidLength := left.invalidLength; 
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
