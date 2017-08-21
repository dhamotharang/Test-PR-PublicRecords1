IMPORT LN_PropertyV2 ; 
EXPORT AppendID (dataset(LN_PropertyV2.Layout_DID_Out	) pSearch ) := FUNCTION 

  GetTxID  := JOIN(pSearch , Files().post_qa , 
                           LEFT.ln_fares_id = RIGHT.ln_fares_id,
                           TRANSFORM(LN_PropertyV2.Layout_DID_Out , 
                           SELF.addr_tx_id 			:= RIGHT.dproptxid ,
                           SELF.best_addr_tx_id := RIGHT.best_dproptx_ind,
                           SELF := LEFT ),
                           LEFT OUTER,HASH);
  RETURN GetTxID  ;

END; 
   
  
  
