export file_base := module
export cardholders := dataset('~thor_data400::base::unirush::cardholders',Unirush.aid_layouts.did_rec1,thor);
export transactions  := dataset('~thor_data400::base::unirush::transactions',Unirush.aid_layouts.did_rec2,thor);
end;
