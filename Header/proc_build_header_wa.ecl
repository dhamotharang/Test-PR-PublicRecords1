import ut,PromoteSupers,std;
  
file_in := Header.File_Headers(st='WA');

integer curr_yr      := (integer)((STRING8)Std.Date.Today())[1..4];
integer five_yrs_ago := curr_yr - 4;

hdr_latest := dedup(sort(distribute(file_in((integer)((string)dt_last_seen)[1..4] between five_yrs_ago and curr_yr),hash(did)), did,local),did,local);

slim_rec := record
 file_in.did;
end;

slim_rec reformat(file_in l) := transform
 self := l;
end;

wa_out      := project(hdr_latest,reformat(left));

PromoteSupers.Mac_SF_BuildProcess(wa_out,'~thor_data400::base::header_wa',build_wa_header,2);

export proc_build_header_wa := build_wa_header;

