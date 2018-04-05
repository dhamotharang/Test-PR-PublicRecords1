/*2008-04-25T14:41:19Z (Faisal_prod Humayun)
Per Tony Kirk/Supercomputer services thor400_84 is the correct new cluster replacement for thor_dell400_2
Giri is on vacation, and I made this correction to fix the build.
*/
import did_add,ut,header_slimsort,lib_stringlib, watchdog, didville, fair_isaac, Drivers,mdr,header;

dlj := DriversV2.DL_Update;

dl_file := project(dlj, transform(DriversV2.Layout_Base_withAID, self.did := 0, self := left));

// generating a sequence number for "dl_seq"
ut.MAC_Sequence_Records(dl_file,dl_seq,dl_file_seq);

//add src 

src_rec := record
header_slimsort.Layout_Source;
DriversV2.Layout_Base_withAID;
end;

DID_Add.Mac_Set_Source_Code(dl_file_seq, src_rec, 'DR', dl_file_seq_src)

matchset := ['A','D','S'];

did_add.MAC_Match_Flex
	(dl_file_seq_src, matchset,						//see above
	 ssn_safe, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, st, JUNK,
	 DID,
	 src_rec, 
	 false, DID_Score_field,						//*if outrec has scores, these will always be zero
	 75,
	 res,true,src)

DriversV2.Layout_Base_withAID lFieldTransform(src_rec l) := TRANSFORM
self.restrictions_delimited := if(l.restrictions_delimited <> '',
								  l.restrictions_delimited,
								  l.Restrictions[1] + 
									if(l.Restrictions[2]<>' ',','+l.Restrictions[2],'') +
									if(l.Restrictions[3]<>' ',','+l.Restrictions[3],'') + 
									if(l.Restrictions[4]<>' ',','+l.Restrictions[4],'') +
									if(l.Restrictions[5]<>' ',','+l.Restrictions[5],'') +
									if(l.Restrictions[6]<>' ',','+l.Restrictions[6],'') + 
									if(l.Restrictions[7]<>' ',','+l.Restrictions[7],'') + 
									if(l.Restrictions[8]<>' ',','+l.Restrictions[8],'') + 
									if(l.Restrictions[9]<>' ',','+l.Restrictions[9],'') +
									if(l.Restrictions[10]<>' ',','+l.Restrictions[10],'')
								 );
self := l;
END;

res_safe := PROJECT(res, lFieldTransform(left));

DID_Add.MAC_Add_SSN_By_DID(res_safe,did,ssn,with_ssn)

//export DL := with_ssn : persist('~thor_data400::Persist::DrvLic_DLs_With_DIDs','thor400_84');
export DL := with_ssn : persist('~thor_data400::Persist::DrvLic_DLs_With_DIDs');
//export DL := with_ssn : persist('~thor_data400::Persist::DrvLic_DLs_With_DIDs','thor40_241');
