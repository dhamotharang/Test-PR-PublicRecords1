EXPORT MAC_SK_BuildProcess_v3_local (the_index, the_dataset, superkeyname, lkeyname,
                                     seq_name, one_node = 'false', diffing = 'false') := MACRO

seq_name :=  
 
	#IF(one_node)    
						BUILDINDEX (the_index, the_dataset, lkeyname, UPDATE, FEW)  
	#ELSE IF (~diffing, 
						BUILDINDEX (the_index, the_dataset, lkeyname, UPDATE),        
						BUILDINDEX (the_index, the_dataset, lkeyname, DISTRIBUTE (INDEX (the_index, superkeyname+'_Prod')), UPDATE)
			);  
	#END  
    
ENDMACRO;
