import risk_indicators, easi, _Control;
// wealth indicator model that accepts the clam
onThor := _Control.Environment.OnThor;

export WIN704_0_0(GROUPED dataset(Risk_Indicators.Layout_Boca_Shell) clam ,
                  dataset(easi.layout_census) easi, 
                  boolean isFCRA=false,
                  boolean IsFIS = false) := FUNCTION

debug := false;

  layout_out := record
    unsigned4 seq;
    unsigned6 did;
    integer1  wealth_indicator;
    #IF(debug)
    Integer ADD1_ASSESSED_AMOUNT;
    Integer ADD1_NAPROP;
    Integer ADD1_PURCHASE_AMOUNT;
    Integer ADD2_ASSESSED_AMOUNT;
    Integer ADD2_NAPROP;
    Integer ADD2_PURCHASE_AMOUNT;
    Integer ADD3_ASSESSED_AMOUNT;
    Integer ADD3_NAPROP;
    Integer ADD3_PURCHASE_AMOUNT;
    Integer PROPERTY_AMBIG_TOTAL;
    Integer PROPERTY_OWNED_ASSESSED_TOTAL;
    Integer PROPERTY_OWNED_PURCHASE_TOTAL;
    Integer PROPERTY_SOLD_PURCHASE_COUNT;
    Integer PROPERTY_SOLD_PURCHASE_TOTAL;
    Integer PROPERTY_SOLD_TOTAL;
    Integer PROPERTY_OWNED_TOTAL;
    boolean _ever_owned;
    Real _mod10_pct_a;
    Real _mod10_pct_b;
    Real _mod10_pct_c;
    Real _mod10_pct_d;
    Real _mod10_pct_e;
    Real _mod10_pct_f;
    Real _mod10_pct1;
    Real _mod10_pct2;
    Real _mod10_pct;
    
    #end
	end;

	layout_out doModel( clam le, easi ri ) := TRANSFORM
		// input fields
			C_MED_HVAL := (INTEGER)ri.MED_HVAL;

#IF(_CONTROL.Environment.onThor_LeadIntegrity)
      // clam values
        ADD1_ASSESSED_AMOUNT          := le.Address_Verification.Input_Address_Information.assessed_amount;
        ADD1_NAPROP                   := le.Address_Verification.Input_Address_Information.naprop;
        ADD1_PURCHASE_AMOUNT          := le.Address_Verification.Input_Address_Information.purchase_amount;
        ADD2_ASSESSED_AMOUNT          := le.Address_Verification.Address_History_1.assessed_amount;
        ADD2_NAPROP                   := le.Address_Verification.Address_History_1.naprop;
        ADD2_PURCHASE_AMOUNT          := le.Address_Verification.Address_History_1.purchase_amount;
        ADD3_ASSESSED_AMOUNT          := le.Address_Verification.Address_History_2.assessed_amount;
        ADD3_NAPROP                   := le.Address_Verification.Address_History_2.naprop;
        ADD3_PURCHASE_AMOUNT          := le.Address_Verification.Address_History_2.purchase_amount;
        PROPERTY_AMBIG_TOTAL          := le.Address_Verification.ambiguous.property_total;
        PROPERTY_OWNED_ASSESSED_TOTAL := le.Address_Verification.owned.property_owned_assessed_total;
        PROPERTY_OWNED_PURCHASE_TOTAL := le.Address_Verification.owned.property_owned_purchase_total;
        PROPERTY_OWNED_TOTAL          := le.Address_Verification.owned.property_total;
        PROPERTY_SOLD_PURCHASE_COUNT  := le.Address_Verification.sold.property_owned_purchase_count;
        PROPERTY_SOLD_PURCHASE_TOTAL  := le.Address_Verification.sold.property_owned_purchase_total;
        PROPERTY_SOLD_TOTAL           := le.Address_Verification.sold.property_total;
      //
