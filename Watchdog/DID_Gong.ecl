import DID_Add,header_slimsort,ut,didville,fair_isaac,_Control,risk_indicators,header;
import header,gong_neustar,header_quick,gong_v2, std;

//Slim the gong file
gng_out := gong_neustar.File_Gong_Full_Prepped_For_Keys;

matchset := ['A','P','Z'];

//DID gong file
/*
DID_Add.MAC_Match_Flex(gng,matchset,junk,junk,name_first,name_middle,
	name_last,name_suffix,prim_range,prim_name,sec_range,z5,st,phone10,
	did,Layout_Gong_DID,false,junk, 
	75,gng_out)
*/	
/*
gng_out := PROJECT(gng, TRANSFORM(gong_neustar.Layout_Gong_Did,
									self.Did := LEFT.did_temp;
									self := LEFT;));
*/
//apply gender

header.Mac_Apply_Title(gng_out, name_prefix, name_first, name_middle, apply_title)
// #55136 Add gong lift (cjs) ***/
gong_v2.Macro_GongLift(apply_title, apply_title_lift, true, false);
// /*** end gong lift ***/
propADL := gong_Neustar.fnPropagateADLs(,,apply_title_lift).base;
//propADL := gong.fnPropagateADLs(,,apply_title).base;

tmp := SEQUENTIAL(
				OUTPUT(propADL,, '~thor_Data400::base::Gong_did::' + workunit, COMPRESSED),
                Std.File.StartSuperFileTransaction(),
                Std.File.ClearSuperFile('~thor_data400::base::gong_did'),
				Std.File.AddSuperFile('~thor_data400::base::gong_did','~thor_Data400::base::Gong_did::' + workunit),
                Std.File.FinishSuperFileTransaction()
				);


pre := if(fileservices.getsuperfilesubcount('~thor_data400::Base::Gong_did_BUILDING')>0,
    output('Nothing added to Base::Gong_did_BUILDING'),
    fileservices.addsuperfile('~thor_data400::Base::Gong_did_BUILDING','~thor_data400::base::gong',,true));

ut.MAC_SF_BuildProcess(propADL,'~thor_data400::BASE::Gong_did',bld,2,,true)

post := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::Gong_did_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::Gong_did_BUILT','~thor_Data400::base::Gong_did_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::Gong_did_BUILDING'));

//Doall := if (fileservices.getsuperfilesubname('~thor_Data400::base::Gong_did_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::gong',1),
//		output('Gong Base = BUILT. Nothing Done.'),
//Doall :=		sequential(pre, bld ,post);
DoAll := tmp;

export DID_Gong := Doall;
