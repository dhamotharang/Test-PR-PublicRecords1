/*Find the Best title dependent on the gender table */


import header, mdr, ut;

f := file_header_filtered(title in ['MR','MS']);

rfields := record
 f.did;
 f.title;
end;

with_title := table(f,rfields,local);

sorted_duped := dedup(sort(with_title,did,title,local),did,local);		

export Besttitle := sorted_duped : persist('persist::watchdog_Besttitle');