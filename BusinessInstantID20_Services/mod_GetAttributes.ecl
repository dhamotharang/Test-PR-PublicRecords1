import BusinessInstantID20_Services,ut,iesp,LNSmallBusiness,Business_Risk_BIP,std;

// The following module obtains Attributes
EXPORT mod_GetAttributes(DATASET(Business_Risk_BIP.Layouts.Shell) BusShell, 
                        BusinessInstantID20_Services.iOptions Options) := 
	
  MODULE
  
    EXPORT ds_Attributes := LNSmallBusiness.getSmallBusinessAttributes(BusShell, Options.BusShellVersion);
        
    // Create Version 1 Name/Value Pair Attributes
    EXPORT NameValuePairsVersion1 := NORMALIZE(ds_Attributes, 200, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion1(LEFT, COUNTER));
    
    EXPORT iesp.smallbusinessanalytics.t_SBAAttributesGroup Version1 := TRANSFORM
      SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V1_NAME;
      SELF.Attributes := NameValuePairsVersion1;
    END;

    EXPORT ds_Version1 := Dataset([Version1])(EXISTS(Options.AttributesRequested(STD.Str.ToUpperCase(AttributeGroup) = 'SMALLBUSINESSATTRV1'))); 

    // Create Version 101 Name/Value Pair Attributes no felonies
    EXPORT NameValuePairsVersion101 := NORMALIZE(ds_Attributes, 197, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion101(LEFT, COUNTER));
    
    EXPORT iesp.smallbusinessanalytics.t_SBAAttributesGroup Version101 := TRANSFORM
      SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_NOFEL;
      SELF.Attributes := NameValuePairsVersion101;
    END;
    
    EXPORT ds_Version101 := Dataset([Version101])(EXISTS(Options.AttributesRequested(STD.Str.ToUpperCase(AttributeGroup) = 'SMALLBUSINESSATTRV101'))); 

    Dataset([Version101])(std.Str.ToUpperCase(Options.AttributesRequested[1].AttributeGroup)='SMALLBUSINESSATTRV101');
    
    // Create Version 2 Name/Value Pair Attributes
    EXPORT NameValuePairsVersion2 := NORMALIZE(ds_Attributes, 316, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion2(LEFT, COUNTER));
  
    EXPORT iesp.smallbusinessanalytics.t_SBAAttributesGroup Version2 := TRANSFORM
      SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V2_NAME;
      SELF.Attributes := NameValuePairsVersion2;
    END;
      
    EXPORT ds_Version2 := Dataset([Version2])(EXISTS(Options.AttributesRequested(STD.Str.ToUpperCase(AttributeGroup) = 'SMALLBUSINESSATTRV2'))); 
  
    // Create SBFE Name/Value Pair Attributes
    EXPORT NameValuePairsSBFE := NORMALIZE(ds_Attributes, 1841, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoSBFE(LEFT, COUNTER));
    
    EXPORT iesp.smallbusinessanalytics.t_SBAAttributesGroup SBFEVersion1 := TRANSFORM
      SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR_NAME;
      SELF.Attributes := NameValuePairsSBFE;
    END; 
    SET_SFBEAttributes := [LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR,LNSmallBusiness.Constants.SMALL_BIZ_SBFE_V1_ATTR,std.Str.ToUpperCase(LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR_NAME)];
    EXPORT ds_SBFE := Dataset([SBFEVersion1])(EXISTS(Options.AttributesRequested(STD.Str.ToUpperCase(AttributeGroup) IN SET_SFBEAttributes)));
        
END;