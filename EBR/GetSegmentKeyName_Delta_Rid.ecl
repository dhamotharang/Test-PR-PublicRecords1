EXPORT GetSegmentKeyName_Delta_Rid (string4 segment_code) := 
							if(trim(segment_code) = 'AUTO',
										trim(KeyName_root) + 'Autokey' + '.delta_rid',
										trim(KeyName_root) + trim(segment_code) + '_' + trim(decode_segments(segment_code)) + '.delta_rid'
								);
