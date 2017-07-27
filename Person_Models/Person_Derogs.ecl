import doxie,ut;

bk_recs := doxie.bk_records();
Derogs_Score := IF ( count( bk_recs ) = 0, 100, 0 );								 

r := record
  string1 derog_area; // Financial, Criminal
  string2 derog_type;
	unsigned4 days_ago;
  end;
	
r into_bk(bk_recs le) := transform
  self.derog_type := 'BK';
	self.derog_area := 'F';
	self.days_ago := ut.DaysApart(ut.GetDate,le.date_filed);
  end;
	
	

export Person_Derogs := project( bk_recs, into_bk(left) ) : global;