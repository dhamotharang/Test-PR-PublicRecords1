
import _control, tools;

export Flags(

	 boolean	pExistCurrentSprayed		
	,boolean	pExistBaseFile					
	,boolean	pIsUpdateFullFile				
	,boolean	pShouldFilter						
	,boolean	pUseStandardizePersists 	= true
	,boolean	pUpdate 									= pExistCurrentSprayed and pExistBaseFile		
	,boolean	pBuildBidKeys							=	true

) :=
module,virtual

	export ExistCurrentSprayed		:= pExistCurrentSprayed			;
	export ExistBaseFile					:= pExistBaseFile						;
	export IsUpdateFullFile				:= pIsUpdateFullFile				;
	export ShouldFilter						:= pShouldFilter						;
	export UseStandardizePersists := pUseStandardizePersists 	;
	export Update 								:= pUpdate 									;
	export BuildBidKeys						:= pBuildBidKeys						;

end;