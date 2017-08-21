import ut;

nv_div_filter := dataset('~thor_200::in::mar_div::nv::divorce',marriage_divorce_v2.Layout_Divorce_NV_In,flat,OPT);

ds_Divorce_NV_In := nv_div_filter( trim(orig_Defendant_Name) !='' or trim(orig_Plantiff_Name)!='' ); 		

fixed_name_layout := record
marriage_divorce_v2.Layout_Divorce_NV_In;
string fixed_name_Def:='';
string fixed_name_Plant:='';
end;


fixed_name_layout tPreProcess(marriage_divorce_v2.Layout_Divorce_NV_In l) := TRANSFORM
  
Name1 := trim(l.orig_Defendant_Name);
tempName1 := regexreplace('DUPLICATE|^[*]+ CREDITOR NOT ON FILE$|REMOVED FROM FILE',Name1,'Unknown',nocase);
	
Name2 := trim(l.orig_Plantiff_Name);
tempName2 := regexreplace('DUPLICATE|^[*]+ CREDITOR NOT ON FILE$|REMOVED FROM FILE',Name2,'Unknown',nocase);
		
self.fixed_name_Def := tempName1;
self.fixed_name_Plant := tempName2;
self:=l;
end;

export File_Divorce_NV_In := project(ds_Divorce_NV_In, tPreProcess(left));
