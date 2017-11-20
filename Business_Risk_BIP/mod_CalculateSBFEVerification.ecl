IMPORT Business_Risk_BIP, BusinessInstantID20_Services, Models, STD;

EXPORT fn_CalculateSBFEVerification( Business_Risk_BIP.Layouts.Shell le, BOOLEAN useSBFE = FALSE ) :=
	MODULE

		SHARED BusinessInstantID20_Services.Layouts.SBFEVerificationLayout xfm_SBFEVerification :=
			TRANSFORM
				SELF.Seq                  := le.Seq;
				SELF.time_on_sbfe         := IF( (INTEGER)le.SBFE.SBFETimeOldestCycle < 0, '0', le.SBFE.SBFETimeOldestCycle );
				SELF.last_seen_sbfe       := IF( (INTEGER)le.SBFE.SBFETimeNewestCycle < 0, '0', le.SBFE.SBFETimeNewestCycle );
				SELF.count_of_trades_sbfe := IF( (INTEGER)le.SBFE.SBFEOpenAllCount    < 0, '0', le.SBFE.SBFEOpenAllCount );
			END;
 
		SHARED BusinessInstantID20_Services.Layouts.SBFEVerificationLayout xfm_SBFEVerification_null :=
			TRANSFORM
				SELF.Seq                  := le.Seq;
				SELF.time_on_sbfe         := '';
				SELF.last_seen_sbfe       := '';
				SELF.count_of_trades_sbfe := '';
			END;
			
		SHARED rw_SBFEVerification := ROW( xfm_SBFEVerification );

		SHARED rw_SBFEVerification_null := ROW( xfm_SBFEVerification_null );

		EXPORT rw_result := IF( useSBFE, rw_SBFEVerification, rw_SBFEVerification_null );

	END;
		