alldata := Files.dsMasters;
categories := SORT(TABLE(alldata, {alldata.EntryCategory; alldata.EntrySubcategory; n := COUNT(GROUP);}, EntryCategory, EntrySubcategory, FEW),
											EntryCategory, EntrySubcategory);
											
EXPORT AllCategoriesFromMaster := PROJECT(categories, TRANSFORM(rSearchCategory,
														self.valueid := COUNTER;
														self.category := LEFT.EntryCategory;
														self.subcategory := LEFT.EntrySubcategory;
														self.name := LEFT.EntryCategory + '-' + LEFT.EntrySubCategory;));