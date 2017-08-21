import watchdog;

export mac_Append_Ssn(

	 pDataset
	,pDid_Field
	,pSsn_Field
	,pOut_Dataset
	,pIsSsn_String			= 'true'
	,pWatchdogBestFile	= 'Watchdog.File_Best_nonglb'
	
) :=
macro

	#uniquename(Filt)
	#uniquename(dInput_get_ssn		)
	#uniquename(dInput_other)
	#uniquename(djoin2watchdog)

	%Filt% := (								pDataset.pDid_Field != 0 
							and (unsigned)pDataset.pSsn_Field  = 0
					);

	%dInput_get_ssn%	:= pDataset(		%Filt%);
	%dInput_other%		:= pDataset(not %Filt%);
	
	%djoin2watchdog% := join(
		 distribute(%dInput_get_ssn%	,(unsigned6)pDid_Field	)
		,distribute(pWatchdogBestFile	,(unsigned6)did					)
		,(unsigned6)left.pDid_Field = (unsigned6)right.did
		,transform(
			 recordof(pDataset)
			,
			#if(pIsSsn_String = true)
				self.pSsn_Field	:= (string)right.ssn;
			#else
				self.pSsn_Field	:= (unsigned4)right.ssn;
			#end
			 self := left;
		)
		,local
		,left outer
	);
	
	
	pOut_Dataset :=		%djoin2watchdog% 
									+ %dInput_other%
									;

endmacro;