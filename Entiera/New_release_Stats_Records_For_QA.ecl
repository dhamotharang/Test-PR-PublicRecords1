
 import _Control;

dPrev	:= 	dataset('~thor_200::base::entiera::basefilew20080626-100400',entiera.All_Entiera_Layouts.Entiera_final_layout,flat);
dNew :=  dataset('~thor_200::base::entiera::basefilew20080929-153431',entiera.All_Entiera_Layouts.Entiera_final_layout,flat);


		oldds 	  := sort(distribute(dPrev		,hash(orig_pmghousehold_id,orig_pmgindividual_id)),orig_pmghousehold_id,orig_pmgindividual_id,local);
		newds		  := sort(distribute(dNew	    ,hash(orig_pmghousehold_id,orig_pmgindividual_id)),orig_pmghousehold_id,orig_pmgindividual_id,local);

		entiera.All_Entiera_Layouts.Entiera_final_layout tGetStandardizedAddress( newds l	,  oldds r) :=
		transform



			self 								:= l;
		
		end;
		
		dlatest	:= join(
																 newds
																,oldds
																,left.orig_pmghousehold_id = right.orig_pmghousehold_id and
																 left.orig_pmgindividual_id = right.orig_pmgindividual_id
																,tGetStandardizedAddress(left,right)
																,local
																,left only
															);




output(dlatest(did!=0 and best_ssn !='' and best_dob!=0 and process_date='20080924'));



