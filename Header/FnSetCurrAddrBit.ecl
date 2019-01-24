EXPORT FnSetCurrAddrBit (pInDs) := functionmacro
import watchdog, ut, doxie;

	InDs:=distribute(pInDs,hash(prim_name,prim_range,st,zip,did));

	wAddr:=watchdog.File_Best(adl_ind in ['CORE','C_MERGE','AMBIG','NO_SSN'],prim_name<>'',(unsigned)zip>0);
	wSlim:=distribute(table(wAddr,{did,qstring28 pn:=doxie.StripOrdinal(prim_name),prim_range,st,zip}),hash(pn,prim_range,st,zip,did));

	OutDs:=join(InDs,wSlim,
					Left.prim_name = Right.pn AND
					Left.prim_range = Right.prim_range AND
					Left.st = Right.st AND
					Left.zip = Right.zip AND
					Left.did = Right.did
				,transform({InDs}
					,SELF.lookups := if(left.did=right.did,ut.bit_set(left.lookups,31),left.lookups)
					,self:=left
					)
				,left outer
				,local
				);

	return OutDs;

endMacro;