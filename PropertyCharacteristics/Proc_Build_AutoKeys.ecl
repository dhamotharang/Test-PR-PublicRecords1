import AutoKeyB2,autokey,AutoKeyI;

export	Proc_Build_AutoKeys(string	pVersion)	:=
function
	ak_dataset	:=	AK_Constants.ak_dataset;
	ak_keyname	:=	AK_Constants.ak_keyname;
	ak_logical	:=	AK_Constants.ak_logical(pVersion);
	ak_skipSet	:=	AK_Constants.ak_skipSet;

	autokey.mac_useFakeIDs(	ak_dataset,
													ds_withFakeID_AKB, 
													proc_build_payload_key_AKB,
													ak_keyname,
													ak_logical,
													zero,
													zero1
												) 
	 
	ds_forLayoutMaster_AKB	:=	ds_withFakeID_AKB;
	 
	ds_inLayoutMaster_AKB	:=	project(	ds_forLayoutMaster_AKB,
																			transform(	autokey.layouts.master,
																									self.inp.fname				:=	left.blank;
																									self.inp.mname				:=	left.blank;
																									self.inp.lname				:=	left.blank;
																									self.inp.ssn					:=	if((integer)left.blank=0,'',(string9)left.blank);
																									self.inp.dob					:=	(integer)left.zero;
																									self.inp.phone				:=	(string10)left.blank;
																									self.inp.prim_name		:=	left.prim_name;
																									self.inp.prim_range		:=	left.prim_range;
																									self.inp.st						:=	left.st;
																									self.inp.city_name		:=	left.v_city_name;
																									self.inp.zip					:=	(string6)left.zip;
																									self.inp.sec_range		:=	left.sec_range;
																									self.inp.states				:=	left.zero;
																									self.inp.lname1				:=	left.zero;
																									self.inp.lname2				:=	left.zero;
																									self.inp.lname3				:=	left.zero;
																									self.inp.city1				:=	left.zero;
																									self.inp.city2				:=	left.zero;
																									self.inp.city3				:=	left.zero;
																									self.inp.rel_fname1		:=	left.zero;
																									self.inp.rel_fname2		:=	left.zero;
																									self.inp.rel_fname3		:=	left.zero;
																									self.inp.lookups			:=	left.zero;
																									self.inp.DID					:=	(unsigned6)left.zero;
																									self.inp.bname				:=	left.blank;
																									self.inp.fein					:=	if((integer)left.blank=0,'',(string9)left.blank);
																									self.inp.bphone				:=	(string10)left.blank;
																									self.inp.bprim_name		:=	left.blank;
																									self.inp.bprim_range	:=	left.blank;
																									self.inp.bst					:=	left.blank;
																									self.inp.bcity_name		:=	left.blank;
																									self.inp.bzip					:=	(string5)left.blank;
																									self.inp.bsec_range		:=	left.blank;
																									self.inp.BDID					:=	(unsigned6)left.zero1;
																									self.FakeID						:=	left.FakeID;
																									self.p								:=	[];
																									self.b								:=	[];
																								) 
																		);
	  
	 
	mod_AKB	:=	module(AutokeyB2.Fn_Build.params) 
								export	dataset(autokey.layouts.master) L_indata	:=	ds_inLayoutMaster_AKB;
								export	string	L_inkeyname												:=	ak_keyname;
								export	string	L_inlogical												:=	ak_logical;
								export	boolean	L_diffing													:=	false;
								export	boolean	L_Biz_useAllLookups								:=	true;
								export	boolean	L_Indv_useAllLookups							:=	true;
								export	boolean	L_by_lookup												:=	true;
								export	boolean	L_skipaddrnorm										:=	false;
								export	boolean	L_skipB2behavior									:=	false;
								export	boolean	L_useOnlyRecordIDs								:=	true;
								export	boolean	L_useFakeIDs											:=	true;
								export	boolean	L_AddCities												:=	true;
								export	integer	L_Biz_favor_lookup								:=	0;
								export	integer	L_Indv_favor_lookup								:=	0;
								export	integer	L_Rep_addr												:=	4;
								export	set of string1	L_build_skip_set 					:=	ak_skipSet;
							end;
	 
	outaction	:=	parallel(	proc_build_payload_key_AKB,
													AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild,AutoKeyI.BuildI_Biz.DoBuild)
												);

	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,mymove,,ak_skipSet)

	retval	:=	sequential(outaction,mymove);

	return	retval;
end;