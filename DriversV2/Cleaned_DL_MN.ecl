import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_MN(string processDate, string filedate) := function

	in_file := DriversV2.File_DL_MN_Update(filedate);
	layout_out := DriversV2.Layouts_DL_MN_New_In.Layout_MN_With_ProcessDte;
	
	layout_out mapClean(in_file l) 			:= transform
		string73 tempName 					:= stringlib.StringToUpperCase(if(trim(l.NAME_FML,left,right) <> '',
															Address.CleanPerson73(trim(l.NAME_FML,left,right)),''));
		
		self.title               			:= tempName[1..5];
		self.fname              			:= tempName[6..25];
		self.mname             				:= tempName[26..45];
		self.lname               			:= tempName[46..65];
		self.name_suffix	          		:= tempName[66..70];
		self.cleaning_score   	          	:= tempName[71..73];
		self.prim_range              	:= '';
		self.predir 	              	:= '';
		self.prim_name 	              := '';
		self.suffix              			:= '';
		self.postdir 	              	:= '';
		self.unit_desig 	          	:= '';
		self.sec_range 	              := '';
		self.p_city_name	          	:= '';
		self.v_city_name	          	:= '';
		self.state                    := '';
		self.zip		              		:= '';
		self.zip4 		              	:= '';
		self.cart 		              	:= '';	
		self.cr_sort_sz 	          	:= '';
		self.lot 		              		:= '';
		self.lot_order 	              := '';
		self.dpbc 		              	:= '';
		self.chk_digit 	              := '';
		self.rec_type   	         		:= '';
		self.ace_fips_st	          	:= '';
		self.county     	          	:= '';
		self.geo_lat 	              	:= '';
		self.geo_long 	              := '';
		self.msa 		              		:= '';
		self.geo_blk                  := '';
		self.geo_match 	              := '';
		self.err_stat 	              := '';
		self.RECORD_TYPE			        :=if((integer)l.RECORD_TYPE<>0,trim(l.RECORD_TYPE,left,right),''); 
		self.DRIVER_LICENSE_NUMBER	    	:=if((integer)stringlib.stringfilter(l.DRIVER_LICENSE_NUMBER,'0123456789')<>0,trim(l.DRIVER_LICENSE_NUMBER,left,right),'');
		self.PREVIOUS1_LICENSE_NUMBER		:=if((integer)stringlib.stringfilter(l.PREVIOUS1_LICENSE_NUMBER,'0123456789')<>0,trim(l.PREVIOUS1_LICENSE_NUMBER,left,right),'');
		self.PREVIOUS2_LICENSE_NUMBER	    :=if((integer)stringlib.stringfilter(l.PREVIOUS2_LICENSE_NUMBER,'0123456789')<>0,trim(l.PREVIOUS2_LICENSE_NUMBER,left,right),'');
		self.PREVIOUS3_LICENSE_NUMBER		:=if((integer)stringlib.stringfilter(l.PREVIOUS3_LICENSE_NUMBER,'0123456789')<>0,trim(l.PREVIOUS3_LICENSE_NUMBER,left,right),'');
		self.process_date                   := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.name_FML                       := stringlib.StringToUpperCase(trim(l.name_FML,left,right));
		self.address1                       := stringlib.StringToUpperCase(trim(l.address1,left,right));
		self.city                           := stringlib.StringToUpperCase(trim(l.city,left,right));
		self.COUNTY_ST_CODE		     		:=stringlib.StringToUpperCase(trim(l.COUNTY_ST_CODE,left,right));
		self.zip_code                       :=if((integer)stringlib.stringfilter(l.ZIP_CODE,'0123456789')<>0,trim(l.ZIP_CODE,left,right),'');
		self.BIRTHDAY		     			:=if((integer)stringlib.stringfilter(l.BIRTHDAY,'0123456789')<>0,trim(l.BIRTHDAY[5..8],left,right) + trim(l.BIRTHDAY[1..4],left,right),'');
		self.SEX 		     				:=stringlib.StringToUpperCase(trim(l.SEX,left,right));
		self.EYE_COLOR		     			:=stringlib.StringToUpperCase(trim(l.EYE_COLOR,left,right));
		self.HEIGHT		     				:=if((integer)stringlib.stringfilter(l.HEIGHT,'0123456789')<>0,trim(l.HEIGHT,left,right),'');
		self.WEIGHT		     				:=if((integer)stringlib.stringfilter(l.WEIGHT,'0123456789')<>0,trim(l.WEIGHT,left,right),'');
		self.LICENSE_ISSUE_DATE		     	:=if((integer)stringlib.stringfilter(l.LICENSE_ISSUE_DATE,'0123456789')<>0,trim(l.LICENSE_ISSUE_DATE[5..8],left,right) + trim(l.LICENSE_ISSUE_DATE[1..4],left,right),'');
		self.LICENSE_EXPIR_DATE		     	:=if((integer)stringlib.stringfilter(l.LICENSE_EXPIR_DATE,'0123456789')<>0,trim(l.LICENSE_EXPIR_DATE[5..8],left,right) + trim(l.LICENSE_EXPIR_DATE[1..4],left,right),'');
		self.LICENSE_CLASS			     	:=stringlib.StringToUpperCase(trim(l.LICENSE_CLASS,left,right));
		self.LICENSE_STATUS	    			:=stringlib.StringToUpperCase(trim(l.LICENSE_STATUS,left,right));
		self.B_CARD_NDICATOR		     	:=stringlib.StringToUpperCase(trim(l.B_CARD_NDICATOR,left,right));
		self.DONOR_INDICATOR		     	:=stringlib.StringToUpperCase(trim(l.DONOR_INDICATOR,left,right));
		self.ENDORSEMENTS		     		:=if((integer)stringlib.stringfilter(l.ENDORSEMENTS,'0123456789')<>0,trim(l.ENDORSEMENTS,left,right),'');
		self.RESTRICTIONS		    		:=if((integer)stringlib.stringfilter(l.RESTRICTIONS,'0123456789')<>0,trim(l.RESTRICTIONS,left,right),'');
		self.INDC_COMMERCIALDRIVER		    :=if((integer)l.INDC_COMMERCIALDRIVER<>0 ,trim(l.INDC_COMMERCIALDRIVER,left,right),'');
		self.COMMERCIAL_DRIVER_STATUS		:=stringlib.StringToUpperCase(trim(l.COMMERCIAL_DRIVER_STATUS,left,right));
		self.RESTRICTED_DATA_IND		    :=trim(l.RESTRICTED_DATA_IND,left,right);
		self.SCHOOL_BUS_PHYSICAL_TYPE		:=trim(l.SCHOOL_BUS_PHYSICAL_TYPE,left,right);
		self.SCHOOL_BUS_PHYSICAL_EXPDATE	:=if((integer)stringlib.stringfilter(l.SCHOOL_BUS_PHYSICAL_EXPDATE,'0123456789')<>0,trim(l.SCHOOL_BUS_PHYSICAL_EXPDATE,left,right),'');
		self.OLD_DL_NUMBER		     		:=if((integer)stringlib.stringfilter(l.OLD_DL_NUMBER,'0123456789')<>0,trim(l.OLD_DL_NUMBER,left,right),'');
		self                          		:= l;		
	end;

	Cleaned_MN_File := project(in_file, mapClean(left));
	
	return Cleaned_MN_File;
end;
