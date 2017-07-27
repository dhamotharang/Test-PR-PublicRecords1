
/*--SOAP--
<message name="SearchService">
<part name="IDL" 			type="unsignedInt"/>
</message>
*/
/*--INFO-- Find the ADL associate to a IDL.
*/
export SearchService := MACRO
unsigned8 input_RID 				:= 0 : stored('IDL');

outputLayout := RECORD 
	unsigned8 ADL,unsigned8 IDL
END;

ds1 := dataset([{input_RID}], {unsigned6 rid});

r1  := if(input_RID > 0, join(ds1, idl_adl_mapping.keys.key_rid,	
																	left.rid = right.rid, 
																		TRANSFORM(outputLayout, 
																			SELF.ADL := right.did, 
																			SELF.IDL := right.rid)));

output(r1, named('Results'));

endmacro;
