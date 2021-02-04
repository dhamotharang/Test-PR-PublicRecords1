import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,IDA,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID,std;

EXPORT Update_Base (string pversion='', boolean pUseProd=false, boolean pdaily=true) := function


//standardize input

input := IDA.Files(pversion,pUseProd).input;

Ida.layouts.base tMapping(ida.layouts.input L, C) := TRANSFORM

	SELF.src                          := '';							
	SELF.persistent_record_id         := pversion;
	SELF.Dt_first_seen                := (unsigned)pversion;
	SELF.Dt_last_seen                 := (unsigned)pversion;
	SELF.Dt_vendor_first_reported     := (unsigned)pversion;
	SELF.Dt_vendor_last_reported      := (unsigned)pversion;
	SELF.orig_first_name              := l.firstname;							
	SELF.orig_middle_name             := l.middlename;
	SELF.orig_last_name               := l.lastname;
	SELF.orig_suffix                  := l.suffix;
	SELF.orig_address1                := l.addressline1;
	SELF.orig_address2                := l.addressline2;
	SELF.orig_city                    := l.city;
	SELF.orig_state_province          := l.state;
	SELF.orig_zip4                    := l.zip;
	SELF.orig_zip5                    := '';
  SELF.orig_dob                     := l.dob;
	SELF.orig_ssn                     := l.ssn;
  SELF.orig_dl                      := l.dl;
  SELF.orig_dlstate                 := l.dlstate;
	SELF.orig_phone                   := l.phone;
	SELF.clientassigneduniquerecordid := l.clientassigneduniquerecordid;
	SELF.adl_ind                      := '';
	SELF.orig_email                   := l.emailaddress; 
	SELF.orig_ipaddress               := l.ipaddress;
	SELF.orig_filecategory            := l.filecategory;
	SELF.clean_phone                  := if(ut.CleanPhone(L.phone) [1] not in ['0','1'],ut.CleanPhone(L.phone), '') ;
	SELF.clean_dob                    := if((string)L.dob <> '', _validate.date.fCorrectedDateString((string)L.dob,false), '');
	SELF  :=  L;
	SELF := [];
END;

std_input := project(IDA.Files(pversion,pUseProd).input, tMapping(LEFT, counter));


//Clean names
NID.Mac_CleanParsedNames(std_input, cleanNames
													, firstname:=orig_first_name,lastname:=orig_last_name
													, includeInRepository:=true, normalizeDualNames:=false
												);

//clean address

cleanNames_t := project(cleanNames, transform({recordof(cleanNames), string orig_addr1, string orig_addr2},
																		self.orig_addr1 := trim(stringlib.stringfilterout(left.orig_address1 + ' ' + left.orig_address2,'.^!$+<>@=%?*\''), left, right),			
																		self.orig_addr2 := trim(StringLib.StringCleanSpaces(
																					trim(left.orig_city)
																					+ if(left.orig_city <> '',',','')
																					+ ' '+ left.orig_state_province
																					+ ' '+ if(length(trim(left.orig_zip5[..5],all)) = 5,
																										left.orig_zip5[..5],''))
																										,left,right),
																		self := left));			
																					
																			
unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(cleanNames_t,orig_addr1,orig_addr2,RawAID,cleanAddr, lFlags);

IDA.Layouts.base tr(cleanAddr l) := TRANSFORM
	self.title := l.cln_title;
	self.fname := l.cln_fname;
	self.mname := l.cln_mname;
	self.lname := l.cln_lname;
	self.name_suffix := l.cln_suffix;
	self.RawAID     := l.aidwork_rawaid;
	self.ACEAID			:= l.	aidwork_acecache.aid;
	self.prim_range := stringlib.stringfilterout(l.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
	self.zip        := l.aidwork_acecache.zip5;
	self.fips_st    := l.aidwork_acecache.county[1..2];
	self.fips_county:= l.aidwork_acecache.county[3..5];
	self.msa        := if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
	self            := l.aidwork_acecache;
	self            := l;
END;

cleanAdd_t := project(cleanAddr,tr(left));

new_base_d := distribute(cleanAdd_t, hash(orig_first_name,orig_last_name,orig_address1,orig_phone,orig_email,orig_dob));  
new_base_s := sort(new_base_d,
 		              orig_first_name,
	                orig_middle_name,
		              orig_last_name, 
	                orig_suffix,
		              orig_address1, 
		  		        orig_address2, 
				         	orig_city,
					        orig_state_province, 
		  	        	orig_zip4, 
			            orig_zip5,
		  	          orig_dob, 
		              orig_ssn,
		              orig_dl,
                  orig_dlstate,
		              orig_phone, 
			            clientassigneduniquerecordid,
		            	orig_email,
		              orig_ipaddress,
	                orig_filecategory,
									-dt_last_seen, 
									-dt_vendor_last_reported,
									local);
						
IDA.Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
 self.dt_first_seen            := ut.EarliestDate (le.dt_first_seen, ri.dt_first_seen);
 self.dt_last_seen             := ut.LatestDate (le.dt_last_seen, ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
 self.persistent_record_id     := if(le.persistent_record_id < ri.persistent_record_id,le.persistent_record_id, ri.persistent_record_id); 
 self.did := 0;
 self := le;
end;

//DID

matchset := ['A','Z','D','P'];
	 did_add.MAC_Match_Flex
	 (new_base_s, matchset,					
	 ssn, clean_dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, clean_phone, 
	 DID,IDA.Layouts.base, false, DID_Score_field, 
	 75, d_did)
	 
//Append ADL_ind
Watchdog.Mac_append_ADL_ind(d_did, Updated_Base);

daily_base:= Updated_Base;

return daily_base;
end;