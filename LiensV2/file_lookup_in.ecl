import LiensV2_CourtLookup;
// ds := dataset(Data_Services.foreign_prod+'thor_data400::lookup::liens::court',LiensV2.layout_lookup_county,csv(Quote(''),heading(1),terminator(['\n','\r\n']),separator(','))) ;
// export	file_lookup_in := project(ds,transform(recordof(ds),self.desc := regexreplace('\"',left.desc,''),self := left));


export	file_lookup_in :=LiensV2_CourtLookup.Files().CourtBase(Current_rec ='Y') ; //DF-24988