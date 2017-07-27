IMPORT Address, ut, idl_header, aid, bipv2, Business_Header_SS;

EXPORT Proc_Build_SDA_Base(STRING filedate) 
:= FUNCTION 

dBase		 	:= Mapping_Cleansing_SDA(filedate) ;

dPrev_SDA_Base	:= project(File_SDA_Base, 
													transform(SDA_SDAA.Layouts.base,
																		self.prep_addr_line1		 := if(trim(left.prep_addr_line1) = '',
																																	 Address.Addr1FromComponents(
																																					trim(left.prim_range)
																																					,trim(left.predir)
																																					,trim(left.prim_name)
																																					,trim(left.addr_suffix)
																																					,trim(left.postdir)
																																					,trim(left.unit_desig)
																																					,trim(left.sec_range)
																																				),	trim(left.prep_addr_line1)),
																		 self.prep_addr_line_last := if(trim(left.prep_addr_line_last) = '',
																																		Address.Addr2FromComponents(
																																				 trim(left.city)
																																				,trim(left.State)	
																																				,if (left.zip <> 0, intformat(left.zip,5,1),'')
																																			), trim(left.prep_addr_line_last)),
																		 self := left));

dBaseFile := dBase+dPrev_SDA_Base;

// Flip names that may have been wrongly parsed by the name cleaner.
ut.mac_flipnames(dBaseFile, fname, mname, lname, dBaseFile_w_flipnames);

//*** Applying AID macro to clean the addresses.
HasAddress	:=	trim(dBaseFile_w_flipnames.prep_addr_line1, left,right) != ''
						and trim(dBaseFile_w_flipnames.prep_addr_line_last, left,right) != '';
								
dBase_With_address		:= dBaseFile_w_flipnames(HasAddress);
dBase_Without_address	:= dBaseFile_w_flipnames(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dBase_With_address, prep_addr_line1, prep_addr_line_last, RawAID, dBase_withAID, lFlags);

dCleanAddrBase := project(
	dBase_withAID
	,transform(
		Layouts.base
		,
		self.ace_aid							:= left.aidwork_acecache.aid					;
		self.rawaid								:= left.aidwork_rawaid								;
		self.company_rawaid				:= left.aidwork_rawaid								;
		
		self.prim_range						:= left.aidwork_acecache.prim_range		;
		self.predir								:= left.aidwork_acecache.predir				;
		self.prim_name						:= left.aidwork_acecache.prim_name		;
		self.addr_suffix					:= left.aidwork_acecache.addr_suffix	;
		self.postdir							:= left.aidwork_acecache.postdir			;
		self.unit_desig						:= left.aidwork_acecache.unit_desig		;
		self.sec_range						:= left.aidwork_acecache.sec_range		;
		self.city									:= left.aidwork_acecache.v_city_name	;
		self.state								:= left.aidwork_acecache.st						;
		self.zip									:= (integer)left.aidwork_acecache.zip5;
		self.zip4									:= (integer)left.aidwork_acecache.zip4;
		self.county								:= left.aidwork_acecache.county[3..]	;
		self.geo_lat							:= left.aidwork_acecache.geo_lat			;
		self.geo_long							:= left.aidwork_acecache.geo_long			;
		self.msa									:= left.aidwork_acecache.msa					;
		
		self.company_prim_range		:= left.aidwork_acecache.prim_range		;
		self.company_predir				:= left.aidwork_acecache.predir				;
		self.company_prim_name		:= left.aidwork_acecache.prim_name		;
		self.company_addr_suffix	:= left.aidwork_acecache.addr_suffix	;
		self.company_postdir			:= left.aidwork_acecache.postdir			;
		self.company_unit_desig		:= left.aidwork_acecache.unit_desig		;
		self.company_sec_range		:= left.aidwork_acecache.sec_range		;
		self.company_city					:= left.aidwork_acecache.v_city_name	;
		self.company_state				:= left.aidwork_acecache.st						;
		self.company_zip					:= (integer)left.aidwork_acecache.zip5;
		self.company_zip4					:= (integer)left.aidwork_acecache.zip4;
							
		self											:= left																;
	)
)
+ dBase_Without_address;
//*** End of AID.

dCleanAddrBase_srt:= SORT(DISTRIBUTE(dCleanAddrBase, HASH(COMPANY_NAME)),EXCEPT Dt_First_Seen, Dt_Last_Seen, rawaid, ace_aid, company_rawaid, prep_addr_line1, prep_addr_line_last, LOCAL);

