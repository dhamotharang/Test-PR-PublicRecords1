/*2012-11-05T21:35:56Z (Shannon Lucero)

*/
import AutoKeyB2, RoxieKeyBuild;

export proc_build_bid_keys(string filedate, boolean isFCRA = false) := function


// clear qa keys
a1:= parallel(
fileservices.clearsuperfile('~thor_data400::key::atf::firearms::bid_qa'),
fileservices.clearsuperfile('~thor_data400::key::atf::firearms::bid::atfid_qa')

//clear fcra qa keys
// fileservices.clearsuperfile('~thor_data400::key::atf::firearms::fcra::qa::bid'),
// fileservices.clearsuperfile('~thor_data400::key::atf::firearms::fcra::qa::bid::atfid')
);


// ********************************************
// build index files
a2 := sequential(
buildindex(ATF.key_atf_bid(),'~thor_data400::key::atf::firearms::'+filedate+'::bid',OVERWRITE),
buildindex(ATF.key_ATF_id_bid(),'~thor_data400::key::atf::firearms::'+filedate+'::bid::atfid',OVERWRITE)

//build fcra index files
// buildindex(ATF.key_atf_bid(true),'~thor_data400::key::atf::firearms::fcra::'+filedate+'::bid',OVERWRITE),
// buildindex(ATF.key_ATF_id_bid(true),'~thor_data400::key::atf::firearms::fcra::'+filedate+'::bid::atfid',OVERWRITE)
);
// **************************************
// add key to QA key

a3:= sequential(
FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::key::atf::firearms::bid_qa', '~thor_data400::key::atf::firearms::'+filedate+'::bid'),
FileServices.FinishSuperFileTransaction()
);

a4:= sequential(
FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::key::atf::firearms::bid::atfid_qa', '~thor_data400::key::atf::firearms::'+filedate+'::bid::atfid'),
FileServices.FinishSuperFileTransaction()
);

// add fcra key to QA key
// a5:= sequential(
// FileServices.StartSuperFileTransaction(),
// FileServices.AddSuperFile('~thor_data400::key::atf::firearms::fcra::qa::bid', '~thor_data400::key::atf::firearms::fcra::'+filedate+'::bid'),
// FileServices.FinishSuperFileTransaction()
// );

// a6:= sequential(
// FileServices.StartSuperFileTransaction(),
// FileServices.AddSuperFile('~thor_data400::key::atf::firearms::fcra::qa::bid::atfid', '~thor_data400::key::atf::firearms::fcra::'+filedate+'::bid::atfid'),
// FileServices.FinishSuperFileTransaction()
// );

//Create autokeys

import atf,standard;
c := ATF.atf_autokey_constants(filedate); 

// ak_keyname  := if(isFCRA,c.bid_ak_keyname_fcra,c.bid_str_autokeyname);
// ak_logical  := if(isFCRA,c.bid_ak_logical_fcra,c.bid_ak_logical);
// ak_dataset  := if(isFCRA,c.bid_ak_dataset_fcra,c.bid_ak_dataset);

ak_keyname  := c.bid_str_autokeyname;
ak_logical  := c.bid_ak_logical;
ak_dataset  := c.bid_ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

// To build the updated keys

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
File_ATF_Autokey := normalize(File_ATF_autoKey_1, 2,Norm2(Left,counter)): PERSIST('persist::ATF_firearms_bid_autokeybase');

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
                     bld_auto_keys,false,
                     ak_skipSet,true,ak_typeStr,
                     true,,,zero);
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipSet)

update_version := RoxieKeyBuild.updateversion('ATFBidKeys',filedate,'cthompson@seisint.com;kgummadi@seisint.com',,'N');

retval := sequential(a1,a2,parallel(a3,a4/*,a5,a6*/),bld_auto_keys,mymove/*,update_version*/);

return retval;

end;