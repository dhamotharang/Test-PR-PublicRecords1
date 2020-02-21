IMPORT InsuranceHeader_xlink;

EXPORT mod_segmentation := MODULE

  /* Returns Segmentation Indicator for LexIDs in infile
      infile - dataset with the list of LexIDs
      in_IDL - LexID value
      in_Indicator - field to return the segmentation indicator. 
  */
  EXPORT appendIndicator(infile, in_IDL, in_Indicator ):= FUNCTIONMACRO
    segmentation_key := #IF(InsuranceHeader_xLink.Environment.isCurrentAlpha) 
          InsuranceHeader_PostProcess.segmentation_keys.key_did;
        #ELSE
          InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;          
        #END;
    boolean asIndex :=  IF(thorlib.nodes() < 400 OR COUNT(infile) < 13000000, TRUE, FALSE);    
    inLayout := RECORDOF(infile);
    ind_Data0 := JOIN( infile,segmentation_key,
                    KEYED(LEFT.in_IDL=RIGHT.DID),
                    TRANSFORM(inLayout, 
                      SELF.in_Indicator := right.ind, 
                      SELF := LEFT), LIMIT(10000), LEFT OUTER);    
    ind_Data1 := JOIN( infile,pull(segmentation_key),    
                    LEFT.in_IDL=RIGHT.DID,
                    TRANSFORM(inLayout, 
                      SELF.in_Indicator := right.ind, 
                      SELF := LEFT), LIMIT(10000), LEFT OUTER, HASH);    
    RETURN IF(asIndex, ind_Data0, ind_Data1);
  ENDMACRO;   
  /* sample code 
  layout := record
    unsigned6 uid, unsigned8 did,  string12 indicator
  end;

  input := dataset([
        {1,  400, ''},
        {1,  910, ''},
        {1, 1725, ''}
        ], layout);
  input1 := project(input, transform(layout, self := left, self:= []));
  outFile := InsuranceHeader_PostProcess.mod_segmentation.appendIndicator(input1, did, indicator);
  outFile;
  */
END;