import uccd;

export File_Business_Contacts_MktApp := Business_Header.File_Business_Contacts(
  source not in ['BR', 'D', 'Y', 'IA', 'ID', 'IF', 'II', 'W', 'DC', 'SK', 'LP'],
  not(source = 'U' and vendor_id[1..2]  not in uccd.set_DirectStates),
  not(source = 'U' and vendor_id[1..2] in ['IL','NM','KS','WA']), // Illinois, New Mexico, Kansas, Washington
  not(source = 'C' and vendor_id[1..2] in ['17','35','20','53']),  // Illinois, New Mexico, Kansas, Washingto
  not(source in ['GB','GG'] and vendor_id[1..3] = 'LSI'), // LSSI data
  not(source in ['MV','AW'] and vendor_id[1..2] in ['NM','KS','WA']));