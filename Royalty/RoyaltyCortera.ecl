EXPORT RoyaltyCortera := MODULE

  EXPORT BOOLEAN isInhouseCorteraHit(STRING SourceIndex) := 
    FUNCTION
      RETURN SourceIndex IN ['2','4','6','8'];
    END;
    
  EXPORT InHouse := MODULE
  
    EXPORT GetOnlineRoyalties(dRecsOut, allowSBA20attrs) := 
      FUNCTIONMACRO	
      
        dTGRoyalOut := 
          DATASET([{
                    Royalty.Constants.RoyaltyCode.CORTERA_FILE,
                    Royalty.Constants.RoyaltyType.CORTERA_FILE,
                    (UNSIGNED)((INTEGER)( Royalty.RoyaltyCortera.isInhouseCorteraHit(dRecsOut[1].Version2.SourceIndex) AND allowSBA20attrs )),
                    0
                  }],Royalty.Layouts.Royalty);			
        
        RETURN dTGRoyalOut;
    ENDMACRO;		

    EXPORT GetCombinedServiceRoyalties(dRecsOut) := 
      FUNCTIONMACRO	

        ds_AttributeGroup_SmallBusinessAttrV2 := 
            dRecsOut[1].SmallBusinessAnalyticsResults.AttributesGroups(Name = 'SmallBusinessAttrV2');

        ds_Cortera_attribute_nameValuePairs := 
            ds_AttributeGroup_SmallBusinessAttrV2[1].Attributes( Name IN LNSmallBusiness.Constants.set_Cortera_attributeNames );

        is_Cortera_hit := 
            '-1' NOT IN SET( ds_Cortera_attribute_nameValuePairs, Value ) AND EXISTS(ds_AttributeGroup_SmallBusinessAttrV2);
      
        dTGRoyalOut := 
          DATASET([{
                    Royalty.Constants.RoyaltyCode.CORTERA_FILE,
                    Royalty.Constants.RoyaltyType.CORTERA_FILE,
                    (UNSIGNED)((INTEGER)( is_Cortera_hit )),
                    0
                  }],Royalty.Layouts.Royalty);			
        
        RETURN dTGRoyalOut;
    ENDMACRO;		

    EXPORT GetNoRoyalties() := 
      FUNCTIONMACRO	
      
        dTGRoyalOut := 
          DATASET([{
                    Royalty.Constants.RoyaltyCode.CORTERA_FILE,
                    Royalty.Constants.RoyaltyType.CORTERA_FILE,
                    0,
                    0
                  }],Royalty.Layouts.Royalty);			
        
        RETURN dTGRoyalOut;
    ENDMACRO;	

    EXPORT GetBatchRoyaltiesByAcctno(dInF, dRecsOut, fAcctno='acctno', allowSBA20attrs) := 
      FUNCTIONMACRO

      Royalty.Layouts.RoyaltyForBatch tPrepForRoyalty(RECORDOF(dInF) l, RECORDOF(dRecsOut) r) :=
        TRANSFORM
          SELF.acctno            := l.acctno;
          SELF.royalty_type_code := Royalty.Constants.RoyaltyCode.CORTERA_FILE;
          SELF.royalty_type      := Royalty.Constants.RoyaltyType.CORTERA_FILE;
          SELF.royalty_count     := (UNSIGNED)((INTEGER)( Royalty.RoyaltyCortera.isInhouseCorteraHit(r.Version2.SourceIndex) AND allowSBA20attrs )); 
          SELF.non_royalty_count := 0;
          SELF.source_type       := Royalty.Constants.SourceType.INHOUSE;
        END;

      dRoyaltiesByAcctno := 
        JOIN(
          dInF, dRecsOut, 
          (STRING)LEFT.fAcctno = (STRING)RIGHT.input_echo.fAcctno, 
          tPrepForRoyalty(LEFT, RIGHT)
        );
      
      RETURN dRoyaltiesByAcctno;
    ENDMACRO;	

  END; // InHouse

  EXPORT ViaGateway := MODULE
    // TODO 
  END;
  
END;