import vehlic;

dProduction		:= vehlic.File_Base_Vehicles_Prod;
dDevelopment	:= vehlic.File_Base_Vehicles_Dev;

rSlim
 :=
  record
	typeof(dProduction.source_code)		source_code;
	typeof(dProduction.orig_state)		orig_state;
	typeof(dProduction.orig_vin)		orig_vin;
	unsigned1	RandomValue	:=	0;
  end
 ;

rSlim	tSlimIt(dProduction pInput)
 :=
  transform
	self				:=	pInput;
  end
 ;

dProductionSlim		:=	project(dProduction(vp_series_name <> ''),tSlimIt(left));
dDevelopmentSlim	:=	project(dDevelopment(vp_series_name <> ''),tSlimIt(left));

dProductionDist		:=	distribute(dProductionSlim,hash(source_code,orig_state,orig_vin));
dProductionSort		:=	sort(dProductionDist,source_code,orig_state,orig_vin,local);
dDevelopmentDist	:=	distribute(dDevelopmentSlim,hash(source_code,orig_state,orig_vin));
dDevelopmentSort	:=	sort(dDevelopmentDist,source_code,orig_state,orig_vin,local);

rSlim	tDevelopmentOnly(dDevelopmentSort pDevelopment, dProductionSort pProduction)
 :=
  transform
	self.RandomValue	:=	random() % 20;
	self				:=	pDevelopment;
  end
 ;

dDevelopmentOnly	:=	join(dDevelopmentSort,dProductionSort,
							 left.source_code = right.source_code and left.orig_state = right.orig_state and left.orig_vin = right.orig_vin,
							 tDevelopmentOnly(left,right),
							 left only,
							 local
							);

dDevelopmentOnlyDedup	:=	dedup(dDevelopmentOnly,source_code,orig_state,RandomValue,all);

export Out_Base_Dev_New_Records_Sample	:=	output(sort(dDevelopmentOnlyDedup,source_code,orig_state),all);