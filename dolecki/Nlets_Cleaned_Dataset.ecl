import dolecki;

CLEAN_RECORD := RECORD
	string2  REQUEST_ID_1;
	string11 REQUEST_ID_2;
  string22 RECIEVED_DATE;
	string5  FILED_DATE_1;
	string2  FILED_DATE_2;
	string8  FILED_DATE_3;
  string12 REQUEST_PARAMETER;
END;

CLEAN_RECORD createRow(dolecki.Nlets_Layout l) := TRANSFORM
	SELF.REQUEST_ID_1      := l.REQUEST_ID[1..2];
	SELF.REQUEST_ID_2      := l.REQUEST_ID[4..14];
	SELF.RECIEVED_DATE     := l.RECIEVED_DATE;
	SELF.FILED_DATE_1      := l.FILED_DATE[30..35];
	SELF.FILED_DATE_2      := l.FILED_DATE[36..37];
	SELF.FILED_DATE_3      := l.FILED_DATE[38..44];
	SELF.REQUEST_PARAMETER := l.REQUEST_PARAMETER;
END;

export Nlets_Cleaned_Dataset := PROJECT(
	dolecki.Nlets_Dataset,
	createRow(LEFT)
);