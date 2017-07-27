import header,ut,address,mdr;

pre_header_file := header.ImprovedByUtil; // basic header file plus 
										  // utility recs

//fix any funky DOBs
header.MAC_format_DOB(pre_header_file, header_file_better_dob )

//fix any funky prim_ranges
header.MAC_Improve_Prim_Range(header_file_better_dob, hd )

// new records enter header process here.
dis_use := distribute(header.New_Header_Records(header.isPersonRec(fname, mname, lname, name_suffix) and
								     prim_name <> ''),hash(fname,lname,zip,zip4));

//Take latest date
use_srt := sort(dis_use,fname,lname,zip,zip4,src,rec_type,phone,ssn,dob,mname,name_suffix,
									 prim_range,predir,prim_name,suffix,postdir,unit_desig,
									 sec_range,city_name,st,county,-dt_last_seen,local);

use_record_d := dedup(use_srt,fname,lname,zip,zip4,src,rec_type,phone,ssn,dob,mname,name_suffix,
									 prim_range,predir,prim_name,suffix,postdir,unit_desig,
									 sec_range,city_name,st,county,local);

ut.MAC_Sequence_Records(use_record_d,uid,outfile1)
mdr.MAC_BasicMatch(outfile1,outf)

header.Layout_Header to_form(outf l) := transform
  self.rid := IF (l.rid=0,mdr.max_rid+l.uid,l.rid);
  self.did := IF (l.did=0,mdr.max_rid+l.uid,l.did);
  self.pflag1 := MAP(l.did=0=>'A',l.rid=0=>'P','+');
  self := l;
  end;

new_month_joined := project(outf,to_form(left))(header.Blocked_data_new());

Header.Layout_header blank_pflag(hd l) := transform
  self.pflag1 := ''; // Header is now considered clean
  self := l;
  end;

pnew := project(hd,blank_pflag(left));

rpp := record
  pnew.did;
  pnew.rid;
  end;
// fixes did > rid problems
bad_rid_did := table(pnew(did>rid),rpp);
brd := dedup(sort(distribute(bad_rid_did,hash(did)),did,rid,local),did,local);
ut.MAC_Patch_Id(pnew,did,brd,did,rid,pnew1)

boolean do_patch := false : stored('DoPatch');

head := if (do_patch,pnew1,pnew);

o_and_n := head + new_month_joined;

rldup := MDR.Rollup1;

ut.MAC_Patch_Id(o_and_n,rid,rldup,old_rid,new_rid,old_and_new)

//****** Remove some known bad names  city_name='OZ' and st
kill_junk := old_and_new(~UT.BogusNames(FNAME, LNAME) and ~UT.BogusCities(city_name, st));

Header.MAC_Merge_ByRid(kill_junk,merged)

typeof(merged) fix_did(merged le,header.dodgydids ri) := transform
  self.did := if ( ri.did=0, le.did, le.rid ); // Patch did back to rid if dodgy
  self.pflag1 := IF( ri.did=0, le.pflag1, 'D' );
  self.name_suffix := IF(~le.name_suffix IN ['','UNK','BOO'] or ri.did=0,le.name_suffix,'UNK');
  self := le;
  end;

neg_dids := join(merged,header.DodgyDids,left.did=right.did,fix_did(left,right),left outer,lookup);
if ( count(neg_dids(did>rid)) <> 0, output('DID > RID constraint violated') );
export header_joined := neg_dids : persist('Header_Joined');
//export header_joined := dataset('temp::head_Match_base',header.layout_header,flat);