#ELSE
      // clam values
        ADD1_ASSESSED_AMOUNT          := IF(IsFIS, le.FIS.add1_assessed_amount, le.Address_Verification.Input_Address_Information.assessed_amount);
        ADD1_NAPROP                   := IF(IsFIS, le.FIS.add1_naprop, le.Address_Verification.Input_Address_Information.naprop);
        ADD1_PURCHASE_AMOUNT          := IF(IsFIS, le.FIS.add1_purchase_amount, le.Address_Verification.Input_Address_Information.purchase_amount);
        ADD2_ASSESSED_AMOUNT          := IF(IsFIS, le.FIS.add2_assessed_amount, le.Address_Verification.Address_History_1.assessed_amount);
        ADD2_NAPROP                   := IF(IsFIS, le.FIS.add2_naprop, le.Address_Verification.Address_History_1.naprop);
        ADD2_PURCHASE_AMOUNT          := IF(IsFIS, le.FIS.add2_purchase_amount, le.Address_Verification.Address_History_1.purchase_amount);
        ADD3_ASSESSED_AMOUNT          := IF(IsFIS, le.FIS.add3_assessed_amount, le.Address_Verification.Address_History_2.assessed_amount);
        ADD3_NAPROP                   := IF(IsFIS, le.FIS.add3_naprop, le.Address_Verification.Address_History_2.naprop);
        ADD3_PURCHASE_AMOUNT          := IF(IsFIS, le.FIS.add3_purchase_amount, le.Address_Verification.Address_History_2.purchase_amount);
        PROPERTY_AMBIG_TOTAL          := IF(IsFIS, le.FIS.ambiguous_property_total, le.Address_Verification.ambiguous.property_total);
        PROPERTY_OWNED_ASSESSED_TOTAL := IF(IsFIS, le.FIS.owned_assessed_total, le.Address_Verification.owned.property_owned_assessed_total);
        PROPERTY_OWNED_PURCHASE_TOTAL := IF(IsFIS, le.FIS.owned_purchase_total, le.Address_Verification.owned.property_owned_purchase_total);
        PROPERTY_OWNED_TOTAL          := IF(IsFIS, le.FIS.owned_property_total, le.Address_Verification.owned.property_total);
        PROPERTY_SOLD_PURCHASE_COUNT  := IF(IsFIS, le.FIS.sold_property_purchase_count, le.Address_Verification.sold.property_owned_purchase_count);
        PROPERTY_SOLD_PURCHASE_TOTAL  := IF(IsFIS, le.FIS.sold_property_purchase_total, le.Address_Verification.sold.property_owned_purchase_total);
        PROPERTY_SOLD_TOTAL           := IF(IsFIS, le.FIS.sold_property_total, le.Address_Verification.sold.property_total);
      //
