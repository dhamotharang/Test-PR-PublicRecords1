EXPORT getAssetIndex(grouped dataset(riskview.layouts.attributes_internal_layout) ds_in ) := function

riskview.layouts.attributes_internal_layout add_asset(ds_in le) := transform

NULL := -999999999;

SubjectDeceased := (integer)le.SubjectDeceased;
ConfirmationSubjectFound := (integer)le.ConfirmationSubjectFound;

AssetProp := (integer)le.AssetProp;
AssetPropCurrentCount := (integer)le.AssetPropCurrentCount;
AssetPropCurrentTaxTotal := (integer)le.AssetPropCurrentTaxTotal;
// PurchaseActivityCount := (integer)le.PurchaseActivityCount;
PurchaseActivityCount := -1;
PurchaseActivityDollarTotal := (integer)le.PurchaseActivityDollarTotal;
AssetPersonalCount := (integer)le.AssetPersonalCount;
SSNDeceased := (integer)le.SSNDeceased;
AddrCurrentOwnershipIndex := (integer)le.AddrCurrentOwnershipIndex;
AddrCurrentAVMValue := (integer)le.AddrCurrentAVMValue;

   /* AssetProp */ 
subscore0 := map(
    NULL < AssetProp AND AssetProp < 0 => -0.000000,
    0 <= AssetProp AND AssetProp < 1   => -0.174165,
    1 <= AssetProp                     => 0.135555,
                                          -0.000000);

rcvaluea41_1 := 0.135555 - subScore0;


/* AssetPersonalCount */
subscore1 := map(
    NULL < AssetPersonalCount AND AssetPersonalCount < 0 => -0.000000,
    0 <= AssetPersonalCount AND AssetPersonalCount < 1   => -0.009872,
    1 <= AssetPersonalCount                              => 0.330429,
                                                            -0.000000);

rcvaluea40_1 := 0.330429 - subScore1;


/* PurchaseActivityCount */
subscore2 := map(
    NULL < PurchaseActivityCount AND PurchaseActivityCount < 1 => -0.000317,
    1 <= PurchaseActivityCount AND PurchaseActivityCount < 2   => -0.101274,
    2 <= PurchaseActivityCount AND PurchaseActivityCount < 4   => -0.063793,
    4 <= PurchaseActivityCount AND PurchaseActivityCount < 6   => 0.026800,
    6 <= PurchaseActivityCount AND PurchaseActivityCount < 12  => 0.074377,
    12 <= PurchaseActivityCount                                => 0.139927,
                                                                  0.000000);

// rcvaluea50_1 := 0.139927 - subScore2;
rcvaluea50_1 := 0;


// average_purchase := if(PurchaseActivityCount = - 1, -1, round(PurchaseActivityDollarTotal / PurchaseActivityCount, 3));
average_purchase := -1;
subscore3 := map(
    NULL < average_purchase AND average_purchase < 0      => -0.020408,
    0 <= average_purchase AND average_purchase < 6.62     => -0.397407,
    6.62 <= average_purchase AND average_purchase < 13.83   => -0.231991,
    13.83 <= average_purchase AND average_purchase < 17.33  => -0.084436,
    17.33 <= average_purchase AND average_purchase < 22.17 => -0.058855,
    22.17 <= average_purchase AND average_purchase < 45.06  => 0.042859,
    45.06 <= average_purchase                              => 0.054277,
                                                             -0.000000);

// rcvaluea50_2 := if(average_purchase=null, 0.054277 - subScore3, 0);
rcvaluea50_2 := 0;

asset_prop_own_amount := if(AssetPropCurrentCount <= 0, 0, round(AssetPropCurrentTaxTotal / AssetPropCurrentCount, 2));

