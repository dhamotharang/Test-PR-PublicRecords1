import business_header_ss,ut, lib_fileservices, header_services,codes, Data_Services;

bh_base := Business_Header.filters.bases.business_header_best(Files().Base.Business_Headers.built);
codesV3 := codes.Key_Codes_V3;

required_src_set := set(codesV3(file_name = 'BUSINESS-HEADER'

                                    AND field_name= (STRING50)'CONSUMER-PORTAL'

                                    AND field_name2= (STRING5)'ALLOW' )
										,code);


bh_layout := business_header.Layout_Business_Header_Base;

bh_layout  filterDNBAddressPhone(bh_layout l) := 
transform
	self.prim_range		:= if(l.source = 'D'	,''	,l.prim_range	);
	self.predir			:= if(l.source = 'D'	,''	,l.predir		);
	self.prim_name		:= if(l.source = 'D'	,''	,l.prim_name	);
	self.addr_suffix	:= if(l.source = 'D'	,''	,l.addr_suffix	);
	self.postdir		:= if(l.source = 'D'	,''	,l.postdir		);
	self.unit_desig		:= if(l.source = 'D'	,''	,l.unit_desig	);
	self.sec_range		:= if(l.source = 'D'	,''	,l.sec_range	);
	self.zip			:= if(l.source = 'D'	,0	,l.zip			);
	self.zip4			:= if(l.source = 'D'	,0	,l.zip4			);
	self.county			:= if(l.source = 'D'	,''	,l.county		);
	self.msa			:= if(l.source = 'D'	,''	,l.msa			);
	self.geo_lat		:= if(l.source = 'D'	,''	,l.geo_lat		);
	self.geo_long		:= if(l.source = 'D'	,''	,l.geo_long		);
	self.phone			:= if(l.source = 'D'	,0	,l.phone		);
	self.phone_score	:= if(l.source = 'D'	,0	,l.phone_score	);
	self 				:= l;                     
end;

bh_base_filtered := project(bh_base(source in required_src_set), filterDNBAddressPhone(left));

f_best := Business_Header.BestAll(bh_base_filtered, 'EB_AE_DNB');
// need to match back to BH to see if the dnb records with address information have another source

Business_Header.Layout_BH_Best tblanksource(Business_Header.Layout_BH_Best l) :=
transform
	self.source := '';
	self := l;
end;

//CNG W20070816-150957 dat//////////////////////////////////

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
	string15 bdid;	         
	string10 dt_last_seen;
	string120 company_name;
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string8 zip;
	string5 zip4;
	string15 phone;
	string10 fein;       
	string3 best_flags;
	string2   source;	 
    string2   DPPA_State;
    string2 eor;
end;

header_services.Supplemental_Data.mac_verify('file_business_best_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();

business_header.Layout_BH_Best reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
	self.bdid := (unsigned6) L.bdid;
	self.dt_last_seen := (unsigned4) L.dt_last_seen;
	self.zip := (unsigned3) L.zip;
	self.zip4 := (unsigned2) L.zip4;
	self.phone := (unsigned6) L.phone;
	self.fein := (unsigned4) L.fein;
	self.best_flags := (unsigned3) L.best_flags;
    self := L;

 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

/////////////////////////////////////////////////////

in_hdr := project(f_best, tblanksource(left));


// Start of code to suppress data based on an MD5 Hash of DID+Address
Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('didaddressbusiness_sup.txt',Suppression_Layout,supp_ds_func);
header_services.Supplemental_Data.mac_verify('businessbest_sup.txt',Suppression_Layout,supp_ds_func1);
 
Suppression_In := supp_ds_func();
supp_in1 := supp_ds_func1();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));
dSupp1 := project(supp_in1, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 business_header.Layout_BH_Best;
 rHashDIDAddress;
 data16 hval1;
end;

rFullOut_HashDIDAddress tHashDIDAddress(business_header.Layout_BH_Best l) := transform                            
 self.hval := hashmd5(intformat(l.bdid,12,1),(string)l.state,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
 self.hval1 := hashmd5(intformat(l.bdid,12,1));
 self := l;
end;

dHeader_withMD5 := project(in_hdr, tHashDIDAddress(left));

business_header.Layout_BH_Best tSuppress(dHeader_withMD5 l) := transform
 self := l;
end;

supp_1 := join(dHeader_withMD5, dSupp1, left.hval1 = right.hval, left only, lookup);

full_out_suppress := join(supp_1,dSuppressedIn,
                          left.hval = right.hval,
            						  tSuppress(left),
						              left only,lookup);

/////////////////////////////////////////////////////////////////////////

f_best_blanksource_unique := full_out_suppress + Base_File_Append;

EXPORT Key_BH_Best_KnowX := INDEX(
	f_best_blanksource_unique, 
	{bdid},
	{f_best_blanksource_unique},
	data_services.data_location.prefix() + 'thor_data400::key::business_header.Best_Knowx_' + business_header_ss.key_version );
