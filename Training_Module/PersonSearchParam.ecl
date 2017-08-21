export PersonSearchParam := MODULE

export STRING11 ssn := '' : STORED('SSN');

export STRING fname := '' : STORED('FirstName');
export STRING lname := '' : STORED('LastName');
export STRING FullName := '' : STORED('UnParsedFullName');

export AllowNickNames := false : STORED('AllowNickNames');
export AllowPhonetics := false : stored('AllowPhoneticMatch');

export STRING5 Zip := '' : STORED('Zip');
export INTEGER ZipRadius := 0 : STORED('ZipRaidus');


END;