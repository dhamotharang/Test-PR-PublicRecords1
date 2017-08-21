
EXPORT AllCategoriesValues := JOIN(Files.dsCategories, Files.dsSubCategories, LEFT.CatName=RIGHT.CatName,
								TRANSFORM(rSearchCategory,
								self.valueid := LEFT.CatId + 100*RIGHT.CatId;
								self.category := LEFT.CatName;
								self.subcategory := RIGHT.CatName;
								self.name := LEFT.CatName + '-' + RIGHT.CatName;),
							 FULL ONLY);
