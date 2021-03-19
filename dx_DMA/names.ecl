EXPORT names := MODULE
  EXPORT base := '~thor_data400::base::suppression::tps_delta';
  EXPORT base_father := base + '_father';
  EXPORT base_grandfather := base + '_grandfather';
  EXPORT key_dnc_part1 := '~thor_data400::key::DNC::';
  EXPORT key_dnc_part2 := 'phone';
  EXPORT key_DNC := key_dnc_part1 + key_dnc_part2 +'_qa';
  EXPORT key_DNC_father := key_dnc_part1 + key_dnc_part2 +'_father';
  EXPORT key_DNC_grandfather := key_dnc_part1 + key_dnc_part2 +'_grandfather';
  EXPORT key_DNC_version := key_dnc_part1 + '@version@::' +key_dnc_part2;
  EXPORT key_dnc_new(string filedate) := key_dnc_part1 + filedate + '::' +key_dnc_part2;
END;
