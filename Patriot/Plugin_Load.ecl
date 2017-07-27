import GlobalWatchLists;

// Index Definition
ind := GlobalWatchLists.Key_GlobalWatchLists_Seq;

fake_layout :=
RECORD
	STRING1 a;
END;

// first-time load
fake_layout readin(ind le) :=
TRANSFORM
	isCompany := le.cname<>'';
	fname := IF(isCompany,'',TRIM(le.first_name));
	lname := TRIM(IF(isCompany,le.cname,le.last_name));

  load1 := OfacLib.Load(le.source, le.seq, fname, lname, ~isCompany, le.seq=le.max_seq);
	SELF.a := IF(load1,'1','0');
END;

read_part := PROJECT(pull(ind),readin(LEFT));


isOfacLoaded := IF(~ofaclib.isloaded(),read_part);

export Plugin_Load := ~exists(isOfacLoaded(a='0'));
