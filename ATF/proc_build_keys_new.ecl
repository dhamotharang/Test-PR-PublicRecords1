import AutoKeyB2, RoxieKeyBuild,PromoteSupers,standard,_Control;

export proc_build_keys_new(string filedate, boolean isFCRA = false) := function

pre :=if (fileservices.getsuperfilesubcount('~thor_Data400::base::atf_firearms_explosives_BUILDING') > 0
				,output('Nothing added to BUILDING Superfile')
				,fileservices.addsuperfile('~thor_Data400::base::atf_firearms_explosives_BUILDING','~thor_data400::base::atf_firearms_explosives',0,true));

pre1 := output(atf.file_firearms_explosives_keybase,,'~thor_data400::base::atf::firearms_expl::phone_suppression',overwrite,compressed);

post:=fileservices.clearsuperfile('~thor_Data400::base::atf_firearms_explosives_BUILDING');

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_atf_did(),'~thor_data400::key::atf::firearms::did','~thor_data400::key::atf::firearms::'+filedate+'::did',B1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_atf_bdid(),'~thor_data400::key::atf::firearms::bdid','~thor_data400::key::atf::firearms::'+filedate+'::bdid',B2);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_atf_lnum(),'~thor_data400::key::atf::firearms::lnum','~thor_data400::key::atf::firearms::'+filedate+'::lnum',B3);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_ATF_id(),'~thor_data400::key::atf::firearms::atfid','~thor_data400::key::atf::firearms::'+filedate+'::atfid',B4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_linkids.key,'~thor_data400::key::atf::firearms::linkids','~thor_data400::key::atf::firearms::'+filedate+'::linkids',B5);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::did','~thor_data400::key::atf::firearms::'+filedate+'::did',M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::bdid','~thor_data400::key::atf::firearms::'+filedate+'::bdid',M2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::lnum','~thor_data400::key::atf::firearms::'+filedate+'::lnum',M3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::atfid','~thor_data400::key::atf::firearms::'+filedate+'::atfid',M4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::linkids','~thor_data400::key::atf::firearms::'+filedate+'::linkids',M5);


PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::did','Q',MQ1,2);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::bdid','Q',MQ2,2);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::lnum','Q',MQ3,2);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::atfid','Q',MQ4,2);
PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::linkids','Q',MQ5,2);

ThorName:=if(_Control.ThisEnvironment.Name='Dataland','thor400_sta01','thor400_44');

fcopy :=	sequential(
			fileservices.clearsuperfile('~thor_data400::key::atf::firearms::fcra::qa::did',true)
			,fileservices.Copy('~thor_data400::key::atf::firearms::'+filedate+'::did', ThorName, '~thor_data400::key::atf::firearms::fcra::'+filedate+'::did',,,,,true,,true)
			,fileservices.addsuperfile('~thor_data400::key::atf::firearms::fcra::qa::did','~thor_data400::key::atf::firearms::fcra::'+filedate+'::did')
			,fileservices.clearsuperfile('~thor_data400::key::atf::firearms::fcra::qa::atfid',true)
			,fileservices.Copy('~thor_data400::key::atf::firearms::'+filedate+'::atfid', ThorName, '~thor_data400::key::atf::firearms::fcra::'+filedate+'::atfid',,,,,true,,true)
			,fileservices.addsuperfile('~thor_data400::key::atf::firearms::fcra::qa::atfid','~thor_data400::key::atf::firearms::fcra::'+filedate+'::atfid')
			);

c := ATF.atf_autokey_constants(filedate); 

ak_keyname  := c.str_autokeyname;
ak_logical  := c.ak_logical;
ak_dataset  := c.ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

f1 := ak_dataset;

layout_autokey := record
		ak_dataset;
end;

layout_autokey Norm1 (f1 L,integer c) := transform
    self.Business_Name:=if(c=1,l.Business_Name,l.License_Name);
		self.license1_fname:=if(c=1,l.license1_fname,l.license2_fname);
		self.license1_mname:=if(c=1,l.license1_mname,l.license2_mname);
		self.license1_lname:=if(c=1,l.license1_lname,l.license2_lname);
		self.license1_name_suffix:=if(c=1,l.license1_name_suffix,l.license2_name_suffix);		
		self := L;
end;

File_ATF_autoKey_1 := normalize(f1, 2,Norm1(Left,counter));

layout_autokey Norm2 (File_ATF_autoKey_1 L,integer c) := transform
    self.premise_prim_range :=if(c=1,l.premise_prim_range,l.mail_prim_range);
		self.premise_predir :=if(c=1,l.premise_predir,l.mail_predir);
		self.premise_prim_name :=if(c=1,l.premise_prim_name,l.mail_prim_name);
		self.premise_suffix:=if(c=1,l.premise_suffix,l.mail_suffix);
		self.premise_postdir:=if(c=1,l.premise_postdir,l.mail_postdir);
		self.premise_unit_desig:=if(c=1,l.premise_unit_desig,l.mail_unit_desig);
		self.premise_sec_range:=if(c=1,l.premise_sec_range,l.mail_sec_range);
		self.premise_p_city_name:=if(c=1,l.premise_p_city_name,l.mail_p_city_name);
		self.premise_st:=if(c=1,l.premise_st,l.mail_st);
		self.premise_zip:=if(c=1,l.premise_zip,l.mail_zip);
		self.premise_zip4:=if(c=1,l.premise_zip4,l.mail_zip4);
		self := L;
end;

File_ATF_Autokey_0 := normalize(File_ATF_autoKey_1, 2,Norm2(Left,counter));
File_ATF_Autokey := dedup(distribute(File_ATF_Autokey_0,hash(license_number)),record,all,local): PERSIST('persist::ATF_firearms_autokeybase');

AutoKeyB2.MAC_Build (File_ATF_Autokey,license1_fname,license1_mname,license1_lname,
                     best_ssn,
                     zero,
                     blank,
                     premise_prim_name,
                     premise_prim_range,
                     premise_st,
                     premise_p_city_name,
                     premise_zip,
                     premise_sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     did_out6,
                     Business_Name, // compname which is string thus "blank"
                     zero,
                     zero,
                     premise_prim_name,premise_prim_range,premise_st,premise_p_city_name,premise_zip,premise_sec_range,
                     bdid6, // bdid_out
                     ak_keyname,
                     ak_logical,
                     BAK,false,
                     ak_skipSet,true,ak_typeStr,
                     true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, MAK,, ak_skipSet);

return sequential(
									pre
									,pre1
									,parallel(B1,B2,B3,B4,B5)
									,parallel(M1,M2,M3,M4,M5)
									,parallel(MQ1,MQ2,MQ3,MQ4,MQ5)
									,fcopy
									,BAK
									,MAK
									,post
									);

end;