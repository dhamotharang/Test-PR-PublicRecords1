export MAC_Vina_Unique_Candidates(pDateTimeStamp)
 :=
  macro

// Spray vina candidates
zSprayCandidates	:=	lib_fileservices.FileServices.sprayfixed(_control.IPAddress.edata12,
																 '/data_999/vin_stuff/processed/' + pDateTimeStamp + '/vina_candidates.d00',
																 23,
																 _control.TargetGroup.ADL_400,
																 '~thor_data400::in::vehreg_vina_candidates',
																 ,
																 ,
																 ,
																 true,		// overwrite
																 false		// replicate - don't bother... it's going away afterwards
																);

rVINA_Candidates
 :=
  record
	string22	vin;
	string1		lf;
  end
 ;

dCandidates		:=	dataset('~thor_data400::in::vehreg_vina_candidates',rVINA_Candidates,thor,unsorted);
dCandidatesDist	:=	distribute(dCandidates,hash(vin));
dCandidatesSort	:=	sort(dCandidatesDist,vin,local);
dCandidatesDedup:=	dedup(dCandidatesDist,vin,local);
dVINADist		:=	distribute(vehlic.File_VINA,hash(vin_input[1..22]));
dVINASort		:=	sort(dVINADist,vin_input,local);
dVINADedup		:=	dedup(dVINASort,vin_input,local);

rVINA_Candidates	tGetCandidates(dCandidatesDedup Pcandidates, dVINADedup pVINA)
 :=
  transform
	self.vin	:=	pCandidates.vin;
	self.lf		:=	'\n';
  end
 ;

dNewVINS		:=	join(dCandidatesDedup,dVINADedup,
						 left.vin = right.vin_input,
						 tGetCandidates(left,right),
						 left only,
						 local
						);

zOutputNewVINS	:=	output(dNewVINS,,'~thor_data400::out::vehreg_vina_candidates_new');

// Despray new vins
zDesprayNewVINS		:=	lib_fileservices.FileServices.despray('~thor_data400::out::vehreg_vina_candidates_new',
															  _control.IPAddress.edata12,
															  '/data_999/vin_stuff/processed/' + pDateTimeStamp + '/vins_to_process_new.d00',
															  ,
															  ,
															  ,
															  true
															 );
// Delete both files
zDeleteBothFiles
 :=
  sequential
	(
	 lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::in::vehreg_vina_candidates'),
	 lib_fileservices.FileServices.DeleteLogicalFile('~thor_data400::out::vehreg_vina_candidates_new')
	)
 ;
	 
sequential
 (
	zSprayCandidates,
	zOutputNewVINS,
	zDesprayNewVINS,
	zDeleteBothFiles
 );	

  endmacro
 ;