IMPORT AID;  

EXPORT mac_AID_cleanAddress(DatasetIn, DatasetOut, lFlag = AID.Common.eReturnValues.ACECacheRecords) := MACRO

IMPORT AID, ADDRESS;

	#uniquename(lFlagAIDAce)
	%lFlagAIDAce% := (UNSIGNED4)lFlag;

	#uniquename(pDatasetIn)
	%pDataSetIn% := DatasetIn;

	#uniquename(Cleaned_Address) 
	AID.MacAppendFromRaw_2Line(%pDataSetIn%, Pline1, PlineLast, aid, %cleaned_address%, %lFlagAIDAce%);

	#uniquename(Add_Clean_Address) 
	TYPEOF(DatasetIn) %add_clean_address%(%cleaned_address% l) := TRANSFORM
		SELF.AID          := l.aidwork_acecache.AID;
		SELF.DALI         := l.aidwork_acecache.DALI;
		SELF.Prim_Range   := l.aidwork_acecache.prim_range;
		SELF.Predir       := l.aidwork_acecache.predir;
		SELF.Prim_Name    := l.aidwork_acecache.prim_name;
		SELF.Addr_Suffix  := l.aidwork_acecache.addr_suffix;
		SELF.Postdir      := l.aidwork_acecache.postdir;
		SELF.Unit_Desig   := l.aidwork_acecache.unit_desig;
		SELF.Sec_Range    := l.aidwork_acecache.sec_range;
		SELF.v_City_Name  := l.aidwork_acecache.v_city_name;
		SELF.p_City_Name  := l.aidwork_acecache.v_city_name;
		SELF.St           := l.aidwork_acecache.st;
		SELF.Z5         := l.aidwork_acecache.zip5;
		SELF.Z4         := l.aidwork_acecache.zip4;
		SELF.Cart         := l.aidwork_acecache.Cart;
		SELF.Cr_Sort_Sz   := l.aidwork_acecache.Cr_Sort_Sz;
		SELF.Lot          := l.aidwork_acecache.Lot;
		SELF.Lot_Order    := l.aidwork_acecache.Lot_Order;
		SELF.Dpbc         := l.aidwork_acecache.Dbpc;
		SELF.Chk_Digit    := l.aidwork_acecache.Chk_Digit;
		SELF.Rec_Type     := l.aidwork_acecache.Rec_Type;
		SELF.County_Code  := l.aidwork_acecache.county;
		SELF.Geo_Lat      := l.aidwork_acecache.Geo_Lat;
		SELF.Geo_Long     := l.aidwork_acecache.Geo_Long;
		SELF.Msa          := l.aidwork_acecache.Msa;
		SELF.Geo_Blk      := l.aidwork_acecache.Geo_Blk;
		SELF.Geo_Match    := l.aidwork_acecache.Geo_Match;
		SELF.Err_Stat     := l.aidwork_acecache.err_stat;
		SELF              := l;
	END;	
	cleanAddr    := PROJECT(%cleaned_address%, %add_clean_address%(LEFT));

	DatasetOut  := cleanAddr;

ENDMACRO;

