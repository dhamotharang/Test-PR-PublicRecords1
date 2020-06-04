EXPORT MAC_BaseFile(inDS, mode, record_type) := FUNCTIONMACRO
  
  cores := Header.key_ADL_segmentation(ind1 = 'CORE'); //257,216,208 
  
  #uniquename(FullDS)
  %FullDS% := D2C_Customers.MAC_Suppressions(inDS, record_type);
        
  #uniquename(CoreDS)
  %CoreDS% := join(distribute(%FullDS%, hash(did)), distribute(cores, hash(did)), left.did = right.did, transform(left), local);    
  
  #uniquename(DerogatoryDS)
  %DerogatoryDS% := %FullDS%;

  return case(mode,
            1=> %FullDS%,
            2=> %CoreDS%,
            3=> %DerogatoryDS%
            );
ENDMACRO;