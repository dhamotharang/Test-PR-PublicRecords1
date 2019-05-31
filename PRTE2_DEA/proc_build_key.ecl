IMPORT ut,RoxieKeyBuild,AutoKeyB2,PRTE2_DEA,Prte2_common,Prte,_control;//,DEA;

EXPORT proc_build_key(string filedate) := FUNCTION

	//seq_name is the out or return value
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(PRTE2_DEA.KEYS.Key_dea_did, constants.KeyName_DEA + '@version@::did',constants.KeyName_DEA + filedate + '::did',b);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(PRTE2_DEA.KEYS.Key_dea_bdid,constants.KeyName_DEA + '@version@::bdid',constants.KeyName_DEA + filedate + '::bdid',c);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(PRTE2_DEA.KEYS.Key_dea_linkids.Key,constants.KeyName_DEA + '@version@::linkids',constants.KeyName_DEA + filedate + '::linkids',d);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(PRTE2_DEA.KEYS.Key_dea_reg_num,constants.KeyName_DEA + '@version@::reg_num',constants.KeyName_DEA + filedate + '::reg_num',e);
	

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_DEA + '@version@::did',constants.KeyName_DEA + filedate + '::did', b1);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_DEA + '@version@::bdid',constants.KeyName_DEA + filedate + '::bdid', c1);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_DEA + '@version@::linkids',constants.KeyName_DEA + filedate + '::linkids', d1);
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.KeyName_DEA + '@version@::reg_num',constants.KeyName_DEA + filedate + '::reg_num', e1);
	
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_DEA + '@version@::did', 'Q', b2);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_DEA + '@version@::bdid', 'Q', c2);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_DEA + '@version@::linkids', 'Q', d2);
	RoxieKeyBuild.MAC_SK_Move_v2(constants.KeyName_DEA + '@version@::reg_num', 'Q', e2);
	
	b_in :=   PRTE2_DEA.Files.File_DEA;

	sep_rec := record
	b_in;
	string10 cprim_range;
	string28 cprim_name;
	string8  csec_range;
	string25 cv_city_name;
	string2  cst;
	string5  czip;
	unsigned1 zero := 0;
	unsigned6 inDID;
	unsigned6 inBDID;
	end;

	sep_rec into_bus(b_in L) := transform
		 self.prim_range := if(l.is_company_flag,'',l.prim_range);
		 self.prim_name := if(l.is_company_flag,'',l.prim_name);
		 self.sec_range := if(l.is_company_flag,'',l.sec_range);
		 self.v_city_name := if(l.is_company_flag,'',l.v_city_name);
		 self.st := if(l.is_company_flag,'',l.st);
		 self.zip := if(l.is_company_flag,'',l.zip);
		 self.cprim_range := if(l.is_company_flag,l.prim_range,'');
		 self.cprim_name := if(l.is_company_flag,l.prim_name,'');
		 self.csec_range := if(l.is_company_flag,l.sec_range,'');
		 self.cv_city_name := if(l.is_company_flag,l.v_city_name,'');
		 self.cst := if(l.is_company_flag,l.st,'');
		 self.czip := if(l.is_company_flag,l.zip,'');
		 self.inDID := (unsigned6)l.did;
		 self.inBDID := (unsigned6)l.bdid;
		 self := l;
	end;

	b_out := project( b_in, into_bus(left));

	skip_set := constants.skip_set;

	AutoKeyB2.MAC_Build (b_out,
						fname,mname,lname,
						best_ssn,
						zero,
						zero,
						prim_name,prim_range,st,v_city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						inDID,
						cname,
						zero,
						zero,
						cprim_name,cprim_range,cst,cv_city_name,czip,csec_range,
						inbdid,
						Constants.ak_keyname,
						Constants.ak_logical(filedate),
						outaction,false,
						skip_set,true,,
						true,,,zero) 

	AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, skip_set)

	retval := 	sequential(outaction,mymove);
	
	//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because we are not in PROD'); 
	updatedops					:= PRTE.UpdateVersion('DEAkeys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,updatedops,NoUpdate);
		
	RETURN 		sequential(b,c,d,e,b1,c1,d1,e1,b2,c2,d2,e2,retval,PerformUpdateOrNot);

END;