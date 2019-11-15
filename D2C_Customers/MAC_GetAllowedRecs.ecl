/************** Filter records based on sub-srcs ****************/

//Aircraft(AR)   - all allowed, no restrictions
//Airmen(AR)     - all allowed, no restrictions
//Bankruptcy(BA) - all allowed, no restrictions
//Students(SL)   - all allowed, no restrictions
//Criminals      - no src filter
//UCC            - no src filter
//people at work - no src filter
//sex offenders  - no src filter
//emails         - no src filter

EXPORT MAC_GetAllowedRecs(inHdr, inAllowedDS, src_code) := FUNCTIONMACRO

    #uniquename(UniqDid)
	%UniqDid% := dedup(inAllowedDS, did, all);

	#uniquename(AllowedHdr)
	%AllowedHdr% := join(distribute(inHdr(src in #EXPAND(src_code)), hash(did)),
					distribute(%UniqDid%, hash(did)),
					left.did = right.did,
					transform(left),
					inner,
					local);
    #uniquename(res)					
	%res% := %AllowedHdr% + inHdr(src not in #EXPAND(src_code));

	return %res%;

ENDMACRO;