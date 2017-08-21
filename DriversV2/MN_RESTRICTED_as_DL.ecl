// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import DriversV2, MDR, ut, std;
//As of 01/2015, data for MN DL processing comes from Insurance via OKC.  This
//module cleans and maps the data into the common DL format and creates a persist file.
export MN_RESTRICTED_as_DL := module

  //Validate person's name
	boolean isNameBad(string name) := function
				temp_name	:= ut.CleanSpacesAndUpper(name);
				ifNameBad := if (regexfind('<=|=>|PRIVATE NAME|REISSURED|POSSIBLE MISUSE|UNKNOWN',temp_name),true,false);
				return ifNameBad;
	end;

  //Validate street address
	//-can't contain only numeric data; or only the state; or an invalid name (e.g. unknown)
	boolean isAddrBad(string addr) := function	
				temp_addr	 := ut.CleanSpacesAndUpper(addr);
				ifAddrBad1 := if (regexfind('PRIVATE ADDR|PRIVATE|UNKNOWN|UNKOWN|NO WHERE CLOSE|ADDRESS UNKNOWN',temp_addr),true,false);
				ifAddrBad2 := if (stringlib.stringfilterout(temp_addr,' 0123456789') = '',true,false);		
				ifAddrBad3 := if (length(ut.CleanSpacesAndUpper(temp_addr)) = 2 and stringlib.stringfilterout(temp_addr,'MN') = '',true,false);
				ifAddrBad	 := if (ifAddrBad1 or ifAddrBad2 or ifAddrBad3,true,false);
				return ifAddrBad;	
	end;
	
	//Validate the city name
	//-can't contain only numeric data; or an invalid name (e.g. unknown)
	boolean isCityBad(string city) := function
				temp_city	 := ut.CleanSpacesAndUpper(city);
				ifCityBad1 := if (regexfind('XX|UNKNOWN|COUNTY:',temp_city),true,false);
				ifCityBad2 := if (stringlib.stringfilterout(temp_city,' 0123456789') = '',true,false);
				ifCityBad3 := if (length(temp_city) = 1,true,false);			
				ifCityBad	 := if (ifCityBad1 or ifCityBad2 or ifCityBad3,true,false);
				return ifCityBad;
	end;

	ds_MN_RESTRICTED_Raw_Rollup  := DriversV2.Files_MN_RESTRICTED_In().Raw_Common_Base.QA;
	
	DriversV2.layout_dl_extended x2common(DriversV2.Layouts_DL_MN_RESTRICTED_In.full_rec l) := transform
				self.dl_seq  										:= 0;    			
				self.did												:= 0; 
				self.preglb_did									:= 0;		
				self.dt_first_seen							:= l.dt_first_seen;
				self.dt_last_seen								:= l.dt_last_seen;
				self.dt_vendor_first_reported		:= l.dt_vendor_first_reported;
				self.dt_vendor_last_reported		:= l.dt_vendor_last_reported;
				self.dlcp_key      							:= ut.CleanSpacesAndUpper(l.dln); 		
				self.orig_state									:= l.statepostalcode;
				self.source_code								:= MDR.sourceTools.src_MN_RESTRICTED_DL;
				self.history										:= if(l.expirationdate <> 0 and (string)l.expirationdate < (string8)Std.Date.Today(),'E','U'); 
				self.name 					  					:= if (isNameBad(ut.CleanSpacesAndUpper(l.fname + l.mname + l.lname)),'',ut.CleanSpacesAndUpper(l.fname + l.mname + l.lname));
				self.addr_type   								:= '';    			                  
				self.addr1           		  			:= if (isAddrBad(l.address),'',l.address);
				self.city					            	:= if (isCityBad(l.city),'',stringlib.stringfilterout(l.city,'/:;[]#\\'));
				self.state											:= l.statepostalcode;
				self.zip             		 				:= if ((integer)l.zip = 0,'',l.zip);
				self.province    								:= '';    			
				self.country     								:= '';   			
				self.postal_code   							:= '';  		
				self.dob												:= l.dob;
				self.race												:= '';  
				self.sex_flag										:= l.gender;
				self.license_class 							:= DriversV2.Tables_DL_MN_RESTRICTED.License_Class(l.classdesc);
				self.license_type								:= l.licensetype;															 
				self.moxie_license_type					:= '';  
				self.attention_flag							:= if (ut.CleanSpacesAndUpper(l.donorflag) <> ''
																							 ,if (ut.CleanSpacesAndUpper(l.donorflag) ='N'
																									 ,'N'
																									 ,'Y' //Numeric data represents the year the individual became a donor 
																									 )
																							 ,'N'
																							 );
				self.dod												:= '';
				self.restrictions								:= DriversV2.Tables_DL_MN_RESTRICTED.Restrictions(l.restrictiondesc);
				self.restrictions_delimited			:= l.restrictions_delimited; 
				self.orig_expiration_date				:= 0;  
				self.orig_issue_date						:= 0;
				self.lic_issue_date							:= l.issueddate;  
				self.expiration_date						:= l.expirationdate;  
				self.active_date								:= 0;  
				self.inactive_date							:= 0;  
				self.lic_endorsement						:= if (l.lic_endorsement<>'',l.lic_endorsement,'');
				self.motorcycle_code						:= '';
				self.dl_number 									:= l.dln; 	  			  
				self.ssn												:= l.ssn;
				self.ssn_safe										:= '';  
				self.age												:= '';  
				self.privacy_flag								:= '';  
				self.driver_edu_code						:= '';  
				self.dup_lic_count							:= '';  
				self.rcd_stat_flag							:= '';  		
				tempheight											:= if (stringlib.stringfind(l.height,'-',1) <> 0,stringlib.stringfindreplace(l.height, '-','0'),l.height);
				self.height          						:= if (tempheight = '000','',tempheight);				
				self.hair_color									:= l.haircolordesc;
				self.eye_color									:= DriversV2.Tables_DL_MN_RESTRICTED.Eye_Color(l.eyecolordesc);
				self.weight         						:= if (l.weight = '000','',l.weight);				
				self.oos_previous_dl_number			:= '';  
				self.oos_previous_st						:= '';  
				self.title											:= l.title;
				self.fname											:= if (l.fname = 'PRIVATE' or isNameBad(l.fname),'',l.fname);
				self.mname											:= if (isNameBad(l.mname),'',l.mname);
				self.lname											:= if (l.lname = 'NAME' or isNameBad(l.lname),'',l.lname);
				self.name_suffix								:= '';  
				self.cleaning_score							:= '';  
				self.addr_fix_flag							:= '';  
				self.prim_range									:= l.cleanaddress.prim_range;
				self.predir											:= l.cleanaddress.predir;
				self.prim_name									:= l.cleanaddress.prim_name;
				self.suffix											:= l.cleanaddress.addr_suffix;
				self.postdir										:= l.cleanaddress.postdir;
				self.unit_desig									:= l.cleanaddress.unit_desig;
				self.sec_range									:= l.cleanaddress.sec_range;
				self.p_city_name            		:= if (isCityBad(l.cleanaddress.p_city_name),'',stringlib.stringfilterout(l.cleanaddress.p_city_name,'/:;[]#\\'));                             
				self.v_city_name     						:= if (isCityBad(l.cleanaddress.v_city_name),'',stringlib.stringfilterout(l.cleanaddress.v_city_name,'/:;[]#\\')); 
				self.st													:= l.cleanaddress.st;
				self.zip5												:= l.cleanaddress.zip;
				self.zip4												:= l.cleanaddress.zip4;			
				self.cart												:= l.cleanaddress.cart;
				self.cr_sort_sz									:= l.cleanaddress.cr_sort_sz;
				self.lot												:= l.cleanaddress.lot;
				self.lot_order									:= l.cleanaddress.lot_order;
				self.dpbc												:= l.cleanaddress.dbpc;
				self.chk_digit									:= l.cleanaddress.chk_digit;
				self.rec_type										:= l.cleanaddress.rec_type;	
				self.ace_fips_st								:= l.cleanaddress.fips_state;
				self.county											:= l.cleanaddress.fips_county;
				self.geo_lat										:= l.cleanaddress.geo_lat;
				self.geo_long										:= l.cleanaddress.geo_long;
				self.msa												:= l.cleanaddress.msa;
				self.geo_blk										:= l.cleanaddress.geo_blk;
				self.geo_match									:= if(l.cleanaddress.geo_lat<>'',l.cleanaddress.geo_match,'');
				self.err_stat										:= l.cleanaddress.err_stat;		
				self.status				 							:= DriversV2.Tables_DL_MN_RESTRICTED.Status(l.statusdesc);  
				self.issuance										:= '';  
				self.address_change							:= '';  
				self.name_change								:= ''; 
				self.dob_change									:= ''; 
				self.sex_change									:= '';  
				self.old_dl_number 							:= '';  		
				self.dl_key_number							:= '';  
				self.cdl_status   							:= l.cdl_status;
				self.origlicenseclass						:= DriversV2.Tables_DL_MN_RESTRICTED.License_Class(l.classdesc);
				self.origlicensetype						:= l.licensetype;
				self.datereceived								:= l.mvrrptdate;
				self.rawfullname								:= if (isNameBad(l.fname + l.mname + l.lname),'',ut.CleanSpacesAndUpper(l.fname + l.mname + l.lname));
				self.orig_canceldate						:= ''; 
				self.orig_origcdldate						:= ''; 
				self.orig_county								:= ''; 
				self.orig_drivered							:= ''; 
				self.orig_habitualoffender			:= ''; 
				self.school_bus_physical_type		:= ''; 
				self.school_bus_physical_expdate:= ''; 
				self														:= l;
	end;									 

	ds_MN_RESTRICTED_Raw_Clean 	:= project(ds_MN_RESTRICTED_Raw_Rollup,x2common(left));

	ds_MN_RESTRICTED_DL 				:= dedup(sort(distribute(ds_MN_RESTRICTED_Raw_Clean,hash(dlcp_key)),record,local),record,local): persist(DriversV2.Constants.Cluster + 'persist::dl2::drvlic_mn_restricted_as_dl');

	export MN_RESTRICTED_DL			:= ds_MN_RESTRICTED_DL;
	
end;