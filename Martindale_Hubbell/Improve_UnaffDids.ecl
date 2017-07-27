import header;

dhdr_nonGLB := dataset(header.Filename_Header,header.Layout_Header_v2,flat);

export Improve_UnaffDids(

	 dataset(layouts.Base.Unaffiliated_Individuals) pUnaffBase		= Files().base.Unaffiliated_Individuals.qa
	,dataset(header.Layout_Header_v2							) pHeaderBase 	= dhdr_nonGLB(header.isPreGLB(dhdr_nonGLB))
	,string																					pISLN_Filter	= ''
	
) :=
function
	layslimmh := 
	record

		string20	lname					;
		string20 	fname 				;
		string20	mname					;
		string2		mail_st				;
		string2 	loc_st 				;
		string2 	admit_st 			;
		string4		born_year			;
		string25	mail_city			;
		string25	loc_city			;
		string		ISLN					;
	end;

	layhdrextra := 
	record
		string20  mname;
		integer4  dob;
		string25  city_name;
		string10  phone;
		string2   st;
	end;
	
	layslim := 
	record

		unsigned8		cnt;
		integer1		score;
		integer1		mname_score;
		unsigned6		Did													:= 0;
		unsigned1		did_score										:= 0;
		layslimmh		mh_fields;
		layhdrextra	hdr_fields;
		
	end;

	layextra := layouts.temporary.unaff_redid;

	daffbase_counter 				:= project(pUnaffBase, transform(layextra,self.cnt := counter;self := left;self := [])) : global;

	dimprovedids1 := fGetUnaffDids(daffbase_counter	,pHeaderBase,pISLN_Filter,['MA','LA','FN']);
	dimprovedids2 := fGetUnaffDids(dimprovedids1		,pHeaderBase,pISLN_Filter,['MA','LA','IA']);
	
	return distribute(dimprovedids2,random());
end;