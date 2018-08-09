import ut;
EXPORT SendReport := module

	 rundatetime := ut.GetTimeDate();

//Get the ofac update file
ofaclayout := RECORD
  string20 pty_key;
  string60 source;
  string350 orig_pty_name;
  string350 orig_vessel_name;
  string100 country;
  string10 name_type;
  string50 addr_1;
  string50 addr_2;
  string50 addr_3;
  string350 cname;
  string10 date_updated;
  string1 add_delflag;
 END;

joinrec := record
 GlobalWatchLists.Layout_GlobalWatchLists;
 	  STRING10 date_updated;
		STRING1 add_delflag;
end;

dIn := dataset('~thor_200::in::globalwatchlists_updates', joinrec ,flat);

dIn_OFAC := project ( dIn ,transform ( ofaclayout,self := left , self := []));

ofaclayout commatr( dIn_OFAC l ) := transform
self.orig_pty_name := regexreplace(',',l.orig_pty_name,'');
self.orig_vessel_name := regexreplace(',',l.orig_vessel_name,'');
self.country := regexreplace(',',l.country,'');
self.addr_1 := regexreplace(',',l.addr_1,'');
self.addr_2 := regexreplace(',',l.addr_2,'');
self.addr_3 := regexreplace(',',l.addr_3,'');
self.cname := regexreplace(',',l.cname,'');
self := l;
end;

dOFAC2trim := project( dIn_OFAC, commatr(left));

dout_OFAC := choosen(sort(dOFAC2trim ( trim(source) = 'Office of Foreign Asset Control' and ut.DaysApart( ut.GetDate,date_updated) < 30 ),date_updated),all);

linestring := RECORD
			STRING300000 line; 
		END;

		headerRec := DATASET([{'pty_key,source,orig_pty_name,orig_vessel_name,country,name_type,addr_1,addr_2,addr_3,cname,date_updated,add_delflag'}], linestring);

		linestring converttoline (dout_OFAC L) := TRANSFORM
				SELF.line         := L.pty_key + ',' +  L.source + ',' + L.orig_pty_name + ',' + L.orig_vessel_name + ',' + L.country + ',' +
				                     L.name_type + ',' + L.addr_1 + ',' + L.addr_2 + ',' + L.addr_3 + ',' + L.cname + ',' + L.date_updated + ',' + L.add_delflag;
		END;
		
		singlelinerecord := PROJECT (dout_OFAC, converttoline(LEFT));

		
		myrec := RECORD
			UNSIGNED  code0; 
			STRING300000 line; 
		END;

		myrec ref(singlelinerecord l) := TRANSFORM 
			SELF.code0 := 0; 
			SELF       := l; 
		END;

		inputs := PROJECT(headerRec+singlelinerecord, ref(LEFT));

		MyRec rollupForm (myrec L, myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
			SELF      := L;
		END;

		XtabOut := ROLLUP(inputs, rollupForm(LEFT,RIGHT), CODE0);

    attachment := trim(XtabOut[1].line);
		
		emailTarget := 'Sudhir.Kasavajjala@lexisnexis.com, Greg.Bethke@lexisnexis.com Desiree.Delgado@lexisnexis.com';
		senderemail := 'Sudhir.Kasavajjala@lexisnexis.com';
		
		mail_mthly :=	FileServices.SendEmailAttachData( emailTarget
																						,'OFAC Monthly Report - ' + rundatetime
																						,'Please see attached file for updates'
																						, (data)attachment
																						,'text/csv'
																						,'OFACReport.csv'
																						,
																						,
																						,senderemail);
		
		EXPORT  out := if ( count( dout_OFAC ) > 0, Sequential ( Output( 'Send OFAC Monthly Report'),mail_mthly),Output('No_OFAC_Updates_Received'));
		end;