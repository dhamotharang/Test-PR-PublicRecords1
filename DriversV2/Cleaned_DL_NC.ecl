import Drivers, Address, ut, lib_stringlib, NID, _Validate;

export Cleaned_DL_NC(string process_date, string fileDate, string fileType) := function

new_in_file 				:= DriversV2.File_DL_NC_Update(fileDate);
Chg_in_file 				:= DriversV2.File_DL_NC_CHG_Update(fileDate);
in_file							:= if(fileType='',new_in_file,Chg_in_file);
layout_out  				:= DriversV2.Layout_DL_NC_In.Layout_NC_With_Clean;

 TrimUpper(string s):= function
		return trim(stringlib.StringToUppercase(s),left,right);
 end;

 layout_out mapClean(in_file l) 	 	:= transform
	  self.License_Number       	      := if((integer)l.License_Number<>0,trim(l.License_Number,left,right),'');                     
		self.FirstName       						  := trimUpper(l.FirstName)  ;  
		self.MiddleName       						:= trimUpper(l.MiddleName)  ; 
		self.LastName       							:= trimUpper(l.LastName)  ; 
		self.Suffix												:= ut.fGetSuffix(trimUpper(l.Suffix))  ; 
		self.DOB              						:= if(_Validate.Date.fIsValid((string)(l.DOB[1..4]+l.DOB[6..7]+l.DOB[9..10])),l.DOB[1..4]+l.DOB[6..7]+l.DOB[9..10],''); 
		self.Address1   									:= trimUpper(l.Address1)  ; 				
		self.Address2    									:= trimUpper(l.Address2)  ;   
		self.City													:= trimUpper(l.City)  ;
		self.STATE    										:= trimUpper(l.STATE)  ;           	   
		self.ZIP     											:= if((integer)stringlib.stringfilter(l.ZIP,'0123456789')<>0,stringlib.stringfilter(l.ZIP,'0123456789'),'');   			    
		self.LicenseType	   							:= trimUpper(l.LicenseType)  ;
		self.IssueDate			 							:= if(_Validate.Date.fIsValid((string)(l.IssueDate[1..4]+l.IssueDate[6..7]+l.IssueDate[9..10])),l.IssueDate[1..4]+l.IssueDate[6..7]+l.IssueDate[9..10],'');
		self.Expiration 							    := if(_Validate.Date.fIsValid((string)(l.Expiration[1..4]+l.Expiration[6..7]+l.Expiration[9..10])),l.Expiration[1..4]+l.Expiration[6..7]+l.Expiration[9..10],''); 
		self.Restriction1								  := trimUpper(l.Restriction1)  ;
		self.Restriction2		 							:= trimUpper(l.Restriction2)  ;
		self.Restriction3		 							:= trimUpper(l.Restriction3)  ;
		self.Restriction4		 							:= trimUpper(l.Restriction4)  ;
		self.Restriction5		 							:= trimUpper(l.Restriction5)  ;
		self.Status	 											:= trimUpper(l.Status)  ;	
		self.title           						  := ''; 
		self.fname           						  := trimUpper(l.FirstName)  ;   
		self.mname           						  := trimUpper(l.MiddleName)  ; 
		self.lname           						  := trimUpper(l.LastName)  ;
		self.name_suffix	 							  := ut.fGetSuffix(trimUpper(l.Suffix));
		self.cleaning_score	 					    := ''; 
		self.prim_range                   := '';
		self.predir 	     							  := '';
		self.prim_name 	     						  := '';
		self.addr_suffix          			  := '';
		self.postdir 	     							  := '';
		self.unit_desig 	 							  := '';
		self.sec_range 	     						  := '';
		self.p_city_name								  := '';
		self.v_city_name	 							  := '';
		self.st	         								  := '';
		self.zip5 		     							  := '';
		self.zip4 		     							  := '';
		self.cart 		    							  := '';
		self.cr_sort_sz 	 							  := '';
		self.lot 		     								  := '';
		self.lot_order 	     						  := '';
		self.dpbc 		     							  := '';
		self.chk_digit 	     						  := '';
		self.rec_type	     							  := '';
		self.ace_fips_st	 							  := '';
		self.county     	 							  := '';
		self.geo_lat 	     							  := '';
		self.geo_long 	     						  := '';
		self.msa 		     								  := '';
		self.geo_blk         						  := '';
		self.geo_match 	     						  := '';
		self.err_stat 	     						  := '';
		self.process_date    						  := if(_Validate.Date.fIsValid((string)process_Date),process_Date,'');
		self                 						  := l;		
	end;

	Cleaned_NC_File 									 := project(in_file, mapClean(left)); 
	
	return Cleaned_NC_File;
	
end;