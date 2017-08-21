/*
**********************************************************************************
Created by    Comments
Vani 					This attribute denormalizes the Super agency and agency fields in 
              Offense file to be used as Police agency and additional comments respectively.  
***********************************************************************************
*/	


Layout_OffenseAgency        := RECORD ,MAXLENGTH(10000)

    File_soff_Offense.id;
		File_soff_Offense.agency;	
		File_soff_Offense.Super_agency;
	  
end; 


DOffense             := DISTRIBUTE(File_soff_Offense,  HASH32(File_soff_Offense.id));
DSortedOffense       := SORT(DOffense,id,agency,Super_agency,LOCAL);

DSortedOffenseAgency := TABLE(DSortedOffense,Layout_OffenseAgency,LOCAL);
//DOffenseAgency       := DISTRIBUTE(OffenseAgencyTable,  HASH32(OffenseAgencyTable.id));
//DSortedOffenseAgency := SORT(DOffenseAgency,id,agency,Super_agency,LOCAL);
DDedup_Agengy_tbl    := DEDUP(DSortedOffenseAgency,id,agency,Super_agency,LOCAL);

IdTable              := table(DSortedOffense,Layout_Denorm_Offense_agency,id,LOCAL);


//output(DDedup_Agengy_tbl(id ='NY187140815'));
//output(IdTable(id ='NY187140815'));
Layout_Denorm_Offense_agency DeNormOffenseArrestAgency(Layout_Denorm_Offense_agency L, Layout_OffenseAgency R, INTEGER C) := TRANSFORM

		  SELF.Arrest_agency := IF(C=1 or L.Arrest_agency = '', 
			                               IF (R.agency <>'', 'ARREST AGENCY: '+trim(R.agency), ''),
																		 L.Arrest_agency +'; '+trim(R.agency));
      SELF.Police_agency := IF(C=1 or L.Police_agency = '', trim(R.Super_agency),
																		 L.Police_agency +'; '+trim(R.Super_agency));																		 
		  SELF := L;

end;
	 
export Mapping_Denorm_Arrest_Agency := DENORMALIZE(IdTable,DDedup_Agengy_tbl,
                                             LEFT.id = RIGHT.id,
																             DeNormOffenseArrestAgency(LEFT,RIGHT,COUNTER),LOCAL );