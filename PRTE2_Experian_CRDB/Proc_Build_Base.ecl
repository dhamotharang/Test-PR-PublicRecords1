import  Address, aid, NID, ut,Prte2, PromoteSupers, std;


EXPORT proc_build_base(String filedate) := FUNCTION

PRTE2.CleanFields(files.Prep, ds_file);
 		
PreProcessInput :=project(ds_file, transform(Layouts.base,self.name_suffix:=''; self:= left;));
		
Layouts.base ClnAddr(PreProcessInput L) := TRANSFORM
   
   FullName	:= L.Executive_First_Name +' '+ L.Executive_Middle_Initial +' '+ L.Executive_Last_Name +
																		   	IF(L.name_suffix <> '', ' '+ L.name_Suffix,'');
	 tempName 						 	   := Address.CleanPersonFML73_fields(FullName);
	 self.title	         := tempName.title;
	 self.fname							   := tempName.fname;
	 self.mname							   := tempName.mname;
	 self.lname	         := tempName.lname;
	 self.name_suffix    := tempName.name_suffix;
	 self.clean_dba_name := L.dba_name;
	 self.company_name   := L.Business_Name;
	 self := L;
  end;

  dStandardizedName := project(PreProcessInput, ClnAddr(left));

 	pStandardizeNameInput := dStandardizedName;
  list :=['PR','AE','VI','AP','MP','FM','GU','MH','PW'];
		
		HasAddress				:= trim(pStandardizeNameInput.prep_addr_line_last, left,right) != '' and trim(pStandardizeNameInput.state,left,right) not in list;
										
		dWith_address			:= pStandardizeNameInput(HasAddress);
		dWithout_address	:= pStandardizeNameInput(not(HasAddress));

		unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

		AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
		
		dBase := project( dwithAID
										  ,transform( Layouts.base
																	,self.ace_aid				:= left.aidwork_acecache.aid;
																	self.raw_aid				 := left.aidwork_rawaid;
																	self.prim_range		:= left.aidwork_acecache.prim_range;
																	self.predir					 := left.aidwork_acecache.predir;
																	self.prim_name			:= left.aidwork_acecache.prim_name;
																	self.addr_suffix	:= left.aidwork_acecache.addr_suffix;
																	self.postdir				 := left.aidwork_acecache.postdir;
																	self.unit_desig		:= left.aidwork_acecache.unit_desig;
																	self.sec_range			:= left.aidwork_acecache.sec_range;
																	self.p_city_name	:= left.aidwork_acecache.p_city_name;
																	self.v_city_name	:= left.aidwork_acecache.v_city_name;
																	self.st							   := left.aidwork_acecache.st;
																	self.zip						   := left.aidwork_acecache.zip5;
																	self.zip4						  := left.aidwork_acecache.zip4;
																	self.cart						  := left.aidwork_acecache.cart;
																	self.cr_sort_sz		:= left.aidwork_acecache.cr_sort_sz;
																	self.lot						   := left.aidwork_acecache.lot;
																	self.lot_order			:= left.aidwork_acecache.lot_order;
																	self.dbpc						  := left.aidwork_acecache.dbpc;
																	self.chk_digit			:= left.aidwork_acecache.chk_digit;
																	self.rec_type				:= left.aidwork_acecache.rec_type;
																	self.fips_state 	:= left.aidwork_acecache.county[1..2];
																	self.fips_county	:= left.aidwork_acecache.county[3..];
																	self.geo_lat				 := left.aidwork_acecache.geo_lat;
																	self.geo_long				:= left.aidwork_acecache.geo_long;
																	self.msa						   := left.aidwork_acecache.msa;
																	self.geo_blk				 := left.aidwork_acecache.geo_blk;
																	self.geo_match			:= left.aidwork_acecache.geo_match;
																	self.err_stat				:= left.aidwork_acecache.err_stat;
																	self.msa_code    := left.aidwork_acecache.msa;
                 															
																	self.bdid :=     prte2.fn_AppendFakeID.bdid(left.Company_name, self.prim_range, 
									                self.prim_name,  self.v_city_name,self.st,self.zip, Left.cust_name); 
													        vLinkingIds      := prte2.fn_AppendFakeID.LinkIds(left.Company_name, Left.link_fein, Left.link_inc_date, 
  									                               self.prim_range,self.prim_name, self.sec_range, self.v_city_name,self.st,
																								          self.zip, Left.cust_name);
																	self.powid       := vLinkingIds.powid;
                                  self.proxid	:= vLinkingIds.proxid;
                                  self.seleid	:= vLinkingIds.seleid;
                                  self.orgid	:= vLinkingIds.orgid;
                                  self.ultid	:= vLinkingIds.ultid;	
    															self  			:= left;
														)
									);
									
									dbase2 := JOIN(files.msa_dedup,
                                dbase, 
                                LEFT.msa_code = RIGHT.msa_code,
									                       TRANSFORM( Layouts.base,
																				            SELF.msa_description  :=  LEFT.msa_description;
																										SELF := RIGHT;
                                                    SELF := [];
																				            ), RIGHT Outer                                 
                                                    );
 dbase3 := dedup(sort(distribute(dbase2,hash(Msa_Code)),Record,local),Record,All,local);								
									
dbase4:=dbase3 + project(dWithout_address,transform(Layouts.base, self := left));
																 
											 
PromoteSupers.MAC_SF_BuildProcess(dbase4,constants.Base_Experian, writefile_Experian);

sequential(writefile_Experian);


return 'success';

end;


