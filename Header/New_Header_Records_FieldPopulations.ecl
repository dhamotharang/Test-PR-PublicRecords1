/*2011-03-17T14:39:02Z (aherzberg)
c:\SuperComputer\Dataland\QueryBuilder\workspace\aherzberg\dataland\Header\New_Header_Records_FieldPopulations\2011-03-17T14_39_02Z.ecl
*/
//BasicMatch is being thrown off by information appended from the Utility file
//Pflag3 was thought to be sufficient because it flags what's been appended
//however bugs 33568 and 33629 go on to explain how those flags can change
//and in turn disrupt what we think was appended

//the thought here is that if we know certain fields aren't populated in new header records
//then we know we can exclude those fields in BasicMatch

//not currently checking for phones in new_header_records because currently
//the header.fn_bm_lr_commonality already allows for one of them to be blank

//utility does not provide dob's at the time of coding

import mdr;
export New_Header_Records_FieldPopulations(boolean pFastHeader = false) := function
nhr := if(pFastHeader, 
					header.File_New_FHeader_Records,
					header.File_New_Header_Records);

r1 := record
	nhr.src;
	src_desc		:= stringlib.stringtouppercase(mdr.sourcetools.translatesource(nhr.src));
	has_ssn_cnt		:= sum(group,if(nhr.ssn<>'',1,0));
	has_phone_cnt	:= sum(group,if(nhr.phone<>'',1,0));
	has_dob_cnt		:= sum(group,if(nhr.dob>0,1,0));
	count_			:= count(group);
end;

//LA and LP sources very low phone appends
ta1 := sort(table(nhr,r1,src,few),src_desc);

return ta1;
end;