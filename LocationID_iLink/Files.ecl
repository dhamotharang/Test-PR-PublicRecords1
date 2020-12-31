import AID,_Control;

EXPORT Files := module
  export bocaProdDali     := _Control.IPAddress.prod_thor_dali;
  export cleanAIDFileName := '~foreign::' + bocaProdDali + '::thor::base::aidtemp::ace::cache::prod';
  export rawAIDFileName   := '~foreign::' + bocaProdDali + '::thor::base::aidtemp::raw::cache::prod';
  export stdAIDFileName   := '~foreign::' + bocaProdDali + '::thor::base::aidtemp::std::cache::prod';

		export	RawAidRec :=
			record
				AID.Common.xAID						   AID;
				unsigned4							        Hash32_Full;
				AID.Common.xAddressType	AddressType;
				string80	               Line1;
				string80	               Line2;
				string80	               Line3;
				string60	               LineLast;
				boolean								         IsNormalized;
				AID.Common.xFlags					  NormalizeFlags;
				AID.Common.xFlags					  Flags;
				AID.Common.xDateString		DateSeenFirst;
				AID.Common.xDateString		DateSeenLast;
				unsigned4							        CountSeen;
				AID.Common.xVersion				 StdVersion;
				AID.Common.xAID						   StdAID;
				AID.Common.xAID						   ReferAID;
				AID.Common.xWUID					   CreatedWUID;
		end;

		export	StdAidRec := record
				AID.Common.xAID						    AID;
				unsigned4							         Hash32_Full;
				AID.Common.xAddressType		AddressType;
				string80	                Line1;
				string60	                LineLast;
				AID.Common.xDateString		 DateSeenFirst;
				AID.Common.xDateString		 DateSeenLast;
				unsigned4							         CountSeen;
				AID.Common.xAID						    ReferAID;
				string1								          Cleaner;
				AID.Common.xDateString		 DateValidFirst;
				AID.Common.xDateString		 DateValidLast;
				AID.Common.xDateString		 DateErrorFirst;
				AID.Common.xDateString		 DateErrorLast;
				AID.Common.xAID						    CleanAID;
				AID.Common.xCleanStatus		ReturnCode;
				AID.Common.xDateString		 DateCleanLast;
				AID.Common.xWUID				    	CreatedWUID;
			end;
			
  export CleanAIDRec := RECORD
    unsigned8 aid;
    unsigned4 hash32_full;
    string1 addresstype;
    string8 dateseenfirst;
    string8 dateseenlast;
    unsigned4 countseen;
    unsigned8 cleanaid;
    unsigned8 referaid;
    string10 prim_range;
    string2 predir;
    string28 prim_name;
    string4 addr_suffix;
    string2 postdir;
    string10 unit_desig;
    string8 sec_range;
    string25 p_city_name;
    string25 v_city_name;
    string2 st;
    string5 zip5;
    string4 zip4;
    string4 cart;
    string1 cr_sort_sz;
    string4 lot;
    string1 lot_order;
    string2 dbpc;
    string1 chk_digit;
    string2 rec_type;
    string5 county;
    string10 geo_lat;
    string11 geo_long;
    string4 msa;
    string7 geo_blk;
    string1 geo_match;
    string4 err_stat;
    string20 createdwuid;
  END;
 
	 export cleandAIDDs := dataset(cleanAIDFileName,CleanAIDRec,thor);
	 export rawAIDDs    := dataset(rawAIDFileName,RawAIDRec,thor);
	 export stdAIDDs    := dataset(stdAIDFileName,StdAIDRec,thor);
end;
