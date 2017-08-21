import crim_common;

export Macro_Fill_Blank_Offender_Traits (pGroupedOffenderDataset, pFieldToFill, pGroupedOffenderFilledDataset)
 :=
	macro

	  #uniquename(lSortedByFieldToFill)
	  #uniquename(tIterateTransform)
	  %lSortedByFieldToFill% := sort(pGroupedOffenderDataset,-pFieldToFill);
 
	  hygenics_crim.Layout_Common_Crim_Offender_new %tIterateTransform%(hygenics_crim.Layout_Common_Crim_Offender_new pLeft, hygenics_crim.Layout_Common_Crim_Offender_new pRight)
	   :=
		transform
		  self.pFieldToFill := if(pRight.pFieldToFill <> '',pRight.pFieldToFill,pLeft.pFieldToFill);
		  self				:= pRight;
		end
	   ;

	  pGroupedOffenderFilledDataset := iterate(%lSortedByFieldToFill%,%tIterateTransform%(left,right));

	endmacro
 ;