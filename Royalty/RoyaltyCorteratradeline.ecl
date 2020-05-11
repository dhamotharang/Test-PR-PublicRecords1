IMPORT Royalty;
EXPORT RoyaltyCorteraTradeline := MODULE

EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, fAcctno='G_ProcBusUID') := 
		FUNCTIONMACRO

			Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
			TRANSFORM
				SELF.acctno							:= l.AcctNo;
				SELF.royalty_type_code	:= Royalty.Constants.RoyaltyCode.CORTERA_FILE;
				SELF.royalty_type 			:= Royalty.Constants.RoyaltyType.CORTERA_FILE;
				SELF.royalty_count 			:= (UNSIGNED)((INTEGER)r.B2BAccountCount > 0); 
				SELF.non_royalty_count 	:= 0;
				SELF.source_type        :=Royalty.Constants.SourceType.INHOUSE; // Inhouse
			END;

			dRoyaltiesByAcctno := 
				JOIN(
					dInF, dRecsOut, 
					(STRING)LEFT.fAcctno = (STRING)RIGHT.fAcctno, 
					tPrepForRoyalty(LEFT, RIGHT)
				);
			
			RETURN dRoyaltiesByAcctno;
	ENDMACRO;	

END;
