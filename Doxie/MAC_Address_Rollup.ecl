export MAC_Address_Rollup(infile,dedup_num,outfile, isKnowx = false) := macro
import ut, address;
#uniquename(grpd)
%grpd% := group(infile,did,all);
#uniquename(srtd)
//%srtd% := sort(%grpd%,prim_range,prim_name,-sec_range,-predir,if(suffix<>'',0,1),-zip4,-dt_last_seen,dt_first_seen,-phone,-listed_phone,-fname,-mname,-lname);

// few challenges of this address rollup: 
// a) can't allow rollup of addresses in different cities/states;
// b) zip5 can change with time;
// c) the only cleaner response code indicator is zip4 field. Assumption is that if it's filled in, then
//    this address used to be cleaned properly at its time;  

//sorting first by state looks to be innocent, but will help to handle case of different states
%srtd% := sort(%grpd%,st, city_name, prim_range,prim_name,-sec_range,-predir, suffix='', zip4='', 
               -dt_last_seen,dt_first_seen,-phone,-listed_phone,-fname,-mname,-lname);
#uniquename(rld)
%rld% := rollup(%srtd%, (left.st = right.st) and (left.city_name = right.city_name) and 
                        (left.prim_range=right.prim_range) and 
               ( 	left.prim_name=right.prim_name or
				(left.zip4<>'' and right.zip4='') and  //only rollup a mismatched prim_name when one is better than the other 
				( ut.StringSimilar(left.prim_name,right.prim_name)<3 or
				length(trim(left.prim_range))>2 )
			)
			and ut.nneq(left.predir, right.predir) and
			address.Sec_Range_Eq(left.sec_range,right.sec_range)<10, doxie.tra_address_rollup(left,right));
#uniquename(rld_sorted)
%rld_sorted% := if (isKnowx, 
		sort( %rld%, doxie.tnt_score(tnt), -dt_last_seen, -dt_vendor_last_reported, -shared_address, -dt_first_seen ), 
		sort( %rld%, doxie.tnt_score(tnt), -dt_last_seen, -shared_address, -dt_first_seen ));
		
#uniquename(outfile_ddp)
%outfile_ddp% := ungroup( dedup( %rld_sorted%, true, keep(dedup_num)));

outfile := if (dedup_num > 0, %outfile_ddp%, dataset ([], doxie.Layout_Comp_Addresses));
endmacro;

