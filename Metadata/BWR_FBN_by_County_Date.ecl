//FBN by County Date W20071105-173418

in_ca := ['CA','CAB','CAO','CAV','CSC']; //For CA state and county sources only

output(table(fbnv2.File_FBN_Business_Base(filing_jurisdiction in in_ca),
  {filing_jurisdiction,bus_county,bus_state,count(group),
   min(group,if(dt_first_seen<18010101,20071105,dt_first_seen)),
   max(group,dt_first_seen)},
  filing_jurisdiction,bus_county,bus_state),all);