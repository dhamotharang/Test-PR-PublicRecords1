import header, ut, Watchdog, drivers, bankrupt, ingenix_natlprof;

export mac_vendor_did_matching(infile, dataset_, 
                               did_field, fname_field, mname_field, lname_field, suffix_field,
							   vendor_id, use_mname, use_suffix, outfile) := macro

#uniquename(did_match_rec)
%did_match_rec% := record
 
 unsigned6 did         := did_field;
 string20  fname       := fname_field;
 string20  mname       := if(use_mname='true',mname_field,'');
 string20  lname       := lname_field;
 string5   name_suffix := if(use_suffix='true',suffix_field,'');
 string30  derived_id  := vendor_id;
 qstring9  ssn         := '';
 qstring4  dob         := '';
 
end;

//Assumption below is that no vendor_id is 2 or less characters
//This should handle potential instances in DL's where orig_state<>'' and dl_number=''

//For DL's, this macro collapses 2 add'l DID's that do not collapse in DL_DID_Matches -> they are valid.
//DID are: 13869284684, 103815674615, 114427957644, 140894115966 -> spreadsheet available

#uniquename(unique_t1)
%unique_t1% := table(infile((integer)did_field<>0 and length(trim((string)vendor_id))>2),%did_match_rec%);

#uniquename(unique_nodup)
ut.MAC_Remove_Withdups(%unique_t1%,derived_id,20,%unique_nodup%)

#uniquename(unique_vendor_dist)
%unique_vendor_dist% := distribute(%unique_nodup%,hash(did));

#uniquename(t_add_dob_ssn)
%did_match_rec% %t_add_dob_ssn%(%did_match_rec% le, watchdog.layout_best ri) := transform
 self.ssn := ri.ssn;
 self.dob := if(ri.dob=0,'',(qstring4)(ri.dob div 10000));
 self     := le;
end;

//The Bankrupt_DID_Matches does an Inner-join to the Best file -> records are dropped from the left dataset
//DL does a left-outer
//The Bankrupt_DID_Matches collapsed 46 DID's that the macro did not
//All of the DL_DID_Matches were also in the macro
//For Bankruptcies, the macro produced 3645 new matches that were not produced in Bankrupt_DID_Matches

#uniquename(unique_best_vendor)
%unique_best_vendor% := join(%unique_vendor_dist%,watchdog.file_best,
                      left.did=right.did,
					  %t_add_dob_ssn%(left,right),
					  left outer,
					  local
					 );

// Find possible DID matches
#uniquename(t_match_dids)
header.layout_pairmatch %t_match_dids%(%did_match_rec% le, %did_match_rec% ri) := transform
 self.old_rid := if(le.did < ri.did, ri.did, le.did);
 self.new_rid := if(le.did > ri.did, ri.did, le.did);
 //self.pflag   := 12;
 
 self.pflag   := case(stringlib.stringtouppercase(dataset_),
                     'DL'       => 12,
				     'BANKRUPT' => 15,
					 'INGENIX'  => 16,
				     0
				  );
 				  
end;

#uniquename(unique_dist)
%unique_dist% := distribute(%unique_best_vendor%,hash(derived_id));

#uniquename(unique_j)
%unique_j% := JOIN(%unique_dist%, %unique_dist%, 
          left.derived_id = right.derived_id                  and
		  left.fname      = right.fname                       and 
		  left.mname      = right.mname                       and 
		  left.lname      = right.lname                       and
		  ut.nneq_suffix(left.name_suffix, right.name_suffix) and 
		  ut.nneq_int   (left.dob,         right.dob)         and 
		  ut.nneq_ssn   (left.ssn,         right.ssn)         and
		  left.did        != right.did,
		  %t_match_dids%(left, right),
		 local);

#uniquename(unique_ddp)
%unique_ddp% := dedup(%unique_j%, old_rid, new_rid, all);

outfile := %unique_ddp% : persist('persist::'+dataset_+'_did_matches');

endmacro;