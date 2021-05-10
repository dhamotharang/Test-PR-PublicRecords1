IMPORT fcra, Risk_Indicators;


EXPORT Transforms := MODULE

  EXPORT risk_indicators.layout_output add_flags(risk_indicators.Layout_output le) := TRANSFORM
      // NOTE: this code is called when the IID library is in use. when it is disabled, risk_indicators.iid_base_function is used
      // instead. therefore, this transform should be the same.

      // by putting personcontext search first, we can check to make sure we don't add any extra flag records that have already been suppressed in personContext ConsumerStatements dataset
      ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (l_ssn=le.ssn, datalib.NameMatch (le.fname, le.mname, le.lname, fname, mname, lname)<3 and record_id not in set(le.consumerstatements, recidforstid)), risk_indicators.iid_constants.MAX_OVERRIDE_LIMIT);
      did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did=(string)le.did) and record_id not in set(le.consumerstatements, recidforstid) ), Risk_Indicators.iid_constants.MAX_OVERRIDE_LIMIT);
      flags := PROJECT (did_flags, fcra.Layout_override_flag) + PROJECT (ssn_flags, fcra.Layout_override_flag);
      flagrecs := CHOOSEN (dedup (flags, ALL), Risk_Indicators.iid_constants.MAX_OVERRIDE_LIMIT);	

    // for each datagroup, add back the record_id we already have obtained from personContext search earlier
      // SELF.veh_correct_vin                := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),record_id) + le.veh_correct_vin;
      // SELF.veh_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.VEHICLE),flag_file_id);

      SELF.bankrupt_correct_cccn          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),record_id) + le.bankrupt_correct_cccn ;
      SELF.bankrupt_correct_ffid          := SET(flagrecs(file_id = FCRA.FILE_ID.BANKRUPTCY),flag_file_id);
      SELF.lien_correct_tmsid_rmsid       := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),record_id) + le.lien_correct_tmsid_rmsid ;
      SELF.lien_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.LIEN),flag_file_id);
      SELF.crim_correct_ofk               := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),record_id) + 
                                            fcra.functions.GetSexOffendersIDs(le.did, flagrecs(file_id = FCRA.FILE_ID.SO_MAIN)) + le.crim_correct_ofk ;
      SELF.crim_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.OFFENDERS),flag_file_id) + 
                                            SET(flagrecs(file_id = FCRA.FILE_ID.SO_MAIN),flag_file_id);

      SELF.prop_correct_lnfare            := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),record_id) +
                                            SET(flagrecs(file_id = FCRA.FILE_ID.DEED),record_id) + le.prop_correct_lnfare ;
      SELF.prop_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.ASSESSMENT),flag_file_id) +
                                            SET(flagrecs(file_id = FCRA.FILE_ID.DEED),flag_file_id) +
                                            SET(flagrecs(file_id = FCRA.FILE_ID.SEARCH),flag_file_id);
      
      SELF.water_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),flag_file_id) ;
      SELF.water_correct_RECORD_ID        := SET(flagrecs(file_id = FCRA.FILE_ID.WATERCRAFT),record_id)  + le.water_correct_RECORD_ID;
      SELF.proflic_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),flag_file_id) ;
      SELF.proflic_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.PROFLIC),record_id)+ le.proflic_correct_RECORD_ID ;
      SELF.student_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),flag_file_id) + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),flag_file_id);
      SELF.student_correct_RECORD_ID      := SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT),record_id)    + SET(flagrecs(file_id = FCRA.FILE_ID.STUDENT_alloy),record_id) + le.student_correct_RECORD_ID ;
      SELF.air_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),flag_file_id);
      SELF.air_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AIRCRAFT),record_id) + le.air_correct_RECORD_ID ;
      SELF.avm_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),flag_file_id);
      SELF.avm_correct_RECORD_ID          := SET(flagrecs(file_id = FCRA.FILE_ID.AVM),record_id) + le.avm_correct_RECORD_ID ;
      
      SELF.infutor_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),flag_file_id);
      SELF.infutor_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.INFUTOR),record_id) + le.infutor_correct_record_id ;
      SELF.impulse_correct_ffid           := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),flag_file_id);
      SELF.impulse_correct_record_id      := SET(flagrecs(file_id = FCRA.FILE_ID.IMPULSE),record_id) + le.impulse_correct_record_id ;
      SELF.gong_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),flag_file_id);
      SELF.gong_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.GONG),record_id) + le.gong_correct_record_id ;
      
      SELF.advo_correct_ffid              := SET(flagrecs(file_id = FCRA.FILE_ID.advo),flag_file_id);
      SELF.advo_correct_record_id         := SET(flagrecs(file_id = FCRA.FILE_ID.advo),record_id) + le.advo_correct_record_id ;
      SELF.paw_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.paw),flag_file_id);
      SELF.paw_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.paw),record_id) + le.paw_correct_record_id ;
      SELF.email_data_correct_ffid        := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),flag_file_id);
      SELF.email_data_correct_record_id   := SET(flagrecs(file_id = FCRA.FILE_ID.email_data),record_id) + le.email_data_correct_record_id ;
      SELF.inquiries_correct_ffid         := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),flag_file_id);
      SELF.inquiries_correct_record_id    := SET(flagrecs(file_id = FCRA.FILE_ID.inquiries),record_id) + le.inquiries_correct_record_id ;
      
      SELF.ssn_correct_ffid               := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),flag_file_id);
      SELF.ssn_correct_record_id          := SET(flagrecs(file_id = FCRA.FILE_ID.ssn),record_id) + le.ssn_correct_record_id ;
      
      SELF.Death_correct_ffid             := SET(flagrecs(file_id = FCRA.FILE_ID.DID_DEATH),flag_file_id);
      SELF.Death_correct_record_id        := SET(flagrecs(file_id = FCRA.FILE_ID.DID_DEATH),record_id) + le.Death_correct_record_id ;

      SELF.header_correct_record_id       := SET(flagrecs(file_id = FCRA.FILE_ID.hdr),record_id) + le.header_correct_record_id ;
      
      // SELF.ibehavior_correct_ffid					:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),flag_file_id) ;
      // SELF.ibehavior_correct_record_id		:= SET(flagrecs(file_id in [FCRA.FILE_ID.ibehavior_consumer,FCRA.FILE_ID.ibehavior_purchase]),record_id) + le.ibehavior_correct_record_id ;
      
      SELF := le;
    END;

  END;