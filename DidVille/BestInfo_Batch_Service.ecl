/*--SOAP--
<message name="BestInfo_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="AppendAddress" type="xsd:boolean"/>
  <part name="AppendPhone" type="xsd:boolean"/>
  <part name="UseNameUniqueDID" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service returns best address and phone etc.*/


import doxie, header, ut;

export BestInfo_Batch_Service := macro

doxie.MAC_Header_Field_Declare()

hdr_ver := (unsigned)thorlib.getenv('header_file_version','0');
util_ver := (unsigned)thorlib.getenv('utility_file_version','0');

//keep quick header version <= utility version
qkh_init_ver := (unsigned)thorlib.getenv('quick_file_version','0');
qkh_ver := map(qkh_init_ver > util_ver => util_ver,
               qkh_init_ver < hdr_ver =>  hdr_ver,
               qkh_init_ver);

//utililty version should be >= header version
ret_ver := if(util_ver>hdr_ver, util_ver, hdr_ver);

//use seqeunce number, classify inputs for different match
f_in_raw := dataset([],DidVille.Layout_BestInfo_BatchIn) : stored('batch_in',few);
use_nd_val := false : stored('UseNameUniqueDID');

in_seq_rec := record
     unsigned6 seq := 0;
	didville.layout_bestInfo_batchin;
end;

f_in_seq_init := project(f_in_raw, transform({in_seq_rec}, self := left));
ut.MAC_Sequence_Records(f_in_seq_init, seq, f_in_seq);

f_in := project(f_in_seq, transform({didville.layout_bestInfo_batchin},
                                     self.acctno := (qstring20)left.seq, self := left));

f_in_triple := f_in((unsigned)version_number<hdr_ver);
f_in_double := f_in((unsigned)version_number>=hdr_ver,(unsigned)version_number<qkh_ver);
f_in_single := f_in((unsigned)version_number>=qkh_ver,(unsigned)version_number<util_ver);

tpl_best_ready := didville.All_recs.get_tpl(f_in_triple,use_nd_val,,,true,true,true);

header.MAC_Best_Address_Moxie(tpl_best_ready, did, 1, tpl_best,true,true);

dbl_best_ready := didville.All_recs.get_dbl(f_in_double);

header.MAC_Best_Address_Moxie(dbl_best_ready, did, 1, dbl_best,true,true);

sgl_ready := didville.All_recs.get_sgl(f_in_single);

header.MAC_Best_Address_Moxie(sgl_ready, did, 1, sgl_best,true,true);

//final mapping for the outputs
out_ready := (tpl_best + dbl_best+ sgl_best)(prim_name<>'');

didville.Layout_BestInfo_BatchOut get_outrc(f_in_seq l, out_ready r) := transform
	self.version_number := (string20)ret_ver;
  self.name_first := r.fname;
	self.name_middle := r.mname;
	self.name_last := r.lname;
	self.p_city_name := r.city_name;
	self.unit_desig := if(r.sec_range='', '', r.unit_desig);
	self.z5 := r.zip;
	self.dob := if(r.dob=0,'',(string8)r.dob);
	self.addr_dt_last_seen := if(r.dt_last_seen=0,'',(string6)r.dt_last_seen);
	self.phone10 := '';
	self := r;
	self.acctno := l.acctno;
	self := [];
end;

out_recs := join(f_in_seq, out_ready,
                 left.seq=right.did,
                 get_outrc(left, right), left outer, keep(1));

output(out_recs, named('Results'));

endmacro;
