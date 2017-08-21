import _control;

export proc_DKCMoxieKeys(string dkc_volume) := function

dkc_server_name := _control.IPAddress.edata11;

create_keys :=
sequential(
output('Start_MOXIE_Keybuild', named('Moxie_Status__')),
parallel(
				Gong_v2.proc_build_moxie_fpos_data_key,
				Gong_v2.proc_build_moxie_cnKeys,
				Gong_v2.proc_build_moxie_lfmnameKeys,
				Gong_v2.proc_build_moxie_lnKeys,
	            Gong_v2.proc_build_moxie_pcnKeys,
				Gong_v2.proc_build_moxie_phoneKeys,
				Gong_v2.proc_build_moxie_phoneticKeys),
output('Start_MOXIE_DKC', named('Moxie_Status_')),
parallel(
fileservices.DKC('~thor_200::key::moxie::gong.area.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.area.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.area.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.area.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.area.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.area.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.area.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.area.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.bell_id.group_id.group_seq.key', dkc_server_name, dkc_volume + '/keys/gong.bell_id.group_id.group_seq.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.fpos.data.key', dkc_server_name, dkc_volume + '/keys/gong.fpos.data.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong10.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong10.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong10.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong10.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong10.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong10.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong10.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong10.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong25.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong25.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong25.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong25.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong25.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong25.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.latlong25.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.latlong25.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phcn.pr.pst.match.key', dkc_server_name, dkc_volume + '/keys/gong.phcn.pr.pst.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phcn.z5.match.key', dkc_server_name, dkc_volume + '/keys/gong.phcn.z5.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phln.pr.pst.match.key', dkc_server_name, dkc_volume + '/keys/gong.phln.pr.pst.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phln.z5.match.key', dkc_server_name, dkc_volume + '/keys/gong.phln.z5.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phone.match.key', dkc_server_name, dkc_volume + '/keys/gong.phone.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phone7.key', dkc_server_name, dkc_volume + '/keys/gong.phone7.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phone_h.key', dkc_server_name, dkc_volume + '/keys/gong.phone_h.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phoneno.key', dkc_server_name, dkc_volume + '/keys/gong.phoneno.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.phoneno.sortname.key', dkc_server_name, dkc_volume + '/keys/gong.phoneno.sortname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.pr.st.pct.match.key', dkc_server_name, dkc_volume + '/keys/gong.pr.st.pct.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.pr.z5.match.key', dkc_server_name, dkc_volume + '/keys/gong.pr.z5.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.recid.key', dkc_server_name, dkc_volume + '/keys/gong.recid.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.city.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.city.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.city.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.city.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.city.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.city.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.city.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.city.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.cityd.st_named.prim_range.predird.st_named.postdird.suffixd.phoneno.key', dkc_server_name, dkc_volume + '/keys/gong.st.cityd.st_named.prim_range.predird.st_named.postdird.suffixd.phoneno.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.county.cn.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.county.cn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.county.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.county.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.county.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.county.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.county.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.county.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.st.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.ln.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.ln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.p_city_name.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.st.p_city_name.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.pcn.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.pcn.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.phcn.pct.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.phcn.pct.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.phln.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.phln.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.phln.pct.match.key', dkc_server_name, dkc_volume + '/keys/gong.st.phln.pct.match.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.phone7.key', dkc_server_name, dkc_volume + '/keys/gong.st.phone7.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.st.prim_name.prim_range.lfmname.city.key', dkc_server_name, dkc_volume + '/keys/gong.st.prim_name.prim_range.lfmname.city.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.z3.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.z3.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.z5.addr.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.z5.addr.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.z5.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.z5.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.z5.neighbor.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.z5.neighbor.lfmname.key',,,,true),
fileservices.DKC('~thor_200::key::moxie::gong.z5.prim_name.prim_range.lfmname.key', dkc_server_name, dkc_volume + '/keys/gong.z5.prim_name.prim_range.lfmname.key',,,,true)
),
output('MOXIE_DKC_Complete', named('Moxie_Status')))
:	SUCCESS(FileServices.SendEmail('cbrodeur@seisint.com, cguyton@seisint.com', 'GONG DKCv2 Complete', thorlib.wuid())),
	Failure(FileServices.SendEmail('cbrodeur@seisint.com, cguyton@seisint.com, cnguyton@tmo.blackberry.net, intel357@bellsouth.net', 'GONG DKCv2 Failure', thorlib.wuid()));


return create_keys;
end;