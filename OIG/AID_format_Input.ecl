import ut, address, _validate, AID, lib_stringlib, lib_date;

TrimUpper(string s):= function
		return trim(stringlib.StringToUppercase(s),left,right);
end;

OIG.Layouts.Temp Trans_format(OIG.Layouts.Raw_OIG_Layout l) := transform
		self.Append_Prep_Address1				:= 	if (trimUpper(l.ADDRESS1[1..3])='C/O', StringLib.StringCleanSpaces(trim(l.Address1[4..],left,right)),StringLib.StringCleanSpaces(trim(l.Address1,left,right)));
		self.Append_Prep_AddressLast		:= 	if (l.City!='',StringLib.StringCleanSpaces(trim(l.City) + ', ' + trim(l.State) + ' ' + trim(l.ZIP5 )),
																						StringLib.StringCleanSpaces(trim(l.State) + ' ' + trim(l.ZIP5 ))
																						);
		self.Append_RawAID							:=	0;
		self	                        	:= 	l;
		self														:=[];
end;

rawid_prepped := project(OIG.File_OIG_raw_in,Trans_format(left));

unsigned4 setAIDflags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(rawid_prepped, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, addresscleaned, setAIDflags);

OIG.Layouts.KeyBuild getCleanaddress(addresscleaned pInput) := transform
		clean_name				  			:=Address.CleanPersonLFM73(trim(trimUpper(pInput.lastname)) + trim(' '+ trimUpper(pInput.firstname)) + trim(' '+trimUpper(pInput.midname))) ;
		self.title				  			:=clean_name[1..5];
		self.fname				 				:=clean_name[6..25];
		self.mname				  			:=clean_name[26..45];
		self.lname				  			:=clean_name[46..65];
		self.name_suffix		  	  :=clean_name[66..70];
		self.FIRSTNAME   		  		:=trimUpper(pInput.FIRSTNAME);
		self.MIDNAME  		      	:=trimUpper(pInput.MIDNAME);
		self.LASTNAME  		      	:=trimUpper(pInput.LASTNAME);
		self.GENERAL   		      	:=trimUpper(pInput.GENERAL);
		self.SPECIALTY		      	:=trimUpper(pInput.SPECIALTY);
		self.SANCTYPE		      		:=trimUpper(pInput.SANCTYPE);
		self.SANCDATE		      		:=if((integer)pInput.SANCDATE<>0 and _validate.date.fIsValid(trim(pInput.SANCDATE,left,right)),trim(pInput.SANCDATE,left,right),'');
		self.REINDATE		      		:=if((integer)pInput.REINDATE<>0 and _validate.date.fIsValid(trim(pInput.REINDATE,left,right)),trim(pInput.REINDATE,left,right),'');
		self.DOB			          	:=if((integer)lib_stringlib.StringLib.StringFindReplace(pInput.DOB, '/','')<>0,(string)(ut.Date_MMDDYY_I2_V2(StringLib.StringFindReplace(trim(pInput.DOB,left,right) ,'/',''))),'');
		self.Append_RawAID		  	:= pInput.AIDWork_RawAID;
		self.ace_aid 			  			:= pInput.aidwork_acecache.aid;
		self.Addr_Type            :=if(pInput.BUSNAME<>'','B','P');
		self.BUSNAME              :=trimUpper(pInput.BUSNAME);
		self.ace_fips_st          := pInput.AIDWork_ACECache.county[1..2];
		self.fips_county      	  := pInput.AIDWork_ACECache.county[3..5];
		SELF.prim_range           := pInput.aidwork_acecache.prim_range;
		SELF.predir               := pInput.aidwork_acecache.predir;
		SELF.prim_name            := pInput.aidwork_acecache.prim_name;
		SELF.addr_suffix          := pInput.aidwork_acecache.addr_suffix;
		SELF.postdir              := pInput.aidwork_acecache.postdir;
		SELF.unit_desig           := pInput.aidwork_acecache.unit_desig;
		SELF.sec_range            := pInput.aidwork_acecache.sec_range;
		SELF.p_city_name          := pInput.aidwork_acecache.p_city_name;
		SELF.v_city_name          := pInput.aidwork_acecache.v_city_name;
		SELF.st                   := pInput.aidwork_acecache.st;
		SELF.zip                  := pInput.aidwork_acecache.zip5;
		SELF.zip4                 := pInput.aidwork_acecache.zip4;
		SELF.cart                 := pInput.aidwork_acecache.cart;
		SELF.cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
		SELF.lot                  := pInput.aidwork_acecache.lot;
		SELF.lot_order            := pInput.aidwork_acecache.dbpc;
		SELF.chk_digit            := pInput.aidwork_acecache.chk_digit;
		SELF.rec_type             := pInput.aidwork_acecache.rec_type;
		SELF.county               := pInput.aidwork_acecache.county;
		SELF.geo_lat              := pInput.aidwork_acecache.geo_lat;
		SELF.geo_long             := pInput.aidwork_acecache.geo_long;
		SELF.msa                  := pInput.aidwork_acecache.msa;
		SELF.geo_blk              := pInput.aidwork_acecache.geo_blk;
		SELF.geo_match            := pInput.aidwork_acecache.geo_match;
		SELF.err_stat             := pInput.aidwork_acecache.err_stat;
		SELF                      :=pInput;
		Self						  				:=[];

end;

AIDFormatFile :=project(addresscleaned,getcleanaddress(left));

ut.mac_flipnames(AIDFormatFile, fname, mname, lname, OIG_Unload_post_flip);

export AID_format_Input := OIG_Unload_post_flip: persist('~thor_data400::OIG::Append_Aid');
