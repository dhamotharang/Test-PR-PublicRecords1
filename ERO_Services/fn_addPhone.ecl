  import  addrbest,AutoStandardI,progressive_phone;
	export fn_addPhone(dataset(Layouts.LookupId) ids ) := function
  	
		progressive_phone.layout_progressive_batch_in filladdr(ids l, integer c) := transform
			SELF.acctno := l.acctNo;
			self.did := (integer)l.did; 
			SELF.ssn  := Stringlib.StringFilter(L.subject_ssn, '1234567890');
			self.dob := l.subject_DOB[7..10]+l.subject_DOB[1..2]+l.subject_DOB[4..5];            //SUBJECT = mm/dd/yyyy, ProgressPhone needs=
			self.name_first := l.best_name.name_first;
			self.name_middle := l.best_name.name_middle;
			self.name_last := l.best_name.name_last;
			self.name_suffix := l.best_name.name_suffix;
			self.prim_range := choose(c, l.addr1.prim_range, l.addr2.prim_range);
			self.predir := choose(c, l.addr1.predir, l.addr2.predir);
			self.prim_name := choose(c, l.addr1.prim_name, l.addr2.prim_name);
			self.suffix := choose(c, l.addr1.addr_suffix, l.addr2.addr_suffix);
			self.postdir := choose(c, l.addr1.postdir, l.addr2.postdir);
			self.unit_desig := choose(c, l.addr1.unit_desig, l.addr2.unit_desig);
			self.sec_range := choose(c, l.addr1.sec_range, l.addr2.sec_range);
			self.p_city_name := choose(c, l.addr1.p_city_name, l.addr2.p_city_name);
			self.st := choose(c, l.addr1.st, l.addr2.st);
			self.z5 := choose(c, l.addr1.z5, l.addr2.z5);
			self := [];
		end;

    in_raw1 := PROJECT(ids, filladdr(left,1));
    in_raw2 := PROJECT(ids, filladdr(left,2));
     
		 //this batch service doesn't return the address but it does return match flags.
		 //ONLY keep records where DID matches and streetaddress and (city/state or zip)
		 //L=DID, A=STREETADDRESS, T=STATE, C=CITY, Z=ZIP
		tmpMod :=
		MODULE(progressive_phone.waterfall_phones_options)
			EXPORT INTEGER MaxPhoneCount       := 5 : STORED('MaxPhoneCount');
			
			EXPORT INTEGER CountES             := 5 : STORED('CountType1_ES_EDASEARCH');
			EXPORT INTEGER CountSE             := 5 : STORED('CountType2_SE_SKIPTRACESEARCH');
			EXPORT INTEGER CountPP             := 5 : STORED('CountType6_PP_PHONESPLUSSEARCH');
		END;
		
    phonerecs1 := addrbest.Progressive_phone_common(in_raw1,tmpMod)(REGEXFIND('A', MATCHCODES) AND
																																		REGEXFIND('L', MATCHCODES) AND
																																	 (REGEXFIND('Z', MATCHCODES) OR
																																		REGEXFIND('T', MATCHCODES) AND
																																		REGEXFIND('C', MATCHCODES))
																																		);
    phonerecs2 := addrbest.Progressive_phone_common(in_raw2,tmpMod)(REGEXFIND('A', MATCHCODES) AND
																																		REGEXFIND('L', MATCHCODES) AND
																																	 (REGEXFIND('Z', MATCHCODES) OR
																																		REGEXFIND('T', MATCHCODES) AND
																																		REGEXFIND('C', MATCHCODES))
																																		);

		 ids fillPhone1(ids l , Progressive_Phone.layout_progressive_phone_common r) := transform
		   self.addr_Phone_1 := r.subj_phone10;
		   self :=l
		 end;
 		 ids fillPhone2(ids l , Progressive_Phone.layout_progressive_phone_common r) := transform
		   self.addr_Phone_2 := r.subj_phone10;
		   self :=l
		 end;

     outrecs1 := join(ids, phonerecs1,  left.acctno = right.acctno, fillPhone1(left,right), KEEP(1),left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
     outrecs2 := join(outrecs1, phonerecs2,  left.acctno = right.acctno, fillPhone2(left,right), KEEP(1),left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));
	
    return outrecs2;
	 end;