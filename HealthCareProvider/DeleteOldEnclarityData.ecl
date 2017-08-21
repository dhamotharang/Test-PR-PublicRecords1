EXPORT DeleteOldEnclarityData (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Hdr, 
															 DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Idv,
															 DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Asc) := FUNCTION

			r := record
				unsigned8 source_rid;
			end;
			
			Indv_DS := project (idv,r);
			
			Assoc_DS := project (asc,r);
			
			RID_DS := DISTRIBUTE(Indv_DS + Assoc_DS, HASH32(SOURCE_RID));
			
			Old_RID := DEDUP(SORT(RID_DS,SOURCE_RID,LOCAL),SOURCE_RID,LOCAL);
			
			O_HDR := DISTRIBUTE (HDR(SRC <> '64'),HASH32(LNPID));
			D_HDR := DISTRIBUTE (HDR(SRC = '64'),HASH32(SOURCE_RID));
			
			New_HDR := JOIN (D_HDR,OLD_RID,LEFT.SOURCE_RID = RIGHT.SOURCE_RID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;), INNER, LOCAL);
			
			RETURN SORT(DISTRIBUTE (New_HDR + O_HDR,HASH32(LNPID)),LNPID,LOCAL);
END;