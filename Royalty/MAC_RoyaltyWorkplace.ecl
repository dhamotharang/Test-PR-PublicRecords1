// code previously located in WorkPlace_Services.Functions.countRoyalties
export MAC_RoyaltyWorkplace(inf, royal_out, src = 'source') := macro

  import MDR;

  //string2 OneClick_src_code     := MDR.sourceTools.src_One_Click_Data;
  // As of 03/04/2020 (estd.), One Click Data is no longer a royalty
  string2 TeleTrack_src_code    := MDR.sourceTools.src_Teletrack;
  string2 SalesChannel_src_code := MDR.sourceTools.src_SalesChannel;
  string2 Thrive_LT_src_code    := MDR.sourceTools.src_Thrive_LT;
  string2 Thrive_PD_src_code    := MDR.sourceTools.src_Thrive_PD;
  string2 Netwise_src_code      := MDR.sourceTools.src_Netwise;
  
  #uniquename(WP_RoyalSources)
  %WP_RoyalSources% := [/*OneClick_src_code,*/ TeleTrack_src_code, SalesChannel_src_code, Thrive_LT_src_code, Thrive_PD_src_code, Netwise_src_code];

  #uniquename(WP_NonRoyaltyCount)
  %WP_NonRoyaltyCount% := count(inf(src not in %WP_RoyalSources%));

  // NOTE: For the first field in the layout, royalty_type, since no one seemed to 
  // know what this field should contain, a format similar to 
  // EmailServices.EmailSearchService was used.
  royal_out := if(exists(inf),
                  dataset([/* {Royalty.Constants.RoyaltyCode.WORKPLACE_OC,
                            Royalty.Constants.RoyaltyType.WORKPLACE_OC,																
                            count(inf(src  = OneClick_src_code)),
                            %WP_NonRoyaltyCount%}, */
                            // As of 03/04/2020 (estd.), One Click Data is no longer a royalty
                            {Royalty.Constants.RoyaltyCode.WORKPLACE_TT,
                            Royalty.Constants.RoyaltyType.WORKPLACE_TT,
                            count(inf(src  = Teletrack_src_code)),
                            %WP_NonRoyaltyCount%},
                            {Royalty.Constants.RoyaltyCode.WORKPLACE_SC,
                            Royalty.Constants.RoyaltyType.WORKPLACE_SC,
                            count(inf(src  = SalesChannel_src_code)),
                            %WP_NonRoyaltyCount%},
                            {Royalty.Constants.RoyaltyCode.WORKPLACE_TL,
                            Royalty.Constants.RoyaltyType.WORKPLACE_TL,
                            count(inf(src  = Thrive_LT_src_code)),
                            %WP_NonRoyaltyCount%},
                            {Royalty.Constants.RoyaltyCode.WORKPLACE_TP,
                            Royalty.Constants.RoyaltyType.WORKPLACE_TP,
                            count(inf(src  = Thrive_PD_src_code)),
                            %WP_NonRoyaltyCount%},
                            {Royalty.Constants.RoyaltyCode.NETWISE_EMAIL,
                            Royalty.Constants.RoyaltyType.NETWISE_EMAIL,
                            count(inf(src  = Netwise_src_code)),
                            %WP_NonRoyaltyCount%}
                          ], Royalty.Layouts.Royalty));
endmacro;
