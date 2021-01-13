EXPORT Get_Transaction_Log_Extension  ( STRING16 TransactionId, 
                                        UNSIGNED8 Lexid,
                                        DATASET(layouts.Payload) ds_Result) := FUNCTION
  slim_global_sid	:= RECORD
    STRING glb_sid;
  END;
  slimmed_ds_Result 							:= PROJECT(ds_Result, TRANSFORM(slim_global_sid, SELF.glb_sid := (STRING)LEFT.global_sid));
  slim_global_sid concat(slim_global_sid L, slim_global_sid R) := TRANSFORM
    SELF.glb_sid 									:= L.glb_sid + ',' + R.glb_sid;
  END;
  all_global_sids 								:= ROLLUP(slimmed_ds_Result,concat(LEFT,RIGHT), RECORD, EXCEPT glb_sid);

  PropertyCharacteristics_Services.Layouts.TransactionLogExtension	tFormatDefaultTransactionLogExtension()	:= TRANSFORM
    SELF.transaction_id						:=	TransactionId;
    SELF.sequence									:=	1;
    SELF.extension_type						:=	Constants.log_extension_type;
    SELF.value										:=	(STRING)Lexid + ',' + all_global_sids[1].glb_sid;
    SELF													:= [];
  END;
  dDefaultTransactionLogExtension	:=	DATASET([tFormatDefaultTransactionLogExtension()]);
  
  PropertyCharacteristics_Services.Layouts.TransactionLogExtensionRec	tFormat2Mbsi(PropertyCharacteristics_Services.Layouts.TransactionLogExtension	pInput)	:=
  TRANSFORM
    SELF.Rec	:=	pInput;
  END;
  dTransactionLogExtension				:=	PROJECT(dDefaultTransactionLogExtension,tFormat2Mbsi(left));

  RETURN	dTransactionLogExtension;
END;