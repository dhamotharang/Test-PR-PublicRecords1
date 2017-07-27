import mdr;
export moxie_src_translation(string2 src_in,string vendor_id) := map(
						   src_in='MA' => 'AM',
						   mdr.Source_is_DPPA(src_in) => 'A' + src_in[2],
						   mdr.Source_is_Utility(src_in) => 'U',
						   src_in = 'TB' => 'TC',
					        src_in = 'FE' => 'FF',
						   src_in = 'FB' => 'FD',
						   src_in = 'PL' => 'MP',
						   src_in = 'FA' and vendor_id[1..2] = 'RA' => 'FA',
						   src_in = 'FA' and vendor_id[1..2] = 'RD' => 'FD',
						   src_in in ['#W' ,'ZW','GW','IW','HW','JW','DW','QW','1W',
									'NW','4W','7W','OW','SW','TW','VW','@W'] => 'WC',
						   src_in = 'AR' => 'RC',
						   src_in = 'AM' => 'EC',
						   src_in = 'AK' => 'KP',
						   src_in);