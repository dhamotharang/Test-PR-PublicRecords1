EXPORT FP_V3_Generic_Transform_Macro(soap_output, soap_input, tag) := functionmacro

		
	  layout_Soap_output trans_rollup(layout_Soap_output l, layout_Soap_output r) := transform
			self.input.Did := r.input.Did;

			self := l;
		End;
					
		soap_output_withDID := rollup(soap_output, ((integer)left.accountnumber = (integer)right.input.seq and left.accountnumber <>''), trans_rollup(left,right));
					
      	
		Global_output_lay trans_flatten( layout_Soap_output L, layout_soap_input r ) := Transform
            			 self.accountnumber := l.accountnumber; 
									 self.model_type := tag; 
            			 self.DID := (integer)l.input.did; 
            			 self.fp_score := L.scores[1].i;
            			 self.fp_reason := L.scores[1].reason_codes[1].reason_code;
            			 self.fp_reason2 := L.scores[1].reason_codes[2].reason_code;
            			 self.fp_reason3 := L.scores[1].reason_codes[3].reason_code;
            			 self.fp_reason4 := L.scores[1].reason_codes[4].reason_code;
            			 self.fp_reason5 := L.scores[1].reason_codes[5].reason_code;
            			 self.fp_reason6 := L.scores[1].reason_codes[6].reason_code;
            			 self.StolenIdentityIndex        := L.scores[1].StolenIdentityIndex;
            			 self.SyntheticIdentityIndex     := L.scores[1].SyntheticIdentityIndex;
            			 self.ManipulatedIdentityIndex   := L.scores[1].ManipulatedIdentityIndex;
            			 self.VulnerableVictimIndex      := L.scores[1].VulnerableVictimIndex;
            			 self.FriendlyFraudIndex         := L.scores[1].FriendlyFraudIndex;
            			 self.SuspiciousActivityIndex    := L.scores[1].SuspiciousActivityIndex;
            			 self.errorcode    := l.errorcode;
   							   self.historydate := (string)r.HistoryDateYYYYMM;
            			 self.FNamePop := r.firstname<>'';
            			 self.LNamePop := r.lastname<>'';
            			 self.AddrPop := r.streetaddress<>'';
            			 self.SSNLength := (string)(length(trim(r.ssn,left,right))) ;
            			 self.DOBPop := r.dateofbirth<>'';
            			 self.EmailPop := r.email<>'';
            			 self.IPAddrPop := r.ipaddress<>'';
            			 self.HPhnPop := r.homephone<>'';
   							   self := L;
            			 self := [];
            		End;
			
		
			

            			
    ds_output_plus_input := join(soap_output,soap_input, LEFT.accountnumber=RIGHT.accountnumber, trans_flatten(Left, Right));
		
		ds_output_plus_input_sorted := group(sort(ds_output_plus_input, accountnumber), accountnumber);
         			 
    dedup_ds_output_plus_input_sorted := dedup(ds_output_plus_input_sorted, accountnumber);
						
		projected_acctno := project(dedup_ds_output_plus_input_sorted, transform(Global_output_lay,self.acctno:=left.accountnumber;self:=left));
	
		
			
		return projected_acctno;
			
endmacro;