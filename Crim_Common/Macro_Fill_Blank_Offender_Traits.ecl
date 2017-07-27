export Macro_Fill_Blank_Offender_Traits (pGroupedOffenderDataset, pFieldToFill, pGroupedOffenderFilledDataset)
 :=
	macro

	  #uniquename(lSortedByFieldToFill)
	  #uniquename(tIterateTransform)
	  %lSortedByFieldToFill% := sort(pGroupedOffenderDataset,-pFieldToFill);
 
	  Layout_Moxie_Crim_Offender2.new %tIterateTransform%(Layout_Moxie_Crim_Offender2.new pLeft, Layout_Moxie_Crim_Offender2.new pRight)
	   :=
		transform
		  self.pFieldToFill := if(pRight.pFieldToFill <> '',pRight.pFieldToFill,pLeft.pFieldToFill);
		  self				:= pRight;
		end
	   ;

	  pGroupedOffenderFilledDataset := iterate(%lSortedByFieldToFill%,%tIterateTransform%(left,right));

	endmacro
 ;