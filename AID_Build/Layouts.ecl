import AID;
export Layouts := MODULE

export dRaw	:=	AID.Files.RawCacheProd;
export dStd	:=	AID.Files.StdCacheProd;
export dACE	:=	AID.Files.ACECacheProd;

export rStdACE := RECORD
	TYPEOF(dStd.AID)	Temp_StdAID;
	RECORDOF(dACE)		rACECache;
END;

export rRawStdACE := RECORD
	TYPEOF(dRaw.AID)		RawAID;
	RECORDOF(rStdACE);
END;

export rFinal := RECORD
	AID.Common.xAID					RawAID;
	AID.Common.xAID					ACEAID;
	AID.Layouts.rACEStruct;
END;

export rFinal_AddressLookup := RECORD
  unsigned8 hash_line1;
  unsigned8 hash_linelast;
	typeof(dRaw.aid) rawaid;
	typeof(dStd.aid) stdaid;
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
END;

END;