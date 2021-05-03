import ut, std;

lines := RECORD
	string	line{MAXLENGTH(2056)};
END;

rItem := RECORD
	string		item{MAXLENGTH(16)};
END;

rpubdate := RECORD
	string		listid{MAXLENGTH(8)};
	string32	pubdate;
END;

sfExtracts := '~thor_data400::in::accuity::extracts'; 
extracts := DATASET(sfExtracts,lines,CSV(SEPARATOR( '|' )));
sIds := extracts(line[1..7]='listids')[1].line[9..];
//slistNames := extracts(line[1..9]='listnames')[1].line[11..];
sVersion := extracts(line[1..7]='Version')[1].line[9..];
slistissuerdate := extracts(line[1..14]='listissuerdate')[1].line[16..];

dsIdsLine := DATASET([sIds], lines);
dsIssueDatesLine := DATASET([slistissuerdate], lines);

rItem XItem(lines s, integer c) := TRANSFORM
	self.item := StringLib.StringExtract(s.line, c);
END;

dsIds := NORMALIZE(dsIdsLine, StringLib.StringFindCount(sIds, ',') + 1, XItem(LEFT,COUNTER));
dsIssueDates := NORMALIZE(dsIssueDatesLine, StringLib.StringFindCount(slistissuerdate, ',') + 1, XItem(LEFT,COUNTER));

FormatDate(string YYYYMMDDHHMM) := Std.Date.ConvertDateFormat(YYYYMMDDHHMM, '%Y%m%d%H%M', '%Y-%m-%dT%H:%M')+':00.0000000Z';

dsPubdates := COMBINE(dsIds, dsIssueDates, TRANSFORM(rpubdate,
			SELF.listid := TRIM(LEFT.item);
			dateIn := TRIM(RIGHT.Item);
			SELF.pubdate :=	IF(dateIn = '000000000000',
						ERROR('The following list failed to build with listissuerdate=000000000000: '+ SELF.listid),
						FormatDate(dateIn));
			//ASSERT(SELF.pubdate <> '',
			//	'No Publication Date for List Id: '+ SELF.listid, FAIL);
			//
			//IF(SELF.pubdate = '',
			//	FAIL('No Publication Date for List Id: '+ SELF.listid));
),LOCAL);
			
GetDefaultDate(string id) :=
	IF(id='1088','2008-05-01T20:00:00.0000000Z',
		''
	);
	
export string GetPublicationDate(string source) := FUNCTION
	id := REGEXFIND(' (\\d+)$', source, 1);
	pubdate := MAP(
							EXISTS(dsPubdates(listid=id)) => TRIM(dsPubdates(listid=id)[1].pubdate),
							source='GWL' => FormatDate((string)Std.date.Today() + '0000'),
							GetDefaultDate(id)
						);
	ASSERT(pubdate <> '',
			'The following list failed to build with listissuerdate=000000000000: '+source, FAIL);
	return pubdate;
END;