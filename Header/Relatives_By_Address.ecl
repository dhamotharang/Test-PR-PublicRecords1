/*					Relatives_By_Address
==============================================================	
Generate did pairs based on the same address. 
Split from the original Header.Relatives.
*/

dhdrs := relative_candidates;
//sreq(string5 le, string5 ri) := MAP( le=ri=>3, le='' or ri=''=>2, 0 );
sreq(string5 le, string5 ri) := MAP( le=ri=>3, le='' or ri=''=>1, 0 );
Layout_Relatives match_them(dhdrs lef, dhdrs rig) := transform
  self.person1 := lef.did;
  self.person2 := rig.did;
  self.same_lname := lef.lname=rig.lname;
  self.zip:=(integer)lef.zip;
  self.prim_range:=if(sreq(lef.sec_range,rig.sec_range)=0,
    -3,
    //Extract any number from prim_name before final roll up, since we dedup by prim_name.
    (integer)Header.getSpecialRelPrim(lef.prim_range, lef.prim_name));
  self.number_cohabits := ut.Max2(
    sreq(lef.sec_range,rig.sec_range)
    + IF (lef.first_seen > rig.last_seen+2  or rig.first_seen > lef.last_seen+2,
      0,
      1 + IF(lef.lname=rig.lname and sreq(lef.sec_range,rig.sec_range)<>0, 
              ut.imin2( lef.lname_weight, rig.lname_weight), 0 
          )
      )
    //Decrease 1 point when both prime range and second range are empty. Mostly for rural area. See bug12826.
    - if (lef.prim_range='' and rig.prim_range='' and lef.sec_range='' and rig.sec_range='', 1, 0),
	0) ; //number_cohabit does not decrease below zero.

  self.recent_cohabit := ut.date_overlap_last(lef.first_seen,lef.last_seen,
                                              rig.first_seen,rig.last_seen)
	                    +IF(self.number_cohabits=0,skip,0);
  end;

export Relatives_By_Address := join(dhdrs,dhdrs(did != 0),left.addr4=right.addr4 and
                             left.predir=right.predir and
                             left.postdir=right.postdir and
                             left.did > right.did,
                             match_them(left,right));
							 
