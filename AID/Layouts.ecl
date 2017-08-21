import	AID_Support;

export Layouts
 :=
	module

		/**************************************************************************************
		 ** Raw address structure.  LineLast always City/State/Zip, other lines used as
		 ** required, starting with Line1.  Typical two-line address would use Line1, LineLast.
		 **************************************************************************************/
		export	rRawStruct
		 :=
			record
				string80	Line1;
				string80	Line2;
				string80	Line3;
				string60	LineLast;
			end
		 ;

		/**************************************************************************************
		 ** Regardless of Raw, these are the two lines passed to cleaner[s].
		 **************************************************************************************/
		export	rStdStruct
		 :=
			record
				string80	Line1;
				string60	LineLast;
			end
		 ;

		/**************************************************************************************/
		export	rACEStruct
		 :=
			record
				string10	prim_range;
				string2		predir;
				string28	prim_name;
				string4		addr_suffix;
				string2		postdir;
				string10	unit_desig;
				string8		sec_range;
				string25	p_city_name;
				string25	v_city_name;
				string2		st;
				string5		zip5;
				string4		zip4;
				string4		cart;
				string1		cr_sort_sz;
				string4		lot;
				string1		lot_order;
				string2		dbpc;
				string1		chk_digit;
				string2		rec_type;
				string5		county;
				string10	geo_lat;
				string11	geo_long;
				string4		msa;
				string7		geo_blk;
				string1		geo_match;
				string4		err_stat;
			end
		 ;

		/**************************************************************************************
		 ** Layout of raw input, slimmed to just Sequence RecordID (not AID), Line1, & Line2 (internal only)
		 **************************************************************************************/
		export	rRawSlimSeq
		 :=
			record
				Common.xRecordID			AIDWork_RecordID;
				Common.xRecordID			AIDWork_RawStructSameAsRecordID;
				Common.xAID						AIDWork_OriginalRawAID;
				rRawStruct						rAIDWork_RawStruct;
			end
		 ;

		/**************************************************************************************
		 ** Layout of Raw Cache
		 **************************************************************************************/
		export	rRawCache
		 :=
			record
				Common.xAID						AID;
				unsigned4							Hash32_Full;
				Common.xAddressType		AddressType;
				rRawStruct;
				boolean								IsNormalized;
				Common.xFlags					NormalizeFlags;
				Common.xFlags					Flags;
				Common.xDateString		DateSeenFirst;
				Common.xDateString		DateSeenLast;
				unsigned4							CountSeen;
				Common.xVersion				StdVersion;
				Common.xAID						StdAID;
				Common.xAID						ReferAID;
				Common.xWUID					CreatedWUID;
			end
		 ;

		/**************************************************************************************
		 ** NOTE:  Should be same as above, but to allow interim builds, another layer
		 **************************************************************************************/
		export	rRawIndexPayload
		 :=
			record
				rRawCache;
			end
		 ;

		/**************************************************************************************
		 ** Sequenced raw input (above) plus Raw Cache layout for join targeting (internal only)
		 **************************************************************************************/
		export	rRawSlimSeqRawCache
		 :=
			record
				rRawSlimSeq;
				boolean								AIDWork_IsInRawCache;
				rRawCache							rAIDWork_RawCache;
			end
		 ;

		/**************************************************************************************
		 ** Standardized cache layout
		 **************************************************************************************/
		export	rStdCache
		 :=
			record
				Common.xAID						AID;
				unsigned4							Hash32_Full;
				Common.xAddressType		AddressType;
				rStdStruct;
				Common.xDateString		DateSeenFirst;
				Common.xDateString		DateSeenLast;
				unsigned4							CountSeen;
				Common.xAID						ReferAID;
				string1								Cleaner;
				Common.xDateString		DateValidFirst;
				Common.xDateString		DateValidLast;
				Common.xDateString		DateErrorFirst;
				Common.xDateString		DateErrorLast;
				Common.xAID						CleanAID;
				Common.xCleanStatus		ReturnCode;
				Common.xDateString		DateCleanLast;
				Common.xWUID					CreatedWUID;
			end
		 ;

		/**************************************************************************************
		 ** NOTE:  Should be same as above, but to allow interim builds, another layer
		 **************************************************************************************/
		export	rStdIndexPayload
		 :=
			record
				rStdCache;
			end
		 ;

		/**************************************************************************************
		 ** Layout of raw input, slimmed, raw cache, and standardized cache (internal only)
		 **************************************************************************************/
		export	rRawSlimSeqRawCacheStdCache
		 :=
			record
				rRawSlimSeqRawCache;
				boolean								AIDWork_IsInStdCache;
				Common.xRecordID			AIDWork_StdStructSameAsRecordID;
				rStdCache							rAIDWork_StdCache;
			end
		 ;

		/**************************************************************************************/
		export	rACECache
		 :=
			record
				Common.xAID						AID;
				unsigned4							Hash32_Full;
				Common.xAddressType		AddressType;
				Common.xDateString		DateSeenFirst;
				Common.xDateString		DateSeenLast;
				unsigned4							CountSeen;
				Common.xAID						CleanAID;
				Common.xAID						ReferAID;
				rACEStruct;
				Common.xWUID					CreatedWUID;
			end
		 ;

		/**************************************************************************************
		 ** NOTE:  Should be same as above, but to allow interim builds, another layer
		 **************************************************************************************/
		export	rACEIndexPayload
		 :=
			record
			rACECache;
			end
		 ;

		/**************************************************************************************
		 ** Layout of raw input, slimmed, raw cache, standardized cache, & clean cache (internal only)
		 **************************************************************************************/
		export	rRawSlimSeqRawCacheStdCacheACECache
		 :=
			record
			rRawSlimSeqRawCacheStdCache;
			boolean									AIDWork_IsInACECache;
			Common.xRecordID				AIDWork_ACEStructSameAsRecordID;
			rACECache								rAIDWork_ACECache;
			end
		 ;

		/**************************************************************************************/
		export	rRawCacheUpdate	:=	AID_Support.Layouts.rRawCacheUpdate;

		/**************************************************************************************/
		export	rStdCacheUpdate	:=	AID_Support.Layouts.rStdCacheUpdate;

		/**************************************************************************************/
		export	rACECacheUpdate	:=	AID_Support.Layouts.rACECacheUpdate;

	end
 ;