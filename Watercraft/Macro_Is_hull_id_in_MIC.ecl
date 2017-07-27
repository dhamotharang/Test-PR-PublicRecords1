import watercraft;


export Macro_Is_hull_id_in_MIC(wDataset,wlayout,wDatasetwithflag)
:=
macro
	#uniquename(Layout_temp);
	#uniquename(joinMIC);
		
%Layout_temp% := record

wlayout;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

%Layout_temp% %joinMIC%(wDataset L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

wDatasetwithflag := join(wDataset, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
%joinMIC%(left, right), left outer, lookup);	


endmacro
;

