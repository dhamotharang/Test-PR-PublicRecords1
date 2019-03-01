IMPORT BIPV2;
EXPORT modSources := MODULE
 EXPORT dHeaderSource := PROJECT(BIPV2.CommonBase.ds_built, TRANSFORM(BIPV2.CommonBase.Layout, SELF:=LEFT, SELF:=[]));
 EXPORT dTopBusiness	:= DATASET('~thor::bipheader::qa::topBusiness', modLayouts.lSrcLayout, THOR);//src := 'T'
 EXPORT dPreFill			:= DATASET('~thor::bipheader::qa::prefill_inquiries', modLayouts.lSrcLayout, THOR);//src := 'P'
 EXPORT dSAOTData 		:= DATASET('~thor::bipheader::qa::saotDataSample', modLayouts.lSrcLayout, THOR);//src := 'T1','T2','T3','T4','T5'
END;

