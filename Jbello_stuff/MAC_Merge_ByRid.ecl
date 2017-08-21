export MAC_Merge_ByRid(infile,outfile) := macro

dinfile := distribute(infile,hash(did));

//****** Sort each group of rids by rid, descending MAC_BR_hasz4,
//		 descending vendor last reported date, ascending vendor first reported date
//       The local is ok because of the preceeding distribute
MAC_BR_s := sort(dinfile
//Roll hard on thes fields
						,did
						,src
						,fname
						,lname
						,prim_range
						,prim_name
						,st
						,dt_first_seen
//Roll soft on these fields when dt_first_seen are close
						,sec_range
						,zip
						,county
						,ssn
						,dob
						,mname
						,name_suffix
						,phone
						,local);

//****** Rollup the records with matching did.  Keep the one first in sort order above.
//		 If the first record has a blank field, info will be taken from the second.
outfile := rollup(MAC_BR_s
//Roll hard on thes fields
					,	left.did		=right.did
					and	left.src		=right.src
					and	left.fname		=right.fname
					and	left.lname		=right.lname
					and	left.prim_range =right.prim_range
					and	left.prim_name  =right.prim_name
					and	left.st			=right.st
					and ut.DaysApart((STRING6)left.dt_first_seen+'01',(STRING6)right.dt_first_seen+'01')<4*30
					and	(
//Roll soft on these fields when dt_first_seen are close
								(ut.nneq(left.ssn				,right.ssn)
							and	ut.NNEQ_Date(left.dob			,right.dob)
							and	ut.nneq(left.phone				,right.phone)
							and	ut.nneq(left.mname				,right.mname)
							and	ut.nneq(left.name_suffix		,right.name_suffix)
							and	ut.nneq(left.sec_range			,right.sec_range)
							and	ut.nneq(left.zip				,right.zip)
							and	ut.nneq(left.county				,right.county)
							)
						)
					,jbello_stuff.Tra_Merge_Headers(left,right)
					,local);

  endmacro;