#END			
			

			sMIN( a, b ) := MACRO if( a < b, a, b ) ENDMACRO;
			sMAX( a, b ) := MACRO if( a > b, a, b ) ENDMACRO;

			PROPERTY_OWNED_ASSESSED_TOTAL_1 := sMIN( PROPERTY_OWNED_ASSESSED_TOTAL, 2000000 );
			PROPERTY_OWNED_PURCHASE_TOTAL_1 := sMIN( PROPERTY_OWNED_PURCHASE_TOTAL, 2000000 );

			PROPERTY_SOLD_PURCHASE_COUNT_1 := sMIN( PROPERTY_SOLD_PURCHASE_COUNT, 10 );
			property_sold_purchase_total_1 := sMIN( property_sold_purchase_total, 2000000 );
		//

		add1_purchase_amount_1 := if( add1_purchase_amount in [0,99999999], -1, sMIN( 2000000, add1_purchase_amount ) );
		add2_purchase_amount_1 := if( add2_purchase_amount in [0,99999999], -1, add2_purchase_amount );
		add3_purchase_amount_1 := if( add3_purchase_amount in [0,99999999], -1, add3_purchase_amount );
		add1_assessed_amount_1 := if( add1_assessed_amount in [0,99999999], -1, sMIN( 2000000, add1_assessed_amount ) );

		property_sold_total_1  := if( property_sold_total = 0, -1, property_sold_total );
		property_ambig_total_1 := if( property_ambig_total = 0, -1, property_ambig_total );


		// EVER OWNED DEFINITION
			ever_owned := ( add1_naprop=4 or add2_naprop=4 or add3_naprop=4 or property_owned_total > 0 or property_ambig_total > 0 or property_sold_total > 0 );


		// CURRENT PROPERTIES VALUE

			add1_val1 := if( add1_naprop=4, add1_purchase_amount, -1 );
			property_val1 := sMAX( property_owned_purchase_total_1, sMAX( property_owned_assessed_total_1, add1_val1 ) );
			property_val := if( property_val1=0, -1, property_val1 );

		// PREVIOUS PROPERTIES VALUE
			SOLD_AVG := if( PROPERTY_SOLD_PURCHASE_TOTAL > 0 and property_sold_purchase_count > 0, PROPERTY_SOLD_PURCHASE_TOTAL / PROPERTY_SOLD_PURCHASE_COUNT, 0 );

			SOLD2 := if( ADD2_NAPROP = 4, sMIN( ADD2_PURCHASE_AMOUNT, 2000000), 0 );
			SOLD3 := if( ADD3_NAPROP = 4, sMIN( ADD3_PURCHASE_AMOUNT, 2000000), 0 );

			SOLD_MAX_AVG := if( property_sold_purchase_total > 0, sMAX(SOLD_AVG,sMAX(SOLD2,SOLD3)), sMAX(SOLD2,SOLD3) );


		ADD1_VAL := sMAX( ADD1_PURCHASE_AMOUNT, ADD1_ASSESSED_AMOUNT );

		PROPERTY_VAL_D := if( ever_owned and property_val > 0, sMIN( property_val, 2000000 ), property_val );


		// intermediate mod10_pct values
			mod10_pct_a := map( 
				isFCRA 							 => 0.0,
				C_MED_HVAL <=  58000 => 2.0,
				C_MED_HVAL <=  90000 => 2.1,
				C_MED_HVAL <= 120588 => 2.2,
				C_MED_HVAL <= 150750 => 2.3,
				C_MED_HVAL <= 185192 => 2.4,
				C_MED_HVAL <= 232600 => 2.5,
				C_MED_HVAL <= 298900 => 2.6,
				C_MED_HVAL <= 400000 => 2.7,
				C_MED_HVAL <= 615125 => 2.8,
				2.9
			);
			mod10_pct_b := map(
				ADD1_VAL <=  58000 => 4.0,
				ADD1_VAL <=  90000 => 4.1,
				ADD1_VAL <= 120588 => 4.2,
				ADD1_VAL <= 150750 => 4.3,
				ADD1_VAL <= 185192 => 4.4,
				ADD1_VAL <= 232600 => 4.5,
				ADD1_VAL <= 298900 => 4.6,
				ADD1_VAL <= 400000 => 4.7,
				ADD1_VAL <= 615125 => 4.8,
				4.9
			);
			mod10_pct_c := map(
				ADD1_VAL <=  58000 => 3.0,
				ADD1_VAL <=  90000 => 3.1,
				ADD1_VAL <= 120588 => 3.2,
				ADD1_VAL <= 150750 => 3.3,
				ADD1_VAL <= 185192 => 3.4,
				ADD1_VAL <= 232600 => 3.5,
				ADD1_VAL <= 298900 => 3.6,
				ADD1_VAL <= 400000 => 3.7,
				ADD1_VAL <= 615125 => 3.8,
				3.9
			);
			mod10_pct_d := map(
				PROPERTY_VAL_D <=  58000 => 20,
				PROPERTY_VAL_D <=  90000 => 30,
				PROPERTY_VAL_D <= 120588 => 40,
				PROPERTY_VAL_D <= 150750 => 50,
				PROPERTY_VAL_D <= 185192 => 60,
				PROPERTY_VAL_D <= 232600 => 70,
				PROPERTY_VAL_D <= 298900 => 80,
				PROPERTY_VAL_D <= 400000 => 90,
				PROPERTY_VAL_D <= 615125 => 100,
				110
			);
			mod10_pct_e := map(
				SOLD_MAX_AVG <=  58000 => 20,
				SOLD_MAX_AVG <=  90000 => 30,
				SOLD_MAX_AVG <= 120588 => 40,
				SOLD_MAX_AVG <= 150750 => 50,
				SOLD_MAX_AVG <= 185192 => 60,
				SOLD_MAX_AVG <= 232600 => 70,
				SOLD_MAX_AVG <= 298900 => 80,
				SOLD_MAX_AVG <= 400000 => 90,
				SOLD_MAX_AVG <= 615125 => 100,
				110
			);
			mod10_pct_f := map(
				isFCRA								=> 0,
				C_MED_HVAL < 79825.57 => 20,
				C_MED_HVAL < 115330.1 => 30,
				C_MED_HVAL < 144889.5 => 40,
				C_MED_HVAL < 170728.6 => 50,
				C_MED_HVAL < 217834.2 => 60,
				60
			);
		//

		mod10_pct1 := map(
			not ever_owned and property_val < 0 =>
				map(
					add1_naprop=0 or (add1_naprop in [1,2,3] and add1_val <= 0 ) => mod10_pct_a,
					add1_naprop=1 and add1_val > 0                               => mod10_pct_b,
					add1_naprop in [2,3] and add1_val > 0                        => mod10_pct_c,
					0
				),
				
			ever_owned and property_val > 0                                              => mod10_pct_d,
			ever_owned and sold_max_avg > 0                                              => mod10_pct_e,
			ever_owned                                                                   => mod10_pct_f,
			-9
		);

		mod10_pct2 := map(
			// prop belongs to a relative
			mod10_pct1 in [3.0]     => 10,
			mod10_pct1 in [3.1]     => 20,
			mod10_pct1 in [3.2,3.3] => 30,
			mod10_pct1 in [3.4,3.5] => 40,
			mod10_pct1 in [3.6,3.7] => 50,
			mod10_pct1 in [3.8]     => 60,
			mod10_pct1 in [3.9]     => 70,

			// know nothing about the value of the property, may not know anything about owner
			mod10_pct1 in [2.0]     => 10,
			mod10_pct1 in [2.1,2.2] => 20,
			mod10_pct1 in [2.3,2.4] => 30,
			mod10_pct1 in [2.5,2.6] => 40,
			mod10_pct1 in [2.7,2.8] => 50,
			mod10_pct1 in [2.9]     => 60,

			// renters
			mod10_pct1 in [4.0]     => 10,
			mod10_pct1 in [4.1]     => 20,
			mod10_pct1 in [4.2,4.3] => 30,
			mod10_pct1 in [4.4,4.5] => 40,
			mod10_pct1 in [4.6,4.7] => 50,
			mod10_pct1 in [4.8,4.9] => 60,
			mod10_pct1
		);

			// if the aircraft count > 0 and the mod10_pct2 is less than or equal to 40, add 40 points just for aircraft
			mod10_pct := mod10_pct2 + if( le.aircraft.aircraft_count>0 and property_val=0 and mod10_pct2 <= 40, 40, 0 );
      
			self.wealth_indicator := map(
				mod10_pct = 0						 => 0,
				mod10_pct = 10           => 1,
				mod10_pct = 20           => 2,
				mod10_pct in [30,40]     => 3,
				mod10_pct in [50,60,70]  => 4,
				mod10_pct in [80,90,100] => 5,
				mod10_pct = 110          => 6,
				-1 // should never hit this
			);
                            
		self.seq := le.seq;
		self.did := le.did;
    
    #IF(debug)
    Self.ADD1_ASSESSED_AMOUNT := ADD1_ASSESSED_AMOUNT;
    Self.ADD1_NAPROP := ADD1_NAPROP;
    Self.ADD1_PURCHASE_AMOUNT := ADD1_PURCHASE_AMOUNT;
    Self.ADD2_ASSESSED_AMOUNT := ADD2_ASSESSED_AMOUNT;
    Self.ADD2_NAPROP := ADD2_NAPROP;
    Self.ADD2_PURCHASE_AMOUNT := ADD2_PURCHASE_AMOUNT;
    Self.ADD3_ASSESSED_AMOUNT := ADD3_ASSESSED_AMOUNT;
    Self.ADD3_NAPROP := ADD3_NAPROP;
    Self.ADD3_PURCHASE_AMOUNT := ADD3_PURCHASE_AMOUNT;
    Self.PROPERTY_AMBIG_TOTAL := PROPERTY_AMBIG_TOTAL;
    Self.PROPERTY_OWNED_ASSESSED_TOTAL := PROPERTY_OWNED_ASSESSED_TOTAL;
    Self.PROPERTY_OWNED_PURCHASE_TOTAL := PROPERTY_OWNED_PURCHASE_TOTAL;
    Self.PROPERTY_SOLD_PURCHASE_COUNT := PROPERTY_SOLD_PURCHASE_COUNT;
    Self.PROPERTY_SOLD_PURCHASE_TOTAL := PROPERTY_SOLD_PURCHASE_TOTAL;
    Self.PROPERTY_SOLD_TOTAL := PROPERTY_SOLD_TOTAL;
    Self.PROPERTY_OWNED_TOTAL := PROPERTY_OWNED_TOTAL;
    self._ever_owned := ever_owned;
    self._mod10_pct_a := mod10_pct_a;
    self._mod10_pct_b := mod10_pct_b;
    self._mod10_pct_c := mod10_pct_c;
    self._mod10_pct_d := mod10_pct_d;
    self._mod10_pct_e := mod10_pct_e;
    self._mod10_pct_f := mod10_pct_f;
    self._mod10_pct1  := mod10_pct1;
    self._mod10_pct2  := mod10_pct2;
    self._mod10_pct   := mod10_pct;
    #end

	END;
	

	resu_roxie := join(clam, easi, 
                      right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
                      doModel(LEFT,RIGHT), left outer , lookup);
            
  resu_thor := join(DISTRIBUTE(clam, HASH64(shell_input.st+shell_input.county+shell_input.geo_blk)),
                    DISTRIBUTE(easi, HASH64(geolink)), 
                    right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
                    doModel(LEFT,RIGHT), left outer , LOCAL);
                    
  #IF(onThor)
    resu := resu_thor;
  #ELSE
    resu := resu_roxie;
  #END

	
	RETURN resu;

END;

