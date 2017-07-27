// The vendor layout for the vote history will change annualy. 
// Please pay special attention to the layout changes and notify
// data fabrication team.
import VotersV2;

In_File    := VotersV2.Updated_Voters;

Layout_History := record
   In_File.process_date;
   VotersV2.Layout_Voters_VoteHistory;
end;

Layout_Out := VotersV2.Layout_Voters_VoteHistory;

Layout_History  makeChild(In_File l, integer c) := transform
	self.vtid        := l.vtid;
	self.voted_year  := choose(c,'2008','2007','2006','2005',
															 '2004','2003','2002','2001',
															 '2000','1999','1998','1997',
															 '1996');
	self.primary     := choose(c,'',l.primary2007,l.primary2006,l.primary2005,
	                             l.primary2004,l.primary2003,l.primary2002,l.primary2001,
															 l.primary2000,l.primary1999,l.primary1998,l.primary1997,
															 l.primary1996);
	self.special_1   := choose(c,'',l.special12007,l.special12006,l.special12005,
	                             l.special12004,l.special12003,l.special12002,l.special2001,
															 l.special2000,l.special1999,l.special1998,l.special1997,
															 l.special1996);
	self.other       := choose(c,'',l.other2007,l.other2006,l.other2005,
	                             l.other2004,l.other2003,l.other2002,l.other2001,
															 l.other2000,l.other1999,l.other1998,l.other1997,
															 l.other1996);
	self.special_2   := choose(c,'',l.special22007,l.special22006,l.special22005,
	                             l.special22004,l.special22003,l.special22002,l.special22001,
															 l.special22000,l.special21999,l.special21998,l.special21997,
															 l.special21996);
	self.general     := choose(c,'',l.general2007,l.general2006,l.general2005,
	                             l.general2004,l.general2003,l.general2002,l.general2001,
															 l.general2000,l.general1999,l.general1998,l.general1997,
															 l.general1996);
	self.pres        := choose(c,l.PresPrimary2008,'','','',
	                             l.PresPrimary2004,'','','',
															 l.PresPrimary2000,'','','',
															 l.PresPrimary1996);															 
  self.vote_date   := if(trim(l.LastDateVote,left,right)[1..4] = self.voted_year, l.LastDateVote, '');	
	self             := l;	
end;

out_vote_hist      := normalize(In_File, 13, makeChild(left, counter));

out_vote_hist_fil  := out_vote_hist(trim(primary,left,right)   <> '' or
																	  trim(special_1,left,right) <> '' or
																	  trim(other,left,right)     <> '' or
																	  trim(special_2,left,right) <> '' or
																	  trim(general,left,right)   <> '' or
																	  trim(pres,left,right)      <> '');

dis_vote_hist := sort(distribute(out_vote_hist_fil, vtid), vtid, voted_year, -process_date, -vote_date, local);

Layout_History RollUpHist(dis_vote_hist l, dis_vote_hist r) := transform	
	self.primary     := if (trim(l.primary,left,right) = '', r.primary, l.primary);
	self.special_1   := if (trim(l.special_1,left,right) = '', r.special_1, l.special_1);
	self.other       := if (trim(l.other,left,right) = '', r.other, l.other);
	self.special_2   := if (trim(l.special_2,left,right) = '', r.special_2, l.special_2);
	self.general     := if (trim(l.general,left,right) = '', r.general, l.general);
	self.pres        := if (trim(l.pres,left,right) = '', r.pres, l.pres);															 
  self             := l;
end;

rollup_vote_hist := rollup(dis_vote_hist, RollUpHist(left,right), vtid, voted_year, vote_date, local);

Layout_Out trfVoteHist(rollup_vote_hist l) := transform
  self := l;
end;

vote_hist := project(rollup_vote_hist, trfVoteHist(left));

export Mapping_Voters_VoteHistory := vote_hist : persist(VotersV2.Cluster + 'persist::Voters_VoteHistory_Base');
