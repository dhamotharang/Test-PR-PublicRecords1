/*
filestobedeleted := 
dataset([
 ('~thor_data400::base::emerges_new_clean_names')
,('~thor_data400::base::ucc_filing_place')
,('~thor_200::base::business_relatives_sample_blankdates')
,('~thor_200::base::business_relatives_sample')
,('~thor_200::base::business_header_sample')
,('~thor_200::base::business_header_sample_blankdates')
,('~thor_200::base::business_header_stat_sample')
,('~thor_200::base::business_header_stat_sample_blankdates')
,('~thor_data400::base::ucc_filing_place_20051111')
,('~thor_200::base::business_relatives_group_sample')
,('~thor_200::base::business_relatives_group_sample_blankdates')
,('~thor_data400::base::business_header_stat_overflow')

], versioncontrol.layout_names);

fDeleteFiles(filestobedeleted);
*/
export fDeleteFiles(dataset(versioncontrol.Layout_Names) pFilesToDeleted) :=
function

	return nothor(apply(pFilesToDeleted, versioncontrol.mUtilities.DeleteLogical(name)));

end;