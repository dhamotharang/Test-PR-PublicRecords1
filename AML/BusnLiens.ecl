import Business_Risk, liensv2, RiskWise, risk_indicators, ut, Doxie, Suppress, AML;

EXPORT BusnLiens(DATASET(Layouts.BusnLayoutV2) BusnIn,
									doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
															// , 
															// string50 DataRestriction,
															// unsigned1 dppa,
															// unsigned1 glba
															) := FUNCTION


//version 2
//--------------------- Get Liens Info ----------------

lienrec := record
	unsigned3	seq := 0;
	unsigned4 historydate;
	unsigned6 bdid := 0;
	string50 tmsid := '';
	string50 rmsid := '';
	// unsigned2	cnt_eviction12 := 0;
	// unsigned2	cnt_eviction := 0;
	unsigned2	cnt_rel12 := 0;
	unsigned2	cnt_rel := 0;
	unsigned2	cnt_unrel12 := 0;
	unsigned2	cnt_unrel := 0;
	// unsigned4 lien_total := 0;
	// string120 def_company := '';
	// string50 address := '';
	// string25 orig_city := '';
	// string2 orig_state := '';
	// string5 orig_zip := '';
	// string4 zip4 := '';
	// string8 filing_date := '';
	string8 date_last_seen := '';
	string8 date_first_seen := '';
	// string50 filingtype_desc := '';	
end;

lienrec get_lien_rmsid(BusnIn L, liensv2.key_liens_bdid R) := transform
	self.seq := L.seq;
	self.historydate := l.historydate;
	self.bdid := L.OrigBdid;
	self.rmsid := R.rmsid;
	self.tmsid := R.tmsid;
	self := [];
end;

rmsids := join(BusnIn, liensv2.key_liens_bdid,
				left.OrigBdid != 0 and
				keyed(left.OrigBdid = right.p_bdid),
			get_lien_rmsid(LEFT,RIGHT), keep(100));

// with liensV2, all fields we're interested in come from the liens_party_id file except the lien amount and filing description which come from the liens_main file
{lienrec, unsigned4 global_sid, unsigned6 did} get_liens(rmsids le, liensv2.key_liens_party_ID ri) := transform
	self.global_sid := ri.global_sid;
	self.did := (unsigned6)ri.did;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.bdid := Le.bdid;
	self.tmsid := le.tmsid;
	self.rmsid := ri.rmsid;
	self.date_last_seen := ri.date_last_seen;
	self.date_first_seen  := ri.date_first_seen;
	// self.lien_total := 0;  // comes from main
	// self.tmsid := if(ri.tmsid='', '', le.tmsid);	// set these to blank so that we miss on the evictions search below
  // self.rmsid := if(ri.rmsid='', '', le.rmsid);
	self := [];
end;

liensrecs_unsuppressed := join(rmsids,  liensv2.key_liens_party_ID,
				keyed(left.rmsid = right.rmsid) and
				keyed(left.tmsid = right.tmsid) and
				left.bdid = (unsigned)right.bdid and  // for cases with multiple debtors, make sure to only include the party records that match on bdid
				right.name_type='D' and
				(unsigned4)right.date_first_seen < (unsigned4)left.historydate,
			   get_liens(LEFT,RIGHT), 
			   atmost( (keyed(left.rmsid=right.rmsid) and keyed(left.tmsid=right.tmsid)), riskwise.max_atmost), keep(100));

liensrecs := Suppress.Suppress_ReturnOldLayout(liensrecs_unsuppressed, mod_access, lienrec);

lienrec roll_and_count(liensrecs L, liensrecs R) := transform
  sameLien := l.tmsid=r.tmsid and l.rmsid=r.rmsid;
	self.seq := L.seq;
	self.cnt_rel12 := L.cnt_rel12 + if ( ~sameLien and (integer)R.date_last_seen != 0 and ut.DaysApart(R.date_last_seen,(string)R.historydate)<=365 , 1, 0);
	self.cnt_rel := L.cnt_rel + if (~sameLien and(integer)R.date_last_seen != 0, 1, 0);
	self.cnt_unrel12 := L.cnt_unrel12 + if (~sameLien and(integer)R.date_last_seen != 0 and ut.DaysApart(R.date_last_seen,(string)R.historydate)<=365 , 1, 0);
	self.cnt_unrel := L.cnt_unrel + if (~sameLien and(integer)R.date_last_seen != 0, 0, 1);
	// self.lien_total := L.lien_total + if(~sameLien, R.lien_total, 0);
	// self.cnt_eviction12 := l.cnt_eviction12 + if(~sameLien, r.cnt_eviction12, 0);
	// self.cnt_eviction := l.cnt_eviction + if(~sameLien, r.cnt_eviction, 0);
	self := l;
end;

lrecs_srt_ddp := rollup(sort(liensrecs,seq,-(if (date_first_seen = '', '0000000', date_first_seen))),
          left.seq=right.seq and
					left.bdid=right.bdid,
					roll_and_count(LEFT,RIGHT));


Layouts.BusnLayoutV2  AddBusnLiensCnts(BusnIn le,lrecs_srt_ddp ri)  := Transform
		  self.UnreleasedLienCount := ri.cnt_unrel;
			self.ReleasedLienCount	:= ri.cnt_rel;
			self.UnreleasedLienCount12 := ri.cnt_unrel12;
			self.ReleasedLienCount12	:= ri.cnt_rel12;		
			// self.EvictionCount12	:= ri.cnt_eviction12;		
			// self.EvictionCount	:= ri.cnt_eviction;		
			self := le;
END;

AddBusnLiens := 	join( BusnIn ,lrecs_srt_ddp	,
                			left.seq=right.seq and
											left.OrigBdid = right.bdid,
											AddBusnLiensCnts(left,right),
											left outer);
											
// output(rmsids, named('rmsids'));
// output(liensrecs, named('liensrecs'));
// output(lrecs_srt_ddp, named('lrecs_srt_ddp'));
// output(AddBusnLiens, named('AddBusnLiens'));


RETURN 	AddBusnLiens;														
															
END;															