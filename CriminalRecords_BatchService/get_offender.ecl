
IMPORT doxie_files,Address;

EXPORT get_offender(DATASET(Assorted_Layouts.key) payload = DATASET([],Assorted_Layouts.key)) := FUNCTION

//offender key to get did from fake ids (sdid)
  offd_key := doxie_files.key_offenders_OffenderKey();
  Assorted_Layouts.Layout_out xfm_offender(payload L, offd_key R) := TRANSFORM
    SELF.sdid := R.did;
    SELF.output_type := 'O';
    SELF.state_origin := Address.Map_State_Name_To_Abbrev(STD.STR.ToUpperCase(R.orig_state));
    SELF.offender_key := L.offender_key;
    SELF.ssn := R.ssn_appended;
    SELF.pty_typ := R.pty_typ;
    SELF := R;
    SELF := L;
    SELF := [];
  END;
  
    
  ofdkey_field_ak := DEDUP(SORT(JOIN(payload,offd_key,KEYED( LEFT.offender_key = RIGHT.ofk )
                                      // and RIGHT.did <>''
                                      ,xfm_offender(LEFT,RIGHT))
                                      ,sdid,offender_key,-ssn,-lname,-fname,-mname,-prim_range,-predir,
                                      -prim_name,-addr_suffix,-postdir,-sec_range,-p_city_name,-st,-zip5)
                                      ,sdid,offender_key);
/* Debug
output(payload,named('payload'));
output(offd_key,named('offd_key'));
output(ofdkey_field_ak,named('ofdkey_field_ak'));
*/

  RETURN ofdkey_field_ak;

END;


//**** PENALTY CODE

  // CriminalRecords_BatchService.Assorted_Layouts.Layout_out xfm_penalt(ak_input L, ofdkey_field_ak R) := TRANSFORM
   // p := BatchServices.FN_Tra_Penalty_Name(r.fname,r.mname,r.lname,l.name_first,l.name_middle,l.name_last)
                  // +
                  // BatchServices.FN_Tra_Penalty_Address( r.prim_range,
                                                        // r.predir,
                                                        // r.prim_name,
                                                        // r.addr_suffix,
                                                        // r.postdir,
                                                        // r.sec_range,
                                                        // r.p_city_name,
                                                        // r.st,
                                                        // r.zip5
                                                        // ,l.prim_range,
                                                        // l.predir,
                                                        // l.prim_name,
                                                        // l.addr_suffix,
                                                        // l.postdir,
                                                        // l.sec_range,
                                                        // l.p_city_name,
                                                        // l.st,
                                                        // l.z5
                                                      // )
                  // + BatchServices.FN_Tra_Penalty_did(r.sdid,(string)l.did);
    // SELF.penalt := p;
    // SELF := R;
    // SELF := [];
  // END;
  
  // ofdkey_field_1 := JOIN(ak_input,ofdkey_field_ak, LEFT.acctno = RIGHT.acctno
                                         // ,xfm_penalt(LEFT,RIGHT)) + ofdkey_field_doc;
