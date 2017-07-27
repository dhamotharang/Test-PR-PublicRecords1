import header;

dhdr_nonGLB := dataset(header.Filename_Header,header.Layout_Header_v2,flat);

export Improve_AffDids(

	 dataset(layouts.Base.Affiliated_Individuals	) pUnaffBase		= Files().base.Affiliated_Individuals.qa
	,dataset(header.Layout_Header_v2							) pHeaderBase 	= dhdr_nonGLB(header.isPreGLB(dhdr_nonGLB))
	,string																					pISLN_Filter	= ''
	
) :=
function

	layextra := layouts.temporary.aff_redid;

	daffbase_counter 				:= project(pUnaffBase, transform(layextra,self.cnt := counter;self := left;self := [])) : global;

	dimprovedids1 := fGetDids(daffbase_counter	,pHeaderBase,pISLN_Filter,['MA','LA','FN']);
	dimprovedids2 := fGetDids(dimprovedids1			,pHeaderBase,pISLN_Filter,['MA','LA','IA']);
	
	dimprove_dist := distribute(dimprovedids2,random());

	return dimprove_dist;
	
end;