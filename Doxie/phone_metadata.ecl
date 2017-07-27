

export phone_metadata(inData, inputPhone='') := functionmacro
import CellPhone,risk_indicators,doxie,Doxie_Raw,Phones,MDR,Phonesplus_v2;

// #######################################################################################
//  This code permits telcordia only data in case we need it

oneRec := record
		typeof(inData.phone) phone 	:= '';
		string1  telcordia_only 		:= 'N';
	end;

	telrec := record
	oneRec or recordof(indata);
	end;
	
	telOnly := project(dataset([{inputPhone,'Y'}], oneRec),transform(telrec, self:= left, self :=[]));

	telcordiaDS := if(inputPhone = '' or (length(trim(inputPhone, all)) = 10 and exists(inData(phone = inputPhone))),
										project(inData,telrec),
										project(inData,telrec) + telOnly);
// #######################################################################################

		g1 := join(telcordiaDS, CellPhone.Key_NeuStar_Phone, 
           keyed(left.phone=right.cellphone), left outer, keep(1), limit(0));				
				
		g2 := join(g1, risk_indicators.Key_Telcordia_tpm, 
           keyed(left.phone[1..3] = right.npa) 
           and keyed(left.phone[4..6] = right.nxx) 
           and Keyed(left.phone[7] = right.tb), left outer, keep(1), limit(0));

		g3 := join(g2, risk_indicators.Key_Telcordia_tds, 
           keyed(left.phone[1..3] = right.npa) 
           and keyed(left.phone[4..6] = right.nxx)  
           and left.phone[7] = right.tb, left outer, keep(1), limit(0)); 	

 return (g3);
	
endmacro;