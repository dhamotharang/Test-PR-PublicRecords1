import ut, unirush;
export aid_files := module
export cardholders := dataset('~thor_data400::in::unirush::cardholders',Unirush.aid_layouts.cardholder,csv(terminator('\n'),separator('|'),maxlength(700000), quote('"')));
export transactions  := dataset('~thor_data400::in::unirush::transactions',Unirush.aid_layouts.transaction,csv(terminator('\n'), separator('|'),maxlength (700000),quote('"')));

end;



