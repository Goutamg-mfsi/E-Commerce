
<cfcomponent output = "false" >

	 <!--- function to add category --->
	<cffunction name = "addCategory" access = "remote" output = "false" >
		<cfargument name = "addCategoryName" required = "true" >
		<cftry>
		<cfquery name = "addCategoryquery">
	    	INSERT INTO product.product_category VALUES(
	    	<cfqueryparam value = "#arguments.addCategoryName#" cfsqltype = "cf_sql_varchar" />
	    	);
		</cfquery>
		<cfcatch type = "any">
			<cfset type="#cfcatch.Type#" />
			<cfset message="#cfcatch.cause.message#" />
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type#
					  Message: #message#" />
		</cfcatch>
		</cftry>
	</cffunction>

	<!--- function to add sub category --->
	<cffunction name = "addSubCategory" access = "remote" output = "false" >
		<cfargument name = "subCategoryName" required = "true" >
		<cfargument name = "categoryId" required = "true" >
		 <cftry>
		<cfquery name = "addSubCategoryquery">
	    	INSERT INTO product.product_subCategory VALUES
	    	(
	    	<cfqueryparam value = "#arguments.subCategoryName#" cfsqltype = "cf_sql_varchar" />,
	    	<cfqueryparam value = "#arguments.categoryId#" cfsqltype = "cf_sql_integer" />
	    	);
		</cfquery>
		 <cfcatch type = "any">
			<cfset type="#cfcatch.Type#" />
			<cfset message="#cfcatch.cause.message#" />
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type#
					  Message: #message#" />
		 </cfcatch>
		 </cftry>
	</cffunction>

	<!--- function to add Product --->
	<cffunction name = "addProduct" access = "remote" output = "true" >
		<cftry>
		<cfquery name="addProductquery" result="addedProduct">
	    	INSERT INTO product.product(productName,subCategoryID,quantity,actualPrice,discountDeduction,color,weight,size,description,status)
	    	 VALUES(
	    	<cfqueryparam value = "#form.productName#" cfsqltype = "cf_sql_varchar" />,
	    	<cfqueryparam value = "#form.subCategory#" cfsqltype = "cf_sql_integer" />,
	    	<cfqueryparam value = "#form.productQuantity#" cfsqltype = "cf_sql_integer" />,
	    	<cfqueryparam value = "#form.productPrice#" cfsqltype = "cf_sql_float" />,
	    	<cfqueryparam value = "#form.discountDeduction#" cfsqltype = "cf_sql_float" null = "#not len(form.discountDeduction)#" />,
	    	<cfqueryparam value = "#form.productColour#" cfsqltype = "cf_sql_varchar" null = "#not len(form.productColour)#" />,
	    	<cfqueryparam value = "#form.productWeight#" cfsqltype = "cf_sql_float" null = "#not len(form.productWeight)#" />,
	    	<cfqueryparam value = "#form.productSize#" cfsqltype = "cf_sql_varchar" null = "#not len(form.productSize)#" />,
	    	<cfqueryparam value = "#form.productDescription#" cfsqltype = "cf_sql_varchar" null = "#not len(form.productDescription)#" />,
	    	<cfqueryparam value = "1" cfsqltype = "cf_sql_bit"  />
	    	);
		</cfquery>
		<cfif isDefined("form.productImage") AND len(form.productImage) >
			<cfset var fileName = "#addedProduct.IDENTITYCOL#">
			<cfset var destination="D:\eclipse\RemoteSystemsTempFiles\ECommerce\images\#fileName#.jpg">
			<cffile action="upload" filefield="productImage" destination="#destination#" nameconflict="makeunique" result="upload_result" accept="image/*">
			<cfset result = application.products.addPicture(#fileName#)/>
		</cfif>
		<cfcatch type="any">
			<cfdump var="#cfcatch#">
			<cfset type="#cfcatch.Type#" />
			<cfset message="#cfcatch.cause.message#" />
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type#
					  Message: #message#" />
		</cfcatch>
		</cftry>
	</cffunction>

	<!--- function to get category --->
	<cffunction name = "getCategory" access = "public" output = "false" returntype = "query" >
		<cfset getCategoryQuery = "">
		<cftry>
		<cfquery name = "getCategoryQuery">
	    	SELECT categoryID,categoryName FROM product.product_category;
		</cfquery>
		<cfcatch type = "any">
			<cfset type="#cfcatch.Type#" />
			<cfset message="#cfcatch.cause.message#" />
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type#
					  Message: #message#" />
		</cfcatch>
		</cftry>
		<cfreturn getCategoryQuery />
	</cffunction>

	<!--- function to get sub category --->
	<cffunction name = "getSubCategory" access = "public" output = "false" returntype = "query" >
		<cfset getSubCategoryQuery = "">
		<cftry>
		<cfquery name = "getSubCategoryQuery">
	    	 SELECT S.subCategoryID,S.subCategoryName,C.categoryName,C.categoryID FROM product.product_subCategory AS S
  			INNER JOIN product.product_category AS C ON S.categoryID = C.categoryID
			ORDER BY C.categoryID;
		</cfquery>
		<cfcatch type = "any">
			<cfset type="#cfcatch.Type#" />
			<cfset message="#cfcatch.cause.message#" />
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type#
					  Message: #message#" />
		</cfcatch>
		</cftry>
		<cfreturn getSubCategoryQuery />
	</cffunction>

	<!--- function to get sub category of a perticular category --->
	<cffunction name = "getSubCategoryByCategory" access = "public" output = "false" returntype = "query" returnformat="json" >
		<cfargument name = "categoryID" required = "true" />
 		<cfset SubCategoryQuery = "">
		<cftry>
		<cfquery name = "SubCategoryQuery">
	    	SELECT subCategoryName FROM product.product_subCategory
	    	WHERE categoryID = <cfqueryparam value = "#arguments.categoryID#" cfsqltype = "cf_sql_integer"  />;
		</cfquery>
		<cfcatch>
			<cfdump var = "get sub category by category error" />
		</cfcatch>
		</cftry>
		<cfreturn SubCategoryQuery />
	</cffunction>

	 <!--- function to return products --->
	<cffunction name = "getProducts" access = "remote" output = "false"  returnformat="json" >
		<cfargument name = "subCategoryID" required = "true">
		<cfargument name = "productName" required = "true">
		<cfargument name = "maxPrice" required = "true">
		<cfargument name = "minPrice" required = "true">
		<cfargument name = "size" required = "false">
		<cfargument name = "colour" required = "false">
		<cfargument name = "status" required = "true">
		<cfset response = [] />
		<cfset getProductQuery = "">
		<cftry>
		<cfquery name = "getProductQuery">
	    	SELECT productID,productName,productImage,quantity,actualPrice,status FROM product.product
	    	WHERE actualPrice BETWEEN
									<cfqueryparam value = "#arguments.minPrice#" cfsqltype = "cf_sql_integer" />
									AND
									<cfqueryparam value = "#arguments.maxPrice#" cfsqltype = "cf_sql_integer" />
	    	<cfif #len(arguments.subCategoryID)# >
				AND subCategoryID = <cfqueryparam value = "#arguments.subCategoryID#" cfsqltype = "cf_sql_integer" />
			</cfif>
			<cfif #len(arguments.productName)# >
				AND productName LIKE <cfqueryparam value = "%#arguments.productName#%" cfsqltype = "cf_sql_varchar" />
			</cfif>
			<cfif #len(arguments.size)# >
				AND size IN (<cfqueryparam value = "#arguments.size#" cfsqltype = "cf_sql_varchar" list="yes" />)
			</cfif>
			<cfif #len(arguments.colour)# >
				AND color IN (<cfqueryparam value = "#arguments.colour#" cfsqltype = "cf_sql_varchar" list="yes" />)
			</cfif>
			<cfif #len(arguments.status)# >
				AND status = <cfqueryparam value = "#arguments.status#" cfsqltype = "cf_sql_bit" />
			</cfif>
			ORDER BY productID DESC;
		</cfquery>
	    <cfloop query="getProductQuery">
		    <cfset obj = structNew()>
	        <cfset obj.ID = getProductQuery.productID />
	        <cfset obj.NAME = getProductQuery.productName />
	        <cfset obj.PRICE = getProductQuery.actualPrice />
	        <cfset obj.STATUS = getProductQuery.status />
	        <cfset obj.IMAGE = getProductQuery.productImage />
	        <cfset obj.QUANTITY = getProductQuery.quantity />
	        <cfset arrayAppend(response, obj) />
	    </cfloop>
	    <cfcatch type = "any">
			<cfset type="#cfcatch.Type#" />
			<cfset message="#cfcatch.cause.message#" />
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type#
					  Message: #message#" />
		</cfcatch>
		</cftry>
			<cfset session.subCategoryID = arguments.subCategoryID />
			<cfset session.productName = arguments.productName />
			<cfset session.maxPrice = arguments.maxPrice />
			<cfset session.minPrice = arguments.minPrice />
			<cfset session.size = arguments.size />
			<cfset session.colour = arguments.colour />
			<cfset session.status = arguments.status />
		<cfreturn response />
	</cffunction>

	<!--- function to call return products --->
	<cffunction name = "getProductsForPdf" access = "public" output = "false"  returnformat="json" >
			<cfreturn getProducts()>
	</cffunction>
	<!--- function to return product details --->
	<cffunction name = "getProductDetails" access = "remote" output = "false"  returnformat="json" >
			<cfargument name = "productID" required = "true">
	 		<cfset getProductDetailsQuery = "">
	 		<cfset obj = structNew()>
	 		<cftry>
				<cfquery name = "getProductDetailsQuery">
			    	SELECT productID,productName,productImage,subCategoryID,
			    	quantity,actualPrice,discountDeduction,color,weight,size,description,status FROM product.product
			    	WHERE productID = <cfqueryparam value = "#arguments.productID#" cfsqltype = "cf_sql_integer" />;
				</cfquery>
			    <cfset obj.ID = getProductDetailsQuery.productID />
			    <cfset obj.NAME = getProductDetailsQuery.productName />
			    <cfset obj.IMAGE = getProductDetailsQuery.productImage />
			    <cfset obj.SUBCATEGORY = getProductDetailsQuery.subCategoryID />
			    <cfset obj.QUANTITY = getProductDetailsQuery.quantity />
			    <cfset obj.PRICE = getProductDetailsQuery.actualPrice />
			    <cfset obj.DISCOUNT = getProductDetailsQuery.discountDeduction />
			    <cfset obj.COLOUR = getProductDetailsQuery.color />
			    <cfset obj.WEIGHT = getProductDetailsQuery.weight />
			    <cfset obj.SIZE = getProductDetailsQuery.size />
			    <cfset obj.DESCRIPTION = getProductDetailsQuery.description />
			    <cfset obj.STATUS = getProductDetailsQuery.status />
		    <cfcatch type = "any">
				<cfset type="#cfcatch.Type#" />
				<cfset message="#cfcatch.cause.message#" />
				<cflog type="Error"
					file="ECommerce"
					text="Exception error --
					   	  Exception type: #type#
						  Message: #message#" />
			</cfcatch>
			</cftry>
			<cfreturn obj />
		</cffunction>

	<!--- function to edit Product --->
	<cffunction name = "editProductDetails" access = "remote" output = "false" >
		<cfset editProductquery="" />
		<cfset var fileName = "#form.editProductID#">
		<cfset var destination="D:\eclipse\RemoteSystemsTempFiles\ECommerce\images\#fileName#.jpg">
		<cftry>
			<cfquery name="editProductquery">
		    	UPDATE product.product SET
		    	productName = <cfqueryparam value = "#form.editProductName#" cfsqltype = "cf_sql_varchar" />,
		    	subCategoryID = <cfqueryparam value = "#form.editSubCategoryList#" cfsqltype = "cf_sql_integer" />,
		    	quantity = <cfqueryparam value = "#form.editProductQuantity#" cfsqltype = "cf_sql_integer" />,
		    	actualPrice = <cfqueryparam value = "#form.editProductPrice#" cfsqltype = "cf_sql_float" />,
		    	discountDeduction = <cfqueryparam value = "#form.editDiscountDeduction#" cfsqltype = "cf_sql_float" null = "#not len(form.editDiscountDeduction)#" />,
		    	color = <cfqueryparam value = "#form.editProductColour#" cfsqltype = "cf_sql_varchar" null = "#not len(form.editProductColour)#" />,
		    	weight = <cfqueryparam value = "#form.editProductWeight#" cfsqltype = "cf_sql_float" null = "#not len(form.editProductWeight)#" />,
		    	size = <cfqueryparam value = "#form.editProductSize#" cfsqltype = "cf_sql_varchar" null = "#not len(form.editProductSize)#" />,
		    	description = <cfqueryparam value = "#form.editProductDescription#" cfsqltype = "cf_sql_varchar" null = "#not len(form.editProductDescription)#" />,
		    	status = <cfqueryparam value = "#form.editStatus#" cfsqltype = "cf_sql_bit"  />
		    	WHERE productID = <cfqueryparam value = "#form.editProductID#" cfsqltype = "cf_sql_integer"  />;
			</cfquery>
			<cfif isDefined("form.editProductImage") AND len(form.editProductImage) >
				<cffile action="upload" filefield="editProductImage" destination="#destination#" nameconflict="overwrite" result="upload_result" accept="image/*">
				<cfset result = application.products.addPicture(#fileName#)/>
			</cfif>
		<cfcatch>
			<cfset var details = "#cfcatch.type#">
				<cflog type="Error"
					file="ECommerce"
					text="Exception error ---
						  type : #details#" />
		</cfcatch>
		</cftry>
	</cffunction>

	<!--- function to add product image --->
	<cffunction name="addPicture" acess="public" output="false">
		<cfargument name = "productID" required = "true" />
		<cftry>
			<cfquery name="addProductImagequery">
				UPDATE product.product SET
				productImage = <cfqueryparam value="#arguments.productID#.jpg" cfsqltype = "cf_sql_varchar">
				WHERE productID = <cfqueryparam value = "#arguments.productID#" cfsqltype = "cf_sql_integer"  />;
			</cfquery>
		<cfcatch>
			<cfset type="#cfcatch.Type#" />
			<!--- <cfset message="#cfcatch.cause.message#" /> --->
			<cflog type="Error"
				file="ECommerce"
				text="Exception error --
				   	  Exception type: #type# " />
		</cfcatch>
		</cftry>
	</cffunction>

</cfcomponent>