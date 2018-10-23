
// The following function turns the 12th pos in the DataPermissionMask (for SBFE) on or off depen-
// ding on what the ProductType is. See BusinessInstantID20_Services.Types.productTypeEnum values.
// 
// To set the 12 pos to '1', it must first be set to '1' already as this indicates that the customer
// has authorization per the MBS account settings. Second, the customer must have selected the product 
// type that instructs the query to run SBFE data. These conditions are examined below in the function.
EXPORT fn_setSBFEBitInDataPermissionMask( STRING dpm, BusinessInstantID20_Services.Types.productTypeEnum productType = BusinessInstantID20_Services.Types.productTypeEnum.BASE) :=
  FUNCTION
    SBFE_BIT := 12;
    
    run_SBFE := productType = BusinessInstantID20_Services.Types.productTypeEnum.COMPLIANCE_PLUS_SBFE;
    
    layout_dpm := { STRING dpm };
    
    ds_dpm := DATASET([{dpm}],layout_dpm);
    
    layout_dpm xfm_setSBFEBit(layout_dpm le, INTEGER _counter) := TRANSFORM
      SELF.dpm := IF( _counter = SBFE_BIT, IF( le.dpm[_counter] = '1' AND run_SBFE, '1', '0' ), le.dpm[_counter] );
    END;
    
    ds_withSBFEBitSet := NORMALIZE( ds_dpm, LENGTH(TRIM(dpm)), xfm_setSBFEBit(LEFT,COUNTER) );

    layout_dpm xfm_reassembleDPM(layout_dpm le, layout_dpm ri) := TRANSFORM
      SELF.dpm := le.dpm + ri.dpm;
    END;
    
    dpm_withSBFEBitSet := ROLLUP( ds_withSBFEBitSet, TRUE, xfm_reassembleDPM(LEFT,RIGHT) );
    
    RETURN dpm_withSBFEBitSet[1].dpm;
  END;