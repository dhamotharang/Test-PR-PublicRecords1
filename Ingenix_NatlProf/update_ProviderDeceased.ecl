import Ingenix_natlprof,ut;

		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
Layout_in_providerdeceased.raw_Allsrc Trans_rec(Layout_in_providerdeceased.raw_Allsrc l)	:=Transform 
self.DeceasedIndicator		:= 	trimUpper(l.DeceasedIndicator);
self.DeceasedDate			:=	l.DeceasedDate[7..10]	+	l.DeceasedDate[1..2]+	l.DeceasedDate[4..5];
self						:=	l;
end;

File_in			:= project(File_in_ProviderDeceased.Allsrc,Trans_Rec(left));

file_dist 		:= distribute(File_in, hash(FILETYP,ProviderID));
file_sort 		:= sort(file_dist,FILETYP, ProviderID,  -ProcessDate,local);



Layout_in_providerdeceased.raw_Allsrc  rollupXform(Layout_in_providerdeceased.raw_Allsrc l, Layout_in_providerdeceased.raw_Allsrc r) := transform
		self.Processdate    			:= if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_Vendor_First_Reported 	:= if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  	:= if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self 							:= l;
end;

export update_ProviderDeceased 			:= rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,ProviderID,local);
                            