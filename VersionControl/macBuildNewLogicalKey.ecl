export macBuildNewLogicalKey(	 

					 pNewKey										// -- Index to Build
					,pOutput 										// -- Output Code to build index
					,pOverwrite				= 'false'	// -- Overwrite an existing file?
					,pOne_node				= 'false'	// -- One node key?
					,pIsMoxieKey			= 'false'	// -- Moxie key?
					,pShouldExport		= 'true'	// -- Should export the pOutput
) := 
macro

	#if(pShouldExport)
		export
	#end
	pOutput :=

				buildindex(pNewKey	 
				
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
