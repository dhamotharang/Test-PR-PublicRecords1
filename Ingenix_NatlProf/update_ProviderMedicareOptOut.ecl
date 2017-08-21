import Ingenix_natlprof,ut;

		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
Ingenix_Natlprof.Layout_in_ProviderMedicareOptOut.raw_allsrc Trans_rec(Ingenix_Natlprof.Layout_in_ProviderMedicareOptOut.raw_allsrc  l)	:=Transform 
self.OptOutSiteDescription		:= 	trimUpper(l.OptOutSiteDescription);
self.DateOptOutTerminationDate	:=	l.DateOptOutTerminationDate[7..10]	+	l.DateOptOutTerminationDate[1..2] +l.DateOptOutTerminationDate[4..5];
self.OptOutEffectiveDate		:=	l.OptOutEffectiveDate[7..10]	+	l.OptOutEffectiveDate[1..2]+	l.OptOutEffectiveDate[4..5];
self.LastUpdate					:=	l.LastUpdate[7..10]	+	l.LastUpdate[1..2]+	l.LastUpdate[4..5];
self							:=	l;
end;

File_in		:= project(File_in_ProviderMedicareOptOut.Allsrc,Trans_Rec(left));

file_dist 	:= distribute(File_in, hash(FILETYP,ProviderID));
file_sort 	:= sort(file_dist,FILETYP, ProviderID,  -ProcessDate,local);



Ingenix_Natlprof.Layout_in_ProviderMedicareOptOut.raw_allsrc   rollupXform(Ingenix_Natlprof.Layout_in_ProviderMedicareOptOut.raw_allsrc  l, Ingenix_Natlprof.Layout_in_ProviderMedicareOptOut.raw_allsrc  r) := transform
		self.Processdate    			:= if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_Vendor_First_Reported 	:= if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  	:= if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self						    := l;
end;

export update_ProviderMedicareOptOut := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,ProviderID,local);
                              