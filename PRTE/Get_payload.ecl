import prte_csv,ut,NID,Doxie,address;

// Feb 2015, this now collects and performs a small preparation on both Boca and Alpharetta base data files

export Get_payload := module

	export header := function

		ds1 := PRTE_CSV.Header.dthor_data400__key__header__data;
		ds2 := PRTE_CSV.ge_header_base.AlphaFinalHeaderDS;
		ds	:= ds1+ds2;

		prte_csv.ge_header_base.layout_payload proj_recs(ds l) := transform

			self.ssn4 := ((string)l.ssn)[6..9];
			self.ssn5 := ((string)l.ssn)[1..5];
			self.s1 := ((string)l.ssn)[1..1];
			self.s2 := ((string)l.ssn)[2..2];
			self.s3 := ((string)l.ssn)[3..3];
			self.s4 := ((string)l.ssn)[4..4];
			self.s5 := ((string)l.ssn)[5..5];
			self.s6 := ((string)l.ssn)[6..6];
			self.s7 := ((string)l.ssn)[7..7];
			self.s8 := ((string)l.ssn)[8..8];
			self.s9 := ((string)l.ssn)[9..9];
			self.dph_lname := metaphonelib.DMetaPhone1(l.lname);
			self.minit := l.mname[1];
			self.addr_suffix := l.suffix;
			self.city_code := if(l.city_code=0,doxie.Make_CityCode(l.city_name),l.city_code);
			self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
			self.yob := (integer)((string)(l.dob))[1..4];
			self.l4 := l.lname[1..4];
			self.f3 := l.fname[1..3];

			lookups := 	  doxie.lookup_setter(2,			'SEX') |
								doxie.lookup_setter(3, 		'CRIM') |
								doxie.lookup_setter(4, 			'CCW') |
								doxie.lookup_setter(3, 			'VEH') |
								doxie.lookup_setter(4, 			'DL') |
								doxie.lookup_setter(3, 		'REL') |
								doxie.lookup_setter(3, 		'FIRE') |
								doxie.lookup_setter(3, 		'FAA') |
								doxie.lookup_setter(3, 		'VESS') |
								doxie.lookup_setter(3, 		'PROF') |
								doxie.lookup_setter(3, 		'BUS') | 
								doxie.lookup_setter(3, 		'PROP') | 
								doxie.lookup_setter(3, 		'BK') |
								doxie.lookup_setter(3, 		'PAW') | 
								doxie.lookup_setter(3, 		'BC') | 
								doxie.lookup_setter(3, 	'PROP_ASSES') | 
								doxie.lookup_setter(3, 	'PROP_DEEDS') | 
								doxie.lookup_setter(3, 	'PROV') | 
								doxie.lookup_setter(3, 	'SANC') | ut.bit_set(0,0);
			self.lookup_did := if (l.lookup_did=0, lookups, l.lookup_did);
			self.lookups     := if (l.lookups=0, lookups, l.lookups);
			self.s_ssn     := l.ssn;
			self.cnt     := 2;
			self.addr_dt_first_seen := l.dt_first_seen;
			self.addr_dt_last_seen := l.dt_last_seen;
			self := l;
			self := [];
		end;

		retds := project( ds,proj_recs(left));

		return retds;

	end;



	export watchdog := function

		ds:=PRTE_CSV.Watchdog.dthor_data400__key__watchdog__best_did;

		prte_csv.ge_header_base.layout_payload proj_recs(ds l) := transform
			title := map (
										ut.GenderTools.gender(l.fname,l.mname)='M'=>'MR'
										,ut.GenderTools.gender(l.fname,l.mname)='F'=>'MS'
										,l.title
										);
			self.title := if(l.title='',title,l.title);
			self.dod := (integer)l.dod;
			self.s_ssn     := l.ssn;
			self.cnt     := 2;
			self := l;
			self := [];
		end;

		retds := project( ds,proj_recs(left));

		return retds;

	end;

end;