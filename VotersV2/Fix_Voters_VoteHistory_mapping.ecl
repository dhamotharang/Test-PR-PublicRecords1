// This is a one time run process to fix the Vote history fields by remapping to 
// there correct year fields based on the file_acquited_date or process_date.
Import VotersV2;

d := VotersV2.Cleaned_Voters_Old_Base;

Layout_out := VotersV2.Layouts_Voters.Layout_Voters_Common;

year2003 := ['2003','2004','2005','2006'];
year2004 := ['2004','2005','2006'];
year2005 := ['2005','2006'];
year2006 := ['2006'];

Layout_out trfFixVoteHist(d l):= transform

	self.primary2003  := if (trim(l.file_acquired_date[1..4],left,right) in year2003,l.Primary1996,
	                         if(trim(l.process_date[1..4],left,right) in year2003, l.Primary1996, ''));
	self.Special12003 := if (trim(l.file_acquired_date[1..4],left,right) in year2003,l.Special1996,
													 if(trim(l.process_date[1..4],left,right) in year2003, l.Special1996, ''));
	self.Other2003    := if (trim(l.file_acquired_date[1..4],left,right) in year2003,l.Other1996,
													 if(trim(l.process_date[1..4],left,right) in year2003, l.Other1996, ''));
	self.Special22003 := if (trim(l.file_acquired_date[1..4],left,right) in year2003,l.Special21996,
													 if(trim(l.process_date[1..4],left,right) in year2003, l.Special21996, ''));
	self.General2003  := if (trim(l.file_acquired_date[1..4],left,right) in year2003,l.General1996,
													 if(trim(l.process_date[1..4],left,right) in year2003, l.General1996, ''));

  self.PresPrimary2004  := if (trim(l.file_acquired_date[1..4],left,right) in year2004,l.PresPrimary1996,
													 if(trim(l.process_date[1..4],left,right) in year2004, l.PresPrimary1996, ''));
													 
  self.primary2004  := if (trim(l.file_acquired_date[1..4],left,right) in year2004,l.Primary1997,
													 if(trim(l.process_date[1..4],left,right) in year2004, l.Primary1997, ''));
	self.Special12004 := if (trim(l.file_acquired_date[1..4],left,right) in year2004,l.Special1997,
													 if(trim(l.process_date[1..4],left,right) in year2004, l.Special1997, ''));
	self.Other2004    := if (trim(l.file_acquired_date[1..4],left,right) in year2004,l.Other1997,
													 if(trim(l.process_date[1..4],left,right) in year2004, l.Other1997, ''));
	self.Special22004 := if (trim(l.file_acquired_date[1..4],left,right) in year2004,l.Special21997,
													 if(trim(l.process_date[1..4],left,right) in year2004, l.Special21997, ''));
	self.General2004  := if (trim(l.file_acquired_date[1..4],left,right) in year2004,l.General1997,
													 if(trim(l.process_date[1..4],left,right) in year2004, l.General1997, ''));
	
	self.primary2005  := if (trim(l.file_acquired_date[1..4],left,right) in year2005,l.Primary1998,
													 if(trim(l.process_date[1..4],left,right) in year2005, l.Primary1998, ''));
	self.Special12005 := if (trim(l.file_acquired_date[1..4],left,right) in year2005,l.Special1998,
													 if(trim(l.process_date[1..4],left,right) in year2005, l.Special1998, ''));
	self.Other2005    := if (trim(l.file_acquired_date[1..4],left,right) in year2005,l.Other1998,
													 if(trim(l.process_date[1..4],left,right) in year2005, l.Other1998, ''));
	self.Special22005 := if (trim(l.file_acquired_date[1..4],left,right) in year2005,l.Special21998,
													 if(trim(l.process_date[1..4],left,right) in year2005, l.Special21998, ''));
	self.General2005  := if (trim(l.file_acquired_date[1..4],left,right) in year2005,l.General1998,
													 if(trim(l.process_date[1..4],left,right) in year2005, l.General1998, ''));
	
	self.primary2006  := if (trim(l.file_acquired_date[1..4],left,right) in year2006,l.Primary1999,
													 if(trim(l.process_date[1..4],left,right) in year2006, l.Primary1999, ''));
	self.Special12006 := if (trim(l.file_acquired_date[1..4],left,right) in year2006,l.Special1999,
													 if(trim(l.process_date[1..4],left,right) in year2006, l.Special1999, ''));
	self.Other2006    := if (trim(l.file_acquired_date[1..4],left,right) in year2006,l.Other1999,
													 if(trim(l.process_date[1..4],left,right) in year2006, l.Other1999, ''));
	self.Special22006 := if (trim(l.file_acquired_date[1..4],left,right) in year2006,l.Special21999,
													 if(trim(l.process_date[1..4],left,right) in year2006, l.Special21999, ''));
	self.General2006  := if (trim(l.file_acquired_date[1..4],left,right) in year2006,l.General1999,
													 if(trim(l.process_date[1..4],left,right) in year2006, l.General1999, ''));
		
  self := l;
end;

export Fix_Voters_VoteHistory_mapping := project(d, trfFixVoteHist(left));