subscore4 := map(
    NULL < asset_prop_own_amount AND asset_prop_own_amount < 1        		=> -0.049561,
    1 <= asset_prop_own_amount AND asset_prop_own_amount < 56174.5        => -0.030156,
    56174.5 <= asset_prop_own_amount AND asset_prop_own_amount < 159994  	=> 0.042630,
    159994 <= asset_prop_own_amount AND asset_prop_own_amount < 214513.33 => 0.132548,
    214513.33 <= asset_prop_own_amount                                    => 0.212993,
                                                                          0.000000);

rcvaluea46_1 := 0.212993 - subScore4;

current_addr_avm_owner := map(
    AddrCurrentOwnershipIndex >= 3 => AddrCurrentAVMValue,
    AddrCurrentOwnershipIndex = -1 => -1,
                                      0);

subscore5 := map(
    NULL < current_addr_avm_owner AND current_addr_avm_owner < 0         => 0.000000,
    0 <= current_addr_avm_owner AND current_addr_avm_owner < 1087         => -0.102679,
    1087 <= current_addr_avm_owner AND current_addr_avm_owner < 114616    => -0.179306,
    114616 <= current_addr_avm_owner AND current_addr_avm_owner < 166577 => 0.087483,
    166577 <= current_addr_avm_owner AND current_addr_avm_owner < 232727 => 0.219727,
    232727 <= current_addr_avm_owner  => 0.498003,
		0.000000);

rcvaluea42_1 := if(AddrCurrentOwnershipIndex < 3, 0.498003 - subScore5, 0);

rcvaluea51_1 := if(AddrCurrentAVMValue = 0 , 0.498003 - subScore5, 0);
rcvaluea47_1 := if(AddrCurrentOwnershipIndex >= 3, 0.498003 - subScore5, 0);
				
rawscore := subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5;

lnoddsscore := (rawscore * 1.000000) + 3.608787;
scaledscore := (rawscore * 1.000000) + 3.608787;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

score2 := round(40 * (ln(probscore / (1 - probscore)) - ln(20)) / ln(2) + 700);

assetindex1 := if(ConfirmationSubjectFound = 0 or SSNDeceased = 1 or SubjectDeceased = 1, 222, min(900, if(max(501, score2) = NULL, -NULL, max(501, score2))));

assetindex := map(
    assetindex1 = 222  => -1,
    assetindex1 <= 714 => 1,
    assetindex1 <= 715 => 2,
    assetindex1 <= 732 => 3,
    assetindex1 <= 735 => 4,
    assetindex1 <= 743 => 5,
    assetindex1 <= 749 => 6,
    assetindex1 <= 758 => 7,
    assetindex1 <= 774 => 8,
                          9);

// rcvaluea50 := rcvaluea50_1 + rcvaluea50_2;
rcvaluea50 := 0;

rcvaluea42 := rcvaluea42_1;

rcvaluea41 := rcvaluea41_1;

rcvaluea40 := rcvaluea40_1;

rcvaluea47 := rcvaluea47_1;

rcvaluea46 := rcvaluea46_1;
rcvaluea51 := rcvaluea51_1;


ds_layout := {STRING rc, REAL value1};

rc_dataset := DATASET([
    // {'A50' , RCValueA50},
    {'A42' , RCValueA42},
    {'A41' , RCValueA41},
    {'A40' , RCValueA40},
		{'A51' , RCValueA51},
    {'A47' , RCValueA47},
    {'A46' , RCValueA46}
    
    ], ds_layout);

// IMPORTANT NOTE:  Select the primary factor ONLY if its value is > 0.  
sorted_factors := sort(rc_dataset(value1 > 0), -value1);
AssetIndexPrimaryFactor := sorted_factors[1].rc;

	self.AssetIndex	:= (string)assetindex;
	
	self.AssetIndexPrimaryFactor := map(AssetIndex = -1 => '-1',
																			AssetIndexPrimaryFactor='' => '0', 
																			AssetIndexPrimaryFactor)	;
																			
	// self.ds_rcs := rc_dataset;
	// self.subscore0 := subscore0;
	
	self := le;

end;

with_asset := project(ds_in, add_asset(left));

return with_asset;

end;