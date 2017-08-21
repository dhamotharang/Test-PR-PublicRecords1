IMPORT FCRA_list,AID_Build,watchdog,FCRA_OPT_OUT,Suppress,AutoStandardI,risk_indicators,STD;

EXPORT fn_fcra_best_patch(dataset(recordof(watchdog.Layout_Best)) in_fcra_list, boolean is_optout_weekly = false) := module

//Applying the filter on LEXID type 

export ADL_ind_outs := in_fcra_list(ADL_ind in FCRA_list.constants.LEXID_type);

//patch all the rawaids to the same for the same addresses.

hdr_has_rawaid := ADL_ind_outs(~(prim_name != '' and city_name != '' and st != '' and zip != '' and rawaid = 0));
hdr_has_no_rawaid := ADL_ind_outs(prim_name != '' and city_name != '' and st != '' and zip != '' and rawaid = 0);

hdr_dist := DISTRIBUTE(hdr_has_no_rawaid, HASH32(prim_name, prim_range, zip)); 

AIDBase := DEDUP(SORT(
              DISTRIBUTE(PULL(AID_Build.Key_AID_Base), HASH32(prim_name, prim_range, zip5)), 
              prim_name,prim_range,addr_suffix,predir,postdir,sec_range,zip5, LOCAL),
							prim_name,prim_range,addr_suffix,predir,postdir,sec_range,zip5, LOCAL);

hdr_append_rawAID := JOIN(hdr_dist, AIDBase,  
                                 left.prim_name=right.prim_name and left.prim_range=right.prim_range and left.suffix = right.addr_suffix and 
																 left.predir=right.predir and left.postdir=right.postdir and left.sec_range=right.sec_range and
																 left.zip=right.zip5 and right.rawaid>0,
													TRANSFORM(recordof(LEFT),
													self.rawaid := right.rawaid, // specifically want to nuke these to all the same.                       
                          self := left),left outer, LOCAL);	
													
//hit AID macro to append rawAID
/*												
hdr_need_addr_cleaner := hdr_append_rawAID(rawaid = 0);
hdr_no_need_addr_cleaner := hdr_append_rawAID(rawaid != 0);
									
Header.macGetCleanAddr(hdr_need_addr_cleaner , RawAID, false, outfile);*/
														
combine_hdr := hdr_has_rawaid + hdr_append_rawAID;

export RawAID_appended := if(is_optout_weekly, in_fcra_list, combine_hdr);
//Suppressing DID(s)/SSN

appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

Suppress.MAC_Suppress(RawAID_appended,pulled_did,appType,Suppress.Constants.LinkTypes.DID,did);
Suppress.MAC_Suppress(pulled_did,pulled_ssn,appType,Suppress.Constants.LinkTypes.SSN,ssn);

shared suppress_out := pulled_ssn;
// search by did, and if a match not found, flag it
shared suppress_flag := join(distribute(RawAID_appended,hash(did)), distribute(suppress_out,hash(did)),
					left.did = right.DID,
				  transform(FCRA_List.layout_optout.base,  
										self.opt_out_hit:= true,
										self.optout_date := (integer4)((STRING8)Std.Date.Today()),
										self := left),left only, local);

//FCRA optout

shared opt_out_flag := fcra_list.fn_idenfity_opt_outs(suppress_out); 

//combine suppression + optouts

export weekly_optout := suppress_flag + opt_out_flag;

//FCRA monthly build and filter out opt out hit and no best info appended
export monthly_optout := project(opt_out_flag(~opt_out_hit and (fname <> '' or lname <> '' or prim_range <> '' 
or prim_name <> '' or zip <> '' or ssn <> '' or mname <> '')),transform(watchdog.Layout_Best,self := left));


end;






