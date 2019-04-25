Layout := RECORD
	 string Attribute_Name;
	 string condition;
	 string Attribute_value;
END;

IMPORT R, ut, Python3;
EXPORT dataset(layout) getpSet(string plist) := embed(Python3)
i = 0
dictnary = []
spi = plist.split(',')
for a in spi:
    for search in ['<=','>=','>','<','=']:
        index = a.find(search)
        if index != -1:
            before = a[:index]
            middle = a[index:index+len(search)]
            after = a[index+len(search):]
            return [(before,middle,after)]     
endembed;

