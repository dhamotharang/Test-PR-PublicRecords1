export macf_WriteIndex(	 
					 pNewKeyInfo								// -- Index to Build + optional name of index(to override what is defined in index)
					,pOverwrite				= 'false'	// -- Overwrite an existing file?
					,pOne_node				= 'false'	// -- One node key?
					,pIsMoxieKey			= 'false'	// -- Moxie key?
) := 
functionmacro
	return
				buildindex(#EXPAND(pNewKeyInfo)	 
				
					#if(pIsMoxieKey) 
						,moxie
					#end
					#if(pOverwrite) 
						,overwrite
					#else
						,update
					#end
				
					#if(pOne_node)
						,few
					#end
				
				);	
				
endmacro;
