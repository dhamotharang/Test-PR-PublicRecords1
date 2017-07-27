export Mac_Bk_Count(inNoCount, outwithCount, didField, BkCountField, In_Party_Type) := MACRO
import BankruptcyV3;

	#uniquename(uniqueDids);
	%uniqueDids% := DEDUP(inNoCount, didField, ALL);
	
	#uniquename(didsBk)
	%didsBk% := join(%uniqueDids%, BankruptcyV3.key_bankruptcyv3_did(false), 
			(unsigned6)left.did = right.did); 

	#uniquename(didsBkParty)
	%didsBkParty% := join(%didsBk%, bankruptcyv3.key_bankruptcyv3_search_full_bip(false),	
                    (left.tmsid = right.tmsid and 
										(unsigned6) left.did = (unsigned6)right.did and 
										(In_Party_Type = '' or 
												right.name_type[1] = stringlib.stringtouppercase(In_Party_Type)[1])),
                    LIMIT (ut.limits.FETCH_KEYED));
	#uniquename(bkCountTable)
	%bkCountTable% := record		
		%didsBkParty%.didField,
		bk_count := COUNT(GROUP);
	end;

	#uniquename(res)
	%res% := table(%didsBkParty%, %bkCountTable%, didField);

	outwithCount := join(inNoCount, %res%, left.didField = right.didField, TRANSFORM(recordof(inNoCount),
			SELF.BkCountField := right.BkCountField,
			self.didField := left.didField, 
			self := left), left outer);
			
ENDMACRO;