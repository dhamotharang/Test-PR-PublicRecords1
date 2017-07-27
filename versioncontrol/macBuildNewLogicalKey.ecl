export macBuildNewLogicalKey(	 

					 pNewKey												// -- New Index to Build
					,pOutput 												// -- Output Code to build index
					,pOne_node					= 'false'		// -- One node key?
) := 
macro


	export pOutput :=
		if(pOne_node != true,
			 buildindex(pNewKey	,update			)
			,buildindex(pNewKey	,update	,few)
		)
		;
		
endmacro;
