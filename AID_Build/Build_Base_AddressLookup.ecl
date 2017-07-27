import aid,ut,STD;
export Build_Base_AddressLookup(	STRING	pVersion											=	(STRING8)Std.Date.Today(),
																					BOOLEAN	pUseOtherEnvironment	=	FALSE,
																					BOOLEAN	isFCRA								=	FALSE)	:=	FUNCTION

	 
	dRaw	:=	AID.Files.RawCacheProd;
	dStd	:=	AID.Files.StdCacheProd;
	dACE	:=	AID.Files.ACECacheProd;

	slimAceRec := record
		typeof(dAce.aid) aceaid;
		dACE.prim_range;
		dACE.predir;
		dACE.prim_name;
		dACE.addr_suffix;
		dACE.postdir;
		dACE.unit_desig;
		dACE.sec_range;
		dACE.p_city_name;
		dACE.v_city_name;
		dACE.st;
		dACE.zip5;
		dACE.zip4;
		dACE.county;
		dACE.geo_lat;
		dACE.geo_long;
		dACE.cart;
		dACE.cr_sort_sz;
		dACE.lot;
		dACE.lot_order;
		dACE.dbpc;
		dACE.chk_digit;
		dACE.rec_type;
		dACE.msa;
		dACE.geo_blk;
		dACE.geo_match;
		dACE.err_stat;
	end;

	slimRawRec := record
		typeof(dRaw.aid) rawaid;
		dRaw.line1;
		dRaw.linelast;
		dRaw.stdaid;
		dRaw.referaid;
		unsigned8 hash_line1;
		unsigned8 hash_linelast;
	end;

	slimStdRec := record
		typeof(dStd.aid) stdaid;
		dStd.cleanaid;
	end;

	WorkRec1 := record
		slimRawRec;
		slimStdRec;
	end;

	WorkRec2 := record
		WorkRec1;
		slimAceRec;
	end;
	 
	 
	 //Slim Down to just to necessary fields and add hash value for address information
	dSlimRaw := project(dRaw, transform(slimRawRec,
																			self.rawaid        := left.aid,
																			self               := left,
																			self.hash_line1    := hash64(left.line1),
																			self.hash_linelast := hash64(left.linelast)));
	dSlimStd := project(dStd, transform(slimStdRec, self.stdaid := left.aid, self := left));
	dSlimAce := project(dAce, transform(slimAceRec, self.aceaid := left.aid, self := left));

	//Distribute in preperation for local joins 
	dDistStd  := distribute(dSlimStd, hash32(stdaid));
	dDistRaw  := distribute(dSlimRaw, hash32(stdaid));
	dDistAce  := distribute(dSlimAce, hash32(aceaid));

	//Get the Standard Address Record so we can tie it to the Cleaned ADdress
	dRawStd   := join(dDistRaw, dDistStd ,
										left.stdaid = right.stdaid,
										transform(WorkRec1,
															self := left,
															self := right), local);
																										
	//Redistribute after join
	dDistRawStd := distribute(dRawStd, hash32(cleanaid));
														
	//Add in the Cleaned Address Info													
	dRawStdACE	:=	join(dDistRawStd, dDistAce,
											 left.cleanaid = right.aceaid,
											 transform(WorkRec2,
																 self := left,
																 self := right),
											 local
											);

	//Distribute and local dedup to make sure we only have one match for each key.
	djoinedDist			:=	distribute(dRawStdACE,hash_line1);
	djoineddedup		:=	dedup(djoinedDist,hash_line1,hash_linelast,all,local);

	//Transform to final layout
	dFinal	:=	project(djoineddedup,layouts.rFinal_AddressLookup);
	RETURN	dFinal;
END;
