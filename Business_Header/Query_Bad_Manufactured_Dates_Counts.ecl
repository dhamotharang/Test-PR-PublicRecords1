#workunit ('name', 'Business Header bad date count');

bh := Business_Header.File_Business_Header_Base;
current_date := '20050829';

// Count Unique BDIDs in the Business Header file
layout_bh_slim := record
bh.source;
bh.dt_first_seen;   // Date record first seen at Seisint
bh.dt_last_seen;    // Date record last (most recently seen) at Seisint
bh.dt_vendor_first_reported;
bh.dt_vendor_last_reported;
end;

bh_slim := table(bh, layout_bh_slim);
output('BH future date first seens: ' + count(bh_slim((integer)dt_first_seen > (integer)current_date))); 
output('BH future date last seens: ' + count(bh_slim((integer)dt_last_seen > (integer)current_date))); 
output('BH date first seens > date last seen: ' + count(bh_slim((integer)dt_first_seen > (integer)dt_last_seen))); 
output('BH future date vendor first reported: ' + count(bh_slim((integer)dt_vendor_first_reported > (integer)current_date))); 
output('BH date vendor first reported > date vendor last reported: ' + count(bh_slim((integer)dt_vendor_first_reported > (integer)dt_vendor_last_reported))); 
output('BH future date vendor last reported: ' + count(bh_slim((integer)dt_vendor_last_reported > (integer)current_date))); 

/////////////////////////////////////////////////////////////////////////
bc := Business_Header.File_Business_Contacts_base;

// Count Unique BDIDs in the Business Header file
layout_bc_slim := record
bc.source;
bc.dt_first_seen;   // Date record first seen at Seisint
bc.dt_last_seen;    // Date record last (most recently seen) at Seisint
end;

bc_slim := table(bc, layout_bc_slim);
output('BC future date first seens: ' + count(bc_slim((integer)dt_first_seen > (integer)current_date))); 
output('BC date first seens > date last seen: ' + count(bc_slim((integer)dt_first_seen > (integer)dt_last_seen))); 
output('Bc future date last seens: ' + count(bc_slim((integer)dt_last_seen > (integer)current_date))); 
/////////////////////////////////////////////////////////////////////////
bhb := Business_Header.File_Business_Header_Best;

// Count Unique BDIDs in the Business Header file
layout_bhb_slim := record
bhb.dt_last_seen;    // Date record last (most recently seen) at Seisint
end;

bhb_slim := table(bhb, layout_bhb_slim);
output('BHB future date last seens: ' + count(bhb_slim((integer)dt_last_seen > (integer)current_date))); 
