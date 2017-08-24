import data_services,header,Relationship,PRTE2_Header;
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_Relatives := project(PRTE2_Header.file_header_base,transform(header.layout_relatives,
        SELF.zip:=(integer)left.zip,
        SELF.prim_range:=(integer)left.prim_range,
        SELF:=LEFT,
        SELF:=[]
        ));
#ELSE
export File_Relatives := 
dataset(data_services.Data_Location.Relatives+'thor_data400::base::relatives',header.layout_relatives,flat)(current_relatives=true);
#END