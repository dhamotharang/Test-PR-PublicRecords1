IMPORT ut, Business_Header,mdr;

export fFBNV2_As_Business_contact(

	 dataset(Layout_Common.contact_AID	) pContactBase
	,dataset(Layout_Common.Business_AID	) pBusinessBase
	,boolean isPRCT=false

) :=
function

	dInputC:=distribute(pContactBase(lname <> ''),hash(tmsid,rmsid));
	dInputB:=distribute(pBusinessBase,hash(tmsid,rmsid));
	//*********************************************************************************
	// Translate Contacts from FBN Debtor and Secured Master to Business Contact Format
	//*********************************************************************************

Business_Header.Layout_Business_Contact_Full_New Translate_FBN_to_BCF(dInputB pLeft,dInputC pRight  ) :=
TRANSFORM
	SELF.company_title				:= '';   // Title of Contact at Company if available
	SELF.name_score						:= Business_Header.CleanName(pRight.fname,pRight.mname,pRight.lname,pRight.name_suffix)[142];
	SELF.addr_suffix					:= pRight.addr_suffix;
	SELF.city									:= pRight.v_city_name;
	SELF.zip									:= (UNSIGNED3)pRight.zip5;
	SELF.zip4									:= (UNSIGNED2)pRight.zip4;
	SELF.phone								:= (UNSIGNED5)Pright.CONTACT_PHONE;
	SELF.source								:= MDR.sourceTools.fFBNV2(pLeft.tmsid);
	SELF.record_type					:= 'C';
	SELF.company_name					:= pLeft.Bus_name;
	SELF.vl_id						    := pLeft.tmsid;
	SELF.vendor_id						:= pLeft.tmsid;
	SELF.company_source_group	:= pLeft.tmsid;
	SELF.company_prim_range		:= pLeft.prim_range;
	SELF.company_predir				:= pLeft.predir;
	SELF.company_prim_name		:= pLeft.prim_name;
	SELF.company_addr_suffix	:= pLeft.addr_suffix;
	SELF.company_postdir			:= pLeft.postdir;
	SELF.company_unit_desig		:= pLeft.unit_desig;
	SELF.company_sec_range		:= pLeft.sec_range;
	SELF.company_city					:= pLeft.v_city_name;
	SELF.company_state				:= pLeft.st;
	SELF.company_zip					:= (UNSIGNED3)pLeft.zip5;
	SELF.company_zip4					:= (UNSIGNED2)pLeft.zip4;
	SELF.company_phone				:= 0;
	SELF.dt_first_seen				:= (unsigned)pLeft.dt_first_seen;
	SELF.dt_last_seen					:= (unsigned)pLeft.dt_last_seen;
	SELF.ssn									:= (UNSIGNED4)pRight.ssn;
	SELF.email_address				:= '';
	SELF.bdid  			          := If(IsPRCT,(integer)pleft.BDID,0);
	//self.bdid									:= 0;
	self.did									:= If(IsPRCT,(integer)pRight.DID,0);
	//self.did									:= 0;
	self.state								:= pRight.st;
	self.county								:= '';
	self.msa									:= '';
	self.Company_RawAID				:= pRight.RawAID;
	SELF											:= pRight;
END;


	FBN_Contacts := Join(dInputB,dInputC,left.tmsid=right.tmsid and left.rmsid=right.rmsid
	                    , Translate_FBN_to_BCF(LEFT,Right)
						,local);

	FBN_Contacts_Filtered	:=	FBN_Contacts(company_name<>'', 
											 lname<>'',fname<>'',
											 (prim_range <> '' or prim_name <> ''),
											 (INTEGER)name_score < 3, 
											 Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
											);

	

	return FBN_Contacts_Filtered;

end;