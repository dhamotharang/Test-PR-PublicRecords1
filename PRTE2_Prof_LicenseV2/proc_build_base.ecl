IMPORT  PromoteSupers,Prte2,AID,Address,ut, std;

EXPORT PROC_BUILD_BASE := FUNCTION

PRTE2.CleanFields(files.DS_prolicv2_IN, in_file);
ds_file := in_file(cust_name != '');


AddressDataSet := PRTE2.AddressCleaner(ds_file,
	 ['orig_addr_1'],
	 ['orig_addr_2'],
	 ['orig_city'],
	 ['orig_st'],
	 ['orig_zip'],
	 ['clean_address'],
   ['orig_rawaid']);
	 
	 
DS_Prof_Lic_out	:=	Project(AddressDataSet,
Transform(Layouts.Layout_out,

self.license_number := left.orig_license_number;																
																		
CleanName	:= Address.CleanPersonFML73_fields(left.orig_name);
self.title          			 	   := CleanName.title;
self.fname                     := CleanName.fname;
self.mname          					 := CleanName.mname;        
self.lname            				 := CleanName.lname;
self.name_suffix    			 		 := CleanName.name_suffix;		  
self.pl_score_in  	   	       := CleanName.name_score;

self.prim_range := left.clean_address.prim_range;
self.predir := left.clean_address.predir;
self.prim_name := left.clean_address.prim_name;
self.suffix := left.clean_address.addr_suffix;
self.postdir := left.clean_address.postdir;
self.unit_desig := left.clean_address.unit_desig;
self.sec_range := left.clean_address.sec_range;
self.p_city_name := left.clean_address.p_city_name;
self.v_city_name := left.clean_address.v_city_name;
self.st := left.clean_address.st;
self.zip := left.clean_address.zip;
self.zip4 := left.clean_address.zip4;
self.cart := left.clean_address.cart;
self.cr_sort_sz := left.clean_address.cr_sort_sz;
self.lot := left.clean_address.lot;
self.lot_order := left.clean_address.lot_order;
self.dpbc := left.clean_address.dbpc;
self.chk_digit := left.clean_address.chk_digit;
self.record_type := left.clean_address.rec_type;
self.ace_fips_st := left.clean_address.fips_state;
self.county := left.clean_address.fips_county;
self.geo_lat := left.clean_address.geo_lat;
self.geo_long := left.clean_address.geo_long;
self.msa := left.clean_address.msa;
self.geo_blk := left.clean_address.geo_blk;
self.geo_match := left.clean_address.geo_match;
self.err_stat := left.clean_address.err_stat;
self.bdid := prte2.fn_AppendFakeID.bdid(left.company_name, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, left.cust_name);
SELF.did  := prte2.fn_AppendFakeID.did(self.fname, self.lname, left.link_ssn, left.link_dob, left.cust_name);		
vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.company_name, Left.link_fein, left.link_inc_date, self.prim_range, self.prim_name, self.sec_range, self.v_city_name, self.st, self.zip, left.cust_name);
self.powid	:= vLinkingIds.powid;
self.proxid	:= vLinkingIds.proxid;
self.seleid	:= vLinkingIds.seleid;
self.orgid	:= vLinkingIds.orgid;
self.ultid	:= vLinkingIds.ultid;	
self.global_sid:=0;
self.record_sid:=0;
self:=LEFT; 
self:=[];
));

df_prof_lic_old := PROJECT(files.DS_prolicv2_IN(cust_name = ''),
Transform (layouts.Layout_out,
self.global_sid:=0;
self.record_sid:=0;
self:=left;
));

df_prof_lic := df_prof_lic_old + DS_Prof_Lic_out;

PromoteSupers.MAC_SF_BuildProcess(df_prof_lic,constants.prolicv2_base, writefile);
sequential(writefile);

	
	return 'success';

END;