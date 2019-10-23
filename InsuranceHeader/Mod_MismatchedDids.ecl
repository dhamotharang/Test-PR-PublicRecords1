numper := 50;		//how many samples to each person
folks := ['Manish', 'Chad', 'Allen', 'David', 'Wenhong', 'Ayeesha', 'Michelle', 'Jose']; //those who will review
numfolks := 8;	//i could just count here, but there are two other places in the code where i would need to update by hand if this changed

import idl_header;
export Mod_MismatchedDids(dataset(idl_header.Layout_Header_link) insHdr, 
												dataset(idl_header.Layout_Header_boca) bocaHdr, 
												string pass_sffx = '') := module

//***** GENERATE A SAMPLE FOR EACH PERSON AFTER GETTING RID OF ANY OVERLAP
numneeded := numper * numfolks;

 //clean up the rules first to make sure we get a good sample
mod_InsvsBoca := Mod_InsHeaderVsBoca(insHdr, bocaHdr, 5);

mismatch := mod_InsvsBoca.mismatchedDids;
re := enth(mismatch, numneeded);
rseq := project(re, transform({re, unsigned2 seq}, self.seq := counter, self := left));

// Ins record
rec_ins := {unsigned2 GroupID, idl_header.Layout_Header_link};
rec_ins tra1(insHdr l, rseq r) := transform
	self.GroupID := r.seq;
	self := l;
end;
j1_ins  := join(insHdr, rseq, left.did = right.did_ins, tra1(left, right), lookup);

// Boca record
rec_boca := {unsigned2 GroupID, idl_header.Layout_Header_boca};
rec_boca tra2(bocaHdr l, rseq r) := transform
	self.GroupID := r.seq;
	self := l;
end;
j1_boca  := join(bocaHdr, rseq, left.did = right.did_boca, tra2(left, right), lookup);


f_mismatchdid(unsigned2 i) := function
	start := (i-1)*numper;
	stop := i*numper;
	return output(sort(rseq(seq > start and seq <= stop), did_ins), named('HeaderMatchSamples_MismatchDIDs'+pass_sffx+folks[i]),all);
end;

f_ins(unsigned2 i) := function
	start := (i-1)*numper;
	stop := i*numper;
	return output(sort(j1_ins(GroupID > start and GroupID <= stop), did, rid), named('HeaderMatchSamples_Insurance'+pass_sffx+folks[i]),all);
end;

f_boca(unsigned2 i) := function
	start := (i-1)*numper;
	stop := i*numper;
	return output(sort(j1_boca(GroupID > start and GroupID <= stop), did, rid), named('HeaderMatchSamples_Boca'+pass_sffx+folks[i]),all);
end;

f(unsigned2 i) := function
	action := parallel(f_mismatchdid(i), f_ins(i), f_boca(i));
	return action;
end;

export samples := 
	parallel(
		f(1), f(2), f(3), f(4), f(5), f(6), f(7), f(8)
	);

sendto 	:= 
// 'rt@isit.br.seisint.com';
'manish.shah@lexisnexis.com';
subject := '[isit.seisint.com #114917]';
body		:= 
folks[1] + ', ' + 'here is a new set of IDL matches for you to review: \nhttp://10.194.10.2:8010/?inner=../WsWorkunits/WUInfo?Wuid=' + thorlib.wuid();
export email := FileServices.SendEmail( sendto, subject, body);

//***** DO BOTH SAMPLES AND EMAIL
export DoALL := 
	sequential(
		samples,
		email
	);

END;

/*
ds_ins := dataset ('~thor_data400::base::insuranceheader::idl_salt_iter_14', idl_header.Layout_Header_Link, flat);
ds_boca := DATASET('~thor_data400::persist::InsuranceHeader::HeaderRecords::BocaDataset_org', idl_header.Layout_Header_Boca,flat);
mod_mismatch := InsuranceHeader.Mod_MismatchedDids(ds_ins, ds_boca);
mod_mismatch.DoAll;
*/