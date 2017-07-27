/*2005-08-11T16:19:41Z (Chad Morton)
for bug report
*/
import doxie_cbrs;
export getSupergroup(
	unsigned6 thebdid,
	boolean use_Levels_val = false,
	dataset(doxie_cbrs.layout_references) bdids = dataset([], doxie_cbrs.layout_references)) :=
	function
		in_bdids := project(bdids, transform(doxie_cbrs.layout_supergroup, self := LEFT, self := []));
		in_single_bdid := dataset([{
																0,
																thebdid,
																0}],
																doxie_cbrs.layout_supergroup);
		use_bdids := if(exists(in_bdids), in_bdids, in_single_bdid);

		return doxie_cbrs.fn_getSupergroup(use_bdids,use_levels_val);
	end;
