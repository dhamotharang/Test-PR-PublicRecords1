EXPORT _ReadMe := 'todo';
/**
map as many fields to the business_header.layout_business_linking as possible. This the BIP common layout.
 You should create the As_Business_Linking attribute, which includes contacts. T
  his is how the Cortera data will get ingested into BIP.  

Use either one of these macro’s business_header_ss.MAC_match_FLEX or Business_Header_SS.MAC_Add_BDID_Flex 
    to append the BIP linkids.

Filter out the foreign addresses since the AID can’t handle them and there’s no foreign addresses in the BIP Header file.

Since the Cortera Header data has SIC and NAIC codes, create an As_Industry attribute as well. 
   Look at Frandx.As_Industry as an example.

Also, map the Alternate_Business_Name field into the header




**/