templayout	:=	record
		unsigned6 bdid := 0;       // BDID from Business Headers
		unsigned6 did := 0;        // DID from Headers
		unsigned1 contact_score := 0;
		qstring34 vendor_id := ''; // Vendor key
		unsigned4 dt_first_seen;   // From contact info if available
		unsigned4 dt_last_seen;    // From contact infor if available
		string2   source;          // Source file type
		string1   record_type;     // 'C' = Current, 'H' = Historical
		string1   from_hdr := 'N'; // 'Y' if contact is from address 
															 // match with person headers.
		BOOLEAN   glb := false;    // GLB restricted record (only possible
															 // for contacts pulled from header)
		BOOLEAN	  dppa := false;   // DPPA restricted record
		qstring35 company_title;   // Title of Contact at Company if available
		qstring35 company_department := '';
		qstring5  title;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5  name_suffix;
		string1   name_score;
		qstring10 prim_range;
		string2   predir;
		qstring28 prim_name;
		qstring4  addr_suffix;
		string2   postdir;
		qstring5  unit_desig;
		qstring8  sec_range;
		qstring25 city;
		string2   state;
		string5		zip;
		unsigned2 zip4;
		string3   county;
		string4   msa;
		qstring10 geo_lat;
		qstring11 geo_long;
		unsigned6 phone;
		string60 email_address;
		unsigned4 ssn := 0;
		qstring34 	company_source_group := ''; // Source group
		qstring120 	company_name;
		qstring10 	company_prim_range;
		string2   	company_predir;
		qstring28 	company_prim_name;
		qstring4  	company_addr_suffix;
		string2   	company_postdir;
		qstring5  	company_unit_desig;
		qstring8  	company_sec_range;
		qstring25 	company_city;
		string2   	company_state;
		unsigned3		company_zip;
		unsigned2 	company_zip4;
		string10		company_phone;
		string9			company_fein;
		string34		vl_id		:= '';  				// Vendor linking Identifier
		unsigned8		RawAID	:= 0;    				// Added for Address_id
		unsigned8		Company_RawAID	:= 0;   // Added for Address_id
		unsigned8		ace_aid								:=  0;
		string100		prep_addr_line1				:= '';
		string50		prep_addr_line_last		:= '';
		BIPV2.IDlayouts.l_xlink_ids;	
end;
	
AssignStringValues	:= project(dCleanAddrBase_srt,transform(templayout,self.zip	:=	(string)left.zip; self.company_phone	:=	(string)left.company_phone; self.company_FEIN	:=	(string)left.company_fein; Self := left;));

BDID_Matchset := ['A','F','P'];
	
Business_Header_SS.MAC_Add_BDID_FLEX(
		 AssignStringValues										// Input Dataset						
		,BDID_Matchset                        // BDID Matchset what fields to match on           
		,company_name	                        // company_name	              
		,prim_range		                        // prim_range		              
		,prim_name		                        // prim_name		              
		,zip	 				                        // zip5					              
		,sec_range		                        // sec_range		              
		,state				                        // state				              
		,company_phone                        // phone				              
		,company_fein	                        // fein              
		,bdid													        // bdid												
		,templayout													  // Output Layout 
		,false                                // output layout has bdid score field?                       
		,''						                        // bdid_score                 
		,dBdidFlexOut                         // Output Dataset 
		,
		,																			// default to use prod version of superfiles
		,																			// default is to hit prod from dataland, and on prod hit prod.
		,[2]
		,
		,
		,city
		,fname
		,mname
		,lname
	);   	
	
RevertToBaseLayout	:= project(dBdidFlexOut,transform(Layouts.Base,self.zip	:=	(integer)left.zip; self.company_phone	:=	(integer)left.company_phone; self.company_FEIN	:=	(integer)left.company_fein; Self := left;));	


Layouts.Base  t_rollup(Layouts.Base pleft, Layouts.Base pRight) 
   := TRANSFORM
		SELF.Dt_First_Seen := IF(pleft.dt_First_Seen >pright.Dt_First_Seen,pright.Dt_First_Seen, pleft.Dt_First_Seen);
		SELF.Dt_Last_Seen  := IF(pleft.dt_Last_Seen  <pright.Dt_Last_Seen, pright.Dt_Last_Seen,  pleft.Dt_Last_Seen);
		SELF := pleft;
   END;

dBaseout := ROLLUP(RevertToBaseLayout,t_rollup(LEFT,RIGHT),RECORD, EXCEPT Dt_First_Seen, Dt_Last_Seen, rawaid, company_rawaid, ace_aid, prep_addr_line1, prep_addr_line_last, local);

ut.MAC_SF_BuildProcess(dBaseout ,SDA_SDAA.cluster.cluster_out+'base::sda',Outbase, 3,,true);
RETURN Outbase;

END;
