import PromoteSupers,dnb_feinv2; 

export proc_build_main_base(string filedate) := function

//join main file and in file - right outer

inds   := dnb_feinv2.Mapping_as_base_main(filedate);
baseds := dnb_feinv2.File_DNB_Fein_base_main_new;

string_rec := record 
	typeof(inds.tmsid) tmsid; 
	end;

string_rec join_recs(baseds l,inds r) := transform
    self := r;
	end;

lookup_tmsid := join(baseds,inds,left.tmsid = right.tmsid,
                         join_recs(left,right),right only);
						 

//Sample Records for QA						 
SampleRecords := output(choosen(lookup_tmsid,1000)) : success(output('Sample Of New Records for QA.'));

PromoteSupers.MAC_SF_BuildProcess(DNB_FEINv2.DNB_FEIN_BDID(inds),
                       '~thor_data400::base::main::dnb_fein', bld_dnbfein_main,3,,true);
                         
retval := sequential(SampleRecords, bld_dnbfein_main);

return retval;

end;
