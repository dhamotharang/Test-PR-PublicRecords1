import certegy,lib_stringlib;
Certegy_In := Certegy.Files.certegy_base;

alnum_filter := '[^[:alnum:]]';

//The function to clean the non alpha numberic [~/+@%&[]]characters from a DL_Number.
string cleanLeadingNonAlpNumChars(string instr) := function
  s := regexreplace(alnum_filter, instr, '', nocase);
	fchar := if (length(s) > 0, s[1], '');  //take only first byte
	pos := if (fchar = '', 0, lib_stringlib.StringLib.StringFind(instr, fchar, 1));
  return(if (pos > 0, instr[pos..], ''));
end;
/*if dl_number is filled with non alpha numeric characters then those non alpha numeric characters will be replaced with blank,(EX: '+', '\', '~'  will be replaced with blank space ) 
And if dl_number starts with non alpha numeric characters then those non alpha numeric characters will be replaced with blank and rest will be served as dl_number
(EX:  [;ATTRC574KE, #BRISKTD282QB,\G0570397 will be corrected as ATTRC574KE, BRISKTD282QB, G0570397). */    


   recordof(Certegy_In)  Trans_clean(recordof(Certegy_In) l) := transform
    self.orig_DL_Num				 :=trim(cleanLeadingNonAlpNumChars(l.orig_DL_Num),left,right);
		self.clean_DOB				 := if(trim(l.clean_DOB,left,right)='0', '',l.clean_DOB);
   	self                			 := l;
   end;
  
   clean_file := project(Certegy_In, Trans_clean(LEFT));

Srt_Dist_Certegy_Base := sort(clean_file, WHOLE RECORD);
   
   recordof(Certegy_In)  rollupXform(recordof(Certegy_In) l, recordof(Certegy_In) r) := transform
   	self.date_vendor_first_reported  := if(l.date_vendor_first_reported > r.date_vendor_first_reported, r.date_vendor_first_reported, l.date_vendor_first_reported);
   	self.date_vendor_last_reported   := if(l.date_vendor_last_reported  < r.date_vendor_last_reported,  r.date_vendor_last_reported,  l.date_vendor_last_reported);
   	self                			 := l;
   end;
  
   rolledup_file := rollup(Srt_Dist_Certegy_Base, rollupXform(LEFT,RIGHT), WHOLE RECORD,EXCEPT date_vendor_first_reported,date_vendor_last_reported);

export File_certegy_in := rolledup_file;