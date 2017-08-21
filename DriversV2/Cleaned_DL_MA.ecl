import Drivers, Address, ut, lib_stringlib, NID, _Validate;

export Cleaned_DL_MA(string passedIn_process_date, string fileDate) := function

in_file		 := DriversV2.File_DL_MA_Update(fileDate);

 TrimUpper(string s):= function
		return trim(stringlib.StringToUppercase(s),left,right);
 end;
 
/* Only keeping records with valid drivers license class.  
   Filtering out blank license class records and liquor license records. 
	 Also filtering out old data with expiration dates before 2013. */
 inFiltered := in_file(trimUpper(license_lic_class) in ['A','B','C','AM','BM','CM','M','D','DM','IM'] 
										 	and (integer)LICENSE_EDATE_YYYYMMDD[1..4] > 2012);

Layout_DL_MA_In.Layout_MA_With_Clean mapClean(inFiltered l) 	 	:= transform
		self.PERS_SURROGATE         := if((integer)l.PERS_SURROGATE<>0,trim(l.PERS_SURROGATE,left,right),'');    
		self.LICENSE_HEIGHT					:= if((integer)stringlib.stringfilter(l.LICENSE_HEIGHT,'0123456789')<>0, stringlib.stringfilter(l.LICENSE_HEIGHT,'0123456789'), '');
		self.LICENSE_SEX 						:= trimUpper(l.LICENSE_SEX);
		self.LICENSE_LICNO 					:= trimUpper(l.LICENSE_LICNO);	
		self.LICENSE_BDATE_YYYYMMDD := if(_Validate.Date.fIsValid(l.LICENSE_BDATE_YYYYMMDD) and l.LICENSE_BDATE_YYYYMMDD <> '18500414', l.LICENSE_BDATE_YYYYMMDD, '');
		self.LICENSE_EDATE_YYYYMMDD := if(_Validate.Date.fIsValid(l.LICENSE_EDATE_YYYYMMDD) and l.LICENSE_EDATE_YYYYMMDD <> '18500414', l.LICENSE_EDATE_YYYYMMDD, '');
		self.LICENSE_LIC_CLASS 			:= trimUpper(l.LICENSE_LIC_CLASS);
		self.LICENSE_LAST_NAME 			:= trimUpper(l.LICENSE_LAST_NAME);	
		self.LICENSE_FIRST_NAME			:= trimUpper(l.LICENSE_FIRST_NAME);
		self.LICENSE_MIDDLE_NAME 		:= trimUpper(l.LICENSE_MIDDLE_NAME);
		self.LICMAIL_STREET1 				:= trimUpper(l.LICMAIL_STREET1); 
		self.LICMAIL_STREET2 				:= trimUpper(l.LICMAIL_STREET2);
		self.LICMAIL_CITY 					:= trimUpper(l.LICMAIL_CITY);	 
		self.LICMAIL_STATE 					:= trimUpper(l.LICMAIL_STATE);	 
		self.LICMAIL_ZIP 						:= if((integer)stringlib.stringfilter(l.LICMAIL_ZIP,'0123456789')<>0, stringlib.stringfilter(l.LICMAIL_ZIP,'0123456789'), ''); 
		self.LICRESI_STREET1        := if(trimUpper(l.LICRESI_STREET1) in ['0', 'D/L SERVICE', 'RI RESIDENT', 'RMV','SAME'], '', trimUpper(l.LICRESI_STREET1));
		self.LICRESI_STREET2        := if(trimUpper(l.LICRESI_STREET2) in ['0', 'D/L SERVICE', 'RI RESIDENT', 'RMV','SAME'], '', trimUpper(l.LICRESI_STREET2));	 
		self.LICRESI_CITY 					:= trimUpper(l.LICRESI_CITY);	 
		self.LICRESI_STATE					:= trimUpper(l.LICRESI_STATE);	 
		self.LICRESI_ZIP						:= if((integer)stringlib.stringfilter(l.LICRESI_ZIP,'0123456789')<>0, stringlib.stringfilter(l.LICRESI_ZIP,'0123456789'), '');
		self.ISSUE_DATE_YYYYMMDD		:= if(_Validate.Date.fIsValid(l.ISSUE_DATE_YYYYMMDD) and l.ISSUE_DATE_YYYYMMDD <> '18500414', l.ISSUE_DATE_YYYYMMDD, '');
		self.LICENSE_STATUS					:= trimUpper(l.LICENSE_STATUS);
		self.clean_status						:= if(trimUpper(l.LICENSE_STATUS[1..3]) in ['ACT','CAN','DEN','EXP','REV','SUS'], trimUpper(l.LICENSE_STATUS[1..3]), '');	
		self.process_date    		    := if(_Validate.Date.fIsValid(passedIn_process_Date),passedIn_process_Date,'');
		self                 			  := l;		
	end;

	Cleaned_MA_File 									 := project(inFiltered, mapClean(left)); 
	
	return Cleaned_MA_File;
	
end;